using System;
using System.Linq;
using System.Security.Cryptography;
using System.Web.Mvc;
using BnWS.Business;
using BnWS.Controllers;
using BnWS.Entity;

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
                x.IsPublic
                ,x.UnitPrice
            }), MaxJsonLength = int.MaxValue };
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
    }
}