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
        protected AppContext _appConext;

        public AppContext AppContext
        {
            get { return _appConext; }
            set { _appConext = value; }
        }

        public BaseBS()
        {
            
        }
        public BaseBS(AppContext appContext)
        {
            _appConext = appContext;
        }
        protected IUnitOfWork GetUnitOfWork()
        {
            return new UnitOfWork(DBContext);
        }

        private BnAppEntities _db;
        protected BnAppEntities DBContext
        {
            get {
                if (_db == null)
                {
                    _db=new BnAppEntities();
                }
                return _db;
            }
        }
    }

}
