using System;
using System.Web.Mvc;
using BnWS.Business;
using BnWS.Entity;

namespace BnWS.Controllers
{
    public class PlateformController : BaseController<PlateFormBS>
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult LoadShops(ShopCriteria condition)
        {
            var shops = BS.SearchShops(condition);

            return new JsonResult(){Data = shops};
        }

        public ActionResult UpdateShopStatus(Guid shopId, int status)
        {
            BS.UpdateShopStatus(shopId,status);
            return new JsonResult(){Data="OK"};
        }
    }
}