﻿using System;
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
        public ActionResult ShopDetail(Guid shipId)
        {
            var shop = BS.GetShopDetail(shipId);

            return new JsonResult() { Data = shop };  
        }

        [HttpPost]
        public ActionResult ShopDesks(SearchDeskCondition condition)
        {
            var desks = BS.GetShopDesks(condition);
            return new JsonResult() { Data = desks };  
        }
	}
}