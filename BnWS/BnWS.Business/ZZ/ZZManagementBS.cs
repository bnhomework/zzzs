using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using BnWS.Entity;
using LinqKit;
using Newtonsoft.Json;

namespace BnWS.Business
{
    public class ZzManageBS : ZzBaseBS
    {
        public ZzManageBS() : base()
        {
            
        }
        public ZzManageBS(AppContext appContext)
            : base(appContext)
        {

        }

        public List<ZZ_Template> SearchTemplateByCondistion(TemplateCondition condition)
        {
            var templatePred = PredicateBuilder.New<ZZ_Template>(x => !x.IsDeleted);
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

        public List<ZZ_Category> GetProductTypes()
        {
            using (var db = GetDbContext())
            {
                return db.ZZ_Category.Where(x=>x.IsDeleted==false).ToList();
            }   
        }

        public bool AddProductType(ZZ_Category item)
        {
            var r = true;
            using (var uow = GetUnitOfWork())
            {
                var maxCategoryId = uow.Repository<ZZ_Category>().Query().Get().Select(x=>x.CategoryId).OrderByDescending(x=>x).FirstOrDefault();
                maxCategoryId += 1;
                item.CategoryId = maxCategoryId;
                uow.Repository<ZZ_Category>().Insert(item);
                uow.Save();
            }
            return r;
        }
        public bool UpdateProductType(ZZ_Category item)
        {
            var result = true;

            using (var uow = GetUnitOfWork())
            {
                var order = uow.Repository<ZZ_Category>().Find(item.CategoryId);
                if (order != null)
                {
                    order.Name = item.Name;
                    order.Description = item.Description;
                    order.UnitPrice = item.UnitPrice;
                    uow.Repository<ZZ_Category>().Update(order);
                    uow.Save();
                }
                else
                {
                    return false;
                }
            }

            return result;
        }
        public bool DeleteProductType(int itemId)
        {
            var result = true;

            using (var uow = GetUnitOfWork())
            {
                var order = uow.Repository<ZZ_Category>().Find(itemId);
                if (order != null )
                {
                    order.IsDeleted = true;
                    uow.Repository<ZZ_Category>().Update(order);
                    uow.Save();
                }
                else
                {
                    return false;
                }
            }

            return result;
        }

        public List<ZZAddressInfo> SearchCustomerAddress(AddressSearchCondition condition)
        {
            using (var db=GetDbContext())
            {
                var customerPred = PredicateBuilder.New<ZY_Customer>(true);
                if (!string.IsNullOrEmpty(condition.CustomerName))
                {
                    customerPred = customerPred.And(x => x.UserName.Contains(condition.CustomerName));
                }
                var tmp = from a in db.ZZ_Address
                    join c in db.ZY_Customer.AsExpandable().Where(customerPred) on a.CustomerId equals c.OpenId
                    select new ZZAddressInfo()
                    {
                        CustomerName = c.UserName,
                        CreatedDate = a.CreatedTime,
                        Address = a.Province + " " + a.City + " " + a.Town + " " + a.AddressLine1,
                        ContactName = a.ContactName,
                        Phone = a.Phone,
                        IsDeleted = a.IsDeleted,
                        AddressId = a.AddressId
                    };
                return tmp.OrderBy(x=>x.CustomerName).ThenByDescending(x=>x.CreatedDate).ToList();
            }
        } 

        public List<ZZTemplate> SearchTemplateByCondistion2(TemplateCondition condition)
        {
            var templatePred = PredicateBuilder.New<ZZ_Template>(x => !x.IsDeleted);
            if (condition.Category.HasValue)
            {
                templatePred = templatePred.And(x => x.Category == condition.Category.Value);
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
                var tmp = from t in db.ZZ_Template.AsExpandable().Where(templatePred)
                          join c in db.ZZ_Category on t.Category equals c.CategoryId
                          select new ZZTemplate()
                          {
                              TemplateId = t.TemplateId,
                              BackImg = t.BackImg,
                              Category = t.Category,
                              Color = t.Color,
                              ColorCode = t.ColorCode,
                              FrontImg = t.FrontImg,
                              IsDeleted = t.IsDeleted,
                              Sex = t.Sex,
                              UnitPrice = c.UnitPrice
                          };
                return tmp.OrderByDescending(x => x.Category).ThenBy(x => x.Sex).ThenBy(x => x.ColorCode).ToList();
            }
        }
        public bool AddProduct(ZZTemplate item)
        {
            var r = true;
            using (var uow = GetUnitOfWork())
            {
                var t = new ZZ_Template();
                t.TemplateId = Guid.NewGuid();
                t.Category = item.Category;
                t.Sex = item.Sex;
                t.Color = item.Color;
                t.ColorCode = item.ColorCode;
                t.FrontImg = item.FrontImg;
                t.BackImg = item.BackImg;

                uow.Repository<ZZ_Template>().Insert(t);
                uow.Save();
            }
            return r;
        }

        public bool UpdateProduct(ZZTemplate item)
        {
            var result = true;

            using (var uow = GetUnitOfWork())
            {
                var t = uow.Repository<ZZ_Template>().Find(item.TemplateId);
                if (t != null)
                {
                    t.Category = item.Category;
                    t.Sex = item.Sex;
                    t.Color = item.Color;
                    t.ColorCode = item.ColorCode;
                    t.FrontImg = item.FrontImg;
                    t.BackImg = item.BackImg;
                    uow.Repository<ZZ_Template>().Update(t);
                    uow.Save();
                }
                else
                {
                    return false;
                }
            }

            return result;
        }
        
        public bool DeleteProduct(Guid tempalteId)
        {
            var result = true;

            using (var uow = GetUnitOfWork())
            {
                var order = uow.Repository<ZZ_Template>().Find(tempalteId);
                if (order != null)
                {
                    order.IsDeleted = true;
                    uow.Repository<ZZ_Template>().Update(order);
                    uow.Save();
                }
                else
                {
                    return false;
                }
            }

            return result;
        }
        public List<ZZOrderSummary> SearchOrderByCriteria(OrderSearchCondition condition)
        {
            var orderPred = PredicateBuilder.New<ZZ_Order>(x=>x.OrderStatus>=(int)ZZOrderStatus.Paid);
            
            if (condition.DateFrom.HasValue)
            {
                condition.DateFrom = condition.DateFrom.Value.Date;
                orderPred = orderPred.And(x => x.CheckOutDate>=condition.DateFrom.Value);
            }
            if (condition.DateTo.HasValue)
            {
                condition.DateTo = condition.DateTo.Value.Date.AddDays(1);
                orderPred = orderPred.And(x => x.CheckOutDate < condition.DateTo.Value);
            }
            if (condition.OrderStatus.HasValue)
            {
                orderPred = orderPred.And(x => x.OrderStatus == condition.OrderStatus.Value);
            }
            if (!string.IsNullOrEmpty(condition.TrackingNumber))
            {
                orderPred = orderPred.And(x => x.TrackingNumber == condition.TrackingNumber);
            }
            var userPred = PredicateBuilder.New<ZY_Customer>(true);
            if (!string.IsNullOrEmpty(condition.CustomerName))
            {
                userPred = userPred.And(x => x.UserName.Contains(condition.CustomerName));
            }

            var categoryPred = PredicateBuilder.New<ZZ_Category>(true);
            if (condition.ProductType.HasValue)
            {
                categoryPred = categoryPred.And(x => x.CategoryId == condition.ProductType.Value);
            }
            using (var db = GetDbContext())
            {
                var tmp = from o in db.ZZ_Order.AsExpandable().Where(orderPred)
                    join u in db.ZY_Customer.AsExpandable().Where(userPred) on o.CustomerId equals u.OpenId
                    join d in db.ZZ_Desgin on o.DesignId equals d.DesginId
                    join t in db.ZZ_Template on d.TemplateId equals t.TemplateId
                    join c in db.ZZ_Category.AsExpandable().Where(categoryPred) on t.Category equals c.CategoryId
                    
                    select new ZZOrderSummary()
                    {
                        OrderId = o.OrderId,
                        TrackingNumber = o.TrackingNumber,
                        CheckOutDate = o.CheckOutDate.Value,
                        CustomerName = u.UserName,
                        DesginName = d.Name,
                        OrderStatus = o.OrderStatus,
                        Preview = d.Preview1,
                        ProductType = c.Name,
                        Quiantity = o.Quiantity,
                        TotalAmount = o.TotalAmount
                    };
                return tmp.OrderByDescending(x=>x.CheckOutDate).ThenByDescending(x=>x.TotalAmount).ToList();
            }
        }

        public bool ProcessingOrder(Guid orderId)
        {
            var result = true;

            using (var uow=GetUnitOfWork())
            {
               var order= uow.Repository<ZZ_Order>().Find(orderId);
                if (order != null && order.OrderStatus == (int) ZZOrderStatus.Paid)
                {
                    order.OrderStatus = (int) ZZOrderStatus.Processing;
                    uow.Repository<ZZ_Order>().Update(order);
                    InsertOrderStatusHistory(uow, orderId, (int) ZZOrderStatus.Processing);
                    uow.Save();
                }
                else
                {
                    return false;
                }
            }

            return result;
        }
        public bool CompleteOrder( LogisticsInfo logisticsInfo)
        {
            var result = true;

            using (var uow=GetUnitOfWork())
            {
               var order= uow.Repository<ZZ_Order>().Find(logisticsInfo.OrderId);
                if (order != null && order.OrderStatus == (int) ZZOrderStatus.Processing)
                {
                    order.OrderStatus = (int) ZZOrderStatus.Completed;
                    uow.Repository<ZZ_Order>().Update(order);
                    InsertOrderStatusHistory(uow, logisticsInfo.OrderId, (int)ZZOrderStatus.Completed);
                    var li = new ZZ_LogisticsInfo();
                    li.Id = Guid.NewGuid();
                    li.OrderId = logisticsInfo.OrderId;
                    li.ExpressCompany = logisticsInfo.ExpressCompany;
                    li.ExpressTrackingNo = logisticsInfo.ExpressTrackingNo;
                    li.Comments = logisticsInfo.Comments;
                    uow.Repository<ZZ_LogisticsInfo>().Insert(li);
                    uow.Save();
                }
                else
                {
                    return false;
                }
            }

            return result;
        }
        public bool RefundOrder(Guid orderId)
        {
            var result = true;

            using (var uow = GetUnitOfWork())
            {
                var order = uow.Repository<ZZ_Order>().Find(orderId);
                if (order != null&&order.OrderStatus==(int)ZZOrderStatus.PendingRefund)
                {
                    order.OrderStatus = (int) ZZOrderStatus.Refund;
                    uow.Repository<ZZ_Order>().Update(order);
                    InsertOrderStatusHistory(uow, orderId, (int) ZZOrderStatus.Refund);
                    uow.Save();
                }
                else
                {
                    return false;
                }
            }

            return result;
        }
        public ZZOrderDetail GetOrderInfo(Guid orderId)
        {
            var result = new ZZOrderDetail();

            var orderPred = PredicateBuilder.New<ZZ_Order>(x => x.OrderId == orderId);
            
            using (var db = GetDbContext())
            {
                var tmp = from o in db.ZZ_Order.AsExpandable().Where(orderPred)
                          join u in db.ZY_Customer on o.CustomerId equals u.OpenId
                          join d in db.ZZ_Desgin on o.DesignId equals d.DesginId
                          join du in db.ZY_Customer on d.CustomerId equals du.OpenId
                          join t in db.ZZ_Template on d.TemplateId equals t.TemplateId
                          join c in db.ZZ_Category  on t.Category equals c.CategoryId
                          join a in db.ZZ_OrderAddress on o.SubmissionId equals a.SubmissionId
                          join ad in db.ZZ_Address on a.AddressId equals ad.AddressId
                          select new ZZOrderDetail()
                          {
                              OrderId = o.OrderId,
                              DesignId = o.DesignId,
                              TrackingNumber = o.TrackingNumber,
                              CheckOutDate = o.CheckOutDate.Value,
                              CustomerName = u.UserName,
                              DesginName = d.Name,
                              OrderStatus = o.OrderStatus,
                              Preview = d.Preview1,
                              ProductType = c.Name,
                              Quiantity = o.Quiantity,
                              TotalAmount = o.TotalAmount,
                              Desginer = du.UserName,
                              Preview1 = d.Preview1,
                              Preview2 = d.Preview2,
                              Color = o.Color,
                              DesginSettings = d.DesginSettings,
                              ContactName = ad.ContactName,
                              Phone = ad.Phone,
                              AddressLine1 = ad.AddressLine1,
                              Town = ad.Town,
                              City = ad.City,
                              Province=ad.Province
                          };

                result= tmp.FirstOrDefault();
                SetUIDisplayFeilds(result);
            }

            return result;
        }
        /// <summary>
        /// raw image
        /// </summary>
        /// <param name="d"></param>
        private void SetUIDisplayFeilds(ZZOrderDetail d)
        {
            if(d==null)
                return;
            d.Preview1 = warpPath(d.Preview1);
            d.Preview2 = warpPath(d.Preview2);

            var s = JsonConvert.DeserializeObject<ZZDesignSetting>(d.DesginSettings);
            d.CustomerImg1 = warpPath(s.front,d.DesignId,string.Format("{0}_1",d.DesignId));
            d.CustomerImg2 = warpPath(s.back,d.DesignId,string.Format("{0}_2",d.DesignId));
            d.OrderStatusDesc = getOrderStatusById(d.OrderStatus);

        }

        private string warpPath(string p,Guid designId=default(Guid),string fileName="")
        {
            if (string.IsNullOrEmpty(p))
                return p;
            //p = HandleRawImage(p, designId, fileName);
            p = p.ToLower();
            if (p.StartsWith("upload/"))
            {
                p = p.Replace("upload/", "../upload/");
            }

            if (p.Contains("_120."))
            {
                p = p.Replace("_120.", ".");
            }
            return p;
        }

        private string HandleRawImage(string raw,Guid designId,string fileName)
        {
            if (!raw.StartsWith("data:image"))
            {
                return raw;
            }
            var folder = Path.Combine(HttpContext.Current.Server.MapPath("~"), "upload", designId.ToString());
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }
            
            var ext = raw.Split(';')[0].Replace("data:image/","");
            var fileFullName = string.Format("{0}/{1}.{2}", folder, fileName, ext);
            if (!File.Exists(fileFullName))
            {
                SaveByteArrayAsImage(designId, raw, fileName, ext);
            }
            return string.Format("upload/{0}/{1}.{2}", designId, fileName, ext);
        }

        private string getOrderStatusById(int s)
        {
            switch (s)
            {
                case (int)ZZOrderStatus.Draft:
                    return "未提交";
                case (int)ZZOrderStatus.Submitted:
                    return "未付款";
                case (int)ZZOrderStatus.Paid:
                    return "已付款";
                case (int)ZZOrderStatus.Processing:
                    return "生产中";
                case (int)ZZOrderStatus.Completed:
                    return "已发货";
                case (int)ZZOrderStatus.PendingRefund:
                    return "申请退款";
                case (int)ZZOrderStatus.Refund:
                    return "已退款";
                default:
                    return s.ToString();
            }
        }
    }
}