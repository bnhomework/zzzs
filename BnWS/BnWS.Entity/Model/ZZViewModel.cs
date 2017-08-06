using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BnWS.Entity
{
    public class TemplateCondition
    {
        public int? Category { get; set; }
        public int? Sex { get; set; }
        public string Color { get; set; }
    }

    public class ZZDesign
    {
        public Guid Id { get; set; }
        public Guid TemplateId { get; set; }
        public string CustomerId { get; set; }
        public string Name { get; set; }
        public string Tags { get; set; }
        public string DesginSettings { get; set; }
        public string Preview1 { get; set; }
        public string Preview2 { get; set; }    
        public string Preview1_120 { get; set; }
        public string Preview2_120 { get; set; }

        //review
        public decimal UnitPrice { get; set; }
        public bool IsPublic { get; set; }
        public string Designer { get; set; }

        //template info
        public List<string> Colors { get; set; } 
    }
    public static class TempalteEx
    {
        public static string GetDefaultImg(this ZZ_Template t,int imageType=0,string ext="png")
        {
            string[] categories = { "tshirt" };
            string[] sexs = { "male", "female" };
            string[] imageTypes = { "front", "back" };
            var folder = System.Configuration.ConfigurationManager.AppSettings["templateFolder"];
            var category = categories[t.Category];
            var sex = string.Empty;
            var direction = "front";
            switch (imageType)
            {
                case 0:
                    direction = "front";
                    break;
                case 1:
                    direction = "back";
                    break;
                default:
                    direction = "front";
                    break;

            }
            if (t.Sex.HasValue)
            {
                sex = sexs[t.Sex.Value];
            }
            return string.Format("{0}//{1}_{2}_{3}{4}.{5}"
                , folder
                , category
                , sex
                , t.Color
                , direction
                , ext);

        }
    }

    public class ZZOrderInfo
    {
        public Guid OrderId { get; set; }
        public string CustomerId { get; set; }
        public Guid DesignId { get; set; }
        public string Color { get; set; }
        public int Quiantity { get; set; }

        public int OrderStatus { get; set; }
        public decimal TotalAmount { get; set; }
    }

    public class ZZOrderReview : ZZOrderInfo
    {
        public string Preview { get; set; }
        
    }
    public class ZZAddress
    {
        public Guid AddressId { get; set; }
        public string CustomerId { get; set; }
        public string ContactName { get; set; }
        public string AddressLine1 { get; set; }
        public string City { get; set; }
        public string Province { get; set; }

    }
}
