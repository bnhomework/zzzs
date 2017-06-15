using System.Data.Entity.ModelConfiguration;

namespace Bn.WeiXin.Entity.Mapping
{
    public class WeiXinMessageMap : EntityTypeConfiguration<WeiXinMessage>
    {
        public WeiXinMessageMap()
        {
            ToTable("WeiXinMessage");
            HasKey(p=>p.WeiXinMessageId);
            Property(p => p.Content).HasColumnName("Content");
            Property(p => p.MessageType).HasColumnName("MessageType");
        }
    }
}