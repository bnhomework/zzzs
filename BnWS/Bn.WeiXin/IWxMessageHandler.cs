using System.Collections.Generic;
using Bn.WeiXin.Messages;

namespace Bn.WeiXin
{
    public interface IWxMessageHandler
    {
        string OnTextMessageReceived(TextWxRequest request);
        string OnImageMessageReceived(ImageWxRequest request);
        string OnSubscribe(EventWxRequest request);
        string OnUserExit(EventWxRequest request);
        string OnMenuButtonClick(EventWxRequest request, string eventKey);
        string OnMenuLinkClick(EventWxRequest request, string eventKey);
    }
    
}