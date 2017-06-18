using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BnWS.Entity
{
    public class LoginViewModel
    {
        public string UserName { get; set; }

        public string Password { get; set; }

        public bool RememberMe { get; set; }
    }

    public class DeskViewModel
    {
        public Guid DeskId { get; set; }
        public string DeskName { get; set; }
        public string BookedPositions { get; set; }
        public string InternalBookedPositions { get; set; } 
    }

    public class ShopCriteria
    {
        public string ShopName { get; set; }
    }
    public class OrderInfo
    {
        public string CustomerOpenId { get; set; }
        public DateTime pickDate { get; set; }
        public Guid DeskId { get; set; }
        public List<string> Positions { get; set; }
        public string IP { get; set; }
    }

    public class PlaceResult
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public Guid OrderId { get; set; }
        public decimal Amount { get; set; }

        public string prepay_id { get; set; }
        public string appId { get; set; }
        public string timeStamp { get; set; }
        public string nonceStr { get; set; }
        public string package {
            get { return string.Format("prepay_id={0}", prepay_id); }
        }//"package": "prepay_id=" + prepay_id,
        public string signType { get; set; }
        public string paySign { get; set; }
    }

    #region wx
    public class SearchShopCondition
    {
        public double? Longitude { get; set; }
        public double? Latitude { get; set; }
    }

    public class ShopInfo
    {
        public Guid shopId { get; set; }
        public string shopName { get; set; }
        public string imageUrl { get; set; }
        public string description { get; set; }
        public string dist {
            get { return d.HasValue ? string.Format("{0:F1}km", d.Value) : ""; }
        }
        public double? d { get; set; }
    }

    public class ShopDetail
    {
        public Guid shopId { get; set; }
        public string  shopName { get; set; }
        public string address { get; set; }
        public decimal? longitude { get; set; }
        public decimal? latitude { get; set; }
        public string detailDescription { get; set; }
        public List<string> imgs { get; set; }
    }

    public class SearchDeskCondition
    {
        public Guid shopId { get; set; }
        public DateTime selectedDate { get; set; }
    }

    public class SearchPositionCondition
    {
        public Guid deskId { get; set; }
        public DateTime selectedDate { get; set; }
    }
    public class DeskDetail
    {
        public Guid deskId { get; set; }
        public string deskName { get; set; }
        //public string bookedPositions { get; set; }
        public DateTime selectedDate { get; set; }
        public decimal unitPrice { get; set; }
    }
    public class DeskPositionDetail
    {
        public string bookedPositions { get; set; }
    }
   
#endregion
}
