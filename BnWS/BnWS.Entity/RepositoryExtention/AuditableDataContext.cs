using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Repository;
using Repository.Providers.EntityFramework;

namespace BnWS.Entity
{
    public class AuditableDataContext : DataContext
    {

        //[Dependency]
        private IAuditInfo _auditInfo;

        public IAuditInfo AuditInfo
        {
            get
            {
                return _auditInfo ?? (_auditInfo = new AppContext()
                {
                    UserName = "anonymous"
                });
            }
            set { _auditInfo = value; }
        }

        public AuditableDataContext(string nameOrConnectionString)
            : base(nameOrConnectionString)
        { }
        protected override void SyncObjectsStatePreCommit()
        {
            foreach (var dbEntityEntry in ChangeTracker.Entries())
            {
                dbEntityEntry.State = StateHelper.ConvertState(((IObjectState)dbEntityEntry.Entity).ObjectState);
                if (((IObjectState)dbEntityEntry.Entity).ObjectState.Equals(ObjectState.Added))
                {
                    ((IAuditableEntity)dbEntityEntry.Entity).CreatedBy = AuditInfo.UserName;
                    ((IAuditableEntity)dbEntityEntry.Entity).CreatedTime = DateTime.Now;
                }
                if (!((IObjectState)dbEntityEntry.Entity).ObjectState.Equals(ObjectState.Unchanged))
                {
                    ((IAuditableEntity) dbEntityEntry.Entity).VersionNo += 1;
                    ((IAuditableEntity)dbEntityEntry.Entity).TransactionId = AuditInfo.TransactionId;
                    ((IAuditableEntity)dbEntityEntry.Entity).UpdatedBy = AuditInfo.UserName;
                    ((IAuditableEntity)dbEntityEntry.Entity).UpdatedTime = DateTime.Now;
                }

            }
        }
    }
    public interface IAuditableEntity
    {
        int VersionNo { get; set; }
        Guid TransactionId { get; set; }
        string CreatedBy { get; set; }
        DateTime CreatedTime { get; set; }
        string UpdatedBy { get; set; }
        DateTime UpdatedTime { get; set; }
    }
    public interface IAuditInfo
    {
        string UserName { get; set; }
        Guid TransactionId { get; set; }
    }
}
