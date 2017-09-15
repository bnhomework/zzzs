using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using BnWS.Business;

namespace BnWS.Controllers
{
    public class CommonController : BaseController
    {
        [HttpPost]
        public ActionResult UploadFile()
        {
            var fileNames = new List<string>();
            for (int i = 0; i < Request.Files.Count; i++)
            {
                var file = Request.Files[i];
                var ext = Path.GetExtension(file.FileName);
                var name = string.Format("temp/{0}{1}", Guid.NewGuid(), ext);
                
                if (!string.IsNullOrEmpty(ext))
                {
                    var fileName = Path.Combine(Request.MapPath("~"), name);
                    fileNames.Add(name);
                    file.SaveAs(fileName);
                }
            } 
           
            return new JsonResult() { Data = fileNames };
        }
         [HttpPost]
        public ActionResult GetMessagesByUserId(string userId)
        {
            var bs = new CommonBS(this.AppContext);
            var messages = bs.GetMessagesByUserId(userId);
            var result = new JsonNetResult() { Data = messages, MaxJsonLength = int.MaxValue };
            result.Settings.DateFormatString = "yyyy-MM-dd";
            return result;
        }
         [HttpPost]
        public ActionResult GetNumberOfUnreadMessages(string userId)
        {
            var bs = new CommonBS(this.AppContext);
            var messages = bs.GetNumberOfUnreadMessages(userId);
            var result = new JsonNetResult() { Data = messages };
            return result;
        }
         [HttpPost]
         public ActionResult MarkMessageReaded(List<Guid> messageIds)
        {
            var bs = new CommonBS(this.AppContext);
            bs.MarkMessageReaded(messageIds);
            var result = new JsonNetResult() { Data = "OK" };
            return result;
        }
    }
}