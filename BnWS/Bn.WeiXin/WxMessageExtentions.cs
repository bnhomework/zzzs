using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Xml;
using System.Xml.Linq;
using Bn.WeiXin.Messages;

namespace Bn.WeiXin
{
    public static class WxMessageExtentions
    {
        public static string ToXml(this WxMessage data)
        {
            var xml = GenerateElements(data, "xml");
            return xml.ToString();
        }
        private static XElement GenerateElements<T>(T data, string name) where T : class
        {
            var type = data.GetType();
            var properties = type.GetProperties();

            var innerElements = new List<XElement>();
            foreach (var p in properties)
            {
                var innerValue = p.GetValue(data, null);

                if (Array.IndexOf(p.PropertyType.GetInterfaces(), typeof(IList)) > -1)
                {
                    var list = new List<XElement>();
                    foreach (var item in (IList)innerValue)
                    {
                        list.Add(GenerateElements(item, string.Empty));
                    }
                    innerElements.Add(new XElement(p.Name, list.ToArray()));
                }
                else if (innerValue is InnerType)
                {
                    innerElements.Add(GenerateElements(innerValue, p.Name));
                }
                else if (innerValue is string)
                {
                    innerElements.Add(new XElement(p.Name
                        , new XCData(innerValue.ToString())));
                }
                else
                {
                    innerElements.Add(new XElement(p.Name, innerValue));
                }
            }
            if (string.IsNullOrEmpty(name))
            {
                return innerElements.FirstOrDefault();
            }
            return new XElement(name, innerElements.ToArray());
        }

        public static void LoadData(this WxRequest request, XmlElement rootElement)
        {
            var type = request.GetType();
            var properties = type.GetProperties();
            foreach (var p in properties)
            {
                var node = rootElement.SelectSingleNode(p.Name);
                if (node == null)
                    continue;
                p.SetValue(request, Convert.ChangeType(node.InnerText, p.PropertyType), null);
            }
        }
    }
}