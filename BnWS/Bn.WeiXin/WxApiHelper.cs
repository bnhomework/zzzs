using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.InteropServices;
using System.Text;
using System.Xml.Serialization;
using Bn.WeiXin.Messages;
using Newtonsoft.Json;
using Bn.WeiXin.GZH;
using Bn.WeiXin.Entity;

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
        public T PostJosnData<T>(string requestPara, string url)
        {
            string data = PostData(requestPara, url);
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

        #region cache
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
        #endregion


        #region AccessToken
        public string GetAccessToken()
        {
            string token = GetCache("Access_Token");
            if (string.IsNullOrEmpty(token))
            {
                token = RenewToken();
            }
            return token;
        }
        private string RenewToken()
        {
            var token = string.Empty;
            var data = string.Format("grant_type=client_credential&appid={0}&secret={1}", WxConfig.Appid, WxConfig.Secret);
            var temp = GetData(data, WxConfig.TokenUrl).Replace("[", "").Replace("]", "").Split(',').FirstOrDefault(p => p.Contains("access_token")).Split(':');
            if (temp.Length == 2)
            {
                token = temp[1].Replace("\"", "");
            }
            SaveCache("Access_Token",token);
            return token;
        }
        #endregion

        #region menu management
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
        #endregion 


        #region js sdk

        public JSSDKConfig JSSDK_Config(string url)
        {
            url = url.Split('#')[0];
            var nonce_str = Utility.GenerateNonceStr();
            var timestamp = Utility.GetTimeSpan();
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

        private string GetPaymentId(JSSDKPayOrder order)
        {
            const string url = "https://api.mch.weixin.qq.com/pay/unifiedorder";

            order.appid = WxConfig.Appid;
            order.mch_id = WxConfig.mch_id;
            order.spbill_create_ip = order.spbill_create_ip;
            order.notify_url = WxConfig.NOTIFY_URL;
            order.nonce_str = Utility.GenerateNonceStr();
            var raw = "appid=" + order.appid
                      + "&attach=" + order.attach
                      + "&body=" + order.body
                      + "&detail=" + order.detail
                      + "&goods_tag=" + order.goods_tag
                      + "&mch_id=" + order.mch_id
                      + "&nonce_str=" + order.nonce_str
                      + "&notify_url=" + order.notify_url
                      + "&openid=" + order.openid
                      + "&out_trade_no=" + order.out_trade_no
                      + "&spbill_create_ip=" + order.spbill_create_ip
                      + "&total_fee=" + order.total_fee
                      + "&trade_type=" + order.trade_type
                      + "&key=" + WxConfig.wxpay_key;

            order.sign = Utility.Signature(raw,"MD5").ToUpper();
            var unifiedorder=PostJosnData<UnifiedOrder>(Utility.Serialize<JSSDKPayOrder>(order), url);
            
            if (unifiedorder.return_code != "SUCCESS")
                throw new Exception(unifiedorder.return_msg);
            return unifiedorder.prepay_id;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="out_trade_no"></param>
        /// <param name="openid"></param>
        /// <param name="spbill_create_ip"></param>
        /// <param name="total_fee">��λ��</param>
        /// <returns></returns>
        public JSSDKPrepay Prepay(string out_trade_no, string openid, string spbill_create_ip, string total_fee)
        {
            var prepay = new JSSDKPrepay();
            var o = new JSSDKPayOrder();
            o.body = WxConfig.wxpay_body;
            o.attach = WxConfig.wxpay_attach; 
            o.out_trade_no = out_trade_no.Substring(0, 32);
            o.spbill_create_ip = spbill_create_ip; //APP����ҳ֧���ύ�û���ip��Native֧�������΢��֧��API�Ļ���IP��
            o.openid = openid;
            o.total_fee = total_fee;
            prepay.prepay_id = GetPaymentId(o);
            prepay.appId = WxConfig.Appid;
            prepay.timeStamp = Utility.GetTimeSpan();
            prepay.nonceStr = Utility.GenerateNonceStr();
            prepay.signType = "MD5";
            string payRaw = "appId=" + prepay.appId
                            + "&nonceStr=" + prepay.nonceStr
                            + "&package=" + prepay.package
                            + "&signType=" + prepay.signType
                            + "&timeStamp=" + prepay.timeStamp
                            + "&key=" + WxConfig.wxpay_key;
            prepay.paySign = Utility.WXPaySignature(payRaw, prepay.signType);
            return prepay;

        }
        #endregion

        public WXUserInfo GetWxUserInfo(string openId, string accessToken)
        {
            var data = string.Format("access_token={0}&openid={1}&lang=zh_CN", accessToken, openId);
            var uif = GetJosnData<WXUserInfo>(data, " https://api.weixin.qq.com/sns/userinfo");
            return uif;
        }
    }
    
}