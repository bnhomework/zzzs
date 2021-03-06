﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.SqlServer.Server;

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
        public string DesignerAvatar { get; set; }
        public int Follows { get; set; }

        //template info
        public List<string> Colors { get; set; } 
    }

    public class DesginQuery
    {
        public string OpenId { get; set; }
    }
    public class zzPublicDesgin:ZZDesign
    {
        public bool IsFollowed { get; set; }
        public DateTime CreatedTime { get; set; }
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
        public string TrackingNumber { get; set; }
        public string CustomerId { get; set; }
        public Guid DesignId { get; set; }
        public string Color { get; set; }
        public int Quiantity { get; set; }

        public int OrderStatus { get; set; }
        public decimal TotalAmount { get; set; }
    }

    public class ZZOrderReview : ZZOrderInfo
    {
        public string DesginName { get; set; }
        public string Preview { get; set; }
        
    }
    public class ZZAddress
    {
        public Guid AddressId { get; set; }
        public string CustomerId { get; set; }
        public string ContactName { get; set; }
        public string Phone { get; set; }
        public string AddressLine1 { get; set; }
        public string City { get; set; }
        public string Province { get; set; }
        public string Town { get; set; }
        public bool IsDefault { get; set; }
        public DateTime CreatedTime { get; set; }
    }

    public enum ZZOrderStatus
    {
        Draft=0,
        Submitted=10,
        Paid=20,
        Processing=30,
        PendingRefund=40,
        Completed=50,
        Refund = 60,
    }

#region zzmanage

    public class AddressSearchCondition
    {
        public string CustomerName { get; set; }
    }

    public class ZZAddressInfo
    {
        public Guid AddressId { get; set; }
        public string CustomerName { get; set; }
        public string ContactName { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsDeleted { get; set; }
    }
    public class OrderSearchCondition
    {
        public DateTime? DateFrom { get; set; }
        public DateTime? DateTo { get; set; }
        public int? OrderStatus { get; set; }
        public int? ProductType { get; set; }
        public string CustomerName { get; set; }
        public string TrackingNumber { get; set; }
    }

    public class ZZOrderSummary
    {
        public Guid OrderId { get; set; }
        public Guid DesignId { get; set; }
        public string TrackingNumber { get; set; }
        public DateTime CheckOutDate { get; set; }
        public string CustomerName { get; set; }
        public int OrderStatus { get; set; }
        public string ProductType { get; set; }
        public string DesginName { get; set; }
        public string Preview { get; set; }
        public decimal Quiantity { get; set; }
        public decimal TotalAmount { get; set; }
    }

    public class ReportCondition
    {
        public DateTime? FromDate { get; set; }
        public DateTime? ToDate { get; set; }
    }
    public class OrderReportInfo
    {
        public string CheckOutTime { get; set; }
        public decimal TotalAmount { get; set; }
        public int Quiantity { get; set; }
        public int Orders { get; set; }
    }
    public class ClientReportInfo
    {
        public string Time { get; set; }
        public int Value { get; set; }
    }

    public class ZZOrderDetail : ZZOrderSummary
    {
        public string OrderStatusDesc { get; set; }
        public string Desginer { get; set; }

        public string Color { get; set; }
        public string ColorCode { get; set; }

        public string Preview1 { get; set; }
        public string Preview2 { get; set; }

        public string DesginSettings { get; set; }
        public string CustomerImg1 { get; set; }
        public string CustomerImg2 { get; set; }

        //address
        public string ContactName { get; set; }
        public string AddressLine1 { get; set; }
        public string Town { get; set; }
        public string City { get; set; }
        public string Province { get; set; }
        public string Phone { get; set; }
    }

    public class ZZDesignSetting
    {
        public string front { get; set; }
        public string frontTxt { get; set; }
        public string back { get; set; }
        public string backTxt { get; set; }
    }

    public class LogisticsInfo
    {
        public Guid OrderId { get; set; }
        public string ExpressCompany { get; set; }
        public string ExpressTrackingNo { get; set; }
        public string Comments { get; set; }
    }

    public class ZZTemplate : ZZ_Template
    {
        public decimal UnitPrice { get; set; }
    }
#endregion
}
