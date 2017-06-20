using System;
using System.IO;
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
             var bs =
                 new ZYBS(new AppContext() {UserId = new Guid("0D321367-C97F-46B0-81B7-4EDC5D7A2829"), UserName = "WX"});
             var result=bs.ConfirmPayment(payInfo);
             if (result)
             {
                 return Content("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>");
                 
             }
             else
             {
                 return Content("<xml><return_code><![CDATA[FAILED]]></return_code><return_msg><![CDATA[ERROR]]></return_msg></xml>");
             }
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
    }
}