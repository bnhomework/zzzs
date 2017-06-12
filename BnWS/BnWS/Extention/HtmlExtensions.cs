using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using BnWS.Entity;

namespace BnWS.Extention
{
    public static class HtmlExtensions
    {
        public static MvcHtmlString BuildMenu(this HtmlHelper html, List<T_S_Function> menus)
        {            
            menus.ForEach(x =>
            {
                x.SubMenus = menus.Where(m => m.ParentId == x.FunctionId).ToList();
            });
            var topMenus = menus.Where(x => !x.ParentId.HasValue);
            StringBuilder sb=new StringBuilder();
            topMenus.OrderBy(x=>x.Seq).ToList().ForEach(x =>
            {
                sb.Append(BuildMenuItem(x));
            });
            return new MvcHtmlString(sb.ToString());
        }

        public static string BuildMenuItem(T_S_Function item)
        {
            var menuItemClass = "J_menuItem";
            var subMenuItemClass = "nav-second-level";
            var content = new StringBuilder();
            if (!item.IsParent)
            {
                content.Append(string.Format("<a class=\"{3}\" href=\"{0}\"><i class=\"fa {1}\"></i> <span class=\"nav-label\">{2}</span></a>",item.Url,item.Icon,item.Name,menuItemClass));
            }
            else
            {
                content.Append(string.Format("<a href=\"{0}\"><i class=\"fa {1}\"></i><span class=\"nav-label\">{2}</span><span class=\"fa arrow\"></span></a>",item.Url,item.Icon,item.Name));
            }
            if (item.SubMenus.Count > 0)
            {
                var subMenus = new StringBuilder();
                item.SubMenus.OrderBy(x=>x.Seq).ToList()
                    .ForEach(x=>subMenus.Append(BuildMenuItem(x)));
                content.Append(string.Format("<ul  class=\"nav {1}\">{0}</ul>", subMenus.ToString(),subMenuItemClass));
            }
            return string.Format("<li>{0}</li>",content.ToString());
        }


        public static MvcHtmlString BuildFunctionTree(this HtmlHelper html, List<T_S_Function> menus)
        {
            menus.ForEach(x =>
            {
                x.SubMenus = menus.Where(m => m.ParentId == x.FunctionId).ToList();
            });
            var topMenus = menus.Where(x => !x.ParentId.HasValue);
            var sb = new StringBuilder();
            topMenus.OrderBy(x => x.Seq).ToList().ForEach(x => sb.Append(BuildFunctionTreeItem(x)));
            return new MvcHtmlString(sb.ToString());
        }

        public static string BuildFunctionTreeItem(T_S_Function item)
        {
            var menuItemClass = "tree-item";
            var subMenuItemClass = "tree-sub-item";
            var content = new StringBuilder();

            content.Append(
                string.Format(
                    "<div class=\"{0}\"><label><input type=\"checkbox\" data-fid=\"{2}\"/><span>{1}</span></label></div>",
                    menuItemClass, item.Name,item.FunctionId));
            if (item.SubMenus.Count > 0)
            {
                var subMenus = new StringBuilder();
                item.SubMenus.OrderBy(x => x.Seq).ToList()
                    .ForEach(x => subMenus.Append(BuildFunctionTreeItem(x)));
                content.Append(string.Format("<ul  class=\" {1}\">{0}</ul>", subMenus.ToString(), subMenuItemClass));
            }
            return string.Format("<li>{0}</li>", content.ToString());
        }
    }
}