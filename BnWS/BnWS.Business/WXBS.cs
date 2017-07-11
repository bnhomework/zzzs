using System.Linq;
using Bn.WeiXin.GZH;
using BnWS.Entity;
using Bn.WeiXin;

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
                if (customer == null || string.IsNullOrEmpty(customer.UserName))
                {
                    var wxuser = WxApiHelper.Instance.GetWxUserInfo(response.openid, response.access_token);
                    if (wxuser != null)
                    {
                        userName = wxuser.nickname;
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
                        TokenId = response.access_token
                    };
                    uow.Repository<ZY_Customer>().Insert(customer);
                }
                else
                {
                    customer.TokenId = response.access_token;
                    customer.UserName = userName;
                    uow.Repository<ZY_Customer>().Update(customer);
                }
                uow.Save();
                //todo load name
            }
        }
    
    }
}