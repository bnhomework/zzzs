using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Bn.WeiXin.Messages;
using Newtonsoft.Json;

namespace Bn.WeiXin.Handlers
{
    //TODO: hardcode first, configurabe later
    public class BnWxMessageHander : IWxMessageHandler
    {

        //智能回复
        public string OnTextMessageReceived(TextWxRequest request)
        {
            if (request.Content.Contains("text"))
            {
                return new TextWxResponseXml(request) { Content = "here is some the sample text:XXXXXXXXXX" }.ToXml();

            }
            else if (request.Content.Contains("news"))
            {
                var alist = new List<ArticleItem>
                {
                    new ArticleItem()
                    {
                        item = new Article()
                        {
                            Description =
                                "新浪体育讯　随着罗本领衔的荷兰的出局，本届世界杯的金球之争中，梅西的竞争对手又少了一个。阿根廷如果能夺得冠军，那么梅西拿到世界杯最佳球员的可能性很大。不过在梅西眼中，冠军奖杯胜过一切，据《阿斯报》报道，梅西在阿根廷国家队内表示，自己宁愿赢得世界杯而不是“金球奖”。"
                            ,
                            PicUrl =
                                "http://i2.sinaimg.cn/2014/news/arg/2014-07-11/U5244P1545T33D24242F682DT20140711120824.jpg"
                            ,
                            Title = "梅西：只想世界杯夺冠不想金球 西媒：对C罗的讽刺"
                            ,
                            Url =
                                "http://2014.sina.com.cn/news/arg/2014-07-11/120824242.shtml?sina-fr=bd.xw.fxw.sports.sjb"
                        }
                    }
                };
                return new NewsWxResponseXml(request) { Articles = alist }.ToXml();
            }
            return "";
        }

        public string OnSubscribe(EventWxRequest request)
        {
          //var message=  _configService.LoadEntities(p => p.ConfigName.Equals(SettingTypes.WelcomeMessage)).FirstOrDefault();
          //  if (message != null&&message.WeixinMessage.Count>0)
          //  {
          //    var alist=  message.WeixinMessage.Select(
          //          p => new ArticleItem() {item = JsonConvert.DeserializeObject<Article>(p.Content)}).ToList();
          //    return new NewsWxResponseXml(request) { Articles = alist }.ToXml();
          //  }
          //  else
          //  {
          //      return new TextWxResponseXml(request) {Content = "~小袁花艺~"}.ToXml();
          //  }
            return "";
        }

        public string OnUserExit(EventWxRequest request)
        {
            //throw new System.NotImplementedException();
            return string.Empty;
        }

        public string OnMenuButtonClick(EventWxRequest request, string eventKey)
        {
            //if (eventKey.Equals(EventKey.ShowLove))
            //{
            //    return GetShowLoveInstructions(request);
            //}
            //else if (eventKey.Equals(EventKey.GetCustomerService))
            //{
            //    return GetCustomerServices(request);
            //}
            //else if (eventKey.Equals(EventKey.GetDiscounts))
            //{
            //    return GetDiscounts(request);
            //}
            //else if (eventKey.Equals(EventKey.GetActivity))
            //{
            //    return GetActivity(request);
            //}
            //else if (eventKey.Equals(EventKey.ClickVip))
            //{
            //    return GetVipInformation(request);
            //}
      
            return string.Empty;
        }

        public string OnMenuLinkClick(EventWxRequest request, string eventKey)
        {
            //throw new System.NotImplementedException();
            return string.Empty;
        }

        ////Login Vip
        //private string GetVipInformation(EventWxRequest request)
        //{
        //    var alist = new List<ArticleItem>();

            
        //    //alist.Add(new ArticleItem()
        //    //{
        //    //    item = new Article()
        //    //    {
        //    //        Description = request.FromUserName,
        //    //        PicUrl = WxConfig.WebSitUrl + @"/Content/Images/VipImages/vipCard.png",
        //    //        Title = @"申请成为小袁鲜花会员",
        //    //        Url = ""
        //    //    }
        //    //});
        //    //return new NewsWxResponseXml(request) { Articles = alist }.ToXml();

        //    if (!IsVip(request))
        //    {
        //        string moreUrl = string.Format("{0}/Home/VipLogin/" + request.FromUserName, WxConfig.WebSitUrl);
        //        alist.Add(new ArticleItem()
        //        {
        //            item = new Article()
        //            {
        //                Description = "申请成为会员，享受更多购花优惠",
        //                PicUrl = WxConfig.WebSitUrl + @"/Content/Images/VipImages/vip.png",
        //                Title = @"申请成为小袁鲜花会员",
        //                Url = moreUrl
        //            }
        //        });
        //    }
        //    else
        //    {
        //        string moreUrl = string.Format("{0}/Home/Vip/" + request.FromUserName, WxConfig.WebSitUrl);
        //        alist.Add(new ArticleItem()
        //        {
        //            item = new Article()
        //            {
        //                Description = "尊敬的会员用户，你会优先知道打折，促销等等活动哦",
        //                PicUrl = WxConfig.WebSitUrl + @"/Content/Images/VipImages/vip2.png",
        //                Title = @"小袁鲜花会员中心",
        //                Url = moreUrl
        //            }
        //        });
        //    }
            
        //    return new NewsWxResponseXml(request) { Articles = alist }.ToXml();
        // }


        ////爱的箴言墙step1
        //private string GetShowLoveInstructions(EventWxRequest request)
        //{
        //    StringBuilder sb=new StringBuilder();
        //    sb.AppendLine("发送图片 参加爱的箴言墙活动");
        //    sb.AppendLine("");
        //    string url = string.Format("{0}/Home/ShowLove", WxConfig.WebSitUrl);

        //    sb.AppendLine(string.Format("<a href=\"{0}\">点击浏览 爱的箴言墙</a>", url));
        //    return new TextWxResponseXml(request) {Content =sb.ToString()}.ToXml();
        //}
        ////爱的箴言墙step2 接受图片
        public string OnImageMessageReceived(ImageWxRequest request)
        {

            ////TODO:通过微信openid 判断是否是会员
            //bool isVip = !IsVip(request);
            //if (!isVip)
            //{
            //    string moreUrl = string.Format("{0}/Home/Vip/" + request.FromUserName, WxConfig.WebSitUrl);
            //    return new TextWxResponseXml(request) { Content = string.Format("<a href=\"{0}\">请点击链接注册会员，参加爱的箴言墙活动</a> ", moreUrl) }.ToXml();
            //}
            //string url = string.Format("{0}/Home/EnterLove?url={1}&uid={2}", WxConfig.WebSitUrl, request.PicUrl, request.FromUserName);
            //string content = string.Format("<a href=\"{0}\">点击,讲诉你们的故事</a>", url);

            //return new TextWxResponseXml(request) { Content = content }.ToXml();
            return string.Empty;

        }
        
        ////客服
        //private string GetCustomerServices(EventWxRequest request)
        //{
        //    var customerServices =
        //        new WeixinMessageService().LoadEntities(p => p.Type.Equals(MessageType.CustomerService)).ToList();
        //    StringBuilder sb = new StringBuilder();
        //    sb.AppendLine("请点击以下链接选择客服代表:");
        //    //string c = "请选择客服代表：\n";
        //    for (int i = 0; i < customerServices.Count; i++)
        //    {
        //        sb.AppendLine(string.Format("<a href=\"{0}\">QQ客服 {1}</a>", customerServices.ElementAt(i).Content, i + 1));
        //        //string s = string.Format("<a href=\"{0}\">客服 {1}</a>", customerServices.ElementAt(i).Content, i + 1);
        //        //c = string.Format("{0}{1}\n", c, s);
        //    }
        //    return new TextWxResponseXml(request) {Content = sb.ToString()}.ToXml();
        //}

        ////优惠
        //public string GetDiscounts(EventWxRequest request)
        //{
        //    var services =
        //        new ProductShowService().LoadEntities(p => p.ItemType.Equals(ShowType.Discounts)).OrderByDescending(p=>p.UpdatedDate.Value).ToList();
        //    string moreUrl = string.Format("{0}/Home/DiscountsShow", WxConfig.WebSitUrl);
        //    if(services.Count==0)
        //        return new TextWxResponseXml(request) { Content = "最近没有优惠" }.ToXml();
        //    else
        //    {
        //        var alist = new List<ArticleItem>();
        //        services//.GetRange(0, services.Count>5?5:services.Count)
        //            .ForEach(p => alist.Add(new ArticleItem()
        //        {
        //            item = new Article()
        //            {
        //                Description = p.SubTitle
        //           ,PicUrl =p.ImageUrl,Title = p.Title,Url = moreUrl }}));
        //        return new NewsWxResponseXml(request) { Articles = alist }.ToXml();
        //    }
        //}
        ////活动
        //public string GetActivity(EventWxRequest request)
        //{
        //    var services =
        //        new ProductShowService().LoadEntities(p => p.ItemType.Equals(ShowType.Activity)).OrderByDescending(p => p.UpdatedDate.Value).ToList();
        //    string moreUrl = string.Format("{0}/Home/ActivityShow", WxConfig.WebSitUrl);
        //    if (services.Count == 0)
        //        return new TextWxResponseXml(request) { Content = "最近没有活动" }.ToXml();
        //    else
        //    {
        //        var alist = new List<ArticleItem>();
        //        services.GetRange(0, services.Count > 5 ? 5 : services.Count).ForEach(p => alist.Add(new ArticleItem()
        //        {
        //            item = new Article()
        //            {
        //                Description = p.SubTitle,
        //                PicUrl = p.ImageUrl,
        //                Title = p.Title,
        //                Url = moreUrl
        //            }
        //        }));
        //        return new NewsWxResponseXml(request) { Articles = alist }.ToXml();
        //    }
        //}

        //public string ClickVip(EventWxRequest request)
        //{
        //    var message=  _configService.LoadEntities(p => p.ConfigName.Equals(SettingTypes.WelcomeMessage)).FirstOrDefault();
        //    if (message != null&&message.WeixinMessage.Count>0)
        //    {
        //      var alist=  message.WeixinMessage.Select(
        //            p => new ArticleItem() {item = JsonConvert.DeserializeObject<Article>(p.Content)}).ToList();
        //      return new NewsWxResponseXml(request) { Articles = alist }.ToXml();
        //    }
        //    else
        //    {
        //        return new TextWxResponseXml(request) {Content = "~小袁花艺~"}.ToXml();
        //    }
        //}

        //private bool IsVip(WxRequest request)
        //{
        //    string openId = request.FromUserName;
        //    var count = (from u in _customerInfoService.LoadSearchData(new CustomerQuery { 
        //        PageIndex=1,
        //        PageSize=10,
        //        WechatId =openId
        //    }) select u.WechatId).Count();

        //    return count>0;
        //}
    }
}
