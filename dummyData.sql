insert into ZY_Shop
select '6049D8BA-F428-4448-97AC-1771EF6F54B3','shop01','1','1','xxx xxx',0,'93BBD33C-0C29-43BB-8EF8-118ED371C524',1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'shop02','1','1','xxx xxx',0,'93BBD33C-0C29-43BB-8EF8-118ED371C524',1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'shop03','1','1','xxx xxx',0,'93BBD33C-0C29-43BB-8EF8-118ED371C524',1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'shop04','1','1','xxx xxx',0,'93BBD33C-0C29-43BB-8EF8-118ED371C524',1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'shop05','1','1','xxx xxx',0,'93BBD33C-0C29-43BB-8EF8-118ED371C524',1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'shop06','1','1','xxx xxx',0,'93BBD33C-0C29-43BB-8EF8-118ED371C524',1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()

select * from ZY_Shop

insert into ZY_Shop_Desk
select NEWID(),'6049D8BA-F428-4448-97AC-1771EF6F54B3','desk01',0,1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'6049D8BA-F428-4448-97AC-1771EF6F54B3','desk02',0,1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'6049D8BA-F428-4448-97AC-1771EF6F54B3','desk03',0,1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'6049D8BA-F428-4448-97AC-1771EF6F54B3','desk04',0,1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'6049D8BA-F428-4448-97AC-1771EF6F54B3','desk05',0,1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'6049D8BA-F428-4448-97AC-1771EF6F54B3','desk06',0,1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()
union all
select NEWID(),'6049D8BA-F428-4448-97AC-1771EF6F54B3','desk07',0,1,NEWID(),'test',GETDATE(),'test'  ,GETDATE()

select * from ZY_Shop_Desk