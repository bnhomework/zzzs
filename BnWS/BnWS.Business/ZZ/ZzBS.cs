using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Mime;
using System.Web;
using Bn.WeiXin;
using Bn.WeiXin.GZH;
using BnWS.Entity;
using LinqKit;
using Repository;

namespace BnWS.Business
{
    public class ZzBS : BaseBS
    {
        public ZzBS() : base()
        {
            
        }
        public ZzBS(AppContext appContext)
            : base(appContext)
        {

        }

        public List<ZZ_Template> SearchTemplateByCondistion(TemplateCondition condition)
        {
            var templatePred = PredicateBuilder.New<ZZ_Template>(true);
            if (condition.Category.HasValue)
            {
                templatePred = templatePred.And(x => x.Category==condition.Category.Value);
            }
            if (condition.Sex.HasValue)
            {
                templatePred = templatePred.And((x => x.Sex == condition.Sex.Value));
            }
            if (!string.IsNullOrEmpty(condition.Color))
            {
                templatePred = templatePred.And(x => x.Color == condition.Color);
            }
            using (var db = GetDbContext())
            {
                return db.ZZ_Template.AsExpandable().Where(templatePred).ToList();
            }
        }
        private string SaveByteArrayAsImage(Guid id, string raw,string name,string ext="png")
        {
            var folder = Path.Combine(HttpContext.Current.Server.MapPath("~"), "upload", id.ToString());
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }
            var fileName = string.Format("{0}.{1}", name, ext);
            var localFullOutputPath = Path.Combine(folder, fileName);
            var base64String = raw.Split(',')[1];
            byte[] bytes = Convert.FromBase64String(base64String);

            Image image;
            using (var ms = new MemoryStream(bytes))
            {
                image = Image.FromStream(ms);
            }
            image.Save(localFullOutputPath);
            return string.Format(@"upload/{0}/{1}", id, fileName);
        }

        public void SaveDesgin(ZZDesign zzDesign)
        {
            using (var uow=GetUnitOfWork())
            {
                var d = new ZZ_Desgin()
                {
                    DesginId = Guid.NewGuid(),
                    TemplateId = zzDesign.TemplateId,
                    CustomerId = zzDesign.CustomerId,
                    Name = zzDesign.Name,
                    Tags = zzDesign.Tags,
                    DesginSettings = zzDesign.DesginSettings
                };
                d.Preview1 = SaveByteArrayAsImage(d.DesginId, zzDesign.Preview1_120, "1_120");
                d.Preview2 = SaveByteArrayAsImage(d.DesginId, zzDesign.Preview2_120, "2_120");
                SaveByteArrayAsImage(d.DesginId, zzDesign.Preview1, "1");
                SaveByteArrayAsImage(d.DesginId, zzDesign.Preview2, "2");
                uow.Repository<ZZ_Desgin>().Insert(d);
                uow.Save();
            }
        }

        public List<ZZDesign> GetDesginList(string openId)
        {
            using (var db = GetDbContext())
            {
                //todo test
                //return db.ZZ_Desgin.AsExpandable()//.Where(x => x.CustomerId == openId)
                //    .OrderByDescending(x=>x.CreatedTime).ToList();
                return (from d in db.ZZ_Desgin.AsExpandable()//.Where(x => x.CustomerId == openId)
                    join t in db.ZZ_Template on d.TemplateId equals t.TemplateId
                    join c in db.ZZ_Category on t.Category equals c.CategoryId
                    join u in db.ZY_Customer on d.CustomerId equals  u.OpenId
                    select new ZZDesign()
                    {
                        Id = d.DesginId,
                        TemplateId = d.TemplateId,
                        CustomerId = d.CustomerId,
                        Name = d.Name,
                        Tags = d.Tags,
                        Preview1 = d.Preview1,
                        Preview2 = d.Preview2,
                        UnitPrice = c.UnitPrice,
                        Designer = u.UserName
                    }).ToList();
            }
        }
        public ZZDesign GetDesign(Guid designId)
        {
            using (var db = GetDbContext())
            {
                var de= (from d in  db.ZZ_Desgin.AsExpandable().Where(x => x.DesginId == designId)
                   join t in db.ZZ_Template on d.TemplateId equals  t.TemplateId
                         join c in db.ZZ_Category on t.Category equals c.CategoryId
                         join u in db.ZY_Customer on d.CustomerId equals u.OpenId
                        select new ZZDesign()
                        {
                            Id = d.DesginId,
                            TemplateId = d.TemplateId,
                            CustomerId = d.CustomerId,
                            Name = d.Name,
                            Tags = d.Tags,
                            Preview1 = d.Preview1,
                            Preview2 = d.Preview2,
                            UnitPrice = c.UnitPrice,
                            Designer = u.UserName,
                            Colors = db.ZZ_Template.Where(x=>x.Category==t.Category).Select(x=>x.Color).Distinct().ToList()
                        }).FirstOrDefault();
                return de;
            }
        }

        public void SetIsPublic(Guid desginId, bool ispublic)
        {
            using (var uow = GetUnitOfWork())
            {
                var desgin = uow.Repository<ZZ_Desgin>().Find(desginId);
                if (desgin != null)
                {
                    desgin.IsPublic = ispublic;
                    uow.Repository<ZZ_Desgin>().Update(desgin);
                    uow.Save();
                }
            }
        }

        #region order

        public Guid AddToCart(ZZOrderInfo orderInfo)
        {
            var unitPrice = 0m;
            using (var db=GetDbContext())
            {
                var xx = (from d in db.ZZ_Desgin
                    join t in db.ZZ_Template on d.TemplateId equals t.TemplateId
                    join c in db.ZZ_Category on t.Category equals c.CategoryId
                    where d.DesginId == orderInfo.DesignId
                    select c).FirstOrDefault();
                if (xx == null)
                {
                    throw new Exception("Invalid Order");
                }
                unitPrice = xx.UnitPrice;
            }
            var o = new ZZ_Order();
            o.OrderId = Guid.NewGuid();
            o.OrderStatus = (int)ZZOrderStatus.Draft;
            o.DesignId = orderInfo.DesignId;
            o.CustomerId = orderInfo.CustomerId;
            o.Color = orderInfo.Color;
            o.Quiantity = orderInfo.Quiantity;
            o.TotalAmount = orderInfo.Quiantity*unitPrice;
            using (var uow = GetUnitOfWork())
            {
                uow.Repository<ZZ_Order>().Insert(o);
                uow.Save();
            }
            return o.OrderId;
        }

        public bool DeleteOrder(Guid orderId)
        {
            using (var uow = GetUnitOfWork())
            {
                var order=uow.Repository<ZZ_Order>().Find(orderId);
                if (order != null && order.OrderStatus < (int)ZZOrderStatus.Paid)
                {
                    uow.Repository<ZZ_Order>().Delete(order);
                    uow.Save();
                    return true;
                }
                else
                {
                    return false;
                }
            }
            
        }
        public bool RequestRefund(Guid orderId)
        {
            using (var uow = GetUnitOfWork())
            {
                var order=uow.Repository<ZZ_Order>().Find(orderId);
                if (order != null && (order.OrderStatus == (int)ZZOrderStatus.Paid
                    || order.OrderStatus == (int)ZZOrderStatus.Processing
                    ))
                {
                    order.OrderStatus =(int)ZZOrderStatus.PendingRefund;
                    uow.Repository<ZZ_Order>().Update(order);
                    uow.Save();
                    return true;
                }
                else
                {
                    return false;
                }
            }
            
        }
        public JSSDKPrepay PlaceOrder(List<Guid> orderIds, Guid addressId, string ip, string customerOpenId)
        {
            var result = new JSSDKPrepay();
            var submissionId =newSubmisstionId();
            using (var uow = GetUnitOfWork())
            {
               var orders= uow.Repository<ZZ_Order>()
                    .Query()
                    .Filter(x => orderIds.Contains(x.OrderId) && x.OrderStatus < (int) ZZOrderStatus.Paid)
                    .Get()
                    .ToList();
                var totalAmount = orders.Sum(x => x.TotalAmount);
                result = WxApiHelper.Instance.Prepay(submissionId, customerOpenId, ip, (Math.Round((decimal)(totalAmount) * 100, 0)).ToString());
                var oa = new ZZ_OrderAddress();
                oa.AddressId = addressId;
                oa.SubmissionId = submissionId;
                oa.OrderAddressId = Guid.NewGuid();
                uow.Repository<ZZ_OrderAddress>().Insert(oa);
                orders.ForEach(x =>
                {
                    x.OrderStatus = (int) ZZOrderStatus.Submitted;
                    uow.Repository<ZZ_Order>().Update(x);
                });
                uow.Save();
            }
            return result;
        }
        public bool ConfirmPayment(PayInfo payInfo)
        {
            using (var uow = GetUnitOfWork())
            {
                //var pay = new Pay();
                //pay.Id = Guid.NewGuid();
                //pay.return_code = payInfo.return_code;
                //pay.return_msg = payInfo.return_msg;
                //pay.appid = payInfo.appid;
                //pay.mch_id = payInfo.mch_id;
                //pay.device_info = payInfo.device_info;
                //pay.nonce_str = payInfo.nonce_str;
                //pay.sign = payInfo.sign;
                //pay.sign_type = payInfo.sign_type;
                //pay.result_code = payInfo.result_code;
                //pay.err_code = payInfo.err_code;
                //pay.err_code_des = payInfo.err_code_des;
                //pay.openid = payInfo.openid;
                //pay.is_subscribe = payInfo.is_subscribe;
                //pay.trade_type = payInfo.trade_type;
                //pay.bank_type = payInfo.bank_type;
                //pay.total_fee = payInfo.total_fee;
                //pay.settlement_total_fee = payInfo.settlement_total_fee;
                //pay.fee_type = payInfo.fee_type;
                //pay.cash_fee = payInfo.cash_fee;
                //pay.cash_fee_type = payInfo.cash_fee_type;
                //pay.coupon_fee = payInfo.coupon_fee;
                //pay.coupon_count = payInfo.coupon_count;
                //pay.transaction_id = payInfo.transaction_id;
                //pay.out_trade_no = payInfo.out_trade_no;
                //pay.attach = payInfo.attach;
                //pay.time_end = payInfo.time_end;
                //uow.Repository<Pay>().Insert(pay);
                var orders =
                        uow.Repository<ZZ_Order>().Query().Filter(x => x.SubmissionId == payInfo.out_trade_no).Get().ToList();
                
                orders.ForEach(x =>
                {
                    x.OrderStatus = (int) ZZOrderStatus.Paid;
                    uow.Repository<ZZ_Order>().Update(x);
                });
                uow.Save();
            }
            return true;
        }
        private string newSubmisstionId()
        {
            return Guid.NewGuid().ToString().Replace("-", "");
        }

        //public List<ZZOrderReview> GetOrders(string customerId)
        //{
        //    using (var db = GetDbContext())
        //    {
        //        var orders = (from o in db.ZZ_Order
        //                      join d in db.ZZ_Desgin on o.DesignId equals d.DesginId
        //                      where o.OrderStatus >0 && o.CustomerId == customerId
        //                      select new ZZOrderReview()
        //                      {
        //                          OrderId = o.OrderId,
        //                          CustomerId = o.CustomerId,
        //                          DesignId = o.DesignId,
        //                          DesginName = d.Name,
        //                          OrderStatus = o.OrderStatus,
        //                          Color = o.Color,
        //                          Quiantity = o.Quiantity,
        //                          TotalAmount = o.TotalAmount,
        //                          Preview = d.Preview1
        //                      }).ToList();
        //        return orders;
        //    }
        //}

        public List<ZZOrderReview> GetShoppingCart(string customerId)
        {
            using (var db = GetDbContext())
            {
                var orders = (from o in db.ZZ_Order
                              join d in db.ZZ_Desgin on o.DesignId equals d.DesginId
                              where o.OrderStatus == 0 && o.CustomerId == customerId
                              orderby o.CreatedTime descending 
                              select new ZZOrderReview()
                              {
                                  OrderId = o.OrderId,
                                  CustomerId = o.CustomerId,
                                  DesignId = o.DesignId,
                                  DesginName = d.Name,
                                  OrderStatus = o.OrderStatus,
                                  Color = o.Color,
                                  Quiantity = o.Quiantity,
                                  TotalAmount = o.TotalAmount,
                                  Preview = d.Preview1
                              }).ToList();
                return orders;
            }
        }
        public List<ZZOrderReview> GetShoppingCartByOrderIds(List<Guid> orderIds)
        {
            using (var db = GetDbContext())
            {
                var orders = (from o in db.ZZ_Order
                              join d in db.ZZ_Desgin on o.DesignId equals d.DesginId
                              where o.OrderStatus == 0 && orderIds.Contains(o.OrderId)
                              orderby o.CreatedTime descending 
                              select new ZZOrderReview()
                              {
                                  OrderId = o.OrderId,
                                  CustomerId = o.CustomerId,
                                  DesignId = o.DesignId,
                                  DesginName = d.Name,
                                  OrderStatus = o.OrderStatus,
                                  Color = o.Color,
                                  Quiantity = o.Quiantity,
                                  TotalAmount = o.TotalAmount,
                                  Preview = d.Preview1
                              }).ToList();
                return orders;
            }
        }
        public List<ZZOrderReview> GetRealOrders(string customerId)
        {
            using (var db = GetDbContext())
            {
                var orders = (from o in db.ZZ_Order
                              join d in db.ZZ_Desgin on o.DesignId equals d.DesginId
                              where o.OrderStatus >= (int)ZZOrderStatus.Paid && o.CustomerId == customerId
                              orderby o.CreatedTime descending
                              select new ZZOrderReview()
                              {
                                  OrderId = o.OrderId,
                                  CustomerId = o.CustomerId,
                                  DesignId = o.DesignId,
                                  DesginName = d.Name,
                                  OrderStatus = o.OrderStatus,
                                  Color = o.Color,
                                  Quiantity = o.Quiantity,
                                  TotalAmount = o.TotalAmount,
                                  Preview = d.Preview1
                              }).ToList();
                return orders;
            }
        }
        #endregion

        #region address

        public List<ZZAddress> GetAddressList(string openId)
        {
            using (var db = GetDbContext())
            {
                var addressList = (from o in db.ZZ_Address
                              where o.CustomerId==openId && !o.IsDeleted
                              select new ZZAddress()
                              {
                                  AddressId = o.AddressId,
                                  AddressLine1 = o.AddressLine1,
                                  City = o.City,
                                  ContactName = o.ContactName,
                                  CustomerId = o.CustomerId,
                                  IsDefault = o.IsDefault,
                                  Province = o.Province,
                                  Town = o.Town,
                                  Phone = o.Phone,
                                  CreatedTime = o.CreatedTime
                              }).OrderByDescending(x=>x.IsDefault).ThenByDescending(x=>x.CreatedTime).ToList();
                return addressList;
            }
        } 
        public Guid UpdateAddress(ZZAddress address)
        {
            var a = new ZZ_Address();
            a.AddressId = address.AddressId;
            a.AddressLine1 = address.AddressLine1;
            a.City = address.City;
            a.ContactName = address.ContactName;
            a.CustomerId = address.CustomerId;
            a.IsDefault = address.IsDefault;
            a.Province = address.Province;
            a.Town = address.Town;
            a.Phone = address.Phone;
            a.IsDeleted = false;
            
            using (var uow = GetUnitOfWork())
            {
                if (a.AddressId == Guid.Empty)
                {
                    a.AddressId = Guid.NewGuid();
                    uow.Repository<ZZ_Address>().Insert(a);

                }
                else
                {
                    uow.Repository<ZZ_Address>().Update(a);
                }
                uow.Save();
            }
            return a.AddressId;
        }

        public bool DeleteAddress(Guid addressId)
        {
            using (var uow = GetUnitOfWork())
            {
                var address=uow.Repository<ZZ_Address>().Find(addressId);
                if (address != null)
                {
                    address.IsDeleted = true;
                    uow.Repository<ZZ_Address>().Update(address);
                    uow.Save();
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        #endregion
    }
}