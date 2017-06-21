using System.Linq;
using Bn.WeiXin.GZH;
using BnWS.Entity;

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
                if (customer == null)
                {
                    customer = new ZY_Customer
                    {
                        OpenId = response.openid,
                        UserName = "",
                        TokenId = response.access_token
                    };
                    uow.Repository<ZY_Customer>().Insert(customer);
                }
                else
                {
                    customer.TokenId = response.access_token;
                    uow.Repository<ZY_Customer>().Update(customer);
                }
                uow.Save();
                //todo load name
            }
        }
    
    }
}