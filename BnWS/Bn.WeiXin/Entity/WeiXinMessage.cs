using System.Collections.Generic;

namespace Bn.WeiXin.Entity
{
    /// <summary>
    /// to store all weixin messages
    /// </summary>
    public partial class WeiXinMessage
    {
        public int WeiXinMessageId { get; set; }
        public string Content { get; set; }
        public string MessageType { get; set; }

        public virtual ICollection<WeiXinSetting> WeiXinSettings { get; set; }
    }
}