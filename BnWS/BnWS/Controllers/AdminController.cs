using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BnWS.Business;
using BnWS.Entity;

namespace BnWS.Controllers
{
    public class AdminController : BaseController<PermissionBS>
    {
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }
        #region role
        [HttpGet]
        public ActionResult Roles()
        {
            ViewBag.Functions = BS.GetAllMenus();
            return View();
        }

        [HttpGet]
        public ActionResult GetRoles()
        {
            var roles = BS.GetRoles();
            return Json(new{data = roles}, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult AddRole(T_S_Role item)
        {
            BS.AddRole(item);
            return Json("");
            
        }
        public ActionResult DeleteRole(Guid itemId)
        {
            BS.DeleteRole(itemId);
            return Json("");
        }
        public ActionResult UpdateRole(T_S_Role item)
        {
            BS.UpdateRole(item);
            return Json("");
        }
        public ActionResult UpdateRoleFunctions(Guid userId, List<Guid> roles)
        {
            BS.UpdateRoleFunctions(userId, roles);
            return Json("");
        }
        #endregion

        #region Functions

        public ActionResult Functions()
        {
            return View();
        }
        [HttpGet]
        public ActionResult GetFunctions()
        {
            var roles = BS.GetFunctions();
            return Json(new { data = roles }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult AddFunction(T_S_Function item)
        {
            BS.AddFunction(item);
            return Json("");

        }
        public ActionResult DeleteFunction(Guid itemId)
        {
            BS.DeleteFunction(itemId);
            return Json("");
        }
        public ActionResult UpdateFunction(T_S_Function item)
        {
            BS.UpdateFunction(item);
            return Json("");
        }
        #endregion

        #region users
        public ActionResult Users()
        {
            ViewBag.Roles = BS.GetRoles();
            return View();
        }
        [HttpGet]
        public ActionResult GetUsers()
        {
            var roles = BS.GetUsers();
            return Json(new { data = roles }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult AddUser(T_S_User item)
        {
            BS.AddUser(item);
            return Json("");

        }
        public ActionResult DeleteUser(Guid itemId)
        {
            BS.DeleteUser(itemId);
            return Json("");
        }
        public ActionResult UpdateUser(T_S_User item)
        {
            BS.UpdateUser(item);
            return Json("");
        }
        public ActionResult UpdateUserRole(Guid userId,List<Guid> roles)
        {
            BS.UpdateUserRole(userId,roles);
            return Json("");
        }
        #endregion
    }
}