USE PropertyDB;
GO

CREATE FUNCTION udfGetDays(@startDate datetime, @endDate datetime)
RETURNS int
AS
BEGIN 

	DECLARE @dateDiff int

	SELECT @dateDiff = DATEDIFF(day, @startDate, @endDate);

	RETURN @dateDiff

END

GO


CREATE VIEW vBookingDetails
AS
Select c.FirstName, c.LastName, c.Email, b.BookDate as 'Date Booked', b.CheckInDate as'Check in', b.CheckOutDate as 'Check Out', b.ChargeAmount as 'Amount',  rt.RoomTypeId AS [Room Type]
FROM Customers c
INNER JOIN Bookings b
ON b.CustomerID = c.CustomerID
INNER JOIN Rooms r
ON r.RoomID = b.RoomID
INNER JOIN dbo.RoomType AS rt 
ON r.RoomTypeId = rt.RoomTypeId;
GO

CREATE VIEW vRoomServiceDetails
AS 
SELECT c.FirstName + ' '+c.LastName as [Customer Name], r.RoomID, sr.ProblemDesc, sr.RequestDate, sc.ServiceAmount, s.FirstName + ' ' + s.LastName as [Staff Name]
FROM Bookings b
JOIN Rooms r
ON r.RoomID = b.RoomID
JOIN ServiceRequest sr
ON sr.RoomID = r.RoomID
JOIN Customers c
ON c.CustomerID = b.CustomerID
JOIN ServiceCatalog sc
ON sc.ServiceID = sr.ServiceId
JOIN Staff s
ON s.StaffID = sr.AssignedTo


GO


CREATE FUNCTION udfCalculateChargeAmount(@roomID int,@start date, @end date)
RETURNS money
AS
BEGIN 

	DECLARE @chargeAmount money 
	DECLARE @days int
	DECLARE @roomAmount money

	SELECT @days = dbo.udfGetDays(@start, @end);
	

	SELECT @roomAmount = rt.RoomPrice
	FROM Rooms r
	JOIN RoomType rt
	ON rt.RoomTypeId = r.RoomTypeId
	WHERE r.RoomID = @roomID;


	RETURN CAST((@days * @roomAmount) as money)

END

GO


CREATE FUNCTION udfSelectLastPayment()
RETURNS int
AS 
BEGIN 
	DECLARE @paymentId int

	SELECT TOP 1 @paymentId = PaymentID
	FROM Payments
	ORDER BY PaymentID DESC;

	RETURN @paymentId
	
END
