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

                        Utility.DownloadFile(wxuser.headimgurl, localheadimg);
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
    }
}