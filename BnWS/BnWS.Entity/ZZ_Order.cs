//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BnWS.Entity
{
    using System;
    using System.Collections.Generic;
    
    using Repository;
    public partial class ZZ_Order:EntityBase,IAuditableEntity
    {
        public System.Guid OrderId { get; set; }
        public string CustomerId { get; set; }
        public System.Guid DesignId { get; set; }
        public string Color { get; set; }
        public int Quiantity { get; set; }
        public int OrderStatus { get; set; }
        public decimal TotalAmount { get; set; }
        public string SubmissionId { get; set; }
        public int VersionNo { get; set; }
        public System.Guid TransactionId { get; set; }
        public string CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public string UpdatedBy { get; set; }
        public System.DateTime UpdatedTime { get; set; }
    }
}