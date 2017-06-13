
alter PROCEDURE sp_GetDesks
  ( 
    @shopId uniqueIdentifier, 
    @date datetime
  ) 
  AS
  BEGIN
    select DeskId,DeskName,booked.position as [BookedPositions],internlbooked.position as [InternalBookedPositions] from ZY_Shop_Desk a
	outer apply (select CONVERT(nvarchar(256),b.Position)+',' from ZY_Shop_Order b where b.DeskId=a.DeskId and b.Status=1 and b.OrderDate=@date for xml path(''))as booked(position)
	outer apply (select CONVERT(nvarchar(256),b.Position)+',' from ZY_Shop_Order b where b.DeskId=a.DeskId and b.Status=1 and b.OrderDate=@date and b.IsInternal=1 for xml path(''))as internlbooked(position)
	where ShopId=@shopId
	order by DeskName
  END