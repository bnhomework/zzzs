using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using Bn.WeiXin.GZH;
using BnWS.Entity;
using Bn.WeiXin;
using System.Web;

namespace BnWS.Business
{
    public class WXBS : BaseBS
    {
        public WXBS()
            : base()
        {

        }

        public WXBS(AppContext appContext)
            : base(appContext)
        {

        }

        public void UpsertCustomer(AccessTokenResponse response)
        {
            using (var uow = GetUnitOfWork())
            {
                var customer =
                    uow.Repository<ZY_Customer>()
                        .Query()
                        .Filter(x => x.OpenId == response.openid)
                        .Get()
                        .FirstOrDefault(); 
                var userName = "";
                var fname = string.Format("{0}.jpg", Utility.Signature(response.openid));
                var headimg = Path.Combine("upload","wxhead", fname);
                var localheadimg = Path.Combine(HttpContext.Current.Server.MapPath("~"), "upload", "wxhead", fname);

                if (customer == null || string.IsNullOrEmpty(customer.UserName) || string.IsNullOrEmpty(customer.Avatar))
                {
                    var wxuser = WxApiHelper.Instance.GetWxUserInfo(response.openid, response.access_token);
                    if (wxuser != null)
                    {
                        userName = wxuser.nickname;
                        try
                        {
                            Utility.DownloadFile(wxuser.headimgurl, localheadimg);

                        }
                        catch
                        {
                            //

                            Debug.WriteLine(wxuser.headimgurl);
                            Debug.WriteLine(localheadimg);
                        }
                    }
                }
                else
                {
                    userName = customer.UserName;
                }
                if (customer == null)
                {
                    customer = new ZY_Customer
                    {
                        OpenId = response.openid,
                        UserName = userName,
                        TokenId = response.access_token,
                        Avatar = headimg
                    };
                    uow.Repository<ZY_Customer>().Insert(customer);
                }
                else
                {
                    customer.TokenId = response.access_token;
                    customer.UserName = userName;
                    customer.Avatar = headimg;
                    uow.Repository<ZY_Customer>().Update(customer);
                }
                uow.Save();
            }
        }

        public ZY_Customer GetWXUserInfo(string openId)
        {
            using (var db = GetDbContext())
            {
               var u= db.ZY_Customer.Find(openId) ?? new ZY_Customer();
               return u;
            }
        }
        public bool ConfirmPayment(PayInfo payInfo)
        {
            using (var uow = GetUnitOfWork())
            {
                var pay = new Pay();
                pay.Id = Guid.NewGuid();
                pay.return_code = payInfo.return_code;
                pay.return_msg = payInfo.return_msg;
                pay.appid = payInfo.appid;
                pay.mch_id = payInfo.mch_id;
                pay.device_info = payInfo.device_info;
                pay.nonce_str = payInfo.nonce_str;
                pay.sign = payInfo.sign;
                pay.sign_type = payInfo.sign_type;
                pay.result_code = payInfo.result_code;
                pay.err_code = payInfo.err_code;
                pay.err_code_des = payInfo.err_code_des;
                pay.openid = payInfo.openid;
                pay.is_subscribe = payInfo.is_subscribe;
                pay.trade_type = payInfo.trade_type;
                pay.bank_type = payInfo.bank_type;
                pay.total_fee = payInfo.total_fee;
                pay.settlement_total_fee = payInfo.settlement_total_fee;
                pay.fee_type = payInfo.fee_type;
                pay.cash_fee = payInfo.cash_fee;
                pay.cash_fee_type = payInfo.cash_fee_type;
                pay.coupon_fee = payInfo.coupon_fee;
                pay.coupon_count = payInfo.coupon_count;
                pay.transaction_id = payInfo.transaction_id;
                pay.out_trade_no = payInfo.out_trade_no;
                pay.attach = payInfo.attach;
                pay.time_end = payInfo.time_end;
                uow.Repository<Pay>().Insert(pay);
               
                uow.Save();
            }
            return true;
        }
    }
}