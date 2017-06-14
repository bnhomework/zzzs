using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BnWS.Business;

namespace BnWS.Controllers
{

    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            var currenUser = CurrentUser;
            if (currenUser == null)
                return RedirectToAction("Login", "Account");
            var pbs = new PermissionBS();
            ViewBag.Menus = pbs.GetMenus(currenUser.UserId);
            ViewBag.User = currenUser.LoginName;
            ViewBag.Role = pbs.GetUserRoles(currenUser.UserId).OrderBy(x=>x).FirstOrDefault();
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult Dashboard()
        {
            return View();
        }
    }

    public class BnAuth : AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            base.OnAuthorization(filterContext);
        }
    }
}