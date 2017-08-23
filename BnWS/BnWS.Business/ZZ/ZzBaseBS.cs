using System;
using BnWS.Entity;
using Repository;

namespace BnWS.Business
{
    public class ZzBaseBS : BaseBS
    {
        public ZzBaseBS() : base()
        {
            
        }
        public ZzBaseBS(AppContext appContext)
            : base(appContext)
        {

        }

        public void InsertOrderStatusHistory(IUnitOfWork uow, Guid orderId, int status)
        {
            var history = new ZZ_OrderStatusHistory()
            {
                Id = Guid.NewGuid(),
                OrderId = orderId,
                OrderStatus = status,
                StatusDate = DateTime.Now
            };
            uow.Repository<ZZ_OrderStatusHistory>().Insert(history);
        }
    }
}