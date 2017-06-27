﻿using System;
using System.Collections.Generic;
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
}