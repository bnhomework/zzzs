using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bn.WeiXin.Entity
{
    public partial class User
    {
        public User()
        {
            UserID = Utility.Generate();
        }

        public System.Guid UserID { get; set; }
        public string PhoneNumber { get; set; }
        public string Name { get; set; }
        public string Sex { get; set; }
        public DateTime? BirthDay { get; set; }
        public string Password { get; set; }
        //public string OpenId { get; set; }
        //public string Provider { get; set; }
        //public string Token { get; set; }
        public string Role { get; set; }
        public System.DateTime LastLoginDate { get; set; }
        public int Status { get; set; }
        //public bool IsActive { get; set; }
        public System.DateTime CreatedOn { get; set; }

        
    }
    public class WXUserInfo
    {
        public string nickname { get; set; }
        public string sex { get; set; }
        public string province { get; set; }
        public string city { get; set; }
        public string country { get; set; }
        public string headimgurl { get; set; }
    }
}
