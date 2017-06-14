alter PROCEDURE [dbo].[sp_GetDesksForCustomer]
  ( 
    @shopId uniqueIdentifier, 
    @date datetime
  ) 
  AS
  BEGIN
    select deskId,DeskName as [deskName],booked.position as [bookedPositions] ,@date as [selectedDate] from ZY_Shop_Desk a
	inner join ZY_Shop c on a.ShopId=c.ShopId
	outer apply (select CONVERT(nvarchar(256),b.Position)+',' from ZY_Booked_Position b where b.DeskId=a.DeskId and b.Status>0 and b.OrderDate=@date for xml path(''))as booked(position)
	where a.ShopId=@shopId and c.ShopStatus=1
	order by DeskName
  END