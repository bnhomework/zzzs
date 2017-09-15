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

    public class PasswordVM
    {
        public Guid UserId { get; set; }
        public string OldPassword { get; set; }
        public string NewPassword { get; set; }
    }

    public class NotificationMessage
    {
        public string UserId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
    }

    public class NotificationMessageReview : NotificationMessage
    {
        public Guid Id { get; set; }
        public DateTime CreatedTime { get; set; }
        public DateTime? ReadTime { get; set; }
    }
}
