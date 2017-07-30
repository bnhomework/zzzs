using System;
using System.Linq;
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
                x.DesginId,
                x.Name,
                x.Tags,
                x.IsPublic
            }), MaxJsonLength = int.MaxValue };
        }
        [HttpPost]
        public ActionResult SetIsPublic(Guid desginId,bool ispublic)
        {
           BS.SetIsPublic(desginId,ispublic);
            return  new JsonResult(){Data = "OK"};
        }
    }
}