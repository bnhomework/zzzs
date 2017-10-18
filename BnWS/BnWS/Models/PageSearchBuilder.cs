using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BnWS.Entity;

namespace BnWS.Models
{
    public class PageSearchBuilder
    {
        public static PageSearch<T> Build<T>(HttpRequestBase Request, T condition)
        {
            var ps = new PageSearch<T>();
            ps.pageIndex = int.Parse(Request.Params["page"] ?? "1");
            ps.pageSize = int.Parse(Request.Params["pageSize"] ?? "20");
            ps.q = condition;
            return ps;
        } 
    }
}