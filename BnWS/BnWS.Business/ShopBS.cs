using System;
using System.Collections.Generic;
using System.Linq;
using BnWS.Entity;

namespace BnWS.Business
{
    public class ShopBS : BaseBS
    {
        public ShopBS() : base()
        {
            
        }
        public ShopBS(AppContext appContext) : base(appContext)
        {

        }

        public List<ZY_Shop> SearchShops(ShopCriteria shopCriteria)
        {
            using (var uow = GetUnitOfWork())
            {
                return uow.Repository<ZY_Shop>().Query().Get().ToList();
            }
        }

        public List<ZY_Shop> GetShopsByUserId(Guid userId)
        {
            using (var uow = GetUnitOfWork())
            {
                return uow.Repository<ZY_Shop>().Query().Filter(x => x.OwnId == userId&&x.ShopStatus==1).Get().OrderBy(x=>x.Name).ToList();
            }

        }

        public List<DeskViewModel> GetShopDesks(Guid shopId, DateTime date)
        {
            var id = new System.Data.SqlClient.SqlParameter
            {
                ParameterName = "@shopId",
                Value = shopId
            };
            var d=new System.Data.SqlClient.SqlParameter
            {
                ParameterName = "@date",
                Value = date
            };
            using (var db = GetDbContext())
            {
                var result=db.Database.SqlQuery<DeskViewModel>("sp_GetDesks @shopId,@date", id, d);
                return result.ToList();
            }
        }

        public void BookPositionsInternal(Guid deskId, DateTime selectedDate, List<string> positions)
        {
            using (var uow = GetUnitOfWork())
            {
                var orders = new List<ZY_Booked_Position>();
                positions.ForEach(p =>
                {
                    var order = new ZY_Booked_Position
                    {
                        Id = Guid.NewGuid(),
                        IsInternal = true,
                        OrderDate = selectedDate,
                        Position = p,
                        DeskId = deskId,
                        Status = 1
                    };
                    orders.Add(order);
                });

                uow.Repository<ZY_Booked_Position>().InsertRange(orders);
                uow.Save();
            }
        }

        public void BookPositions()
        {
            
        }
    }
}