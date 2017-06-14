

CREATE TABLE [dbo].[ZY_Shop](
	[ShopId] uniqueIdentifier NOT NULL primary key,
	[Name] [varchar](256) NOT NULL,
	Longitude decimal(10,7) null,
	Latitude decimal(10,7) null,
	[Address] nvarchar(256) null,
	[ShopStatus] int default(0) null,
	[OwnId] uniqueIdentifier ,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueIdentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
)

CREATE TABLE [dbo].[ZY_Shop_Desk](
	[DeskId] uniqueIdentifier NOT NULL primary key,
	[ShopId] uniqueIdentifier not null,
	[DeskName] [varchar](256) NOT NULL,
	[DeskStatus] int default(0) not null,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueIdentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
)

CREATE TABLE [dbo].[ZY_Customer](
	[OpenId] nvarchar(256) NOT NULL primary key,
	[UserName] nvarchar(256) Not null,
	[Avatar] nvarchar(256) null,
	[TokenId] nvarchar(256) null,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueIdentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
)

--  0 待付款， 30min 未付款 订单将取消
--  -1 将取消
--  -2 申请退款
--  1 已付款
--drop table [ZY_Shop_Order]
CREATE TABLE [dbo].[ZY_Shop_Order](
	[OrderId] uniqueIdentifier NOT NULL primary key,
	[OrderDate] datetime not null,
	[Status] int default(0) not null,
	[IsInternal] bit default(0) not null,
	CustomerOpenId nvarchar(256)  NULL,
	[DeskId] uniqueIdentifier  not null,
	[Position] nvarchar(256)  not null,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueIdentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
)

--drop table [ZY_Session]
CREATE TABLE [dbo].[ZY_Session](
	[SessionId] uniqueIdentifier NOT NULL primary key,
	[UserId] uniqueIdentifier not null,
	[ExpireTime] datetime not null,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueIdentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
)

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


ALTER TABLE [dbo].[ZY_Session]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Session_T_S_User] FOREIGN KEY(UserId)
REFERENCES [dbo].T_S_User (UserId)
GO
ALTER TABLE [dbo].[ZY_Session] CHECK CONSTRAINT [FK_ZY_Session_T_S_User]
GO



CREATE TABLE [dbo].[ZY_Booked_Position](
	[Id] uniqueIdentifier NOT NULL primary key,
	[OrderDate] datetime not null,
	[Status] int default(0) not null,
	[DeskId] uniqueIdentifier  not null,
	[Position] nvarchar(256)  not null,
	[IsInternal] bit default(0) not null,
	[OrderId] uniqueIdentifier NULL,
	[CustomerOpenId] nvarchar(256)  NULL,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueIdentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
)

ALTER TABLE [dbo].[ZY_Booked_Position]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Booked_Position_ZY_Customer] FOREIGN KEY(CustomerOpenId)
REFERENCES [dbo].ZY_Customer ([OpenId])
GO
ALTER TABLE [dbo].[ZY_Booked_Position] CHECK CONSTRAINT [FK_ZY_Booked_Position_ZY_Customer]
GO

ALTER TABLE [dbo].[ZY_Booked_Position]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Booked_Position_ZY_Shop_Desk] FOREIGN KEY(DeskId)
REFERENCES [dbo].ZY_Shop_Desk (DeskId)
GO
ALTER TABLE [dbo].[ZY_Booked_Position] CHECK CONSTRAINT [FK_ZY_Booked_Position_ZY_Shop_Desk]
GO

ALTER TABLE [dbo].[ZY_Booked_Position]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Booked_Position_ZY_Order] FOREIGN KEY(OrderId)
REFERENCES [dbo].ZY_Order (OrderId)
GO
ALTER TABLE [dbo].[ZY_Booked_Position] CHECK CONSTRAINT [FK_ZY_Booked_Position_ZY_Order]
GO

CREATE TABLE [dbo].[ZY_Order](
	[OrderId] uniqueIdentifier NOT NULL primary key,
	[CustomerOpenId] nvarchar(256)  NULL,
	[Status] int default(0) not null,
	[Amount] decimal(18,2) default(0) not null,
	[VersionNo] [int] NOT NULL,
	[TransactionId] [uniqueIdentifier] NOT NULL,
	[CreatedBy] [varchar](128) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedBy] [varchar](128) NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
)
ALTER TABLE [dbo].[ZY_Order]  WITH CHECK ADD  CONSTRAINT [FK_ZY_Order_ZY_Customer] FOREIGN KEY(CustomerOpenId)
REFERENCES [dbo].ZY_Customer ([OpenId])
GO
ALTER TABLE [dbo].[ZY_Order] CHECK CONSTRAINT [FK_ZY_Order_ZY_Customer]
GO
