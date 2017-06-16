using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.InteropServices;
using System.Text;
using Bn.WeiXin.Messages;
using Newtonsoft.Json;
using Bn.WeiXin.GZH;

namespace Bn.WeiXin
{
    public class WxApiHelper
    {
        private WxApiHelper()
        { }
        public static WxApiHelper Instance
        {
            get
            {
                return _instance;
            }
        }
        private static readonly WxApiHelper _instance = new WxApiHelper();
        
        public T GetJosnData<T>(string requestPara, string url)
        {
            string data = GetData(requestPara, url);
            return JsonConvert.DeserializeObject<T>(data);
        }

        public static string GetJosnDataList<T>(List<string> list)
        {
            var r=new List<T>();
            list.ForEach(p => r.Add(JsonConvert.DeserializeObject<T>(p)));
          return  JsonConvert.SerializeObject(r);
        }

        public string GetData(string requestPara, string url)
        {
            requestPara = requestPara.IndexOf('?') > -1 ? (requestPara) : ("?" + requestPara);

            var hr = WebRequest.Create(url + requestPara);

            var buf = Encoding.GetEncoding("utf-8").GetBytes(requestPara);
            hr.Method = "GET";

            var response = hr.GetResponse();
            var reader = new StreamReader(response.GetResponseStream(), Encoding.GetEncoding("utf-8"));
            var returnVal = reader.ReadToEnd();
            reader.Close();
            response.Close();
            return returnVal;
        }
        public string PostData(string requestPara, string url)
        {
            var hr = WebRequest.Create(url);

            var buf = Encoding.GetEncoding("utf-8").GetBytes(requestPara);
            hr.ContentType = "application/x-www-form-urlencoded";
            hr.ContentLength = buf.Length;
            hr.Method = "POST";

            var requestStream = hr.GetRequestStream();
            requestStream.Write(buf, 0, buf.Length);
            requestStream.Close();

            var response = hr.GetResponse();
            var reader = new StreamReader(response.GetResponseStream(), Encoding.GetEncoding("utf-8"));
            var returnVal = reader.ReadToEnd();
            reader.Close();
            response.Close();

            return returnVal;
        }
        public string GetCache(string itemType, int expires_in = 6000)
        {
            var value = string.Empty;
            var folder = string.Format("{0}\\{1}", Environment.CurrentDirectory, itemType);
            if (Directory.Exists(folder))
            {
                var di = new DirectoryInfo(folder);
                var files = di.GetFiles();
                var f = files.OrderByDescending(x => x.Name).FirstOrDefault();

                DateTime itemDate;
                if (f != null
                    && DateTime.TryParse(f.Name, out itemDate)
                    && (DateTime.Now - itemDate).TotalSeconds < expires_in)
                {
                    using (var sr = new StreamReader(f.FullName.Replace("~", ":")))
                    {
                        value = sr.ReadLine();
                        sr.Close();
                    }
                }
            }
            return value;
        }

        public void SaveCache(string itemType, string value)
        {
            if (string.IsNullOrEmpty(value))
                return;
            var folder = string.Format("{0}\\{1}", Environment.CurrentDirectory, itemType);
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }
            var fileName = Path.Combine(folder, DateTime.Now.ToString("yyyy-MM-dd hh~mm~ss"));

            using (var sw = new StreamWriter(fileName, false))
            {
                sw.WriteLine(value);
                sw.Close();
            }
        }
        //todo:
        public string GetAccessToken()
        {
            string token = GetCache("Access_Token");
            if (string.IsNullOrEmpty(token))
            {
                token = RenewToken();
            }
            return token;
            //string token;
            //tokenFileName = string.Format("Access_Token_{0:yyyyMMddHH}", DateTime.Now);
            //var fileName = string.Format("{0}\\{1}", Environment.CurrentDirectory, tokenFileName);
            //if (!File.Exists(fileName))
            //{
            //    RenewToken();
            //}
            //using (var sr = new StreamReader(fileName))
            //{
            //    token = sr.ReadLine();
            //    sr.Close();
            //}
            //if (string.IsNullOrEmpty(token))
            //{
            //    token = RenewToken();
            //}
            //return token;
        }
        private string RenewToken()
        {
            var token = string.Empty;
            var url = WxConfig.TokenUrl;
            var data = string.Format("grant_type=client_credential&appid={0}&secret={1}", WxConfig.Appid, WxConfig.Secret);
            var temp = GetData(data, url).Replace("[", "").Replace("]", "").Split(',').FirstOrDefault(p => p.Contains("access_token")).Split(':');
            if (temp.Length == 2)
            {
                token = temp[1].Replace("\"", "");
            }
            SaveCache("Access_Token",token);
//            var fileName = string.Format("{0}\\{1}", Environment.CurrentDirectory, tokenFileName);
//            using (var sw = new StreamWriter(fileName, false))
//            {
//                sw.WriteLine(token);
//                sw.Close();
//            }
            return token;
        }

        public string ApplyMenu(string data)
        {
            var accessToken = GetAccessToken();
            var url = string.Format(WxConfig.MenuUrlCreate, accessToken);
            return PostData(data, url);
        }
        public string DeleteMenu()
        {
            var accessToken = GetAccessToken();
            var url = string.Format(WxConfig.MenuUrlDel);
            var data = string.Format("access_token={0}", accessToken);
            return GetData(data, url);
        }
        public WxMenu GetMenu()
        {
            WxMenu menu = null;
            var accessToken = GetAccessToken();
            var data = string.Format("access_token={0}", accessToken);
            var menuList= GetJosnData<WxMenuList>(data, WxConfig.MenuUrlGet);
            if (menuList != null)
            {
                menu = menuList.menu;
            }
            return menu;
        }

        //创建二维码ticket

        /*
         临时二维码请求说明 
        http请求方式: POST
        URL: https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=TOKEN
        POST数据格式：json
        POST数据例子：{"expire_seconds": 1800, "action_name": "QR_SCENE", "action_info": {"scene": {"scene_id": 123}}}


        永久二维码请求说明 
        http请求方式: POST
        URL: https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=TOKEN
        POST数据格式：json
        POST数据例子：{"action_name": "QR_LIMIT_SCENE", "action_info": {"scene": {"scene_id": 123}}}
        
         * 返回说明 
         * 正确的Json返回结果: 
         * {"ticket":"gQG28DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0FuWC1DNmZuVEhvMVp4NDNMRnNRAAIEesLvUQMECAcAAA==","expire_seconds":1800}
        错误的Json返回示例: 
        {"errcode":40013,"errmsg":"invalid appid"}
         */

        public string CreateTicket(bool isTemporarily)
        {
            return string.Empty;
        }

        #region js sdk

        public JSSDKConfig JSSDK_Config(string url)
        {
            url = url.Split('#')[0];
            var nonce_str = Guid.NewGuid().ToString();
            var timestamp = (DateTime.Now - TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1))).TotalSeconds.ToString();
            var jsapi_ticket = WxApiHelper.Instance.GetJSSDK_Ticket();
            var raw = "jsapi_ticket=" + jsapi_ticket + "&noncestr=" + nonce_str
                    + "&timestamp=" + timestamp + "&url=" + url;
            var signature = Utility.Signature(raw);
            var jssdk = new JSSDKConfig()
            {
                appId = WxConfig.Appid,
                timestamp = timestamp,
                nonceStr = nonce_str,
                signature = signature
            };
            return jssdk;
        }
        public string GetJSSDK_Ticket()
        {
            var ticket = GetCache("JSSDK_Ticket");
            if (string.IsNullOrEmpty(ticket))
            {
                ticket = RenewJSSDK_Ticket();
            }
            return ticket;
        }

        private string RenewJSSDK_Ticket()
        {
            var access_token = GetAccessToken();
            var ticket = string.Empty;
            var url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket";
            var data = string.Format("access_token={0}&type=jsapi", access_token);
            var res=GetJosnData<JSApiResponse>(data, url);
            if (res != null)
            {
                return res.ticket;
            }
            SaveCache("JSSDK_Ticket", ticket);
            return ticket;
        }
        #endregion


    }
    
}