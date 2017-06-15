using System.IO;
using BnWS.Business;
using BnWS.Entity;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace BnWS.Controllers
{
    public class JsonNetResult : JsonResult
    {
        public JsonSerializerSettings Settings { get; set; }

        public JsonNetResult()
        {
            Settings = new JsonSerializerSettings
            {
                //To ignore the loop reference                 
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
            };
        }
        /// <summary>
        /// Return Json result by customized setting
        /// </summary>
        /// <param name="context"></param>
        public override void ExecuteResult(ControllerContext context)
        {
            if (context == null)
                throw new ArgumentNullException("context");
            if (this.JsonRequestBehavior == JsonRequestBehavior.DenyGet && string.Equals(context.HttpContext.Request.HttpMethod, "GET", StringComparison.OrdinalIgnoreCase))
                throw new InvalidOperationException("JSON GET is not allowed");
            HttpResponseBase response = context.HttpContext.Response;
            response.ContentType = string.IsNullOrEmpty(this.ContentType) ? "application/json" : this.ContentType;
            if (this.ContentEncoding != null)
                response.ContentEncoding = this.ContentEncoding;
            if (this.Data == null)
                return;
            var scriptSerializer = JsonSerializer.Create(this.Settings);
            using (var sw = new StringWriter())
            {
                scriptSerializer.Serialize(sw, this.Data);
                response.Write(sw.ToString());
            }
        }
    }
    public class BaseController : Controller
    {

        protected string auth_key = "ZY_Auth";
        protected override JsonResult Json(object data, string contentType, Encoding contentEncoding, JsonRequestBehavior behavior)
        {
            return new JsonNetResult
            {
                Data = data,
                ContentType = contentType,
                ContentEncoding = contentEncoding,
                JsonRequestBehavior = behavior,
                Settings = new JsonSerializerSettings
                {
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
                    DateFormatString =  System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.SortableDateTimePattern
                }
            };
        }

        private T_S_User _currentUser;
        protected T_S_User CurrentUser
        {
            get { return _currentUser ?? (_currentUser = GetCurrentUser()); }
        }

        private T_S_User GetCurrentUser()
        {
            var token = HttpContext.Request.Cookies.Get(auth_key);
            if (token == null)
            {
                return null;
            }
            return new AccountBS().GetUserByTokenId(token.Value);

        }

        private AppContext _appContext;

        private void BuildContext()
        {
            _appContext=new AppContext();
            if (CurrentUser != null)
            {
                _appContext.UserId = CurrentUser.UserId;
                _appContext.UserName = CurrentUser.LoginName;
            }
        }

        protected AppContext AppContext
        {
            get
            {
                if (_appContext == null)
                    BuildContext();
                return _appContext;
            }
        }
    }

    public class BaseController<T> : BaseController where T:BaseBS,new()
    {
        protected T _bs;

        protected T BS
        {
            get
            {
                if (_bs == null)
                {
                    _bs=new T();
                    _bs.AppContext = this.AppContext;
                }
                return _bs;
            }
        }
    }

}