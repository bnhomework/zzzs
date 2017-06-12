using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BnWS.Entity
{
    public class AppContext:IAuditInfo
    {
        public AppContext()
        {
            TransactionId = Guid.NewGuid();
        }
        public Guid UserId { get; set; }
        public string UserName { get; set; }
        public Guid TransactionId { get; set; }
    }
}
