using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Repository;
using BnWS.Entity;

namespace BnWS.Business
{
    public class BaseBS
    {
        protected IUnitOfWork GetUnitOfWork()
        {
            return new UnitOfWork(new BnAppEntities());
        }
    }
}
