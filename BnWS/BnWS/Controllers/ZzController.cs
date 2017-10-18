using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Security.Cryptography;
using System.Web.Mvc;
using BnWS.Business;
using BnWS.Controllers;
using BnWS.Entity;
using BnWS.Models;

namespace BnWS.Views
{
    public class ZzController : BaseController<ZzBS>
    {
        [HttpPost]
        public ActionResult GetTemplates(TemplateCondition condition)
        {
            var templates = BS.SearchTemplateByCondistion(condition);
            return new JsonResult(){Data = templates.Select(x =>
                new {
                    x.TemplateId,
                    x.FrontImg,
                    x.BackImg,
                    x.Category,
                    x.Sex,
                    x.Color
                })};
        }

        [HttpPost]
        public ActionResult SaveDesgin(ZZDesign zzDesign)
        {
            if (zzDesign.Id == Guid.Empty)
            {
                zzDesign.Id = Guid.NewGuid();
            }
            BS.SaveDesgin(zzDesign);
            return  new JsonResult(){Data = new {desginId=zzDesign.Id}};
        }
        [HttpPost]
        public ActionResult GetDesginList(string openId)
        {
            var designs=BS.GetDesginList(openId);
            return new JsonResult() { Data = designs.Select(x=>new
            {
                x.Preview1,
                DesignId=x.Id,
                x.Name,
                x.Tags,
                x.IsPublic,
                x.Follows
                ,x.UnitPrice
            }), MaxJsonLength = int.MaxValue };
        }
        [HttpPost]
        public ActionResult GetDesginList(DesginQuery condition)
        {
            var c = PageSearchBuilder.Build(Request, condition);
            var designs = BS.GetDesginList(c);
            //designs.
            return new JsonResult()
            {
                Data = designs,
                MaxJsonLength = int.MaxValue
            };
        }

        [HttpPost]
        public ActionResult GetDesign(Guid designId)
        {
            var design = BS.GetDesign(designId);
            return new JsonResult()
            {
                Data = design,
                MaxJsonLength = int.MaxValue
            };
            
        }
        [HttpPost]
        public ActionResult SetIsPublic(Guid designId,bool ispublic)
        {
            BS.SetIsPublic(designId, ispublic);
            return  new JsonResult(){Data = "OK"};
        }
        [HttpPost]
        public ActionResult AddToCart(ZZOrderInfo orderInfo)
        {
          var orderId=  BS.AddToCart(orderInfo);
          return new JsonResult() { Data = orderId };
        }
        [HttpPost]
        public ActionResult PlaceOrder(List<Guid> orderIds,Guid addressId,string openId )
        {
            var result = BS.PlaceOrder(orderIds, addressId, Request.UserHostAddress, openId);
            return new JsonResult() { Data = result };
        }
        [HttpPost]
        public ActionResult DeleteOrder(Guid orderId)
        {
            //var o = BS.de(orderId);
           var deleted= BS.DeleteOrder(orderId);
            return new JsonResult() { Data = deleted };
        }

        [HttpPost]
        public ActionResult GetShoppingCart(string openId)
        {
            var orders = BS.GetShoppingCart(openId);
            return new JsonResult() { Data = orders, MaxJsonLength = int.MaxValue };
        }
        [HttpPost]
        public ActionResult GetShoppingCartByOrderIds(List<Guid> orderIds)
        {
            var orders = BS.GetShoppingCartByOrderIds(orderIds);
            return new JsonResult() { Data = orders ,MaxJsonLength = int.MaxValue};
        }


        [HttpPost]
        public ActionResult GetRealOrders(string openId)
        {
            var orders = BS.GetRealOrders(openId);
            return new JsonResult() { Data = orders, MaxJsonLength = int.MaxValue };
        }
        [HttpPost]
        public ActionResult RequestRefund(Guid orderId)
        {
             BS.RequestRefund(orderId);
            return new JsonResult() { Data = "OK" };
        }
        
        [HttpPost]
        public ActionResult UpdateOrders(List<Guid> orders)
        {
            //todo
            return new JsonResult() { Data = "OK" };
        }

        #region address
        [HttpPost]
        public ActionResult GetCustomerAddress(string openId)
        {
            var addressList = BS.GetAddressList(openId);
            return new JsonResult() { Data = addressList, MaxJsonLength = int.MaxValue };
        }

        [HttpPost]
        public ActionResult UpdateAddress(ZZAddress address)
        {
            var addressId=BS.UpdateAddress(address);
            return new JsonResult() { Data = addressId };
        }
        [HttpPost]
        public ActionResult DeleteAddress(Guid addressId)
        {
            BS.DeleteAddress(addressId);
            return new JsonResult() { Data = "OK" };
        }
        #endregion

        [HttpPost]
        public ActionResult GetPublicDesgins(string customerId)
        {
            var desgins = BS.GetPublicDesgins(customerId); 
            return new JsonResult()
            {
                Data = desgins,
                MaxJsonLength = int.MaxValue
            };
        }

        [HttpPost]
        public ActionResult GetMyFollowedDesgins(string customerId)
        {
            var desgins = BS.GetMyFollowedDesgins(customerId);
            return new JsonResult()
            {
                Data = desgins,
                MaxJsonLength = int.MaxValue
            };
        }

        #region follow
        [HttpPost]
        public ActionResult UpdateDesginFollowStatus(Guid designId, string customerId, bool follow)
        {
            BS.UpdateDesginFollowStatus(designId,customerId,follow);
            return new JsonResult() { Data = "OK" }; 
        }
        #endregion
    }
}