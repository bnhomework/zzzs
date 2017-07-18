USE [master]
GO
/****** Object:  Database [zzzs]    Script Date: 07/18/2017 22:25:26 ******/
CREATE DATABASE [zzzs] ON  PRIMARY 
( NAME = N'zzzs', FILENAME = N'D:\BN\zzzs\db\zzzs.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'zzzs_log', FILENAME = N'D:\BN\zzzs\db\zzzs_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [zzzs] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [zzzs].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [zzzs] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [zzzs] SET ANSI_NULLS OFF
GO
ALTER DATABASE [zzzs] SET ANSI_PADDING OFF
GO
ALTER DATABASE [zzzs] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [zzzs] SET ARITHABORT OFF
GO
ALTER DATABASE [zzzs] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [zzzs] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [zzzs] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [zzzs] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [zzzs] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [zzzs] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [zzzs] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [zzzs] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [zzzs] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [zzzs] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [zzzs] SET  DISABLE_BROKER
GO
ALTER DATABASE [zzzs] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [zzzs] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [zzzs] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [zzzs] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [zzzs] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [zzzs] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [zzzs] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [zzzs] SET  READ_WRITE
GO
ALTER DATABASE [zzzs] SET RECOVERY FULL
GO
ALTER DATABASE [zzzs] SET  MULTI_USER
GO
ALTER DATABASE [zzzs] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [zzzs] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'zzzs', N'ON'
GO
USE [zzzs]
GO
/****** Object:  Table [dbo].[ZZ_Template]    Script Date: 07/18/2017 22:25:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZZ_Template](
	[TemplateId] [uniqueidentifier] NOT NULL,
	[Category] [int] NOT NULL,
	[Sex] [int] NULL,
	[Color] [nvarchar](256) NULL,
	[ColorCode] [nvarchar](256) NULL,
	[FrontImg] [nvarchar](256) NULL,
	[BackImg] [nvarchar](256) NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TemplateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'e5dd098d-d3d0-443f-a6ef-0ca77a45f3e3', 0, 2, N'green', N'#64A100', N'template/tshirt_female_greenfront.png', N'template/tshirt_female_greenback.png', 1, N'48f76246-9bcb-4a52-b056-6b25fa589e33', N'system', CAST(0x0000A7A00153EDB3 AS DateTime), N'system', CAST(0x0000A7A00153EDB3 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2aae4a90-9495-48ab-bd8c-12642963db9b', 0, 2, N'gray', N'#D0D0D1', N'template/tshirt_female_grayfront.png', N'template/tshirt_female_grayback.png', 1, N'0f321e37-741a-4383-baa4-663f1db438d6', N'system', CAST(0x0000A7A00153EDB4 AS DateTime), N'system', CAST(0x0000A7A00153EDB4 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'7c894dff-0e5a-44d5-a8e3-29bb7c16a112', 0, 2, N'skyblue', N'#CAAD15', N'template/tshirt_female_skybluefront.png', N'template/tshirt_female_skyblueback.png', 1, N'df8f90ba-ee28-48fb-9699-9b37028f08df', N'system', CAST(0x0000A7A00153EDB3 AS DateTime), N'system', CAST(0x0000A7A00153EDB3 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'47b0fb7d-3476-4744-a351-32688467d438', 0, 1, N'skyblue', N'#CAAD15', N'template/tshirt_male_skybluefront.png', N'template/tshirt_male_skyblueback.png', 1, N'fc7406b6-580a-4ea6-b001-624be6504798', N'system', CAST(0x0000A7A00153EDB2 AS DateTime), N'system', CAST(0x0000A7A00153EDB2 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'b3331114-8cd8-47a8-be72-42f1fcf03e03', 0, 1, N'black', N'#1F1D1C', N'template/tshirt_male_blackfront.png', N'template/tshirt_male_blackback.png', 1, N'2f2939d5-a222-4d05-a5e0-8dd77cd9f3be', N'system', CAST(0x0000A7A00153EDB3 AS DateTime), N'system', CAST(0x0000A7A00153EDB3 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'4d40d3c7-5d41-4adc-acd9-4c0d294c2eec', 0, 2, N'red', N'#061CCC', N'template/tshirt_female_redfront.png', N'template/tshirt_female_redback.png', 1, N'74d43b91-9df8-4e2b-b696-855add86c63e', N'system', CAST(0x0000A7A00153EDB3 AS DateTime), N'system', CAST(0x0000A7A00153EDB3 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'175cc7a4-c43e-44f7-9c10-50be09ac1d61', 0, 2, N'blue', N'#2E1C18', N'template/tshirt_female_bluefront.png', N'template/tshirt_female_blueback.png', 1, N'f1b5ea40-5978-4258-b174-53f8f0d298d3', N'system', CAST(0x0000A7A00153EDB4 AS DateTime), N'system', CAST(0x0000A7A00153EDB4 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'81ad5463-6c91-4152-b43e-52eea5ef4d03', 0, 2, N'white', N'#E2DDDB', N'template/tshirt_female_whitefront.png', N'template/tshirt_female_whiteback.png', 1, N'8c28d259-24aa-40f9-91fe-270a9298a210', N'system', CAST(0x0000A7A00153EDB3 AS DateTime), N'system', CAST(0x0000A7A00153EDB3 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2d0ddf59-35ff-4eff-b7e6-6c509139bb24', 0, 2, N'black', N'#1F1D1C', N'template/tshirt_female_blackfront.png', N'template/tshirt_female_blackback.png', 1, N'ddb72679-58ba-4f26-a503-ced17c396733', N'system', CAST(0x0000A7A00153EDB4 AS DateTime), N'system', CAST(0x0000A7A00153EDB4 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'1d0c316f-4e8c-4940-b36d-750b86c1dff2', 0, 2, N'yellow', N'#01D3EE', N'template/tshirt_female_yellowfront.png', N'template/tshirt_female_yellowback.png', 1, N'676b2f45-f347-4826-9ded-fb18f1fcb201', N'system', CAST(0x0000A7A00153EDB3 AS DateTime), N'system', CAST(0x0000A7A00153EDB3 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'ddc5867c-f4fb-482a-977b-8515c3e6b027', 0, 1, N'white', N'#E2DDDB', N'template/tshirt_male_whitefront.png', N'template/tshirt_male_whiteback.png', 1, N'176249e0-7616-4415-836e-6ee99b36c422', N'system', CAST(0x0000A7A00153EDB1 AS DateTime), N'system', CAST(0x0000A7A00153EDB1 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'70b6cd01-30ff-445a-aee6-8ac0beea7f22', 0, 1, N'red', N'#061CCC', N'template/tshirt_male_redfront.png', N'template/tshirt_male_redback.png', 1, N'd4d935fe-860e-4eee-a99e-69c7b2ff0255', N'system', CAST(0x0000A7A00153EDB2 AS DateTime), N'system', CAST(0x0000A7A00153EDB2 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2d9e35a4-be55-47dd-a9ef-da3443806099', 0, 1, N'yellow', N'#01D3EE', N'template/tshirt_male_yellowfront.png', N'template/tshirt_male_yellowback.png', 1, N'98620cc2-be34-454c-a182-27336edc9ca9', N'system', CAST(0x0000A7A00153EDB2 AS DateTime), N'system', CAST(0x0000A7A00153EDB2 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'64b10e96-5c15-4ec3-a1ac-db31d8cf95e9', 0, 1, N'green', N'#64A100', N'template/tshirt_male_greenfront.png', N'template/tshirt_male_greenback.png', 1, N'80ed8875-bb12-4cca-bb54-249f306367d3', N'system', CAST(0x0000A7A00153EDB2 AS DateTime), N'system', CAST(0x0000A7A00153EDB2 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'd50316bc-76b2-4114-a236-f22bc2b62537', 0, 1, N'gray', N'#D0D0D1', N'template/tshirt_male_grayfront.png', N'template/tshirt_male_grayback.png', 1, N'c07004d2-2468-49be-8d47-b087df072b8c', N'system', CAST(0x0000A7A00153EDB2 AS DateTime), N'system', CAST(0x0000A7A00153EDB2 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c875b623-943d-4f9f-8cee-f539a039e5e4', 0, 2, N'pink', N'#C6AEF5', N'template/tshirt_female_pinkfront.png', N'template/tshirt_female_pinkback.png', 1, N'b94174a4-1d67-4ed9-895e-3be42ea916d5', N'system', CAST(0x0000A7A00153EDB4 AS DateTime), N'system', CAST(0x0000A7A00153EDB4 AS DateTime))
INSERT [dbo].[ZZ_Template] ([TemplateId], [Category], [Sex], [Color], [ColorCode], [FrontImg], [BackImg], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'13c3e2b8-392e-48df-8f5c-f7a615c5ad94', 0, 1, N'blue', N'#2E1C18', N'template/tshirt_male_bluefront.png', N'template/tshirt_male_blueback.png', 1, N'a5e3f8bb-af99-4850-9d24-b80b1b4bba1a', N'system', CAST(0x0000A7A00153EDB3 AS DateTime), N'system', CAST(0x0000A7A00153EDB3 AS DateTime))
/****** Object:  Table [dbo].[ZZ_Desgin]    Script Date: 07/18/2017 22:25:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZZ_Desgin](
	[DesginId] [uniqueidentifier] NOT NULL,
	[CustomerId] [nvarchar](256) NOT NULL,
	[TemplateId] [uniqueidentifier] NOT NULL,
	[Desgin] [nvarchar](2000) NULL,
	[DesginName] [nvarchar](256) NULL,
	[DesginPreview] [nvarchar](256) NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DesginId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_S_Role]    Script Date: 07/18/2017 22:25:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T_S_Role](
	[RoleId] [uniqueidentifier] NOT NULL,
	[RoleName] [varchar](128) NOT NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[T_S_Role] ([RoleId], [RoleName], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'4d209d0b-748d-425a-ba43-24c80c5ba073', N'店员', 1, N'ce9ff0ff-04e6-4177-92c7-874b232a62b5', N'anonymous', CAST(0x0000A79001428912 AS DateTime), N'anonymous', CAST(0x0000A79001428912 AS DateTime))
INSERT [dbo].[T_S_Role] ([RoleId], [RoleName], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'ecf21049-770a-4654-a91a-4fca51649bd5', N'客户', 1, N'c9b08c6a-4904-4839-bd96-eec79b94d97f', N'anonymous', CAST(0x0000A790014328AF AS DateTime), N'anonymous', CAST(0x0000A790014328AF AS DateTime))
INSERT [dbo].[T_S_Role] ([RoleId], [RoleName], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'超级管理员', 2, N'8fe0ac23-0c78-46c8-bb00-caea4e43d88f', N'anonymous', CAST(0x0000A64101893F18 AS DateTime), N'anonymous', CAST(0x0000A79001437AD6 AS DateTime))
/****** Object:  Table [dbo].[T_S_Function]    Script Date: 07/18/2017 22:25:28 ******/
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
	[Seq] [int] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FunctionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'058c6833-bf76-4862-82fb-16e5e39b83a1', N'我的店铺', NULL, N'fa-desktop', NULL, 2000, 5, N'eb0dd246-fb84-43b5-a2f1-7518230dc5e7', N'anonymous', CAST(0x0000A79001401D38 AS DateTime), N'admin', CAST(0x0000A798018240F1 AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'd59f4727-eba5-40ba-9258-2b375f491d6a', N'桌游平台', NULL, N'fa-cubes', NULL, 4000, 1, N'a2001f3a-c7e9-4ee8-aa2d-4b0b207b181d', N'admin', CAST(0x0000A7980183FE9B AS DateTime), N'admin', CAST(0x0000A7980183FE9B AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2c32448a-e950-457c-a0d7-2eb7f4b302ae', N'订单管理', N'/shop/order', NULL, N'058c6833-bf76-4862-82fb-16e5e39b83a1', 2030, 4, N'f5ee32ad-e4f3-46a2-afb8-b1d4db9d489d', N'anonymous', CAST(0x0000A7900141480C AS DateTime), N'abc', CAST(0x0000A7930178EB7C AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'fd67035c-7a43-42a5-a88e-52d68e5f1b08', N'店铺管理', N'/Plateform/index', NULL, N'd59f4727-eba5-40ba-9258-2b375f491d6a', 4010, 1, N'6d0cecb3-b043-49ec-b6f4-4a8c857c9436', N'admin', CAST(0x0000A799017779B4 AS DateTime), N'admin', CAST(0x0000A799017779B4 AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'9e612770-95aa-40e6-84f8-5983d08d3c0e', N'角色管理', N'/admin/roles', NULL, N'fe0c2adb-f3df-4427-ace2-5e8ddbc67f82', 1020, 10, N'946d8c3e-a54c-4b46-9472-89ceb13ef590', N'anonymous', CAST(0x0000A63F0006E154 AS DateTime), N'abc', CAST(0x0000A7930178FCB8 AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'fe0c2adb-f3df-4427-ace2-5e8ddbc67f82', N'系统配置', NULL, N'fa-home', NULL, 1000, 4, N'80c307e3-659b-4725-8e84-8d7886f1d2b5', N'anonymous', CAST(0x0000A63F0001AE14 AS DateTime), N'anonymous', CAST(0x0000A63F0094E9B1 AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'd8342259-f72b-431d-a0b2-703b8a442bfb', N'账户管理', N'/admin/users', NULL, N'fe0c2adb-f3df-4427-ace2-5e8ddbc67f82', 1030, 3, N'93ece35b-8ac2-401d-bcfa-a334df022de1', N'anonymous', CAST(0x0000A63F0097B198 AS DateTime), N'abc', CAST(0x0000A79301790264 AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'35f86788-235b-4309-895c-8ff7ce473ad3', N'座位预约', N'/shop/index', NULL, N'058c6833-bf76-4862-82fb-16e5e39b83a1', 2010, 5, N'09c01118-e50e-460b-9e80-c5195783bee9', N'anonymous', CAST(0x0000A79001405C80 AS DateTime), N'abc', CAST(0x0000A79301790690 AS DateTime))
INSERT [dbo].[T_S_Function] ([FunctionId], [Name], [Url], [Icon], [ParentId], [Seq], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'b240b292-87a0-456b-9458-a697dc450a5c', N'功能管理', N'/admin/functions', NULL, N'fe0c2adb-f3df-4427-ace2-5e8ddbc67f82', 1010, 7, N'22421452-ffd5-4060-800e-0c57e4faa1c6', N'anonymous', CAST(0x0000A63F00071868 AS DateTime), N'abc', CAST(0x0000A79301790C13 AS DateTime))
/****** Object:  Table [dbo].[T_S_Code]    Script Date: 07/18/2017 22:25:28 ******/
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ZY_Customer]    Script Date: 07/18/2017 22:25:28 ******/
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ZY_Customer] ([OpenId], [UserName], [Avatar], [TokenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'owRpquBH9AqcqMYjWGnSM-sgcAFo', N'', NULL, N'BMIOxJY7TPXNVOizcsIp1DxOaVo8NgioH-gLHeXHdNbGe8uDJFy9yyLKWIjngC1KaJKgtbM6iIL6sgpy8OB5Koz8X5ZLrOvqTtGtUcQGRb8', 59, N'6b01a284-1a2d-4742-b528-acb9b111cf49', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', CAST(0x0000A7980170721D AS DateTime), N'owRpquBH9AqcqMYjWGnSM-sgcAFo', CAST(0x0000A7B4016FF71E AS DateTime))
/****** Object:  Table [dbo].[T_S_User]    Script Date: 07/18/2017 22:25:28 ******/
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
	[IsActive] [bit] NOT NULL,
	[Source] [int] NOT NULL,
	[OpenId] [varchar](256) NULL,
	[AccessToken] [varchar](512) NULL,
	[IsLock] [bit] NOT NULL,
	[LastLoginTime] [datetime] NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[T_S_User] ([UserId], [LoginName], [Password], [IsActive], [Source], [OpenId], [AccessToken], [IsLock], [LastLoginTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'93bbd33c-0c29-43bb-8ef8-118ed371c524', N'user', N'111111', 0, 0, NULL, NULL, 0, CAST(0x0000A79A00B79658 AS DateTime), 12, N'50c2a8fc-4777-4dd0-9d58-bdc05a652f0c', N'anonymous', CAST(0x0000A6410188B980 AS DateTime), N'anonymous', CAST(0x0000A79A00B79659 AS DateTime))
INSERT [dbo].[T_S_User] ([UserId], [LoginName], [Password], [IsActive], [Source], [OpenId], [AccessToken], [IsLock], [LastLoginTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', N'admin', N'111111', 0, 0, NULL, NULL, 0, CAST(0x0000A7A200FF5500 AS DateTime), 13, N'f070a9b2-18cc-4e31-8cc6-7fe70cf7b8bf', N'anonymous', CAST(0x0000A6400148E288 AS DateTime), N'anonymous', CAST(0x0000A7A200FF551E AS DateTime))
/****** Object:  Table [dbo].[Pay]    Script Date: 07/18/2017 22:25:28 ******/
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
	[UpdatedTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Pay] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[T_S_User_Role]    Script Date: 07/18/2017 22:25:28 ******/
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
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[T_S_User_Role] ([Id], [UserId], [RoleId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'a7a309e1-e93c-498b-9cbc-0ba7393a5de2', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', N'4d209d0b-748d-425a-ba43-24c80c5ba073', 1, N'a1f4f097-0b1c-4bfa-8023-8e6982b263ce', N'anonymous', CAST(0x0000A79100752F03 AS DateTime), N'anonymous', CAST(0x0000A79100752F03 AS DateTime))
INSERT [dbo].[T_S_User_Role] ([Id], [UserId], [RoleId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'283b940d-10df-47d1-a749-8520ba0deda5', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', 1, N'27951eb1-d77f-4b45-9fcc-bb8851208536', N'anonymous', CAST(0x0000A79100751EAD AS DateTime), N'anonymous', CAST(0x0000A79100751EAD AS DateTime))
/****** Object:  Table [dbo].[T_S_Role_Function]    Script Date: 07/18/2017 22:25:28 ******/
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
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'41b5cfdd-c26a-4c55-90e3-11f71a17af35', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'058c6833-bf76-4862-82fb-16e5e39b83a1', 1, N'c936c36e-f963-4b86-9c54-39fbfcf79ec1', N'admin', CAST(0x0000A79901779A21 AS DateTime), N'admin', CAST(0x0000A79901779A21 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'08e42f0f-e349-4c0a-a6ae-15b130a4fc81', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'd8342259-f72b-431d-a0b2-703b8a442bfb', 1, N'c936c36e-f963-4b86-9c54-39fbfcf79ec1', N'admin', CAST(0x0000A79901779A21 AS DateTime), N'admin', CAST(0x0000A79901779A21 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'ad59dd6f-c982-405c-b112-2240b7419b9c', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'2c32448a-e950-457c-a0d7-2eb7f4b302ae', 1, N'c936c36e-f963-4b86-9c54-39fbfcf79ec1', N'admin', CAST(0x0000A79901779A21 AS DateTime), N'admin', CAST(0x0000A79901779A21 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'cbe6ab98-73b1-4aa6-9067-250d660fde45', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'b240b292-87a0-456b-9458-a697dc450a5c', 1, N'c936c36e-f963-4b86-9c54-39fbfcf79ec1', N'admin', CAST(0x0000A79901779A21 AS DateTime), N'admin', CAST(0x0000A79901779A21 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2cc5b299-8031-48b4-849f-39d8aaac9fda', N'4d209d0b-748d-425a-ba43-24c80c5ba073', N'35f86788-235b-4309-895c-8ff7ce473ad3', 1, N'2b590389-2de1-4f6e-a450-5aab9132c382', N'abc', CAST(0x0000A7980181B112 AS DateTime), N'abc', CAST(0x0000A7980181B112 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'5924b0a3-93e4-48a0-80e0-44c6e720cba8', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'fd67035c-7a43-42a5-a88e-52d68e5f1b08', 1, N'c936c36e-f963-4b86-9c54-39fbfcf79ec1', N'admin', CAST(0x0000A79901779A21 AS DateTime), N'admin', CAST(0x0000A79901779A21 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'16c05fa8-e998-4ae4-8a2d-4b9c87cc03af', N'4d209d0b-748d-425a-ba43-24c80c5ba073', N'058c6833-bf76-4862-82fb-16e5e39b83a1', 1, N'2b590389-2de1-4f6e-a450-5aab9132c382', N'abc', CAST(0x0000A7980181B112 AS DateTime), N'abc', CAST(0x0000A7980181B112 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'b2f0ff22-e2e2-47ee-8ef4-53908adf71b8', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'fe0c2adb-f3df-4427-ace2-5e8ddbc67f82', 1, N'c936c36e-f963-4b86-9c54-39fbfcf79ec1', N'admin', CAST(0x0000A79901779A21 AS DateTime), N'admin', CAST(0x0000A79901779A21 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'3c3c7f0d-6c24-44c4-97a7-5e7a94492f90', N'4d209d0b-748d-425a-ba43-24c80c5ba073', N'2c32448a-e950-457c-a0d7-2eb7f4b302ae', 1, N'2b590389-2de1-4f6e-a450-5aab9132c382', N'abc', CAST(0x0000A7980181B112 AS DateTime), N'abc', CAST(0x0000A7980181B112 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'09f5755f-156b-40ce-995f-6521d5607c6b', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'9e612770-95aa-40e6-84f8-5983d08d3c0e', 1, N'c936c36e-f963-4b86-9c54-39fbfcf79ec1', N'admin', CAST(0x0000A79901779A21 AS DateTime), N'admin', CAST(0x0000A79901779A21 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'603f517e-6269-4eaa-865b-cb60a3bb8efc', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'35f86788-235b-4309-895c-8ff7ce473ad3', 1, N'c936c36e-f963-4b86-9c54-39fbfcf79ec1', N'admin', CAST(0x0000A79901779A21 AS DateTime), N'admin', CAST(0x0000A79901779A21 AS DateTime))
INSERT [dbo].[T_S_Role_Function] ([Id], [RoleId], [FunctionId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2ef3825e-f289-4d99-82ca-cdd9369bd8e5', N'f3c95dcc-f4ef-4cdb-bade-9fb2b26b484e', N'd59f4727-eba5-40ba-9258-2b375f491d6a', 1, N'c936c36e-f963-4b86-9c54-39fbfcf79ec1', N'admin', CAST(0x0000A79901779A21 AS DateTime), N'admin', CAST(0x0000A79901779A21 AS DateTime))
/****** Object:  Table [dbo].[ZY_Shop]    Script Date: 07/18/2017 22:25:28 ******/
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
	[ShopStatus] [int] NOT NULL,
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'shop02', CAST(120.7442560 AS Decimal(10, 7)), CAST(31.2947500 AS Decimal(10, 7)), N'xxx xxx', 1, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 5, N'151b7187-fbae-4449-8fe9-3ae53b714cd7', N'test', CAST(0x0000A79101629B84 AS DateTime), N'admin', CAST(0x0000A799017E1A5C AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'3916c7a9-2d7c-4c55-a14d-196a0d79c11a', N'shop03', CAST(121.7442560 AS Decimal(10, 7)), CAST(31.2947500 AS Decimal(10, 7)), N'xxx xxx', 0, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 6, N'275a539c-3544-40de-87fe-651f287ef0ab', N'test', CAST(0x0000A79101629B84 AS DateTime), N'admin', CAST(0x0000A7A200FF6621 AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'9da09cbf-0eb1-417c-b143-39f853ff51ef', N'shop06', CAST(1.0000000 AS Decimal(10, 7)), CAST(1.0000000 AS Decimal(10, 7)), N'xxx xxx', 0, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 4, N'586523ba-1a07-4019-922d-a5d463471adf', N'test', CAST(0x0000A79101629B84 AS DateTime), N'admin', CAST(0x0000A7A200FF670C AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'cbdef62f-3424-4958-bd58-6531546065d2', N'shop01', CAST(1.0000000 AS Decimal(10, 7)), CAST(1.0000000 AS Decimal(10, 7)), N'xxx xxx', 0, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 2, N'2c9132f3-b936-4715-aa7a-c3dc4a810ad3', N'test', CAST(0x0000A79101629B84 AS DateTime), N'admin', CAST(0x0000A7A200FF6801 AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'03d99f20-8d8d-45ea-9c3b-9bb82422ff12', N'shop04', CAST(1.0000000 AS Decimal(10, 7)), CAST(1.0000000 AS Decimal(10, 7)), N'xxx xxx', 1, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 1, N'5f0479e4-d854-4d31-83ab-a476379d7af0', N'test', CAST(0x0000A79101629B84 AS DateTime), N'test', CAST(0x0000A79101629B84 AS DateTime))
INSERT [dbo].[ZY_Shop] ([ShopId], [Name], [Longitude], [Latitude], [Address], [ShopStatus], [OwnId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'42d9278f-bd77-4994-960e-fc9fa1241cda', N'shop05', CAST(1.0000000 AS Decimal(10, 7)), CAST(1.0000000 AS Decimal(10, 7)), N'xxx xxx', 1, N'93bbd33c-0c29-43bb-8ef8-118ed371c524', 1, N'8374d7d5-cf86-4b12-9fa2-ead448e99b12', N'test', CAST(0x0000A79101629B84 AS DateTime), N'test', CAST(0x0000A79101629B84 AS DateTime))
/****** Object:  Table [dbo].[ZY_Session]    Script Date: 07/18/2017 22:25:28 ******/
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'a34d6162-5876-47f8-a3c4-00f934d1435c', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(0x0000A79801817724 AS DateTime), 2, N'9569a60f-9919-44c7-b0ee-e6287bc91bf6', N'anonymous', CAST(0x0000A79800011BA5 AS DateTime), N'xxx', CAST(0x0000A7980181773A AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'3df6e838-cf0b-47b9-928e-09cbecce0bfe', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(0x0000A79201551720 AS DateTime), 2, N'ce73244f-3ade-49d7-ad7c-0f112f4e5c2b', N'anonymous', CAST(0x0000A79201515614 AS DateTime), N'anonymous', CAST(0x0000A79201551720 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c3281cf1-53f2-442d-a5e8-0da7bec392ff', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A793015ABBC1 AS DateTime), 2, N'82894c01-5e06-437d-bb89-2946d4d83d8d', N'anonymous', CAST(0x0000A792016329EC AS DateTime), N'abc', CAST(0x0000A793015ABBD1 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'b0ec0161-5306-4783-8360-20184249de94', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A79100749E45 AS DateTime), 2, N'4ef4e9ec-a2a2-4cb3-8f6a-3b893b3f28c1', N'anonymous', CAST(0x0000A790018150F9 AS DateTime), N'anonymous', CAST(0x0000A79100749E51 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'7f89ae23-401a-4a33-be4d-3e98978d3a40', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A79901815757 AS DateTime), 2, N'32007955-e2dd-4f4b-8d9c-3d327491973f', N'anonymous', CAST(0x0000A799016C9151 AS DateTime), N'admin', CAST(0x0000A7990181576B AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'e0ad2a3a-f998-447a-9fa5-6e012197c480', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A7A8014B1EE4 AS DateTime), 1, N'94b084b1-8334-47b7-bfb6-0673fdff1dab', N'anonymous', CAST(0x0000A7A1014B1EF9 AS DateTime), N'anonymous', CAST(0x0000A7A1014B1EF9 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'171bf145-d95e-4f3f-8187-8131e899bf44', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A79800010BE9 AS DateTime), 2, N'6eb646c8-1f05-43a1-9379-51be4ca83673', N'anonymous', CAST(0x0000A7930178008C AS DateTime), N'abc', CAST(0x0000A79800010BFB AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'66a1d02e-bf0a-43e5-bf6b-81e4eb43906e', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(0x0000A7930177F580 AS DateTime), 2, N'c84bdb1c-1632-45ac-b498-b3d90ef697b1', N'anonymous', CAST(0x0000A793015E2E41 AS DateTime), N'xxx', CAST(0x0000A7930177F592 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'7e54e44c-4f07-4d95-abd8-835ca185538c', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(0x0000A79201631EB4 AS DateTime), 2, N'68044440-4150-4c6c-9881-946c587fe2aa', N'anonymous', CAST(0x0000A79201555E4D AS DateTime), N'anonymous', CAST(0x0000A79201631EBF AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'545b67a5-3be6-477c-9216-90400ebf67b2', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A79F018184C7 AS DateTime), 1, N'64a9dde6-1b5f-46a9-b4c4-f46e455215a7', N'anonymous', CAST(0x0000A798018184D9 AS DateTime), N'anonymous', CAST(0x0000A798018184D9 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'15957e48-5aae-4db8-8a67-91edafb72ad6', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A790018148C7 AS DateTime), 2, N'7bfe9f10-cab1-439a-9e2c-47c3d4e936d2', N'anonymous', CAST(0x0000A7900180FFD2 AS DateTime), N'anonymous', CAST(0x0000A790018148D4 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'26d0e08d-ecae-46f7-b68a-9783bb3b42eb', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(0x0000A79201510522 AS DateTime), 2, N'7d91da29-44e2-4caa-b7a3-74c772cb9899', N'anonymous', CAST(0x0000A791016C2E54 AS DateTime), N'anonymous', CAST(0x0000A7920151052C AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'11c53267-4377-408f-8361-9a22233b7c3e', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A7A8014B1EDC AS DateTime), 1, N'a406aeb8-814d-40a8-8e17-4749f1938d43', N'anonymous', CAST(0x0000A7A1014B1EF9 AS DateTime), N'anonymous', CAST(0x0000A7A1014B1EF9 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'2548622a-0f70-40e4-8a0f-9f2f72998df4', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(0x0000A79E015D6749 AS DateTime), 1, N'20cb3e7b-0818-4675-adc1-50f2cda74d34', N'anonymous', CAST(0x0000A797015D6772 AS DateTime), N'anonymous', CAST(0x0000A797015D6772 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c29379af-5f87-4591-b69d-a7ad0f9a965a', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A791014A7181 AS DateTime), 2, N'ce02c8d8-d7dd-4cd4-8c05-9704071cfad4', N'anonymous', CAST(0x0000A7910075575A AS DateTime), N'anonymous', CAST(0x0000A791014A7196 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'53404e8c-19fa-42eb-aaa4-b752818deeea', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A7A900FF5500 AS DateTime), 1, N'f070a9b2-18cc-4e31-8cc6-7fe70cf7b8bf', N'anonymous', CAST(0x0000A7A200FF551E AS DateTime), N'anonymous', CAST(0x0000A7A200FF551E AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c7606ca7-ccd4-42fb-947e-d501a978ed59', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A7920151475C AS DateTime), 2, N'f9269182-ebe6-4e87-bfc1-5dbcd4fa79cb', N'anonymous', CAST(0x0000A79201510E27 AS DateTime), N'anonymous', CAST(0x0000A7920151475C AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'f3d53a26-fe3c-42c1-86ba-d88596065781', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A790018074E3 AS DateTime), 2, N'c0121af2-c5c4-4a04-a4b7-9fa062e46d29', N'anonymous', CAST(0x0000A79001806A51 AS DateTime), N'anonymous', CAST(0x0000A790018074E5 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'd5819c0e-abe9-417e-aeb2-d94a9d40e27b', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A791007535BA AS DateTime), 2, N'35bb0118-70cb-4559-84f4-f242ae2a485f', N'anonymous', CAST(0x0000A7910074A7DD AS DateTime), N'anonymous', CAST(0x0000A791007535BA AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'f9e41f9e-a26a-4821-ac1d-e840e470a769', N'2c08d58b-8109-4e5f-94fe-fdf339bc0ca2', CAST(0x0000A79201554D92 AS DateTime), 2, N'dd8d599f-21d7-4719-8d6d-79a1ca7eff72', N'anonymous', CAST(0x0000A79201552026 AS DateTime), N'anonymous', CAST(0x0000A79201554D92 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'e42cc7b1-0c8a-48cc-b47c-eea3fe0dbe9b', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(0x0000A7A001815EDE AS DateTime), 1, N'422572b0-7152-4030-8d8c-59e2b3375383', N'anonymous', CAST(0x0000A79901815EF4 AS DateTime), N'anonymous', CAST(0x0000A79901815EF4 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c2cfe72f-4cc1-4127-8101-f51e157923a2', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(0x0000A7A100B79658 AS DateTime), 1, N'50c2a8fc-4777-4dd0-9d58-bdc05a652f0c', N'anonymous', CAST(0x0000A79A00B79659 AS DateTime), N'anonymous', CAST(0x0000A79A00B79659 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c35df8f6-ceb1-47ce-bb53-f5405c689d24', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(0x0000A791016C263A AS DateTime), 2, N'c68efd37-e430-4bf5-b033-c356f11a6568', N'anonymous', CAST(0x0000A791014A7D22 AS DateTime), N'anonymous', CAST(0x0000A791016C2646 AS DateTime))
INSERT [dbo].[ZY_Session] ([SessionId], [UserId], [ExpireTime], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'e9745f33-2e39-47f8-95a6-fd0155a52fbc', N'93bbd33c-0c29-43bb-8ef8-118ed371c524', CAST(0x0000A79100754D41 AS DateTime), 2, N'77117aa6-2d49-48b4-8371-e909e2cb23c7', N'anonymous', CAST(0x0000A79100753DBC AS DateTime), N'anonymous', CAST(0x0000A79100754D41 AS DateTime))
/****** Object:  Table [dbo].[ZY_Order]    Script Date: 07/18/2017 22:25:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZY_Order](
	[OrderId] [uniqueidentifier] NOT NULL,
	[CustomerOpenId] [nvarchar](256) NULL,
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
	[PickTime] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ZY_Order] ([OrderId], [CustomerOpenId], [OrderDate], [Status], [Amount], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [Prepay_id], [IsInternal], [Comments], [PickTime]) VALUES (N'6b577133-3819-4cf0-81f5-2115ba3812e9', NULL, CAST(0x0000A79800000000 AS DateTime), 1, CAST(0.00 AS Decimal(18, 2)), 1, N'c9d297b5-8219-48eb-b8c1-3b927f7b90fd', N'user', CAST(0x0000A79A000641C0 AS DateTime), N'user', CAST(0x0000A79A000641C0 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[ZY_Order] ([OrderId], [CustomerOpenId], [OrderDate], [Status], [Amount], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [Prepay_id], [IsInternal], [Comments], [PickTime]) VALUES (N'7e7efa0a-196a-4605-96f2-274902faed67', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', CAST(0x0000A79800000000 AS DateTime), -2, CAST(210.00 AS Decimal(18, 2)), 3, N'4227d66b-ecbd-41b0-89c5-dc968465eaac', N'anonymous', CAST(0x0000A798017C84F3 AS DateTime), N'xxx', CAST(0x0000A798017ED823 AS DateTime), NULL, 0, N'2,3,11,12,1,9,10', NULL)
INSERT [dbo].[ZY_Order] ([OrderId], [CustomerOpenId], [OrderDate], [Status], [Amount], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [Prepay_id], [IsInternal], [Comments], [PickTime]) VALUES (N'0833838b-a77f-45e5-8a35-38f513901fab', NULL, CAST(0x0000A79800000000 AS DateTime), 1, CAST(0.00 AS Decimal(18, 2)), 1, N'b80e292b-92f7-4fe8-8708-8e1e7d3adb62', N'user', CAST(0x0000A79A00063220 AS DateTime), N'user', CAST(0x0000A79A00063221 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[ZY_Order] ([OrderId], [CustomerOpenId], [OrderDate], [Status], [Amount], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [Prepay_id], [IsInternal], [Comments], [PickTime]) VALUES (N'6541524c-3550-4d4f-838c-3e2e2755d9e5', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', CAST(0x0000A79800000000 AS DateTime), -2, CAST(60.00 AS Decimal(18, 2)), 3, N'971dbd5f-f264-45c7-88b5-a085b318188b', N'anonymous', CAST(0x0000A798017C5A5A AS DateTime), N'xxx', CAST(0x0000A798017ED39E AS DateTime), NULL, 0, N'9,10', NULL)
INSERT [dbo].[ZY_Order] ([OrderId], [CustomerOpenId], [OrderDate], [Status], [Amount], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [Prepay_id], [IsInternal], [Comments], [PickTime]) VALUES (N'6f1d9c06-1e90-4b5f-9e07-738d6cda5639', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', CAST(0x0000A79A00000000 AS DateTime), 0, CAST(60.00 AS Decimal(18, 2)), 1, N'676980eb-1e90-48a3-a48d-aa4130280215', N'anonymous', CAST(0x0000A79A00B6D524 AS DateTime), N'anonymous', CAST(0x0000A79A00B6D524 AS DateTime), NULL, 0, NULL, N'11:00')
INSERT [dbo].[ZY_Order] ([OrderId], [CustomerOpenId], [OrderDate], [Status], [Amount], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [Prepay_id], [IsInternal], [Comments], [PickTime]) VALUES (N'ec9df18d-f2a3-40dc-8813-b388e9301998', NULL, CAST(0x0000A79800000000 AS DateTime), 1, CAST(0.00 AS Decimal(18, 2)), 1, N'3c0e167a-d1c7-4c76-88fa-0ff5f9f035d4', N'user', CAST(0x0000A79A000639CD AS DateTime), N'user', CAST(0x0000A79A000639CD AS DateTime), NULL, 1, NULL, NULL)
/****** Object:  Table [dbo].[ZY_Shop_Img]    Script Date: 07/18/2017 22:25:28 ******/
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
	[ImgType] [int] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ZY_Shop_Img] ([Id], [ShopId], [Name], [Url], [ImgType], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'b2fac074-922f-428b-b90e-516802189c82', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'', N'upload/shop/3.jpg', 1, 1, N'3e6fde88-6b3a-4fb5-9eda-6caf2556ce3b', N'bn', CAST(0x0000A797016077E4 AS DateTime), N'bn', CAST(0x0000A797016077E4 AS DateTime))
INSERT [dbo].[ZY_Shop_Img] ([Id], [ShopId], [Name], [Url], [ImgType], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'3cfa475d-60d7-4a5b-a5b2-5a90b03b2048', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'', N'upload/shop/1.jpg', 1, 1, N'916bfd51-0b36-4dbd-b7a7-f032a1020a94', N'bn', CAST(0x0000A797016077E2 AS DateTime), N'bn', CAST(0x0000A797016077E2 AS DateTime))
INSERT [dbo].[ZY_Shop_Img] ([Id], [ShopId], [Name], [Url], [ImgType], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'1bb53deb-9645-40e3-b1c7-db9757c76f09', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'', N'upload/shop/2.jpg', 1, 1, N'd8d521cf-7856-4c60-b760-0fd6071ef75d', N'bn', CAST(0x0000A797016077E4 AS DateTime), N'bn', CAST(0x0000A797016077E4 AS DateTime))
/****** Object:  Table [dbo].[ZY_Shop_Desk]    Script Date: 07/18/2017 22:25:28 ******/
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
	[DeskStatus] [int] NOT NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DeskId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'6c0b77b1-fb61-46ef-97a6-02c8b5fdd198', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk01', 0, 1, N'7bb79c8c-dbb9-4942-9595-6611b96f6e1c', N'test', CAST(0x0000A79101635DC8 AS DateTime), N'test', CAST(0x0000A79101635DC8 AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'920b3c06-8af1-479e-b2ae-3bb68055610a', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk03', 0, 1, N'c8d946ab-822c-4f2a-9517-c545a48dfda1', N'test', CAST(0x0000A79101635DC8 AS DateTime), N'test', CAST(0x0000A79101635DC8 AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'e23af55b-69ae-4c99-83b2-6144dee0eb20', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk06', 0, 1, N'19cacede-9e88-41e7-82c3-3300b102e0b0', N'test', CAST(0x0000A79101635DC8 AS DateTime), N'test', CAST(0x0000A79101635DC8 AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'e09fc35a-2176-4e53-aac3-9cc172251ff7', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk07', 0, 1, N'5bab1505-80e3-477f-826a-2ef92f54dad3', N'test', CAST(0x0000A79101635DC8 AS DateTime), N'test', CAST(0x0000A79101635DC8 AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'9733420c-6a4a-4ea6-9332-a86adef3d7bb', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk05', 0, 1, N'78cb217e-aa3e-4084-abbc-a93c586cb986', N'test', CAST(0x0000A79101635DC8 AS DateTime), N'test', CAST(0x0000A79101635DC8 AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'5e2f6f6e-ded2-4223-b4c6-c48b4bc5cdd2', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk02', 0, 1, N'8487944b-e9a9-4440-80a2-72df89f6c440', N'test', CAST(0x0000A79101635DC8 AS DateTime), N'test', CAST(0x0000A79101635DC8 AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[ZY_Shop_Desk] ([DeskId], [ShopId], [DeskName], [DeskStatus], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime], [UnitPrice]) VALUES (N'f6def65a-9903-4759-9611-e1eeb3dcb5c6', N'6049d8ba-f428-4448-97ac-1771ef6f54b3', N'desk04', 0, 1, N'2c75dcec-7553-4c98-9d4e-207fe3291ac8', N'test', CAST(0x0000A79101635DC8 AS DateTime), N'test', CAST(0x0000A79101635DC8 AS DateTime), CAST(30.00 AS Decimal(18, 2)))
/****** Object:  Table [dbo].[ZY_Booked_Position]    Script Date: 07/18/2017 22:25:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZY_Booked_Position](
	[Id] [uniqueidentifier] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Status] [nvarchar](256) NOT NULL,
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [uq_book_position] UNIQUE NONCLUSTERED 
(
	[OrderDate] ASC,
	[DeskId] ASC,
	[Position] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'f0231788-f70d-461c-b595-032f8d66ef22', CAST(0x0000A79A00000000 AS DateTime), N'1', N'5e2f6f6e-ded2-4223-b4c6-c48b4bc5cdd2', N'7', 0, N'6f1d9c06-1e90-4b5f-9e07-738d6cda5639', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 1, N'676980eb-1e90-48a3-a48d-aa4130280215', N'anonymous', CAST(0x0000A79A00B6D524 AS DateTime), N'anonymous', CAST(0x0000A79A00B6D524 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'e3c2cd46-1150-4703-b90b-0b8ac511d591', CAST(0x0000A79800000000 AS DateTime), N'1', N'f6def65a-9903-4759-9611-e1eeb3dcb5c6', N'7', 1, NULL, NULL, 1, N'b80e292b-92f7-4fe8-8708-8e1e7d3adb62', N'user', CAST(0x0000A79A00063221 AS DateTime), N'user', CAST(0x0000A79A00063221 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'95354131-3b83-4f3c-a447-232278ad5332', CAST(0x0000A79800000000 AS DateTime), N'1', N'920b3c06-8af1-479e-b2ae-3bb68055610a', N'7', 1, NULL, NULL, 1, N'3c0e167a-d1c7-4c76-88fa-0ff5f9f035d4', N'user', CAST(0x0000A79A000639CD AS DateTime), N'user', CAST(0x0000A79A000639CD AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'0f1e6d61-06d3-4806-9717-3a0d3863f1d8', CAST(0x0000A79A00000000 AS DateTime), N'1', N'5e2f6f6e-ded2-4223-b4c6-c48b4bc5cdd2', N'6', 0, N'6f1d9c06-1e90-4b5f-9e07-738d6cda5639', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 1, N'676980eb-1e90-48a3-a48d-aa4130280215', N'anonymous', CAST(0x0000A79A00B6D524 AS DateTime), N'anonymous', CAST(0x0000A79A00B6D524 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'bd295e01-052f-4578-b443-41a060bc6254', CAST(0x0000A79800000000 AS DateTime), N'1', N'6c0b77b1-fb61-46ef-97a6-02c8b5fdd198', N'9', 0, N'6541524c-3550-4d4f-838c-3e2e2755d9e5', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 3, N'971dbd5f-f264-45c7-88b5-a085b318188b', N'anonymous', CAST(0x0000A798017C5A5A AS DateTime), N'xxx', CAST(0x0000A798017ED39E AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'db6d4017-bcd3-4081-af35-50248a4da559', CAST(0x0000A79800000000 AS DateTime), N'1', N'920b3c06-8af1-479e-b2ae-3bb68055610a', N'12', 1, NULL, NULL, 1, N'c9d297b5-8219-48eb-b8c1-3b927f7b90fd', N'user', CAST(0x0000A79A000641C0 AS DateTime), N'user', CAST(0x0000A79A000641C0 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'a947b91e-0f78-4f9b-8bc4-5b41687e5100', CAST(0x0000A79800000000 AS DateTime), N'1', N'f6def65a-9903-4759-9611-e1eeb3dcb5c6', N'2', 0, N'7e7efa0a-196a-4605-96f2-274902faed67', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 3, N'4227d66b-ecbd-41b0-89c5-dc968465eaac', N'anonymous', CAST(0x0000A798017C84F3 AS DateTime), N'xxx', CAST(0x0000A798017ED823 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'c5deab15-c774-4346-9dd4-77911d95c29b', CAST(0x0000A79800000000 AS DateTime), N'1', N'f6def65a-9903-4759-9611-e1eeb3dcb5c6', N'3', 0, N'7e7efa0a-196a-4605-96f2-274902faed67', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 3, N'4227d66b-ecbd-41b0-89c5-dc968465eaac', N'anonymous', CAST(0x0000A798017C84F3 AS DateTime), N'xxx', CAST(0x0000A798017ED823 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'72d30129-3dd5-49d9-a97d-8a3a34e705c4', CAST(0x0000A79800000000 AS DateTime), N'1', N'6c0b77b1-fb61-46ef-97a6-02c8b5fdd198', N'10', 0, N'6541524c-3550-4d4f-838c-3e2e2755d9e5', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 3, N'971dbd5f-f264-45c7-88b5-a085b318188b', N'anonymous', CAST(0x0000A798017C5A5A AS DateTime), N'xxx', CAST(0x0000A798017ED39E AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'b0b5d85f-b7ca-4ead-ae9f-8a77a3d7a110', CAST(0x0000A79800000000 AS DateTime), N'1', N'920b3c06-8af1-479e-b2ae-3bb68055610a', N'6', 1, NULL, NULL, 1, N'c9d297b5-8219-48eb-b8c1-3b927f7b90fd', N'user', CAST(0x0000A79A000641C0 AS DateTime), N'user', CAST(0x0000A79A000641C0 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'12175c5f-fcc6-4561-87d2-9319d8206d8a', CAST(0x0000A79800000000 AS DateTime), N'1', N'f6def65a-9903-4759-9611-e1eeb3dcb5c6', N'11', 0, N'7e7efa0a-196a-4605-96f2-274902faed67', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 3, N'4227d66b-ecbd-41b0-89c5-dc968465eaac', N'anonymous', CAST(0x0000A798017C84F3 AS DateTime), N'xxx', CAST(0x0000A798017ED823 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'25e3514b-d8d7-4904-8c65-95fa3c9e96ff', CAST(0x0000A79800000000 AS DateTime), N'1', N'f6def65a-9903-4759-9611-e1eeb3dcb5c6', N'12', 0, N'7e7efa0a-196a-4605-96f2-274902faed67', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 3, N'4227d66b-ecbd-41b0-89c5-dc968465eaac', N'anonymous', CAST(0x0000A798017C84F3 AS DateTime), N'xxx', CAST(0x0000A798017ED823 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'f8e71f35-305b-46be-93a8-9d0a78afa1ce', CAST(0x0000A79800000000 AS DateTime), N'1', N'920b3c06-8af1-479e-b2ae-3bb68055610a', N'3', 1, NULL, NULL, 1, N'3c0e167a-d1c7-4c76-88fa-0ff5f9f035d4', N'user', CAST(0x0000A79A000639CD AS DateTime), N'user', CAST(0x0000A79A000639CD AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'939d1ca5-6089-4f15-ab55-a9d06fc64a00', CAST(0x0000A79800000000 AS DateTime), N'1', N'f6def65a-9903-4759-9611-e1eeb3dcb5c6', N'1', 0, N'7e7efa0a-196a-4605-96f2-274902faed67', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 3, N'4227d66b-ecbd-41b0-89c5-dc968465eaac', N'anonymous', CAST(0x0000A798017C84F3 AS DateTime), N'xxx', CAST(0x0000A798017ED823 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'77b1759c-32cc-4565-a1e4-aa07e1942fc2', CAST(0x0000A79800000000 AS DateTime), N'1', N'f6def65a-9903-4759-9611-e1eeb3dcb5c6', N'9', 0, N'7e7efa0a-196a-4605-96f2-274902faed67', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 3, N'4227d66b-ecbd-41b0-89c5-dc968465eaac', N'anonymous', CAST(0x0000A798017C84F3 AS DateTime), N'xxx', CAST(0x0000A798017ED823 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'3e56856b-6bfc-44c4-95ca-ac99986e7579', CAST(0x0000A79800000000 AS DateTime), N'1', N'920b3c06-8af1-479e-b2ae-3bb68055610a', N'11', 1, NULL, NULL, 1, N'3c0e167a-d1c7-4c76-88fa-0ff5f9f035d4', N'user', CAST(0x0000A79A000639CD AS DateTime), N'user', CAST(0x0000A79A000639CD AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'341e6f04-0ee1-4db6-9787-b96615c3afdd', CAST(0x0000A79800000000 AS DateTime), N'1', N'f6def65a-9903-4759-9611-e1eeb3dcb5c6', N'10', 0, N'7e7efa0a-196a-4605-96f2-274902faed67', N'owRpquBH9AqcqMYjWGnSM-sgcAFo', 3, N'4227d66b-ecbd-41b0-89c5-dc968465eaac', N'anonymous', CAST(0x0000A798017C84F3 AS DateTime), N'xxx', CAST(0x0000A798017ED823 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'd7cc7452-b3a0-46b9-936b-c22d514a5408', CAST(0x0000A79800000000 AS DateTime), N'1', N'920b3c06-8af1-479e-b2ae-3bb68055610a', N'1', 1, NULL, NULL, 1, N'c9d297b5-8219-48eb-b8c1-3b927f7b90fd', N'user', CAST(0x0000A79A000641C0 AS DateTime), N'user', CAST(0x0000A79A000641C0 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'85a3dd41-340a-47eb-afdc-efa15dde40ed', CAST(0x0000A79800000000 AS DateTime), N'1', N'920b3c06-8af1-479e-b2ae-3bb68055610a', N'8', 1, NULL, NULL, 1, N'c9d297b5-8219-48eb-b8c1-3b927f7b90fd', N'user', CAST(0x0000A79A000641C0 AS DateTime), N'user', CAST(0x0000A79A000641C0 AS DateTime))
INSERT [dbo].[ZY_Booked_Position] ([Id], [OrderDate], [Status], [DeskId], [Position], [IsInternal], [OrderId], [CustomerOpenId], [VersionNo], [TransactionId], [CreatedBy], [CreatedTime], [UpdatedBy], [UpdatedTime]) VALUES (N'a3bb070b-1cf7-4cb8-82de-ffde26f28601', CAST(0x0000A79800000000 AS DateTime), N'1', N'920b3c06-8af1-479e-b2ae-3bb68055610a', N'2', 1, NULL, NULL, 1, N'c9d297b5-8219-48eb-b8c1-3b927f7b90fd', N'user', CAST(0x0000A79A000641C0 AS DateTime), N'user', CAST(0x0000A79A000641C0 AS DateTime))
/****** Object:  StoredProcedure [dbo].[sp_GetDesksForCustomer]    Script Date: 07/18/2017 22:25:29 ******/
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
	outer apply (select CONVERT(nvarchar(256),b.Position)+',' from ZY_Booked_Position b where b.DeskId=a.DeskId and b.Status='1' and b.OrderDate=@date for xml path(''))as booked(position)
	where a.ShopId=@shopId and c.ShopStatus=1
	order by DeskName
  END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDesks]    Script Date: 07/18/2017 22:25:29 ******/
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
	outer apply (select CONVERT(nvarchar(256),b.Position)+',' from ZY_Booked_Position b where b.DeskId=a.DeskId and b.Status='1' and b.OrderDate=@date for xml path(''))as booked(position)
	outer apply (select CONVERT(nvarchar(256),b.Position)+',' from ZY_Booked_Position b where b.DeskId=a.DeskId and b.Status='1' and b.OrderDate=@date and b.IsInternal=1 for xml path(''))as internlbooked(position)
	where ShopId=@shopId
	order by DeskName
  END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCustomerOrders]    Script Date: 07/18/2017 22:25:29 ******/
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
/****** Object:  Default [DF__ZZ_Templa__Categ__5165187F]    Script Date: 07/18/2017 22:25:27 ******/
ALTER TABLE [dbo].[ZZ_Template] ADD  DEFAULT ((0)) FOR [Category]
GO
/****** Object:  Default [DF__T_S_Role__Versio__0DAF0CB0]    Script Date: 07/18/2017 22:25:27 ******/
ALTER TABLE [dbo].[T_S_Role] ADD  DEFAULT ((0)) FOR [VersionNo]
GO
/****** Object:  Default [DF__T_S_Role__Create__0EA330E9]    Script Date: 07/18/2017 22:25:27 ******/
ALTER TABLE [dbo].[T_S_Role] ADD  DEFAULT (getdate()) FOR [CreatedTime]
GO
/****** Object:  Default [DF__T_S_Role__Update__0F975522]    Script Date: 07/18/2017 22:25:27 ******/
ALTER TABLE [dbo].[T_S_Role] ADD  DEFAULT (getdate()) FOR [UpdatedTime]
GO
/****** Object:  Default [DF__T_S_Functio__Seq__060DEAE8]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Function] ADD  DEFAULT ((0)) FOR [Seq]
GO
/****** Object:  Default [DF__T_S_Funct__Versi__07020F21]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Function] ADD  DEFAULT ((0)) FOR [VersionNo]
GO
/****** Object:  Default [DF__T_S_Funct__Creat__07F6335A]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Function] ADD  DEFAULT (getdate()) FOR [CreatedTime]
GO
/****** Object:  Default [DF__T_S_Funct__Updat__08EA5793]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Function] ADD  DEFAULT (getdate()) FOR [UpdatedTime]
GO
/****** Object:  Default [DF__T_S_Code__Seq__534D60F1]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Code] ADD  DEFAULT ((0)) FOR [Seq]
GO
/****** Object:  Default [DF__T_S_Code__Versio__5441852A]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Code] ADD  DEFAULT ((0)) FOR [VersionNo]
GO
/****** Object:  Default [DF__T_S_Code__Create__5535A963]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Code] ADD  DEFAULT (getdate()) FOR [CreatedTime]
GO
/****** Object:  Default [DF__T_S_Code__Update__5629CD9C]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Code] ADD  DEFAULT (getdate()) FOR [UpdatedTime]
GO
/****** Object:  Default [DF__T_S_User__IsActi__1B0907CE]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User] ADD  DEFAULT ((0)) FOR [IsActive]
GO
/****** Object:  Default [DF__T_S_User__Source__1BFD2C07]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User] ADD  DEFAULT ((0)) FOR [Source]
GO
/****** Object:  Default [DF__T_S_User__IsLock__1CF15040]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User] ADD  DEFAULT ((0)) FOR [IsLock]
GO
/****** Object:  Default [DF__T_S_User__Versio__1DE57479]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User] ADD  DEFAULT ((0)) FOR [VersionNo]
GO
/****** Object:  Default [DF__T_S_User__Create__1ED998B2]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User] ADD  DEFAULT (getdate()) FOR [CreatedTime]
GO
/****** Object:  Default [DF__T_S_User__Update__1FCDBCEB]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User] ADD  DEFAULT (getdate()) FOR [UpdatedTime]
GO
/****** Object:  Default [DF__T_S_User___Versi__24927208]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User_Role] ADD  DEFAULT ((0)) FOR [VersionNo]
GO
/****** Object:  Default [DF__T_S_User___Creat__25869641]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User_Role] ADD  DEFAULT (getdate()) FOR [CreatedTime]
GO
/****** Object:  Default [DF__T_S_User___Updat__267ABA7A]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User_Role] ADD  DEFAULT (getdate()) FOR [UpdatedTime]
GO
/****** Object:  Default [DF__T_S_Role___Versi__145C0A3F]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Role_Function] ADD  DEFAULT ((0)) FOR [VersionNo]
GO
/****** Object:  Default [DF__T_S_Role___Creat__15502E78]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Role_Function] ADD  DEFAULT (getdate()) FOR [CreatedTime]
GO
/****** Object:  Default [DF__T_S_Role___Updat__164452B1]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Role_Function] ADD  DEFAULT (getdate()) FOR [UpdatedTime]
GO
/****** Object:  Default [DF__ZY_Shop__ShopSta__3E52440B]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Shop] ADD  DEFAULT ((0)) FOR [ShopStatus]
GO
/****** Object:  Default [DF__ZY_Order__Status__33D4B598]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Order] ADD  DEFAULT ((0)) FOR [Status]
GO
/****** Object:  Default [DF__ZY_Order__Amount__34C8D9D1]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Order] ADD  DEFAULT ((0)) FOR [Amount]
GO
/****** Object:  Default [DF__ZY_Order__IsInte__35BCFE0A]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Order] ADD  DEFAULT ((0)) FOR [IsInternal]
GO
/****** Object:  Default [DF__ZY_Shop_I__ImgTy__48CFD27E]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Shop_Img] ADD  DEFAULT ((1)) FOR [ImgType]
GO
/****** Object:  Default [DF__ZY_Shop_D__DeskS__4316F928]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Shop_Desk] ADD  DEFAULT ((0)) FOR [DeskStatus]
GO
/****** Object:  Default [DF__ZY_Shop_D__UnitP__440B1D61]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Shop_Desk] ADD  DEFAULT ((0)) FOR [UnitPrice]
GO
/****** Object:  Default [DF__ZY_Booked__IsInt__2B3F6F97]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Booked_Position] ADD  DEFAULT ((0)) FOR [IsInternal]
GO
/****** Object:  ForeignKey [FK_T_S_User_Role_T_S_Role]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User_Role]  WITH CHECK ADD  CONSTRAINT [FK_T_S_User_Role_T_S_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[T_S_Role] ([RoleId])
GO
ALTER TABLE [dbo].[T_S_User_Role] CHECK CONSTRAINT [FK_T_S_User_Role_T_S_Role]
GO
/****** Object:  ForeignKey [FK_T_S_User_Role_T_S_User]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_User_Role]  WITH CHECK ADD  CONSTRAINT [FK_T_S_User_Role_T_S_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[T_S_User] ([UserId])
GO
ALTER TABLE [dbo].[T_S_User_Role] CHECK CONSTRAINT [FK_T_S_User_Role_T_S_User]
GO
/****** Object:  ForeignKey [FK_T_S_Role_Function_T_S_Function]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Role_Function]  WITH CHECK ADD  CONSTRAINT [FK_T_S_Role_Function_T_S_Function] FOREIGN KEY([FunctionId])
REFERENCES [dbo].[T_S_Function] ([FunctionId])
GO
ALTER TABLE [dbo].[T_S_Role_Function] CHECK CONSTRAINT [FK_T_S_Role_Function_T_S_Function]
GO
/****** Object:  ForeignKey [FK_T_S_Role_Function_T_S_Role]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[T_S_Role_Function]  WITH CHECK ADD  CONSTRAINT [FK_T_S_Role_Function_T_S_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[T_S_Role] ([RoleId])
GO
ALTER TABLE [dbo].[T_S_Role_Function] CHECK CONSTRAINT [FK_T_S_Role_Function_T_S_Role]
GO
/****** Object:  ForeignKey [FK_ZY_Shop_T_S_User]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Shop]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Shop_T_S_User] FOREIGN KEY([OwnId])
REFERENCES [dbo].[T_S_User] ([UserId])
GO
ALTER TABLE [dbo].[ZY_Shop] CHECK CONSTRAINT [FK_ZY_Shop_T_S_User]
GO
/****** Object:  ForeignKey [FK_ZY_Session_T_S_User]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Session]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Session_T_S_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[T_S_User] ([UserId])
GO
ALTER TABLE [dbo].[ZY_Session] CHECK CONSTRAINT [FK_ZY_Session_T_S_User]
GO
/****** Object:  ForeignKey [FK_ZY_Order_ZY_Customer]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Order]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Order_ZY_Customer] FOREIGN KEY([CustomerOpenId])
REFERENCES [dbo].[ZY_Customer] ([OpenId])
GO
ALTER TABLE [dbo].[ZY_Order] CHECK CONSTRAINT [FK_ZY_Order_ZY_Customer]
GO
/****** Object:  ForeignKey [FK_ZY_Shop_Img_ZY_Shop]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Shop_Img]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Shop_Img_ZY_Shop] FOREIGN KEY([ShopId])
REFERENCES [dbo].[ZY_Shop] ([ShopId])
GO
ALTER TABLE [dbo].[ZY_Shop_Img] CHECK CONSTRAINT [FK_ZY_Shop_Img_ZY_Shop]
GO
/****** Object:  ForeignKey [FK_ZY_Shop_Desk_ZY_Shop]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Shop_Desk]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Shop_Desk_ZY_Shop] FOREIGN KEY([ShopId])
REFERENCES [dbo].[ZY_Shop] ([ShopId])
GO
ALTER TABLE [dbo].[ZY_Shop_Desk] CHECK CONSTRAINT [FK_ZY_Shop_Desk_ZY_Shop]
GO
/****** Object:  ForeignKey [FK_ZY_Booked_Position_ZY_Customer]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Booked_Position]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Booked_Position_ZY_Customer] FOREIGN KEY([CustomerOpenId])
REFERENCES [dbo].[ZY_Customer] ([OpenId])
GO
ALTER TABLE [dbo].[ZY_Booked_Position] CHECK CONSTRAINT [FK_ZY_Booked_Position_ZY_Customer]
GO
/****** Object:  ForeignKey [FK_ZY_Booked_Position_ZY_Order]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Booked_Position]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Booked_Position_ZY_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[ZY_Order] ([OrderId])
GO
ALTER TABLE [dbo].[ZY_Booked_Position] CHECK CONSTRAINT [FK_ZY_Booked_Position_ZY_Order]
GO
/****** Object:  ForeignKey [FK_ZY_Booked_Position_ZY_Shop_Desk]    Script Date: 07/18/2017 22:25:28 ******/
ALTER TABLE [dbo].[ZY_Booked_Position]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Booked_Position_ZY_Shop_Desk] FOREIGN KEY([DeskId])
REFERENCES [dbo].[ZY_Shop_Desk] ([DeskId])
GO
ALTER TABLE [dbo].[ZY_Booked_Position] CHECK CONSTRAINT [FK_ZY_Booked_Position_ZY_Shop_Desk]
GO
