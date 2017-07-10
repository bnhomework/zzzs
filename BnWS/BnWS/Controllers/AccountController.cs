using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using BnWS.Business;
using BnWS.Entity;

namespace BnWS.Controllers
{
    public class AccountController : BaseController<AccountBS>
    {
        //public AccountController() { }
        //
        // GET: /Account/
        public ActionResult Index()
        {
            return View();
        }
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }
        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            var tokenId = Guid.NewGuid();
            var user = BS.SignIn(model.UserName, model.Password, tokenId);
            if (user!=null)
            {
                var token = new HttpCookie(auth_key, tokenId.ToString()) {Expires = DateTime.Now.AddDays(7)};
                HttpContext.Response.SetCookie(token);
                return RedirectToLocal(returnUrl);
            }
            ViewBag.Error = "登陆失败";
            return View(model);
        }
        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Index", "Home");
        }

        public ActionResult LogOut()
        {
           var token= HttpContext.Request.Cookies.Get(auth_key);
            if (token != null)
            {
                BS.SignOut(token.Value);
            }
            var newtoken = new HttpCookie(auth_key,"") { Expires = DateTime.Now.AddDays(-1) };
            HttpContext.Response.SetCookie(newtoken);
            return RedirectToAction("Login");
        }

        public ActionResult ChangePassword()
        {
            return View();
        }
        
        [HttpPost]
        public ActionResult DoChangePassword(PasswordVM passwordVm)
        {
            passwordVm.UserId = AppContext.UserId;
            var result = BS.ChangePassword(passwordVm);
            return new JsonNetResult() { Data = result };
        }
    }
}