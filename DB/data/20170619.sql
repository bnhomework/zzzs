declare @from datetime
declare @to datetime
declare @status nvarchar(256)
declare @shopId uniqueIdentifier


select * from ZY_Booked_Position a
left join ZY_Order b on a.OrderId=b.OrderId
left join ZY_Shop_Desk c on a.DeskId=c.DeskId
left join ZY_Shop d on c.ShopId=d.ShopId
where


