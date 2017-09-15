using System;
using System.Collections.Generic;
using System.Linq;
using BnWS.Entity;
using Repository;

namespace BnWS.Business
{
    public class CommonBS : BaseBS
    {
        public CommonBS()
            : base()
        {

        }

        public CommonBS(AppContext appContext)
            : base(appContext)
        {

        }
        public void InsertMessage(IUnitOfWork uow, NotificationMessage message)
        {
            var m = new T_S_Message();
            m.Id = Guid.NewGuid();
            m.UserId = message.UserId;
            m.Title = message.Title;
            m.Content = message.Content;
            uow.Repository<T_S_Message>().Insert(m);
        }

        public List<NotificationMessageReview> GetMessagesByUserId(string userId)
        {
            using (var db = GetDbContext())
            {
                var messages = from m in db.T_S_Message
                    where m.UserId == userId
                    orderby m.CreatedTime descending
                    select new NotificationMessageReview()
                    {
                        Id = m.Id,
                        UserId = m.UserId,
                        Title = m.Title,
                        Content = m.Content,
                        CreatedTime = m.CreatedTime,
                        ReadTime = m.ReadTime
                    };
                return messages.ToList();
            }
        }

        public int GetNumberOfUnreadMessages(string userId)
        {
            using (var db = GetDbContext())
            {
                return db.T_S_Message.Where(x => x.UserId == userId && x.ReadTime == null).Count();
            }
        }

        public void MarkMessageReaded(List<Guid> messageIds)
        {
            using (var uow = GetUnitOfWork())
            {
                var messages= uow.Repository<T_S_Message>().Query().Filter(x => messageIds.Contains(x.Id)).Get().ToList();
                messages.ForEach(x =>
                {
                    x.ReadTime = DateTime.Now;
                    uow.Repository<T_S_Message>().Update(x);
                });
                uow.Save();
            }
        }
    }
}