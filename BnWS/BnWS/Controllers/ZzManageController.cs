using System;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using BnWS.Business;
using BnWS.Controllers;
using BnWS.Entity;

namespace BnWS.Views
{
    public class ZzManageController : BaseController<ZzManageBS>
    {
        [HttpPost]
        public ActionResult GetTemplates(TemplateCondition condition)
        {
            var templates = BS.SearchTemplateByCondistion(condition);
            return new JsonResult()
            {
                Data = templates.Select(x =>
                    new
                    {
                        x.TemplateId,
                        x.FrontImg,
                        x.BackImg,
                        x.Category,
                        x.Sex,
                        x.Color
                    })
            };
        }

        //[HttpPost]
        public ActionResult GetProductTypes()
        {
            var types = BS.GetProductTypes();
            return new JsonResult()
            {
                Data = types.Select(x =>
                    new
                    {
                        Id=x.CategoryId,
                        Name=x.Name
                    }).OrderBy(x => x.Name).ToList(),
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        #region 销售管理

        public ActionResult OrderManagement()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SearchOrderByCriteria(OrderSearchCondition condition)
        {
            var orders = BS.SearchOrderByCriteria(condition);
           

            var result = new JsonNetResult() { Data = orders, MaxJsonLength = int.MaxValue };
            result.Settings.DateFormatString = "yyyy-MM-dd";
            return result;
        }

        public ActionResult Pendding()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ProcessingOrder(Guid orderId)
        {
            var result = BS.ProcessingOrder(orderId);
            return new JsonResult() { Data = result };
        }

        public ActionResult Deliver()
        {
            return View();
        }

        [HttpPost]
        public ActionResult CompleteOrder(LogisticsInfo logisticsInfo)
        {
            var result = BS.CompleteOrder( logisticsInfo);
            return new JsonResult() { Data = result };
        }
        public ActionResult Refund()
        {
            return View();
        }
        [HttpPost]
        public ActionResult RefundOrder(Guid orderId)
        {
            var result = BS.RefundOrder(orderId);
            return new JsonResult() { Data = result };
        }

        public ActionResult ViewOrder(Guid orderId)
        {
            var vm = BS.GetOrderInfo(orderId);
            return View(vm);
        }
        #endregion



        #region 商品管理

        public ActionResult ProductCategory()
        {
            return View();
        }
        public ActionResult GetAllProductTypes()
        {
            var types = BS.GetProductTypes();
            return new JsonResult()
            {
                Data = types.OrderBy(x => x.CategoryId).ToList(),
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }
        [HttpPost]
        public ActionResult AddProductType(ZZ_Category item)
        {
            BS.AddProductType(item);
            return new JsonResult() {Data = "OK"};
        }
        [HttpPost]
        public ActionResult UpdateProductType(ZZ_Category item)
        {
            BS.UpdateProductType(item);
            return new JsonResult() { Data = "OK" };
        }
        [HttpPost]
        public ActionResult DeleteProductType(int itemId)
        {
            BS.DeleteProductType(itemId);
            return new JsonResult() { Data = "OK" };
        }
        public ActionResult Product()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddProduct(ZZTemplate item)
        {
            HandleImg(item);
            var r=BS.AddProduct(item);
            return new JsonResult() { Data = r };
        }
        [HttpPost]
        public ActionResult UpdateProduct(ZZTemplate item)
        {
            HandleImg(item);
            var r = BS.UpdateProduct(item);
            return new JsonResult() { Data = r };
        }

        private void HandleImg(ZZTemplate t)
        {
            t.FrontImg = CheckImg(t.FrontImg);
            t.BackImg = CheckImg(t.BackImg);
        }

        private string CheckImg(string filepath)
        {
            if (string.IsNullOrEmpty(filepath)||!filepath.StartsWith("temp/"))
            {
                return filepath;
            }
            string newFilePath = filepath.Replace("temp/", "Upload/template/");
            string from = Path.Combine(Request.MapPath("~"), filepath);
            string to = Path.Combine(Request.MapPath("~"), newFilePath);

            var fi = new FileInfo(from);
            fi.MoveTo(to);
            return newFilePath;

        }
        [HttpPost]
        public ActionResult DeleteProduct(Guid templateId)
        {
            var r = BS.DeleteProduct(templateId);
            return new JsonResult() { Data = r };
        }
        [HttpPost]
        public ActionResult GetAllTemplates(TemplateCondition condition)
        {
            var templates = BS.SearchTemplateByCondistion2(condition);
            return new JsonResult()
            {
                Data = templates
                //.Select(x =>
                //    new
                //    {
                //        x.TemplateId,
                //        x.FrontImg,
                //        x.BackImg,
                //        x.Category,
                //        x.Sex,
                //        x.Color
                //    })
            };
        }
        #endregion



        #region 统计

        public ActionResult OrderReport()
        {
            return View();
        }

        public ActionResult UserReport()
        {
            return View();
        }

        public ActionResult SalesReport()
        {
            return View();
        }

        #endregion

    }
}