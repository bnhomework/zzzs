using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using Bn.WeiXin;
using System.Web.Mvc;
using Bn.WeiXin.GZH;
using Bn.WeiXin.Handlers;
using BnWS.Business;
using BnWS.Entity;

namespace BnWS.Views
{
    public class WXController : Controller
    {
       
        public ActionResult Index(string signature, string timestamp, string nonce, string echostr)
        {
            if (CheckSignature.Check(signature, timestamp, nonce, WxConfig.Token))
            {
                return Content(echostr);
            }
            return Content("failed");
        }

        [HttpPost]
        [ActionName("Index")]
        public ActionResult ReceiveMessage(string signature, string timestamp, string nonce, string echostr)
        {
            if (!CheckSignature.Check(signature, timestamp, nonce, WxConfig.Token))
            {
                return Content("error");
            }
            Stream s = System.Web.HttpContext.Current.Request.InputStream;
            var b = new byte[s.Length];
            s.Read(b, 0, (int)s.Length);
            string postStr = Encoding.UTF8.GetString(b);
            var response = WxHelper.Handle(postStr, new BnWxMessageHander());
            return Content(response);
        }
         [HttpPost]
        public ActionResult Pay(PayInfo payInfo)
         {
             var context = new AppContext() {UserId = new Guid("0D321367-C97F-46B0-81B7-4EDC5D7A2829"), UserName = "WX"};
             var bs =new ZzBS(context);
             var wx = new WXBS(context);
             var s = this.Request.InputStream;
             var count = 0;
             var buffer = new byte[1024];
             var builder = new StringBuilder();
             while ((count = s.Read(buffer, 0, 1024)) > 0)
             {
                 builder.Append(Encoding.UTF8.GetString(buffer, 0, count));
             }
             s.Flush();
             s.Close();
             s.Dispose();
             var xml = builder.ToString();
             payInfo = Utility.Deserialize<PayInfo>(xml);
             var result = wx.ConfirmPayment(payInfo);
             bs.ConfirmPayment(payInfo);
             return Content(result ? "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>" 
                 : "<xml><return_code><![CDATA[FAILED]]></return_code><return_msg><![CDATA[ERROR]]></return_msg></xml>");
         }
        public ActionResult Login()
        {
            //1.get open id
            //2.check js skd api
            string url = string.Format("https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope={2}&state=STATE#wechat_redirect"
                ,WxConfig.Appid
                ,Url.Encode(WxConfig.WebServerUrl+"/WX/LoginCallback")
                , "snsapi_userinfo");
            return Redirect(url);
        }

        public ActionResult LoginCallback(string code,string state)
        {
            var wxHelper = WxApiHelper.Instance;
            string requestData=string.Format("appid={0}&secret={1}&code={2}&grant_type=authorization_code",
                WxConfig.Appid
                ,WxConfig.Secret
                ,code);
            string url = "https://api.weixin.qq.com/sns/oauth2/access_token";
           var res= wxHelper.GetJosnData<AccessTokenResponse>(requestData, url);
            if (res!=null&&!string.IsNullOrEmpty(res.openid))
            {
                var bs = new WXBS(new AppContext(){UserId = Guid.NewGuid(),UserName = res.openid});
                bs.UpsertCustomer(res);
                var redirectUrl = string.Format("{0}/{1}", WxConfig.WebClientUrl ,res.openid);
                return Redirect(redirectUrl);
            }
            else
            {
                return RedirectToAction("WX404");
            }
        }

        
        public ActionResult JSSDK(string url)
        {
            var config= WxApiHelper.Instance.JSSDK_Config(url);
            return new JsonResult() {Data = config, JsonRequestBehavior = JsonRequestBehavior.AllowGet};
        }
        public ActionResult WX404()
        {
            return Content("微信授权失败,请刷新页面");
        }


        public ActionResult GetUserInfo(string openId)
        {
            var user = new WXBS().GetWXUserInfo(openId);

            return new JsonResult() { Data = new{user.UserName,user.Avatar,user.OpenId}, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        [HttpPost]
        public ActionResult loadImageFromWX(string serverId)
        {
            try
            {

                var url = WxApiHelper.Instance.loadImageFromWX(serverId);
                var mywebclient = new WebClient();
                var ext = url.Reverse().ToString().Split('.')[0].Reverse().ToString();
                var fileName = string.Format("{0}.{1}",
                    DateTime.Now.ToString("yyyyMMddHHmmssfff") + (new Random()).Next().ToString().Substring(0, 4), ext);

                var serverPath = string.Format("{0}\\temp\\{1}", WxConfig.WebServerUrl, fileName);

                var savepath = string.Format("{0}\\{1}", Server.MapPath("Temp"), fileName);

                mywebclient.DownloadFile(url, savepath);
                return new JsonResult() { Data = serverPath };

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.ToString());
                throw;
            }
        }
    }
}