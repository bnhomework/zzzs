using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BnWS.Entity
{
    public class LoginViewModel
    {
        public string UserName { get; set; }

        public string Password { get; set; }

        public bool RememberMe { get; set; }
    }

    public class DeskViewModel
    {
        public Guid DeskId { get; set; }
        public string DeskName { get; set; }
        public string BookedPositions { get; set; }
        public string InternalBookedPositions { get; set; } 
    }
}
