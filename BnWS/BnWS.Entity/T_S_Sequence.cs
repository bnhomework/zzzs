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
    public partial class T_S_Sequence:EntityBase,IAuditableEntity
    {
        public System.Guid Id { get; set; }
        public string SeqType { get; set; }
        public int Year { get; set; }
        public int Month { get; set; }
        public int Day { get; set; }
        public int Seq { get; set; }
        public int VersionNo { get; set; }
        public System.Guid TransactionId { get; set; }
        public string CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public string UpdatedBy { get; set; }
        public System.DateTime UpdatedTime { get; set; }
    }
}