using System;
using System.Collections.Generic;
using System.Linq;
using BnWS.Entity;
using LinqKit;
using Repository;

namespace BnWS.Business
{
    public class ZzBS : BaseBS
    {
        public ZzBS() : base()
        {
            
        }
        public ZzBS(AppContext appContext)
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


        public void SaveDesgin(ZZDesign zzDesign)
        {
            using (var uow=GetUnitOfWork())
            {
                var d = new ZZ_Desgin()
                {
                    DesginId = Guid.NewGuid(),
                    TemplateId = zzDesign.TemplateId,
                    CustomerId = zzDesign.CustomerId,
                    Name = zzDesign.Name,
                    Tags = zzDesign.Tags,
                    DesginSettings = zzDesign.DesginSettings,
                    Preview1 = zzDesign.Preview1,
                    Preview2 = zzDesign.Preview2
                };
                uow.Repository<ZZ_Desgin>().Insert(d);
                uow.Save();
            }
        }

        public List<ZZ_Desgin> GetDesginList(string openId)
        {
            using (var db = GetDbContext())
            {
                return db.ZZ_Desgin.AsExpandable().Where(x => x.CustomerId == openId)
                    .OrderByDescending(x=>x.CreatedTime).ToList();
            }
        }

        public void SetIsPublic(Guid desginId, bool ispublic)
        {
            using (var uow = GetUnitOfWork())
            {
                var desgin = uow.Repository<ZZ_Desgin>().Find(desginId);
                if (desgin != null)
                {
                    desgin.IsPublic = ispublic;
                    uow.Repository<ZZ_Desgin>().Update(desgin);
                    uow.Save();
                }
            }
        }
    }
}