using System;
using System.Collections.Generic;
using System.Linq;
using Bn.WeiXin;
using Bn.WeiXin.GZH;
using BnWS.Entity;

namespace BnWS.Business
{
    public class ZYBS : BaseBS
    {
        public ZYBS()
            : base()
        {
            
        }
        public ZYBS(AppContext appContext)
            : base(appContext)
        {

        }
        private const double EarthRadius = 6378137;

        public List<ShopInfo> GetShops(SearchShopCondition condition)
        {

            using (var uow = GetUnitOfWork())
            {
                var shops= uow.Repository<ZY_Shop>().Query().Filter(x=>x.ShopStatus==1).Include(x=>x.ZY_Shop_Img).Get().ToList();
                return shops.Select(x => new ShopInfo()
                {
                    shopId = x.ShopId,
                    shopName = x.Name,
                    description = x.Address,
                    imageUrl =x.ZY_Shop_Img.Select(i=>i.Url).FirstOrDefault(), //x.ZY_Shop_Img.Count()>0?x.ZY_Shop_Img.First().Url:"", //todo
                    d = GetLantitudeLongitudeDist(condition.Longitude, condition.Latitude, x.Longitude, x.Latitude)
                }).OrderBy(x=>x.dist).ToList();

            }
        }

        public ShopDetail GetShopDetail(Guid shopId)
        {
            using (var uow = GetUnitOfWork())
            {
                var shop =
                    uow.Repository<ZY_Shop>()
                        .Query()
                        .Include(x => x.ZY_Shop_Img)
                        .Filter(x => x.ShopId == shopId)
                        .Get()
                        .FirstOrDefault();
                if (shop != null)
                {
                    return new ShopDetail()
                    {
                        shopId = shop.ShopId,
                        address = shop.Address,
                        //detailDescription = shop.
                        imgs = shop.ZY_Shop_Img.Select(i => i.Url).ToList(),
                        latitude = shop.Latitude,
                        longitude = shop.Longitude,
                        shopName=shop.Name
                    };
                }
            }

            return null;
        }

        public List<DeskDetail> GetShopDesks(SearchDeskCondition condition)
        {
            var id = new System.Data.SqlClient.SqlParameter
            {
                ParameterName = "@shopId",
                Value = condition.shopId
            };
            var d = new System.Data.SqlClient.SqlParameter
            {
                ParameterName = "@date",
                Value = condition.selectedDate.Date
            };
            using (var db = GetDbContext())
            {
                var result = db.Database.SqlQuery<DeskDetail>("sp_GetDesksForCustomer @shopId,@date", id, d);
                return result.ToList();
            }
        }

        public DeskPositionDetail GetDeskPostions(SearchPositionCondition condition)
        {
            using (var uow = GetUnitOfWork())
            {
               var postions= uow.Repository<ZY_Booked_Position>()
                    .Query()
                    .Filter(x => x.DeskId == condition.deskId && x.OrderDate == condition.selectedDate)
                    .Get()
                    .Select(x => x.Position).ToList();
                return new DeskPositionDetail(){bookedPositions = string.Join(",",postions)};
            }
        } 

        public PlaceResult PlaceOrder(OrderInfo orderInfo)
        {
            var result = new PlaceResult(){Success = true,OrderId = Guid.NewGuid()};
            if (orderInfo.Positions==null||orderInfo.Positions.Count == 0)
            {
                result.Success = false;
                result.Message = "请选择位置";
                return result;
            }
            var o = new JSSDKPayOrder();
            o.out_trade_no = result.OrderId.ToString();
            o.body = "";//腾讯充值中心-QQ会员充值
            o.attach = "";//深圳分店
            o.spbill_create_ip = orderInfo.IP;//APP和网页支付提交用户端ip，Native支付填调用微信支付API的机器IP。
            result.prepay_id = WxApiHelper.Instance.GetPaymentId(o);
            result.appId = WxConfig.Appid;
            result.timeStamp = Utility.GetTimeSpan();
            result.nonceStr = Utility.GenerateNonceStr();
            result.signType = "MD5";
            string payRaw = "appId=" + result.appId
                            + "&nonceStr=" + result.nonceStr
                            + "&package=" + result.package
                            + "&signType=" + result.signType
                            + "&timeStamp=" + result.timeStamp;
            result.paySign = Utility.Signature(payRaw, result.signType);
            try
            {
            using (var uow = GetUnitOfWork())
            {
                var desk =
                    uow.Repository<ZY_Shop_Desk>()
                        .Query()
                        .Filter(x => x.DeskId == orderInfo.DeskId)
                        .Get()
                        .FirstOrDefault();
                if (desk == null)
                {
                    result.Success = false;
                    result.Message = "没有找到桌子";
                    return result;
                }
                var order = new ZY_Order()
                {
                    OrderId = result.OrderId,
                    Amount = orderInfo.Positions.Count * desk.UnitPrice,
                    CustomerOpenId = orderInfo.CustomerOpenId,
                    OrderDate = orderInfo.pickDate,
                    Prepay_id = result.prepay_id,
                    Status = 0
                };
                var positions = new List<ZY_Booked_Position>();
                orderInfo.Positions.ForEach(x =>
                {
                    var p = new ZY_Booked_Position()
                    {
                        Id = Guid.NewGuid(),
                        CustomerOpenId = orderInfo.CustomerOpenId,
                        OrderDate = orderInfo.pickDate.Date,
                        DeskId = orderInfo.DeskId,
                        Position = x,
                        Status = 1
                    };
                    positions.Add(p);
                });
                uow.Repository<ZY_Order>().Insert(order);
                uow.Repository<ZY_Booked_Position>().InsertRange(positions);
                uow.Save();
                result.Success = true;
                result.Message = string.Format("下单成功");//todo message 优化
            }
            }
            catch (Exception ex)
            {
                result.Success = false;
                result.Message = "失败啦";
            }
            return result;
        }

        private double rad(double d)
        {
            return d * Math.PI / 180.0;
        }

        private double? GetLantitudeLongitudeDist(double? lon1, double? lat1, decimal? lon2, decimal? lat2)
        {
            if (!lon1.HasValue || !lat1.HasValue||!lon2.HasValue||!lat2.HasValue)
            {
                return null;
            }
            var d = LantitudeLongitudeDist(lon1.Value, lat1.Value, double.Parse(lon2.Value.ToString()), double.Parse(lat2.Value.ToString()));
            return d;
            //return string.Format("{0:F1}km", d);
        }
        private  double LantitudeLongitudeDist(double lon1, double lat1,double lon2, double lat2) {  
            double radLat1 = rad(lat1);  
            double radLat2 = rad(lat2);  
  
            double radLon1 = rad(lon1);  
            double radLon2 = rad(lon2);  
  
            if (radLat1 < 0)  
                radLat1 = Math.PI / 2 + Math.Abs(radLat1);// south  
            if (radLat1 > 0)
                radLat1 = Math.PI / 2 - Math.Abs(radLat1);// north  
            if (radLon1 < 0)
                radLon1 = Math.PI * 2 - Math.Abs(radLon1);// west  
            if (radLat2 < 0)
                radLat2 = Math.PI / 2 + Math.Abs(radLat2);// south  
            if (radLat2 > 0)
                radLat2 = Math.PI / 2 - Math.Abs(radLat2);// north  
            if (radLon2 < 0)
                radLon2 = Math.PI * 2 - Math.Abs(radLon2);// west  
            double x1 = EarthRadius * Math.Cos(radLon1) * Math.Sin(radLat1);
            double y1 = EarthRadius * Math.Sin(radLon1) * Math.Sin(radLat1);
            double z1 = EarthRadius * Math.Cos(radLat1);

            double x2 = EarthRadius * Math.Cos(radLon2) * Math.Sin(radLat2);
            double y2 = EarthRadius * Math.Sin(radLon2) * Math.Sin(radLat2);
            double z2 = EarthRadius * Math.Cos(radLat2);  
  
            double d = Math.Sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)+ (z1 - z2) * (z1 - z2));  
            //余弦定理求夹角  
            double theta = Math.Acos((EarthRadius * EarthRadius + EarthRadius * EarthRadius - d * d) / (2 * EarthRadius * EarthRadius));  
            double dist = theta * EarthRadius;  
            return dist;  
        }

        public bool ConfirmPayment(PayInfo payInfo)
        {
            using (var uow = GetUnitOfWork())
            {
                var pay = new Pay();
                pay.Id = Guid.NewGuid();
                pay.return_code = payInfo.return_code;
                pay.return_msg = payInfo.return_msg;
                pay.appid = payInfo.appid;
                pay.mch_id = payInfo.mch_id;
                pay.device_info = payInfo.device_info;
                pay.nonce_str = payInfo.nonce_str;
                pay.sign = payInfo.sign;
                pay.sign_type = payInfo.sign_type;
                pay.result_code = payInfo.result_code;
                pay.err_code = payInfo.err_code;
                pay.err_code_des = payInfo.err_code_des;
                pay.openid = payInfo.openid;
                pay.is_subscribe = payInfo.is_subscribe;
                pay.trade_type = payInfo.trade_type;
                pay.bank_type = payInfo.bank_type;
                pay.total_fee = payInfo.total_fee;
                pay.settlement_total_fee = payInfo.settlement_total_fee;
                pay.fee_type = payInfo.fee_type;
                pay.cash_fee = payInfo.cash_fee;
                pay.cash_fee_type = payInfo.cash_fee_type;
                pay.coupon_fee = payInfo.coupon_fee;
                pay.coupon_count = payInfo.coupon_count;
                pay.transaction_id = payInfo.transaction_id;
                pay.out_trade_no = payInfo.out_trade_no;
                pay.attach = payInfo.attach;
                pay.time_end = payInfo.time_end;
                uow.Repository<Pay>().Insert(pay);
                Guid orderId;
                if (Guid.TryParse(payInfo.out_trade_no, out orderId))
                {
                    var order =
                        uow.Repository<ZY_Order>().Query().Filter(x => x.OrderId == orderId).Get().FirstOrDefault();
                    if (order != null)
                    {
                        order.Status = 1;
                        uow.Repository<ZY_Order>().Update(order);
                    }
                }
                uow.Save();
            }
            return true;
        }

        public List<OrderHistory> GetOrders(string openId)
        {
            var id = new System.Data.SqlClient.SqlParameter
            {
                ParameterName = "@openId",
                Value = openId
            };
            using (var db = GetDbContext())
            {
                var result = db.Database.SqlQuery<OrderHistory>("sp_GetCustomerOrders @openId", openId);
                return result.ToList();
            }
        } 
    }
}