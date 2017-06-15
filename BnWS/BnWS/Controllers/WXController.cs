using Bn.WeiXin;
using System.Web.Mvc;
using Bn.WeiXin.GZH;

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
                var redirectUrl = string.Format("{0}/wx/{1}", WxConfig.WebClientUrl ,res.openid);
                return Redirect(redirectUrl);
            }
            else
            {
                return RedirectToAction("WX404");
            }
        }

        public ActionResult WX404()
        {
            return Content("微信授权失败,请刷新页面");
        }
    }
}