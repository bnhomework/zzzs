using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using BnWS.Entity;
using LinqKit;

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

                var order = new ZY_Order()
                {
                    OrderId = Guid.NewGuid(),
                    Amount = 0,
                    IsInternal = true,
                    OrderDate = selectedDate,
                    Status = 1
                };
                var bookedPositions = new List<ZY_Booked_Position>();
                positions.ForEach(p =>
                {
                    var bookedPosition = new ZY_Booked_Position
                    {
                        Id = Guid.NewGuid(),
                        IsInternal = true,
                        OrderDate = selectedDate,
                        Position = p,
                        DeskId = deskId,
                        Status = "1"
                    };
                    bookedPositions.Add(bookedPosition);
                });
                uow.Repository<ZY_Order>().Insert(order);
                uow.Repository<ZY_Booked_Position>().InsertRange(bookedPositions);
                uow.Save();
            }
        }

        public List<OrderReview> GetOrders(SearchOrderCondition condition)
        {
            var orderPred = PredicateBuilder.New<ZY_Order>(true);
            if (condition.From.HasValue)
            {
                orderPred = orderPred.And(x => x.OrderDate >= condition.From.Value);
            }
            if (condition.To.HasValue)
            {
                orderPred = orderPred.And(x => x.OrderDate <= condition.To.Value);
            }
            if (condition.Status.HasValue)
            {
                orderPred = orderPred.And(x => x.Status.Equals(condition.Status.Value));
            }
            if (!string.IsNullOrEmpty(condition.CustomerOpenId))
            {
                orderPred = orderPred.And(x =>x.CustomerOpenId.Contains(condition.CustomerOpenId));
            }
            var shopPred = PredicateBuilder.New<ZY_Shop>(true);
            if (!condition.ShopId.HasValue)
            {
                condition.ShopId = Guid.NewGuid();
            }
            shopPred = shopPred.And(x => condition.ShopId.Value==(x.ShopId));
            
            using (var db = GetDbContext())
            {
                var positions = (from bp in db.ZY_Booked_Position
                    join o in db.ZY_Order.AsExpandable().Where(orderPred) on bp.OrderId equals o.OrderId
                    join desk in db.ZY_Shop_Desk on bp.DeskId equals desk.DeskId
                    join shop in db.ZY_Shop.AsExpandable().Where(shopPred) on desk.ShopId equals shop.ShopId
                    select new
                    {
                        o.OrderId,
                        ShopName=shop.Name,
                        desk.DeskName,
                        o.OrderDate,
                        bp.Position,
                        o.Status,
                        o.Amount,
                        o.IsInternal,
                        o.CustomerOpenId,
                        o.PickTime
                    }).ToList();
               return positions.GroupBy(
                    x => new {x.OrderId, x.OrderDate, x.ShopName, x.DeskName, x.Status, x.IsInternal, x.Amount,x.CustomerOpenId,x.PickTime})
                    .Select(x => new OrderReview()
                    {
                        OrderId = x.Key.OrderId,
                        OrderDate = x.Key.OrderDate,
                        ShopName = x.Key.ShopName,
                        DeskName = x.Key.DeskName,
                        Status = x.Key.Status,
                        IsInternal = x.Key.IsInternal,
                        Amount = x.Key.Amount,
                        Positions = x.Select(p => p.Position).ToList(),
                        PickTime = x.Key.PickTime,
                        CustomerOpenId = x.Key.CustomerOpenId

                    }).ToList();
            }

        }
        public void RefundOrder(Guid orderId)
        {
            using (var uow = GetUnitOfWork())
            {
                var order =
                    uow.Repository<ZY_Order>().Query().Filter(x => x.OrderId == orderId&&x.Status!=-2).Get().FirstOrDefault();
                if(order==null)
                    return;
                order.Status = -2;
//                var bps = uow.Repository<ZY_Booked_Position>().Query().Filter(x => x.OrderId == orderId).Get().ToList();
//                
//                order.Comments = string.Join(",",bps.Select(x => x.Position).ToList());
//                bps.ForEach(x =>
//                {
//                    x.Status = x.Id.ToString();
//                    uow.Repository<ZY_Booked_Position>().Update(x);
//                });
                uow.Repository<ZY_Order>().Update(order);
                uow.Save();
            }

        }
    }
}