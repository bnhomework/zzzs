USE [master]
GO
/****** Object:  Database [bn_zy]    Script Date: 2017/6/20 0:05:47 ******/
CREATE DATABASE [bn_zy]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BnApp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\bn_zy.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BnApp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\bn_zy_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [bn_zy] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [bn_zy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [bn_zy] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [bn_zy] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [bn_zy] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [bn_zy] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [bn_zy] SET ARITHABORT OFF 
GO
ALTER DATABASE [bn_zy] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [bn_zy] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [bn_zy] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [bn_zy] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [bn_zy] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [bn_zy] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [bn_zy] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [bn_zy] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [bn_zy] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [bn_zy] SET  DISABLE_BROKER 
GO
ALTER DATABASE [bn_zy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [bn_zy] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [bn_zy] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [bn_zy] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [bn_zy] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [bn_zy] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [bn_zy] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [bn_zy] SET RECOVERY FULL 
GO
ALTER DATABASE [bn_zy] SET  MULTI_USER 
GO
ALTER DATABASE [bn_zy] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [bn_zy] SET DB_CHAINING OFF 
GO
ALTER DATABASE [bn_zy] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [bn_zy] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [bn_zy] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'bn_zy', N'ON'
GO
USE [bn_zy]
GO
/****** Object:  Table [dbo].[Pay]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pay](
	[Id] [uniqueidentifier] NOT NULL,
	[return_code] [nvarchar](256) NULL,
	[return_msg] [nvarchar](256) NULL,
	[appid] [nvarchar](256) NULL,
	[mch_id] [nvarchar](256) NULL,
	[device_info] [nvarchar](256) NULL,
	[nonce_str] [nvarchar](256) NULL,
	[sign] [nvarchar](256) NULL,
	[sign_type] [nvarchar](256) NULL,
	[result_code] [nvarchar](256) NULL,
	[err_code] [nvarchar](256) NULL,
	[err_code_des] [nvarchar](256) NULL,
	[openid] [nvarchar](256) NULL,
	[is_subscribe] [nvarchar](256) NULL,
	[trade_type] [nvarchar](256) NULL,
	[bank_type] [nvarchar](256) NULL,
	[total_fee] [nvarchar](256) NULL,
	[settlement_total_fee] [nvarchar](256) NULL,
	[fee_type] [nvarchar](256) NULL,
	[cash_fee] [nvarchar](256) NULL,
	[cash_fee_type] [nvarchar](256) NULL,
	[coupon_fee] [nvarchar](256) NULL,
	[coupon_count] [nvarchar](256) NULL,
	[transaction_id] [nvarchar](256) NULL,
	[out_trade_no] [nvarchar](256) NULL,
	[attach] [nvarchar](256) NULL,
	[time_end] [nvarchar](256) NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_S_Code]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_S_Code](
	[Id] [uniqueidentifier] NOT NULL,
	[CodeCategory] [varchar](128) NOT NULL,
	[Code] [varchar](128) NOT NULL,
	[Desc] [varchar](128) NOT NULL,
	[Seq] [int] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_S_Function]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_S_Function](
	[FunctionId] [uniqueidentifier] NOT NULL,
	[Name] [varchar](128) NULL,
	[Url] [varchar](128) NULL,
	[Icon] [varchar](128) NULL,
	[ParentId] [uniqueidentifier] NULL,
	[Seq] [int] NOT NULL DEFAULT ((0)),
	[VersionNo] [int] NOT NULL DEFAULT ((0)),
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[FunctionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_S_Role]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_S_Role](
	[RoleId] [uniqueidentifier] NOT NULL,
	[RoleName] [varchar](128) NOT NULL,
	[VersionNo] [int] NOT NULL DEFAULT ((0)),
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_S_Role_Function]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_S_Role_Function](
	[Id] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[FunctionId] [uniqueidentifier] NOT NULL,
	[VersionNo] [int] NOT NULL DEFAULT ((0)),
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_S_User]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_S_User](
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginName] [varchar](128) NOT NULL,
	[Password] [varchar](128) NOT NULL,
	[IsActive] [bit] NOT NULL DEFAULT ((0)),
	[Source] [int] NOT NULL DEFAULT ((0)),
	[OpenId] [varchar](256) NULL,
	[AccessToken] [varchar](512) NULL,
	[IsLock] [bit] NOT NULL DEFAULT ((0)),
	[LastLoginTime] [datetime] NULL,
	[VersionNo] [int] NOT NULL DEFAULT ((0)),
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_S_User_Role]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_S_User_Role](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[VersionNo] [int] NOT NULL DEFAULT ((0)),
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL DEFAULT (getdate()),
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ZY_Booked_Position]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZY_Booked_Position](
	[Id] [uniqueidentifier] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[DeskId] [uniqueidentifier] NOT NULL,
	[Position] [nvarchar](256) NOT NULL,
	[IsInternal] [bit] NOT NULL,
	[OrderId] [uniqueidentifier] NULL,
	[CustomerOpenId] [nvarchar](256) NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ZY_Customer]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZY_Customer](
	[OpenId] [nvarchar](256) NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[Avatar] [nvarchar](256) NULL,
	[TokenId] [nvarchar](256) NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OpenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ZY_Order]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZY_Order](
	[OrderId] [uniqueidentifier] NOT NULL,
	[CustomerOpenId] [nvarchar](256) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
	[Prepay_id] [nvarchar](256) NULL,
	[IsInternal] [bit] NOT NULL,
	[Comments] [nvarchar](2000) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ZY_Session]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZY_Session](
	[SessionId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ExpireTime] [datetime] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ZY_Shop]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZY_Shop](
	[ShopId] [uniqueidentifier] NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[Longitude] [decimal](10, 7) NULL,
	[Latitude] [decimal](10, 7) NULL,
	[Address] [nvarchar](256) NULL,
	[ShopStatus] [int] NULL DEFAULT ((0)),
	[OwnId] [uniqueidentifier] NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ShopId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ZY_Shop_Desk]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZY_Shop_Desk](
	[DeskId] [uniqueidentifier] NOT NULL,
	[ShopId] [uniqueidentifier] NOT NULL,
	[DeskName] [varchar](256) NOT NULL,
	[DeskStatus] [int] NOT NULL DEFAULT ((0)),
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[DeskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ZY_Shop_Img]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZY_Shop_Img](
	[Id] [uniqueidentifier] NOT NULL,
	[ShopId] [uniqueidentifier] NOT NULL,
	[Name] [varchar](256) NULL,
	[Url] [varchar](256) NOT NULL,
	[ImgType] [int] NOT NULL DEFAULT ((1)),
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'058c6833-bf76-4862-82fb-16e5e39b83a1', N'店铺', NULL, N'fa-desktop', NULL, 2000, 4, N'446ceb67-bf36-4a27-9419-6b4eca05c7f8', N'anonymous', CAST(N'2017-06-12 19:25:30.000' AS DateTime), N'anonymous', CAST(N'2017-06-14 20:42:24.847' AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2c32448a-e950-457c-a0d7-2eb7f4b302ae', N'订单管理', N'/shop/order', NULL, N'058c6833-bf76-4862-82fb-16e5e39b83a1', 2030, 4, N'f5ee32ad-e4f3-46a2-afb8-b1d4db9d489d', N'anonymous', CAST(N'2017-06-12 19:29:45.000' AS DateTime), N'abc', CAST(N'2017-06-15 22:52:19.400' AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'27773262-a218-408c-bf98-3afd1f91814e', N'退款处理', N'/shop/refund', NULL, N'058c6833-bf76-4862-82fb-16e5e39b83a1', 2050, 4, N'd65eade2-4374-445f-9926-f7c1417405bd', N'anonymous', CAST(N'2017-06-12 19:29:07.000' AS DateTime), N'abc', CAST(N'2017-06-15 22:52:30.607' AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'9e612770-95aa-40e6-84f8-5983d08d3c0e', N'角色管理', N'/admin/roles', NULL, N'fe0c2adb-f3df-4427-ace2-5e8ddbc67f82', 1020, 10, N'946d8c3e-a54c-4b46-9472-89ceb13ef590', N'anonymous', CAST(N'2016-07-10 00:25:03.000' AS DateTime), N'abc', CAST(N'2017-06-15 22:52:34.107' AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'fe0c2adb-f3df-4427-ace2-5e8ddbc67f82', N'系统配置', NULL, N'fa-home', NULL, 1000, 4, N'80c307e3-659b-4725-8e84-8d7886f1d2b5', N'anonymous', CAST(N'2016-07-10 00:06:07.000' AS DateTime), N'anonymous', CAST(N'2016-07-10 09:02:10.510' AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'd8342259-f72b-431d-a0b2-703b8a442bfb', N'账户管理', N'/admin/users', NULL, N'fe0c2adb-f3df-4427-ace2-5e8ddbc67f82', 1030, 3, N'93ece35b-8ac2-401d-bcfa-a334df022de1', N'anonymous', CAST(N'2016-07-10 09:12:18.000' AS DateTime), N'abc', CAST(N'2017-06-15 22:52:38.947' AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'35f86788-235b-4309-895c-8ff7ce473ad3', N'座位预约', N'/shop/index', NULL, N'058c6833-bf76-4862-82fb-16e5e39b83a1', 2010, 5, N'09c01118-e50e-460b-9e80-c5195783bee9', N'anonymous', CAST(N'2017-06-12 19:26:24.000' AS DateTime), N'abc', CAST(N'2017-06-15 22:52:42.507' AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'b240b292-87a0-456b-9458-a697dc450a5c', N'功能管理', N'/admin/functions', NULL, N'fe0c2adb-f3df-4427-ace2-5e8ddbc67f82', 1010, 7, N'22421452-ffd5-4060-800e-0c57e4faa1c6', N'anonymous', CAST(N'2016-07-10 00:25:50.000' AS DateTime), N'abc', CAST(N'2017-06-15 22:52:47.210' AS DateTime))
INSERT [dbo].[T_S_Role] ([RoleId], [RoleName], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'4d209d0b-748d-425a-ba43-24c80c5ba073', N'店员', 1, N'ce9ff0ff-04e6-4177-92c7-874b232a62b5', N'anonymous', CAST(N'2017-06-12 19:34:18.940' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:34:18.940' AS DateTime))
INSERT [dbo].[T_S_Role] ([RoleId], [RoleName], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'ecf21049-770a-4654-a91a-4fca51649bd5', N'客户', 1, N'c9b08c6a-4904-4839-bd96-eec79b94d97f', N'anonymous', CAST(N'2017-06-12 19:36:35.143' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:36:35.143' AS DateTime))
INSERT [dbo].[T_S_Role] ([RoleId], [RoleName], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'超级管理员', 2, N'8fe0ac23-0c78-46c8-bb00-caea4e43d88f', N'anonymous', CAST(N'2016-07-12 23:51:46.000' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:37:45.247' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'f6b91c77-7e20-4aa8-ac47-0ba6a71547c7', N'4d209d0b-748d-425a-ba43-24c80c5ba073', N'2c32448a-e950-457c-a0d7-2eb7f4b302ae', 1, N'e8f9d5e1-0b02-492a-9b7a-b40a7633ddfe', N'anonymous', CAST(N'2017-06-12 19:36:45.647' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:36:45.647' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'7414b909-2eb7-4626-8902-1ba2e7c0355f', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'27773262-a218-408c-bf98-3afd1f91814e', 1, N'c5f3d64f-461f-42fb-a2eb-6880a036efc8', N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c89e4ba7-c42d-4303-8f87-21e26b82bbe7', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'2c32448a-e950-457c-a0d7-2eb7f4b302ae', 1, N'c5f3d64f-461f-42fb-a2eb-6880a036efc8', N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'97e3ed47-a9b2-4362-9463-2dc30cb5592b', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'd8342259-f72b-431d-a0b2-703b8a442bfb', 1, N'c5f3d64f-461f-42fb-a2eb-6880a036efc8', N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'7a7b9757-d1c8-43a6-8ced-3f94cd433412', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'fe0c2adb-f3df-4427-ace2-5e8ddbc67f82', 1, N'c5f3d64f-461f-42fb-a2eb-6880a036efc8', N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'227cd171-5c17-4f4e-85dc-6f8c014a6cdf', N'4d209d0b-748d-425a-ba43-24c80c5ba073', N'27773262-a218-408c-bf98-3afd1f91814e', 1, N'e8f9d5e1-0b02-492a-9b7a-b40a7633ddfe', N'anonymous', CAST(N'2017-06-12 19:36:45.647' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:36:45.647' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c2e6b275-4871-4515-b5c2-ac38583799e1', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'35f86788-235b-4309-895c-8ff7ce473ad3', 1, N'c5f3d64f-461f-42fb-a2eb-6880a036efc8', N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'3a6d7548-70e6-4e7d-9793-bbee43cb48dd', N'4d209d0b-748d-425a-ba43-24c80c5ba073', N'058c6833-bf76-4862-82fb-16e5e39b83a1', 1, N'e8f9d5e1-0b02-492a-9b7a-b40a7633ddfe', N'anonymous', CAST(N'2017-06-12 19:36:45.647' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:36:45.647' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'293f429d-db86-40e7-91b8-bc0935321631', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'058c6833-bf76-4862-82fb-16e5e39b83a1', 1, N'c5f3d64f-461f-42fb-a2eb-6880a036efc8', N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'6b4094c4-2da9-4d22-a634-d5a52c823064', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'b240b292-87a0-456b-9458-a697dc450a5c', 1, N'c5f3d64f-461f-42fb-a2eb-6880a036efc8', N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c2c33126-98af-4224-bcb3-eded48006023', N'4d209d0b-748d-425a-ba43-24c80c5ba073', N'35f86788-235b-4309-895c-8ff7ce473ad3', 1, N'e8f9d5e1-0b02-492a-9b7a-b40a7633ddfe', N'anonymous', CAST(N'2017-06-12 19:36:45.647' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:36:45.647' AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2cbef2c6-9d8d-4234-9caf-f9eea5ba06eb', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'9e612770-95aa-40e6-84f8-5983d08d3c0e', 1, N'c5f3d64f-461f-42fb-a2eb-6880a036efc8', N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime), N'anonymous', CAST(N'2017-06-12 19:37:53.550' AS DateTime))
INSERT [dbo].[T_S_User] ([UserId], [LoginName], [Password], [IsActive], [Source], [OpenId], [AccessToken], [IsLock], [LastLoginTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'93bbd33c-0c29-43bb-8ef8-118ed371c524', N'xxx', N'111111', 0, 0, NULL, NULL, 0, CAST(N'2017-06-20 00:04:01.987' AS DateTime), 9, N'5740f505-b444-40f9-92ca-a19856fa60cb', N'anonymous', CAST(N'2016-07-12 23:49:52.860' AS DateTime), N'anonymous', CAST(N'2017-06-20 00:04:02.043' AS DateTime))
INSERT [dbo].[T_S_User] ([UserId], [LoginName], [Password], [IsActive], [Source], [OpenId], [AccessToken], [IsLock], [LastLoginTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', N'abc', N'111111', 0, 0, NULL, NULL, 0, CAST(N'2017-06-15 22:48:58.860' AS DateTime), 8, N'670b512c-451b-48d1-9a14-63626881db5a', N'anonymous', CAST(N'2016-07-11 19:57:26.053' AS DateTime), N'anonymous', CAST(N'2017-06-15 22:48:58.920' AS DateTime))
INSERT [dbo].[T_S_User_Role] ([Id], [UserId], [RoleId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'a7a309e1-e93c-498b-9cbc-0ba7393a5de2', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', N'4d209d0b-748d-425a-ba43-24c80c5ba073', 1, N'a1f4f097-0b1c-4bfa-8023-8e6982b263ce', N'anonymous', CAST(N'2017-06-13 07:06:39.157' AS DateTime), N'anonymous', CAST(N'2017-06-13 07:06:39.157' AS DateTime))
INSERT [dbo].[T_S_User_Role] ([Id], [UserId], [RoleId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'283b940d-10df-47d1-a749-8520ba0deda5', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', 1, N'27951eb1-d77f-4b45-9fcc-bb8851208536', N'anonymous', CAST(N'2017-06-13 07:06:25.217' AS DateTime), N'anonymous', CAST(N'2017-06-13 07:06:25.217' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'a34d6162-5876-47f8-a3c4-00f934d1435c', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(N'2017-06-27 00:04:01.987' AS DateTime), 1, N'5740f505-b444-40f9-92ca-a19856fa60cb', N'anonymous', CAST(N'2017-06-20 00:04:02.043' AS DateTime), N'anonymous', CAST(N'2017-06-20 00:04:02.043' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'3df6e838-cf0b-47b9-928e-09cbecce0bfe', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(N'2017-06-14 20:41:52.320' AS DateTime), 2, N'ce73244f-3ade-49d7-ad7c-0f112f4e5c2b', N'anonymous', CAST(N'2017-06-14 20:28:12.227' AS DateTime), N'anonymous', CAST(N'2017-06-14 20:41:52.320' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c3281cf1-53f2-442d-a5e8-0da7bec392ff', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(N'2017-06-15 21:02:25.070' AS DateTime), 2, N'82894c01-5e06-437d-bb89-2946d4d83d8d', N'anonymous', CAST(N'2017-06-14 21:33:06.707' AS DateTime), N'abc', CAST(N'2017-06-15 21:02:25.123' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'b0ec0161-5306-4783-8360-20184249de94', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(N'2017-06-13 07:04:35.643' AS DateTime), 2, N'4ef4e9ec-a2a2-4cb3-8f6a-3b893b3f28c1', N'anonymous', CAST(N'2017-06-12 23:22:53.630' AS DateTime), N'anonymous', CAST(N'2017-06-13 07:04:35.683' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'171bf145-d95e-4f3f-8187-8131e899bf44', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(N'2017-06-20 00:03:48.617' AS DateTime), 2, N'6eb646c8-1f05-43a1-9379-51be4ca83673', N'anonymous', CAST(N'2017-06-15 22:48:58.920' AS DateTime), N'abc', CAST(N'2017-06-20 00:03:48.677' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'66a1d02e-bf0a-43e5-bf6b-81e4eb43906e', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(N'2017-06-15 22:48:49.493' AS DateTime), 2, N'c84bdb1c-1632-45ac-b498-b3d90ef697b1', N'anonymous', CAST(N'2017-06-15 21:14:58.137' AS DateTime), N'xxx', CAST(N'2017-06-15 22:48:49.553' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'7e54e44c-4f07-4d95-abd8-835ca185538c', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(N'2017-06-14 21:32:57.133' AS DateTime), 2, N'68044440-4150-4c6c-9881-946c587fe2aa', N'anonymous', CAST(N'2017-06-14 20:42:53.057' AS DateTime), N'anonymous', CAST(N'2017-06-14 21:32:57.170' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'15957e48-5aae-4db8-8a67-91edafb72ad6', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(N'2017-06-12 23:22:46.637' AS DateTime), 2, N'7bfe9f10-cab1-439a-9e2c-47c3d4e936d2', N'anonymous', CAST(N'2017-06-12 23:21:44.380' AS DateTime), N'anonymous', CAST(N'2017-06-12 23:22:46.680' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'26d0e08d-ecae-46f7-b68a-9783bb3b42eb', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(N'2017-06-14 20:27:03.153' AS DateTime), 2, N'7d91da29-44e2-4caa-b7a3-74c772cb9899', N'anonymous', CAST(N'2017-06-13 22:05:56.547' AS DateTime), N'anonymous', CAST(N'2017-06-14 20:27:03.187' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2548622a-0f70-40e4-8a0f-9f2f72998df4', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(N'2017-06-26 21:12:08.350' AS DateTime), 1, N'20cb3e7b-0818-4675-adc1-50f2cda74d34', N'anonymous', CAST(N'2017-06-19 21:12:08.487' AS DateTime), N'anonymous', CAST(N'2017-06-19 21:12:08.487' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c29379af-5f87-4591-b69d-a7ad0f9a965a', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(N'2017-06-13 20:03:06.457' AS DateTime), 2, N'ce02c8d8-d7dd-4cd4-8c05-9704071cfad4', N'anonymous', CAST(N'2017-06-13 07:07:13.580' AS DateTime), N'anonymous', CAST(N'2017-06-13 20:03:06.527' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c7606ca7-ccd4-42fb-947e-d501a978ed59', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(N'2017-06-14 20:27:59.667' AS DateTime), 2, N'f9269182-ebe6-4e87-bfc1-5dbcd4fa79cb', N'anonymous', CAST(N'2017-06-14 20:27:10.850' AS DateTime), N'anonymous', CAST(N'2017-06-14 20:27:59.667' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'f3d53a26-fe3c-42c1-86ba-d88596065781', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(N'2017-06-12 23:19:45.823' AS DateTime), 2, N'c0121af2-c5c4-4a04-a4b7-9fa062e46d29', N'anonymous', CAST(N'2017-06-12 23:19:36.803' AS DateTime), N'anonymous', CAST(N'2017-06-12 23:19:45.830' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'd5819c0e-abe9-417e-aeb2-d94a9d40e27b', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(N'2017-06-13 07:06:44.887' AS DateTime), 2, N'35bb0118-70cb-4559-84f4-f242ae2a485f', N'anonymous', CAST(N'2017-06-13 07:04:43.830' AS DateTime), N'anonymous', CAST(N'2017-06-13 07:06:44.887' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'f9e41f9e-a26a-4821-ac1d-e840e470a769', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(N'2017-06-14 20:42:38.780' AS DateTime), 2, N'dd8d599f-21d7-4719-8d6d-79a1ca7eff72', N'anonymous', CAST(N'2017-06-14 20:42:00.020' AS DateTime), N'anonymous', CAST(N'2017-06-14 20:42:38.780' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c35df8f6-ceb1-47ce-bb53-f5405c689d24', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(N'2017-06-13 22:05:49.633' AS DateTime), 2, N'c68efd37-e430-4bf5-b033-c356f11a6568', N'anonymous', CAST(N'2017-06-13 20:03:16.380' AS DateTime), N'anonymous', CAST(N'2017-06-13 22:05:49.673' AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'e9745f33-2e39-47f8-95a6-fd0155a52fbc', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(N'2017-06-13 07:07:04.963' AS DateTime), 2, N'77117aa6-2d49-48b4-8371-e909e2cb23c7', N'anonymous', CAST(N'2017-06-13 07:06:51.720' AS DateTime), N'anonymous', CAST(N'2017-06-13 07:07:04.963' AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'shop02', CAST(1.0000000 AS Decimal(10, 7)), CAST(1.0000000 AS Decimal(10, 7)), N'xxx xxx', 1, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 1, N'74fe6047-ca23-4e6b-afff-fbb6ffcececc', N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime), N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'3916c7a9-2d7c-4c55-a14d-196a0d79c11a', N'shop03', CAST(1.0000000 AS Decimal(10, 7)), CAST(1.0000000 AS Decimal(10, 7)), N'xxx xxx', 1, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 1, N'091184ad-375a-4a25-8a78-da201c17da1d', N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime), N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'9da09cbf-0eb1-417c-b143-39f853ff51ef', N'shop06', CAST(1.0000000 AS Decimal(10, 7)), CAST(1.0000000 AS Decimal(10, 7)), N'xxx xxx', 1, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 1, N'dd0f282b-eefd-4a8d-bb82-93c178679891', N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime), N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'cbdef62f-3424-4958-bd58-6531546065d2', N'shop01', CAST(1.0000000 AS Decimal(10, 7)), CAST(1.0000000 AS Decimal(10, 7)), N'xxx xxx', 1, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 1, N'7fa4dd23-98d4-413e-9f37-c38056197e7d', N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime), N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'03d99f20-8d8d-45ea-9c3b-9bb82422ff12', N'shop04', CAST(1.0000000 AS Decimal(10, 7)), CAST(1.0000000 AS Decimal(10, 7)), N'xxx xxx', 1, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 1, N'5f0479e4-d854-4d31-83ab-a476379d7af0', N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime), N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'42d9278f-bd77-4994-960e-fc9fa1241cda', N'shop05', CAST(1.0000000 AS Decimal(10, 7)), CAST(1.0000000 AS Decimal(10, 7)), N'xxx xxx', 1, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 1, N'8374d7d5-cf86-4b12-9fa2-ead448e99b12', N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime), N'test', CAST(N'2017-06-13 21:31:05.187' AS DateTime))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'6c0b77b1-fb61-46ef-97a6-02c8b5fdd198', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk01', 0, 1, N'7bb79c8c-dbb9-4942-9595-6611b96f6e1c', N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'920b3c06-8af1-479e-b2ae-3bb68055610a', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk03', 0, 1, N'c8d946ab-822c-4f2a-9517-c545a48dfda1', N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'e23af55b-69ae-4c99-83b2-6144dee0eb20', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk06', 0, 1, N'19cacede-9e88-41e7-82c3-3300b102e0b0', N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'e09fc35a-2176-4e53-aac3-9cc172251ff7', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk07', 0, 1, N'5bab1505-80e3-477f-826a-2ef92f54dad3', N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'9733420c-6a4a-4ea6-9332-a86adef3d7bb', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk05', 0, 1, N'78cb217e-aa3e-4084-abbc-a93c586cb986', N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'5e2f6f6e-ded2-4223-b4c6-c48b4bc5cdd2', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk02', 0, 1, N'8487944b-e9a9-4440-80a2-72df89f6c440', N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'f6def65a-9903-4759-9611-e1eeb3dcb5c6', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk04', 0, 1, N'2c75dcec-7553-4c98-9d4e-207fe3291ac8', N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), N'test', CAST(N'2017-06-13 21:33:50.960' AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Img] ([Id], [ShopId], [Name], [Url], [ImgType], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'b2fac074-922f-428b-b90e-516802189c82', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'', N'upload/shop/3.jpg', 1, 1, N'3e6fde88-6b3a-4fb5-9eda-6caf2556ce3b', N'bn', CAST(N'2017-06-19 21:23:17.880' AS DateTime), N'bn', CAST(N'2017-06-19 21:23:17.880' AS DateTime))
INSERT [dbo].[ZY_Shop_Img] ([Id], [ShopId], [Name], [Url], [ImgType], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'3cfa475d-60d7-4a5b-a5b2-5a90b03b2048', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'', N'upload/shop/1.jpg', 1, 1, N'916bfd51-0b36-4dbd-b7a7-f032a1020a94', N'bn', CAST(N'2017-06-19 21:23:17.873' AS DateTime), N'bn', CAST(N'2017-06-19 21:23:17.873' AS DateTime))
INSERT [dbo].[ZY_Shop_Img] ([Id], [ShopId], [Name], [Url], [ImgType], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'1bb53deb-9645-40e3-b1c7-db9757c76f09', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'', N'upload/shop/2.jpg', 1, 1, N'd8d521cf-7856-4c60-b760-0fd6071ef75d', N'bn', CAST(N'2017-06-19 21:23:17.880' AS DateTime), N'bn', CAST(N'2017-06-19 21:23:17.880' AS DateTime))
ALTER TABLE [dbo].[T_S_Code] ADD  DEFAULT ((0)) FOR [Seq]
GO
ALTER TABLE [dbo].[T_S_Code] ADD  DEFAULT ((0)) FOR [VersionNo]
GO
ALTER TABLE [dbo].[T_S_Code] ADD  DEFAULT (getdate()) FOR [CreatedTime]
GO
ALTER TABLE [dbo].[T_S_Code] ADD  DEFAULT (getdate()) FOR [UpdatedTime]
GO
ALTER TABLE [dbo].[ZY_Booked_Position] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[ZY_Booked_Position] ADD  DEFAULT ((0)) FOR [IsInternal]
GO
ALTER TABLE [dbo].[ZY_Order] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[ZY_Order] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[ZY_Order] ADD  DEFAULT ((0)) FOR [IsInternal]
GO
ALTER TABLE [dbo].[T_S_Role_Function]  WITH CHECK ADD  CONSTRAINT [FK_T_S_Role_Function_T_S_Function] FOREIGN KEY([FunctionId])
REFERENCES [dbo].[T_S_Function] ([FunctionId])
GO
ALTER TABLE [dbo].[T_S_Role_Function] CHECK CONSTRAINT [FK_T_S_Role_Function_T_S_Function]
GO
ALTER TABLE [dbo].[T_S_Role_Function]  WITH CHECK ADD  CONSTRAINT [FK_T_S_Role_Function_T_S_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[T_S_Role] ([RoleId])
GO
ALTER TABLE [dbo].[T_S_Role_Function] CHECK CONSTRAINT [FK_T_S_Role_Function_T_S_Role]
GO
ALTER TABLE [dbo].[T_S_User_Role]  WITH CHECK ADD  CONSTRAINT [FK_T_S_User_Role_T_S_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[T_S_Role] ([RoleId])
GO
ALTER TABLE [dbo].[T_S_User_Role] CHECK CONSTRAINT [FK_T_S_User_Role_T_S_Role]
GO
ALTER TABLE [dbo].[T_S_User_Role]  WITH CHECK ADD  CONSTRAINT [FK_T_S_User_Role_T_S_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[T_S_User] ([UserId])
GO
ALTER TABLE [dbo].[T_S_User_Role] CHECK CONSTRAINT [FK_T_S_User_Role_T_S_User]
GO
ALTER TABLE [dbo].[ZY_Booked_Position]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Booked_Position_ZY_Customer] FOREIGN KEY([CustomerOpenId])
REFERENCES [dbo].[ZY_Customer] ([OpenId])
GO
ALTER TABLE [dbo].[ZY_Booked_Position] CHECK CONSTRAINT [FK_ZY_Booked_Position_ZY_Customer]
GO
ALTER TABLE [dbo].[ZY_Booked_Position]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Booked_Position_ZY_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[ZY_Order] ([OrderId])
GO
ALTER TABLE [dbo].[ZY_Booked_Position] CHECK CONSTRAINT [FK_ZY_Booked_Position_ZY_Order]
GO
ALTER TABLE [dbo].[ZY_Booked_Position]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Booked_Position_ZY_Shop_Desk] FOREIGN KEY([DeskId])
REFERENCES [dbo].[ZY_Shop_Desk] ([DeskId])
GO
ALTER TABLE [dbo].[ZY_Booked_Position] CHECK CONSTRAINT [FK_ZY_Booked_Position_ZY_Shop_Desk]
GO
ALTER TABLE [dbo].[ZY_Order]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Order_ZY_Customer] FOREIGN KEY([CustomerOpenId])
REFERENCES [dbo].[ZY_Customer] ([OpenId])
GO
ALTER TABLE [dbo].[ZY_Order] CHECK CONSTRAINT [FK_ZY_Order_ZY_Customer]
GO
ALTER TABLE [dbo].[ZY_Session]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Session_T_S_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[T_S_User] ([UserId])
GO
ALTER TABLE [dbo].[ZY_Session] CHECK CONSTRAINT [FK_ZY_Session_T_S_User]
GO
ALTER TABLE [dbo].[ZY_Shop]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Shop_T_S_User] FOREIGN KEY([OwnId])
REFERENCES [dbo].[T_S_User] ([UserId])
GO
ALTER TABLE [dbo].[ZY_Shop] CHECK CONSTRAINT [FK_ZY_Shop_T_S_User]
GO
ALTER TABLE [dbo].[ZY_Shop_Desk]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Shop_Desk_ZY_Shop] FOREIGN KEY([ShopId])
REFERENCES [dbo].[ZY_Shop] ([ShopId])
GO
ALTER TABLE [dbo].[ZY_Shop_Desk] CHECK CONSTRAINT [FK_ZY_Shop_Desk_ZY_Shop]
GO
ALTER TABLE [dbo].[ZY_Shop_Img]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Shop_Img_ZY_Shop] FOREIGN KEY([ShopId])
REFERENCES [dbo].[ZY_Shop] ([ShopId])
GO
ALTER TABLE [dbo].[ZY_Shop_Img] CHECK CONSTRAINT [FK_ZY_Shop_Img_ZY_Shop]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCustomerOrders]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_GetCustomerOrders]
  ( 
    @openId nvarchar(256)
  ) 
  AS
  BEGIN
  select a.OrderDate,a.Status,booked.Positions,xx.ShopName,xx.DeskName from ZY_Order a
  outer apply (select b.Position+',' as [positions] from ZY_Booked_Position b where a.orderId=b.OrderId for xml path('')) as booked(positions)
  outer apply (select top 1 e.Name as [ShopName],d.DeskName from ZY_Booked_Position c
  inner join ZY_Shop_Desk d on c.DeskId=d.DeskId
  inner join ZY_Shop e on d.ShopId=e.ShopId where c.OrderId=a.OrderId) as xx
  where a.CustomerOpenId=@openId
  END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDesks]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetDesks]
  ( 
    @shopId uniqueIdentifier, 
    @date datetime
  ) 
  AS
  BEGIN
    select DeskId,DeskName,booked.position as [BookedPositions],internlbooked.position as [InternalBookedPositions] from ZY_Shop_Desk a
	outer apply (select CONVERT(nvarchar(256),b.Position)+',' from ZY_Booked_Position b where b.DeskId=a.DeskId and b.Status=1 and b.OrderDate=@date for xml path(''))as booked(position)
	outer apply (select CONVERT(nvarchar(256),b.Position)+',' from ZY_Booked_Position b where b.DeskId=a.DeskId and b.Status=1 and b.OrderDate=@date and b.IsInternal=1 for xml path(''))as internlbooked(position)
	where ShopId=@shopId
	order by DeskName
  END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDesksForCustomer]    Script Date: 2017/6/20 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetDesksForCustomer]
  ( 
    @shopId uniqueIdentifier, 
    @date datetime
  ) 
  AS
  BEGIN
    select deskId,DeskName as [deskName],booked.position as [bookedPositions] ,@date as [selectedDate],a.UnitPrice from ZY_Shop_Desk a
	inner join ZY_Shop c on a.ShopId=c.ShopId
	outer apply (select CONVERT(nvarchar(256),b.Position)+',' from ZY_Booked_Position b where b.DeskId=a.DeskId and b.Status>0 and b.OrderDate=@date for xml path(''))as booked(position)
	where a.ShopId=@shopId and c.ShopStatus=1
	order by DeskName
  END
GO
USE [master]
GO
ALTER DATABASE [bn_zy] SET  READ_WRITE 
GO
