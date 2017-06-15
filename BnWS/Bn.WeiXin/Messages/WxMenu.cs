using System.Collections.Generic;
using Newtonsoft.Json;

namespace Bn.WeiXin.Messages
{
    public class WxMenuList
    {
        public WxMenu menu { get; set; }
    }

    public class WxMenu
    {
        public List<MenuInfo> button { get; set; }

        public WxMenu()
        {
            button = new List<MenuInfo>();
        }
    }

    public class MenuInfo
    {
        public MenuInfo(string name, ButtonType buttonType, string value)
        {
            this.name = name;
            this.type = buttonType.ToString();

            if (buttonType == ButtonType.click)
            {
                this.key = value;
            }
            else if (buttonType == ButtonType.view)
            {
                this.url = value;
            }
        }
        /// <summary>
        /// 按钮描述，既按钮名字，不超过16个字节，子菜单不超过40个字节
        /// </summary>
        public string name { get; set; }

        /// <summary>
        /// 按钮类型（click或view）
        /// </summary>
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string type { get; set; }

        /// <summary>
        /// 按钮KEY值，用于消息接口(event类型)推送，不超过128字节
        /// </summary>
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string key { get; set; }

        /// <summary>
        /// 网页链接，用户点击按钮可打开链接，不超过256字节
        /// </summary>
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public string url { get; set; }

        /// <summary>
        /// 子按钮数组，按钮个数应为2~5个
        /// </summary>
        [JsonProperty(NullValueHandling = NullValueHandling.Ignore)]
        public List<MenuInfo> sub_button { get; set; }
    }

    public enum ButtonType
    {
        click,
        view
    }
}
