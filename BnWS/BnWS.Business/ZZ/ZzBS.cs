using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Mime;
using System.Web;
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
        private string SaveByteArrayAsImage(Guid id, string raw,string name,string ext="svg")
        {
            var folder = Path.Combine(HttpContext.Current.Server.MapPath("~"), "upload", id.ToString());
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }
            var fileName = string.Format("{0}.{1}", name, ext);
            var localFullOutputPath = Path.Combine(folder, fileName);
            var base64String = raw.Split(',')[1];
            byte[] bytes = Convert.FromBase64String(base64String);

            Image image;
            using (var ms = new MemoryStream(bytes))
            {
                image = Image.FromStream(ms);
            }

            image.Save(localFullOutputPath);
            return string.Format(@"upload/{0}/{1}", id, fileName);
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
                    DesginSettings = zzDesign.DesginSettings
                };
                d.Preview1 = SaveByteArrayAsImage(d.DesginId, zzDesign.Preview1, "1");
                d.Preview2 = SaveByteArrayAsImage(d.DesginId, zzDesign.Preview2, "2");
                uow.Repository<ZZ_Desgin>().Insert(d);
                uow.Save();
            }
        }

        public List<ZZDesign> GetDesginList(string openId)
        {
            using (var db = GetDbContext())
            {
                //todo test
                //return db.ZZ_Desgin.AsExpandable()//.Where(x => x.CustomerId == openId)
                //    .OrderByDescending(x=>x.CreatedTime).ToList();
                return (from d in db.ZZ_Desgin.AsExpandable()//.Where(x => x.CustomerId == openId)
                    join t in db.ZZ_Template on d.TemplateId equals t.TemplateId
                    join c in db.ZZ_Category on t.Category equals c.CategoryId
                    join u in db.ZY_Customer on d.CustomerId equals  u.OpenId
                    select new ZZDesign()
                    {
                        Id = d.DesginId,
                        TemplateId = d.TemplateId,
                        CustomerId = d.CustomerId,
                        Name = d.Name,
                        Tags = d.Tags,
                        Preview1 = d.Preview1,
                        Preview2 = d.Preview2,
                        UnitPrice = c.UnitPrice,
                        Designer = u.UserName
                    }).ToList();
            }
        }
        public ZZDesign GetDesign(Guid designId)
        {
            using (var db = GetDbContext())
            {
                var de= (from d in  db.ZZ_Desgin.AsExpandable().Where(x => x.DesginId == designId)
                   join t in db.ZZ_Template on d.TemplateId equals  t.TemplateId
                         join c in db.ZZ_Category on t.Category equals c.CategoryId
                         join u in db.ZY_Customer on d.CustomerId equals u.OpenId
                        select new ZZDesign()
                        {
                            Id = d.DesginId,
                            TemplateId = d.TemplateId,
                            CustomerId = d.CustomerId,
                            Name = d.Name,
                            Tags = d.Tags,
                            Preview1 = d.Preview1,
                            Preview2 = d.Preview2,
                            UnitPrice = c.UnitPrice,
                            Designer = u.UserName,
                            Colors = db.ZZ_Template.Where(x=>x.Category==t.Category).Select(x=>x.Color).Distinct().ToList()
                        }).FirstOrDefault();
                return de;
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