
CREATE TABLE [dbo].[T_S_Role](
	[RoleId] uniqueidentifier NOT NULL primary key,
	[RoleName] [varchar](128) NOT NULL,
	[VersionNo] [int] NOT NULL default(0),
	[TransactionId]uniqueidentifier NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate())
)
CREATE TABLE [dbo].[T_S_User](
	[UserId] uniqueidentifier NOT NULL primary key,
	[LoginName] [varchar](128) NOT NULL,
	[Password] [varchar](128) not null,
	[IsActive] [bit] not null default(0),
	[Source] int not null default(0),
	[OpenId] [varchar](256) null,
	[AccessToken] [varchar](512) null,
	[IsLock] bit not null default(0),
	[LastLoginTime] datetime null,
	[VersionNo] [int] NOT NULL default(0),
	[TransactionId]uniqueidentifier NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate())
)
CREATE TABLE [dbo].[T_S_Function](
	[FunctionId] uniqueidentifier NOT NULL primary key,
	[Name] [varchar](128) NULL,
	[Url] [varchar](128) NULL,
	[Icon] [varchar](128) NULL,
	[ParentId] uniqueidentifier NULL,
	[Seq] int not null default(0), 
	[VersionNo] [int] NOT NULL default(0),
	[TransactionId]uniqueidentifier NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate())
)
CREATE TABLE [dbo].[T_S_Role_Function](
	[Id] uniqueidentifier NOT NULL primary key,
	[RoleId] uniqueidentifier NOT NULL,
	[FunctionId] uniqueidentifier NOT NULL,
	[VersionNo] [int] NOT NULL default(0),
	[TransactionId]uniqueidentifier NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate())
)
CREATE TABLE [dbo].[T_S_User_Role](
	[Id] uniqueidentifier NOT NULL primary key,
	[UserId] uniqueidentifier NOT NULL,
	[RoleId] uniqueidentifier NOT NULL,
	[VersionNo] [int] NOT NULL default(0),
	[TransactionId]uniqueidentifier NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate())
)
CREATE TABLE [dbo].[T_S_Code](
	[Id] uniqueidentifier NOT NULL primary key,
	[CodeCategory] [varchar](128) NOT NULL,
	[Code] [varchar](128) NOT NULL,
	[Desc] [varchar](128) NOT NULL,
	[Seq] int not null default(0),
	[VersionNo] [int] NOT NULL default(0),
	[TransactionId]uniqueidentifier NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate())
)

