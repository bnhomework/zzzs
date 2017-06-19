using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BnWS.Business;
using BnWS.Entity;

namespace BnWS.Controllers
{
    public class ShopController : BaseController<ShopBS>
    {
        //
        // GET: /Shop/
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult GetShops()
        {
            var shops = BS.GetShopsByUserId(CurrentUser.UserId)
                .Select(x => new
                {
                    ShopId = x.ShopId,
                    ShopName = x.Name
                }).ToList();
            
            return new JsonResult()
            {
                Data = shops,JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }
        [HttpPost]
        public ActionResult GetShopDesks(Guid shopId, DateTime selectedDate)
        {
            var desks = BS.GetShopDesks(shopId, selectedDate);
            return new JsonResult()
            {
                Data = desks
            };
        }

        [HttpPost]
        public ActionResult BookPositionsInternal(Guid deskId, DateTime selectedDate,List<string> positions )
        {
            BS.BookPositionsInternal(deskId, selectedDate,positions);
            return new JsonResult()
            {
                Data =new {Status="OK"}
            };
        }

        public ActionResult Order()
        {
            return View();
        }

        public ActionResult GetOrders(SearchOrderCondition condition)
        {
            var orders = BS.GetOrders(condition);
            return new JsonResult(){Data = orders};
        }
        public ActionResult Refund()
        {
            return View();
        }

        //todo
        public ActionResult Management()
        {
            return View();
        }
	}
}