using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BnWS.Business;
using BnWS.Controllers;
using BnWS.Entity;

namespace BnWS.Views
{
    [AllowAnonymous]
    public class ZYController : BaseController<ZYBS>
    {
        //
        // GET: /ZY/
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Shops(SearchShopCondition condition)
        {
            var shops = BS.GetShops(condition);
            return new JsonResult(){Data = shops};        
        }

        [HttpPost]
        public ActionResult ShopDetail(Guid shopId)
        {
            var shop = BS.GetShopDetail(shopId);

            return new JsonResult() { Data = shop };  
        }

        [HttpPost]
        public ActionResult ShopDesks(SearchDeskCondition condition)
        {
            var desks = BS.GetShopDesks(condition);
            return new JsonResult() { Data = desks };  
        }

        public ActionResult DeskPostions(SearchPositionCondition condition)
        {
            var deskPositions = BS.GetDeskPostions(condition);
            return new JsonResult() { Data = deskPositions }; 
            
        }
        [HttpPost]
        public ActionResult PlaceOrder(OrderInfo orderInfo)
        {
            orderInfo.IP=Request.UserHostAddress;
            var result = BS.PlaceOrder(orderInfo);
            return new JsonResult() { Data = result }; 
        }

        [HttpPost]
        public ActionResult GetOrders(string orderId)
        {
            var orders = BS.GetOrders(orderId);

            return new JsonResult() { Data = orders }; 
        }
	}
}