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

    }
}