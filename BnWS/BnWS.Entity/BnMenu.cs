using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BnWS.Entity
{
    public partial class T_S_Function
    {
        public List<T_S_Function> SubMenus { get; set; }
        public bool IsParent { get { return SubMenus!=null&&SubMenus.Count > 0; } }
    }

}
