using System;
using System.Collections.Generic;
using System.Linq;
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
                    name = x.Name,
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
                        longitude = shop.Longitude
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
                Value = condition.shipId
            };
            var d = new System.Data.SqlClient.SqlParameter
            {
                ParameterName = "@date",
                Value = condition.selectedDate
            };
            using (var db = new BnAppEntities())
            {
                var result = db.Database.SqlQuery<DeskDetail>("sp_GetDesksForCustomer @shopId,@date", id, d);
                return result.ToList();
            }
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
            //ÓàÏÒ¶¨ÀíÇó¼Ð½Ç  
            double theta = Math.Acos((EarthRadius * EarthRadius + EarthRadius * EarthRadius - d * d) / (2 * EarthRadius * EarthRadius));  
            double dist = theta * EarthRadius;  
            return dist;  
        }


        
    }
}