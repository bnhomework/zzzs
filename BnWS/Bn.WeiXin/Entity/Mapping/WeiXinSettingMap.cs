using System;
using System.Collections.Generic;
using System.Data.Entity.ModelConfiguration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bn.WeiXin.Entity.Mapping
{
    public class WeiXinSettingMap : EntityTypeConfiguration<WeiXinSetting>
    {
        public WeiXinSettingMap()
        {
            ToTable("WeiXinSetting");
            HasKey(p => p.WeiXinSettingId);
            //Property(p => p.EffectiveDate).HasColumnName("EffectiveDate");
            Property(p => p.WeiXinMessageId).HasColumnName("WeiXinMessageId");
            Property(p => p.RuleName).HasColumnName("RuleName");
            Property(p => p.IsMatchAll).HasColumnName("IsMatchAll");
            Property(p => p.SettingName).HasColumnName("SettingName");

            HasRequired(p=>p.WeiXinMessage).WithMany(p=>p.WeiXinSettings).HasForeignKey(p=>p.WeiXinMessageId).WillCascadeOnDelete(false);
        }
    }
}
