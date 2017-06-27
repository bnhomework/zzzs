using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using BnWS.Entity;
using LinqKit;

namespace BnWS.Business
{
    public class ZzManageBS : BaseBS
    {
        public ZzManageBS() : base()
        {
            
        }
        public ZzManageBS(AppContext appContext)
            : base(appContext)
        {

        }

        public List<ZZ_Template> SearchTemplateByCondistion(TemplateCondition condition)
        {
            var templatePred = PredicateBuilder.New<ZZ_Template>(true);
            if (condition.Category.HasValue)
            {
                templatePred = templatePred.And(x => x.Category==condition.Category.Value);
            }
            if (condition.Sex.HasValue)
            {
                templatePred = templatePred.And((x => x.Sex == condition.Sex.Value));
            }
            if (!string.IsNullOrEmpty(condition.Color))
            {
                templatePred = templatePred.And(x => x.Color == condition.Color);
            }
            using (var db = GetDbContext())
            {
               return db.ZZ_Template.AsExpandable().Where(templatePred).ToList();
            }
        }

    }
}