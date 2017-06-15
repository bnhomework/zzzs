using System.Data.Entity.ModelConfiguration;

namespace Bn.WeiXin.Entity.Mapping
{
    public class LogMap : EntityTypeConfiguration<Log>
    {
        public LogMap()
        {
            this.HasKey(t => t.LogID);
            this.ToTable("Log");
            this.Property(t => t.LogID).HasColumnName("LogID");
            this.Property(t => t.EventID).HasColumnName("EventID");
            this.Property(t => t.Priority).HasColumnName("Priority");
            this.Property(t => t.Severity).HasColumnName("Severity");
            this.Property(t => t.Title).HasColumnName("Title");
            this.Property(t => t.Timestamp).HasColumnName("Timestamp");
            this.Property(t => t.MachineName).HasColumnName("MachineName");
            this.Property(t => t.AppDomainName).HasColumnName("AppDomainName");
            this.Property(t => t.ProcessID).HasColumnName("ProcessID");
            this.Property(t => t.ProcessName).HasColumnName("ProcessName");
            this.Property(t => t.ThreadName).HasColumnName("ThreadName");
            this.Property(t => t.Win32ThreadId).HasColumnName("Win32ThreadId");
            this.Property(t => t.Message).HasColumnName("Message");
            this.Property(t => t.FormattedMessage).HasColumnName("FormattedMessage");
        }
    }
}