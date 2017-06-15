using System;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bn.WeiXin.Entity
{
    /// <summary>
    ///to store-> welcome message, Menu, auto reply rules
    /// </summary>
    public partial class WeiXinSetting
    {
        public int WeiXinSettingId { get; set; }
        public string SettingName { get; set; }
        public string RuleName { get; set; }
        public bool IsMatchAll { get; set; }
        public int WeiXinMessageId { get; set; }
        //public DateTime EffectiveDate { get; set; }
        
        public virtual WeiXinMessage WeiXinMessage{ get; set; }
    }
}
