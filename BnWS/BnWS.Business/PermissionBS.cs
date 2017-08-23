using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BnWS.Entity;
using Repository;

namespace BnWS.Business
{
    public class PermissionBS:BaseBS
    {
        public PermissionBS()
            : base()
        {
            
        }
        public PermissionBS(AppContext appContext)
            : base(appContext)
        {

        }
        //$('#side-menu>li:not(.nav-header)>a:first-child')
        //.each(function(i,x){var url=x.href;var icon=$('i',x)[0].className.replace('fa ','');var name=$('span.nav-label',x)[0].innerHTML;console.log('new BnMenu() {Url = "'+url+'", Icon = "'+icon+'", Name = "'+name+'"},');})
        public List<T_S_Function> GetAllMenus()
        {
            using (var uow = GetUnitOfWork())
            {
                return uow.Repository<T_S_Function>().Query().Get().ToList();
            }
        }

        public List<T_S_Function> GetMenus(Guid userId)
        {
            using (var uow = GetUnitOfWork())
            {
                //is supper user?
                if (
                    uow.Repository<T_S_User_Role>()
                        .Query()
                        .Filter(x => x.UserId == userId && x.RoleId.ToString() == "F3C95DCC-F4EF-4CDB-BADE-9FB2B26B484E")
                        .Get().Any())
                {
                    return GetAllMenus();
                }

                var functions = (from ur in uow.Repository<T_S_User_Role>().Query().Get()
                    join r in uow.Repository<T_S_Role_Function>().Query().Get() on ur.RoleId equals r.RoleId
                    join f in uow.Repository<T_S_Function>().Query().Get() on r.FunctionId equals f.FunctionId
                    where ur.UserId == userId
                    select f).ToList();
                return functions;
            }
        }

        public List<string> GetUserRoles(Guid userId)
        {
            using (var uow = GetUnitOfWork())
            {
                return  (from ur in uow.Repository<T_S_User_Role>().Query().Get()
                    join r in uow.Repository<T_S_Role>().Query().Get() on ur.RoleId equals r.RoleId
                    where ur.UserId == userId
                    select r.RoleName).ToList();
            }
        } 

        #region Role
        public List<T_S_Role> GetRoles()
        {
            using (var uow = GetUnitOfWork())
            {
             return   uow.Repository<T_S_Role>().Query().Include(x=>x.T_S_Role_Function).Get().ToList();
            }
        }

        public void AddRole(T_S_Role role)
        {
            using (var uow = GetUnitOfWork())
            {
                role.RoleId = Guid.NewGuid();
                uow.Repository<T_S_Role>().Insert(role);
                uow.Save();
            }
        }

        public void DeleteRole(Guid roleId)
        {
            using (var uow = GetUnitOfWork())
            {
                uow.Repository<T_S_Role>().Delete(roleId);
                uow.Save();
            }
        }

        public void UpdateRole(T_S_Role role)
        {
            using (var uow = GetUnitOfWork())
            {
                uow.Repository<T_S_Role>().Update(role);
                uow.Save();
            }
        }
        #endregion

        #region Function
        public List<T_S_Function> GetFunctions()
        {
            using (var uow = GetUnitOfWork())
            {
                return uow.Repository<T_S_Function>().Query().Get().OrderBy(x=>x.Seq).ToList();
            }
        }

        public void AddFunction(T_S_Function f)
        {
            using (var uow = GetUnitOfWork())
            {
                f.FunctionId = Guid.NewGuid();
                uow.Repository<T_S_Function>().Insert(f);
                uow.Save();
            }
        }

        public void DeleteFunction(Guid fId)
        {
            using (var uow = GetUnitOfWork())
            {
                uow.Repository<T_S_Function>().Delete(fId);
                uow.Save();
            }
        }

        public void UpdateFunction(T_S_Function f)
        {
            using (var uow = GetUnitOfWork())
            {
                uow.Repository<T_S_Function>().Update(f);
                uow.Save();
            }
        }
        #endregion

        #region User
        public List<T_S_User> GetUsers()
        {
            using (var uow = GetUnitOfWork())
            {
                return uow.Repository<T_S_User>().Query().Include(x=>x.T_S_User_Role).Get().ToList();
            }
        }

        public void AddUser(T_S_User f)
        {
            using (var uow = GetUnitOfWork())
            {
                f.UserId = Guid.NewGuid();
                if (string.IsNullOrEmpty(f.Password))
                {
                    f.Password = "111111";
                }
                uow.Repository<T_S_User>().Insert(f);
                uow.Save();
            }
        }

        public void DeleteUser(Guid fId)
        {
            using (var uow = GetUnitOfWork())
            {
                uow.Repository<T_S_User>().Delete(fId);
                uow.Save();
            }
        }

        public void UpdateUser(T_S_User f)
        {
            using (var uow = GetUnitOfWork())
            {
                uow.Repository<T_S_User>().Update(f);
                uow.Save();
            }
        }


        public void UpdateUserRole(Guid userId, List<Guid> roles)
        {
            using (var uow = GetUnitOfWork())
            {
               var userRoles =uow.Repository<T_S_User_Role>().Query().Filter(x => x.UserId.Equals(userId)).Get().ToList();
                userRoles.ForEach(x=>uow.Repository<T_S_User_Role>().Delete(x));
                if (roles != null)
                {
                    roles.ForEach(x =>
                    {
                        var r = new T_S_User_Role
                        {
                            Id = Guid.NewGuid(),
                            UserId = userId,
                            RoleId = x,
                            ObjectState = ObjectState.Added
                        };

                        uow.Repository<T_S_User_Role>().Insert(r);
                    });
                }
                uow.Save();
            }
        }
        public void UpdateRoleFunctions(Guid roleId, List<Guid> functions)
        {
            using (var uow = GetUnitOfWork())
            {
               var userRoles =uow.Repository<T_S_Role_Function>().Query().Filter(x => x.RoleId.Equals(roleId)).Get().ToList();
               userRoles.ForEach(x => uow.Repository<T_S_Role_Function>().Delete(x));
                if (functions != null)
                {
                    functions.ForEach(x =>
                    {
                        var r = new T_S_Role_Function
                        {
                            Id = Guid.NewGuid(),
                            RoleId = roleId,
                            FunctionId = x,
                            ObjectState = ObjectState.Added
                        };

                        uow.Repository<T_S_Role_Function>().Insert(r);
                    });
                    
                }
                uow.Save();
            }
        }

        #endregion
    }
}
