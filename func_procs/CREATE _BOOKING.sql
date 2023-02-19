USE [PropertyDB]
GO

DECLARE	@return_value int
DECLARE @date datetime
DECLARE @dateOut datetime

SELECT @date= getDate()
SELECT @dateOut = GETDATE()-1

EXEC	@return_value = [dbo].[uspMakeBooking]
		@customerId = 4,
		@checkInDate = @date,
		@checkOutDate = @dateOut,
		@RoomId = 4

SELECT	'Return Value' = @return_value

GO
