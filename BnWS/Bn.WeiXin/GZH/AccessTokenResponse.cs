using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bn.WeiXin.GZH
{
    public class AccessTokenResponse
    {
        public string access_token { get; set; }
        public int expires_in { get; set; }
        public string refresh_token { get; set; }
        public string openid { get; set; }
        public string scope { get; set; }
    }

    public class JSApiResponse
    {
        public int errcode { get; set; }
        public string errmsg { get; set; }
        public string ticket { get; set; }
        public int expires_in { get; set; }
    }

    public class JSSDKConfig
    {
        public string appId { get; set; }
        public string timestamp { get; set; }
        public string nonceStr { get; set; }
        public string signature { get; set; }
    }

    public class JSSDKPayOrder
    {
        public string out_trade_no { get; set; }
        public string body { get; set; }
        public string attach { get; set; }
        public string detail { get; set; }
        public string total_fee { get; set; }
        public string goods_tag { get; set; }
        public string trade_type { get; set; }
        public string openid { get; set; }


        public string notify_url { get; set; }
        public string appid { get; set; }
        public string mch_id { get; set; }
        public string spbill_create_ip { get; set; }
        public string nonce_str { get; set; }
        public string sign { get; set; }
    }

    public class UnifiedOrder
    {
        public string return_code { get; set; }
        public string return_msg { get; set; }
        public string prepay_id { get; set; }
        public string nonce_str { get; set; }
    }

    public class PayInfo
    {
        public string return_code { get; set; }
        public string return_msg { get; set; }
        public string appid { get; set; }
        public string mch_id { get; set; }
        public string device_info { get; set; }
        public string nonce_str { get; set; }
        public string sign { get; set; }
        public string sign_type { get; set; }
        public string result_code { get; set; }
        public string err_code { get; set; }
        public string err_code_des { get; set; }
        public string openid { get; set; }
        public string is_subscribe { get; set; }
        public string trade_type { get; set; }
        public string bank_type { get; set; }
        public string total_fee { get; set; }
        public string settlement_total_fee { get; set; }
        public string fee_type { get; set; }
        public string cash_fee { get; set; }
        public string cash_fee_type { get; set; }
        public string coupon_fee { get; set; }
        public string coupon_count { get; set; }
        //public string coupon_type_$n { get; set; }
        //public string coupon_id_$n { get; set; }
        //public string coupon_fee_$n { get; set; }
        public string transaction_id { get; set; }
        public string out_trade_no { get; set; }
        public string attach { get; set; }
        public string time_end { get; set; }
    }
}
