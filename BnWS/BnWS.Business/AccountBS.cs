using System;
using System.Linq;
using BnWS.Entity;
using Repository;

namespace BnWS.Business
{
    public class AccountBS : BaseBS
    {
        public AccountBS():base()
        {
            
        }
        public AccountBS(AppContext appContext)
            : base(appContext)
        {

        }
        public T_S_User SignIn(string email, string password,Guid sessionId)
        {
            using (var uow = GetUnitOfWork())
            {
                var user= uow.Repository<T_S_User>().Query().Filter(x=>x.LoginName==email&&x.Password==password).Get().FirstOrDefault();
                if (user != null)
                {
                    var token = new ZY_Session()
                    {
                        SessionId = sessionId,
                        UserId = user.UserId,
                        ExpireTime = DateTime.Now.AddDays(7),
                        ObjectState = ObjectState.Added
                    };
                    user.LastLoginTime = DateTime.Now;
                    uow.Repository<T_S_User>().Update(user);
                    uow.Repository<ZY_Session>().Insert(token);
                    uow.Save();
                }
                return user;
            }
        }

        public void SignOut(string tokenId)
        {
            using (var uow = GetUnitOfWork())
            {
               var token= uow.Repository<ZY_Session>()
                    .Query()
                    .Filter(x => x.SessionId.ToString() == tokenId).Get().FirstOrDefault();
                if (token != null)
                {
                    token.ExpireTime = DateTime.Now;
                    uow.Repository<ZY_Session>().Update(token);
                    uow.Save();
                }
            }

        }

        public T_S_User GetUserByTokenId(string tokenId)
        {
            using (var uow = GetUnitOfWork())
            {
                return uow.Repository<ZY_Session>()
                    .Query()
                    .Filter(x => x.SessionId.ToString() == tokenId && x.ExpireTime > DateTime.Now)
                    .Include(x => x.T_S_User)
                    .Get()
                    .Select(x=>x.T_S_User)
                    .FirstOrDefault();
            }
        }
    }
}