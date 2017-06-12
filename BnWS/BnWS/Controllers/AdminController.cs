using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BnWS.Business;
using BnWS.Entity;

namespace BnWS.Controllers
{
    public class AdminController : BaseController
    {
        private PermissionBS _permissionBS=new PermissionBS();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }
        #region role
        [HttpGet]
        public ActionResult Roles()
        {
            ViewBag.Functions = _permissionBS.GetAllMenus();
            return View();
        }

        [HttpGet]
        public ActionResult GetRoles()
        {
            var roles = _permissionBS.GetRoles();
            return Json(new{data = roles}, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult AddRole(T_S_Role item)
        {
            _permissionBS.AddRole(item);
            return Json("");
            
        }
        public ActionResult DeleteRole(Guid itemId)
        {
            _permissionBS.DeleteRole(itemId);
            return Json("");
        }
        public ActionResult UpdateRole(T_S_Role item)
        {
            _permissionBS.UpdateRole(item);
            return Json("");
        }
        public ActionResult UpdateRoleFunctions(Guid userId, List<Guid> roles)
        {
            _permissionBS.UpdateRoleFunctions(userId, roles);
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
            var roles = _permissionBS.GetFunctions();
            return Json(new { data = roles }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult AddFunction(T_S_Function item)
        {
            _permissionBS.AddFunction(item);
            return Json("");

        }
        public ActionResult DeleteFunction(Guid itemId)
        {
            _permissionBS.DeleteFunction(itemId);
            return Json("");
        }
        public ActionResult UpdateFunction(T_S_Function item)
        {
            _permissionBS.UpdateFunction(item);
            return Json("");
        }
        #endregion

        #region users
        public ActionResult Users()
        {
            ViewBag.Roles = _permissionBS.GetRoles();
            return View();
        }
        [HttpGet]
        public ActionResult GetUsers()
        {
            var roles = _permissionBS.GetUsers();
            return Json(new { data = roles }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult AddUser(T_S_User item)
        {
            _permissionBS.AddUser(item);
            return Json("");

        }
        public ActionResult DeleteUser(Guid itemId)
        {
            _permissionBS.DeleteUser(itemId);
            return Json("");
        }
        public ActionResult UpdateUser(T_S_User item)
        {
            _permissionBS.UpdateUser(item);
            return Json("");
        }
        public ActionResult UpdateUserRole(Guid userId,List<Guid> roles)
        {
            _permissionBS.UpdateUserRole(userId,roles);
            return Json("");
        }
        #endregion
    }
}