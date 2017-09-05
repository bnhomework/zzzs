using System;
using System.Diagnostics;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using BnWS.Entity;
using Repository;

namespace BnWS.Business
{
    public class ZzBaseBS : BaseBS
    {
        public ZzBaseBS() : base()
        {
            
        }
        public ZzBaseBS(AppContext appContext)
            : base(appContext)
        {

        }

        public void InsertOrderStatusHistory(IUnitOfWork uow, Guid orderId, int status)
        {
            var history = new ZZ_OrderStatusHistory()
            {
                Id = Guid.NewGuid(),
                OrderId = orderId,
                OrderStatus = status,
                StatusDate = DateTime.Now
            };
            uow.Repository<ZZ_OrderStatusHistory>().Insert(history);
        }
        protected string SaveByteArrayAsImage(Guid id, string raw, string name, string ext = "png")
        {
            var folder = Path.Combine(HttpContext.Current.Server.MapPath("~"), "upload", id.ToString());
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }
            //Debug.WriteLine(string.Format("------------{0}-------------",name));
            //Debug.WriteLine(raw);
            var fileName = string.Format("{0}.{1}", name, ext);
            var localFullOutputPath = Path.Combine(folder, fileName);
            var base64String = raw.Split(',')[1];
            byte[] bytes = Convert.FromBase64String(base64String);

            //Image image;

            var ext2 = ext.ToLower();
            ImageFormat imageformat = ImageFormat.Png;

            switch (ext2)
            {
                case "png":
                    imageformat = ImageFormat.Png;
                    break;
                case "jpg":
                case "jpeg":
                    imageformat = ImageFormat.Jpeg;
                    break;
                default:
                    break;
            }

            using (MemoryStream memoryStream = new MemoryStream(bytes))
            {
                using (Image image = Image.FromStream(memoryStream))
                {
                    image.Save(localFullOutputPath, imageformat);
                }
            }

            //using (var ms = new MemoryStream(bytes))
            //{
            //    image = Image.FromStream(ms);
            //}
            //image.Save(localFullOutputPath, imageformat);
            return string.Format(@"upload/{0}/{1}", id, fileName);
        }

    }
}