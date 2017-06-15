using System;
using System.Collections.Generic;

namespace Bn.WeiXin.Messages
{
    public class WxMessage
    {
        public string ToUserName { get; set; }
        public string FromUserName { get; set; }
        public int CreateTime { get; set; }
        public string MsgType { get; set; }

        protected int ConvertDateTimeInt(DateTime time)
        {
            var startTime = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));
            return (int)(time - startTime).TotalSeconds;
        }
    }

    #region Request

    public class WxRequest : WxMessage
    {
        public IWxMessageHandler MessageHandler { get; set; }

        public virtual string HandleMessage()
        {
            if (MessageHandler == null)
            {
                throw new InvalidOperationException("MessageHandler is not defined");
            }
            return "";
        }
        
    }

    public class TextWxRequest : WxRequest
    {
        public string Content { get; set; }
        public string MsgId { get; set; }
        public override string HandleMessage()
        {
            base.HandleMessage();
            return MessageHandler.OnTextMessageReceived(this);
        }
    }
    public class ImageWxRequest : WxRequest
    {
        public string PicUrl { get; set; }
        public string MediaId { get; set; }
        public string MsgId { get; set; }
        public override string HandleMessage()
        {
            base.HandleMessage();
            return MessageHandler.OnImageMessageReceived(this);
        }
    }
    public class VoiceWxRequest : WxRequest
    {
        public string Format { get; set; }
        public string MediaId { get; set; }
        public string MsgId { get; set; }
        //开通语音识别功能，用户每次发送语音给公众号时，
        //微信会在推送的语音消息XML数据包中，增加一个Recongnition字段
        public string Recognition { get; set; }
    }
    public class VideoWxRequest : WxRequest
    {
        public string ThumbMediaId { get; set; }
        public string MediaId { get; set; }
        public string MsgId { get; set; }
    }
    //地理位置消息
    public class LocationWxRequest : WxRequest
    {
        public string Location_X { get; set; }
        public string Location_Y { get; set; }
        public string Scale { get; set; }
        public string Label { get; set; }
        public string MsgId { get; set; }
    }
    public class LinkWxRequest : WxRequest
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public string Url { get; set; }
        public string MsgId { get; set; }
    }

    //接收消息
    //关注/取消关注事件
    //Event	 事件类型，subscribe(订阅)、unsubscribe(取消订阅)
    //扫描带参数二维码事件
    //    1. 用户未关注时，进行关注后的事件推送    
    //    Event	 事件类型，subscribe
    //EventKey	 事件KEY值，qrscene_为前缀，后面为二维码的参数值
    //    2. 用户已关注时的事件推送
    //    Event	 事件类型，scan
    //EventKey	 事件KEY值，是一个32位无符号整数
    //LOCATION
    //Click
    public class EventWxRequest : WxRequest
    {
        public string Event { get; set; }

        public string EventKey { get; set; }
        public string Ticket { get; set; }

        public string Latitude { get; set; }
        public string Longitude { get; set; }
        public string Precision { get; set; }

        public override string HandleMessage()
        {
            string defaultValue = base.HandleMessage();

            switch (Event)
            {
                case "subscribe":
                    return MessageHandler.OnSubscribe(this);
                case "unsubscribe":
                    return MessageHandler.OnUserExit(this);
                case "CLICK":
                    return MessageHandler.OnMenuButtonClick(this, EventKey);
                case "VIEW":
                    return MessageHandler.OnMenuLinkClick(this, EventKey);
                default:
                    return defaultValue;
            }
        }
    }

    #endregion

    //发送被动响应消息
    #region Response

    public class WxResponseXml : WxMessage
    {
        public WxResponseXml(WxRequest request)
        {
            this.FromUserName = request.ToUserName;
            this.ToUserName = request.FromUserName;
            this.CreateTime = ConvertDateTimeInt(DateTime.Now);
        }
    }
    public class TextWxResponseXml : WxResponseXml
    {
        public TextWxResponseXml(WxRequest request)
            : base(request)
        {
            this.MsgType = "text";
        }
        public string Content { get; set; }
    }
    public class NewsWxResponseXml : WxResponseXml
    {
        public NewsWxResponseXml(WxRequest request)
            : base(request)
        {
            this.MsgType = "news";
        }
        public int ArticleCount {
            get { return Articles==null?0:Articles.Count; }
        }

        public List<ArticleItem> Articles { get; set; }
    }

    public class ImageWxResponseXml : WxResponseXml
    {
        public ImageWxResponseXml(WxRequest request)
            : base(request)
        {
            this.MsgType = "image";
        }
        public Media Image { get; set; }
    }
    public class VoiceWxResponseXml : WxResponseXml
    {
        public VoiceWxResponseXml(WxRequest request)
            : base(request)
        {
            this.MsgType = "voice";
        }
        public Media Voice { get; set; }
    }
    public class VideoWxResponseXml : WxResponseXml
    {
        public VideoWxResponseXml(WxRequest request)
            : base(request)
        {
            this.MsgType = "video";
        }
        public Video Video { get; set; }
    }
    public class MusicWxResponseXml : WxResponseXml
    {
        public MusicWxResponseXml(WxRequest request)
            : base(request)
        {
            this.MsgType = "music";
        }
        public Music Music { get; set; }
    }
   


    public class Media : InnerType
    {
        public string MediaId { get; set; }
    }
    public class Video : Media
    {
        public string Title { get; set; }
        public string Description { get; set; }
    }
    public class Music : InnerType
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public string MusicUrl { get; set; }
        public string HqMusicUrl { get; set; }
        public string ThumbMediaId { get; set; }
    }
    public class ArticleItem : InnerType
    {
        public Article item { get; set; }
    }
    public class Article : InnerType
    {
        public string Title { get; set; }
        public string Description { get; set; }
        public string PicUrl { get; set; }
        public string Url { get; set; }
    }
    public interface InnerType
    { }

    #endregion
}