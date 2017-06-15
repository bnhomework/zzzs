using System.Xml;
using Bn.WeiXin.Messages;

namespace Bn.WeiXin
{
    public static class WxHelper
    {
        public static string Handle(string message,IWxMessageHandler handler)
        {
           var request = DeserializeMessage(message);
           request.MessageHandler = handler;
           return request.HandleMessage();
        }
        public static WxRequest DeserializeMessage(string rawXml)
        {
            var doc = new XmlDocument();
            doc.LoadXml(rawXml);
            var rootElement = doc.DocumentElement;
            var msgType = rootElement.SelectSingleNode("MsgType");
            var messageType = msgType.InnerText.ToLower();
            WxRequest request = null;
            switch (messageType)
            {
                case "text":
                    request = new TextWxRequest();
                    break;
                case "image":
                    request = new ImageWxRequest();
                    break;
                case "voice":
                    request = new VoiceWxRequest();
                    break;
                case "video":
                    request = new VideoWxRequest();
                    break;
                case "location":
                    request = new LocationWxRequest();
                    break;
                case "link":
                    request = new LinkWxRequest();
                    break;
                case "event":
                    request = new EventWxRequest();
                    break;
                default:
                    request = new WxRequest();
                    break;
            }
            request.LoadData(rootElement);
            return request;
        }
    }
}