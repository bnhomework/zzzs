using System;
using System.Collections.Generic;
using System.Linq;
using BnWS.Entity;
using LinqKit;

namespace BnWS.Business
{
    public class PlateFormBS : BaseBS
    {
        public PlateFormBS() : base()
        {

        }

        public PlateFormBS(AppContext appContext)
            : base(appContext)
        {

        }

        public List<ShopViewModel> SearchShops(ShopCriteria shopCriteria)
        {
            var shopPred = PredicateBuilder.New<ZY_Shop>(true);
            if (shopCriteria.Status.HasValue)
            {
                shopPred = shopPred.And(x => x.ShopStatus == shopCriteria.Status.Value);
            }
            if (!string.IsNullOrEmpty(shopCriteria.ShopName))
            {
                shopPred = shopPred.And(x => x.Name.Contains(shopCriteria.ShopName));
            }
            var userPred = PredicateBuilder.New<T_S_User>(true);
            if (!string.IsNullOrEmpty(shopCriteria.OwnerName))
            {
                userPred = userPred.And(x => x.LoginName.Contains(shopCriteria.OwnerName));
            }
            using (var db = GetDbContext())
            {
                var query = from s in db.ZY_Shop.AsExpandable().Where(shopPred)
                    join u in db.T_S_User.AsExpandable().Where(userPred) on s.OwnId equals u.UserId
                    select new ShopViewModel()
                    {
                        ShopId=s.ShopId,
                        ShopName = s.Name,
                        ShopStatus = s.ShopStatus,
                        ShopAddress = s.Address,
                        Owner = u.LoginName
                    };
                return query.ToList();
            }
        }

        public void UpdateShopStatus(Guid shopId, int status)
        {
            using (var uow=GetUnitOfWork())
            {
               var shop= uow.Repository<ZY_Shop>().Query().Filter(x => x.ShopId == shopId).Get().FirstOrDefault();
                if (shop != null)
                {
                    shop.ShopStatus = status;
                    uow.Repository<ZY_Shop>().Update(shop);
                    uow.Save();
                }
            }
        }
    }
}