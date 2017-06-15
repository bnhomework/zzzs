

using System.Configuration;

namespace Bn.WeiXin
{
    public class WxConfig
    {
        //TODO:move to config file
        private static string _token = string.Empty;//"wysbww";
        private static string _appId = string.Empty;//"wxb12d2164cce0e800";
        private static string _appsecret = string.Empty;// "8ec68e4773e89da15407ff1501658c8a";
        private static string _wsUrl = string.Empty;
        private static string _wxUrl = string.Empty;// "8ec68e4773e89da15407ff1501658c8a";

        //baidu api
        private static string _ak = //"6jOLD3YkipUn18bmZOb2rXhz";
        string.Empty;//"hOclb1CUGaCvxmpSGekMjITR";
        public static string Ak
        {
            get
            {
                if (string.IsNullOrEmpty(_ak))
                {
                    _ak = ConfigurationManager.AppSettings["baidu_api_ak"];
                }
                return _ak;
            }
        }

        public static string Appid
        {
            get
            {
                if (string.IsNullOrEmpty(_appId))
                {
                    _appId = ConfigurationManager.AppSettings["appid"];
                }
                return _appId;
            }
        }
        public static string Secret
        {
            get
            {
                if (string.IsNullOrEmpty(_appsecret))
                {
                    _appsecret = ConfigurationManager.AppSettings["appsecret"];
                }
                return _appsecret;
            }
        }
        public static string Token
        {
            get
            {
                if (string.IsNullOrEmpty(_token))
                {
                    _token = ConfigurationManager.AppSettings["token"];
                }
                return _token;
            }
        }

        public static string WebServerUrl
        {
            get
            {
                if (string.IsNullOrEmpty(_wsUrl))
                {
                    _wsUrl = ConfigurationManager.AppSettings["WebSitURL"];
                }
                return _wsUrl;
            }
        }

        public static string WebClientUrl
        {
            get
            {
                if (string.IsNullOrEmpty(_wxUrl))
                {
                    _wxUrl = ConfigurationManager.AppSettings["WebClientSitURL"];
                }
                return _wxUrl;
            }
        }

        public const string MenuUrlGet = "https://api.weixin.qq.com/cgi-bin/menu/get";
        public const string MenuUrlCreate = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token={0}";
        public const string MenuUrlDel = "https://api.weixin.qq.com/cgi-bin/menu/delete";
        public const string TokenUrl = "https://api.weixin.qq.com/cgi-bin/token";
    }
}
