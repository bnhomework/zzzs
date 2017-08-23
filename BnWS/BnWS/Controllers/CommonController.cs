using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;

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
    }
}