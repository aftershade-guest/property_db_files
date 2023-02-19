CREATE PROCEDURE uspMakeBooking
@customerId int,
@checkInDate date,
@checkOutDate date,
@RoomId int
AS
BEGIN 
	DECLARE @bookingCharge money
	DECLARE @paymentId int
	BEGIN TRY
		BEGIN TRANSACTION tsScheduleBooking;

		SELECT @bookingCharge = dbo.udfCalculateChargeAmount(@RoomId, @checkInDate, @checkOutDate);

		INSERT INTO Payments(PaymentDate)
		VALUES(getDate());
		SELECT @paymentId = SCOPE_IDENTITY();


		INSERT INTO Bookings(BookDate, ChargeAmount, CheckInDate, CheckOutDate, RoomID, CustomerID, PaymentID)
		VALUES(CAST(getDate() as date), @bookingCharge, @checkInDate, @checkOutDate, @RoomId, @customerId, @paymentId);

		UPDATE Rooms
		SET Availability=0
		WHERE RoomID = @RoomId;
		COMMIT TRANSACTION tsScheduleBooking

	END TRY
	BEGIN CATCH
		print 'An error occured' + error_message()
		ROLLBACK TRANSACTION tsScheduleBooking
	END CATCH
	
END


CREATE PROCEDURE uspCheckIn
@bookingId int
AS 
BEGIN
	Update Bookings
	SET isCheckedIn  = 1
	WHERE BookingID = @bookingId;
END

CREATE PROCEDURE uspCheckOut
@bookingId int
AS 
BEGIN
	DECLARE @RoomID int

	BEGIN TRY
		SELECT @RoomID=RoomID
		FROM Bookings
		WHERE BookingID = @BookingId;

		BEGIN TRANSACTION

		UPDATE Bookings
		SET isCheckedOut=1
		WHERE BookingID = @BookingId;

		UPDATE Rooms
		SET Availability=1
		WHERE RoomID = @RoomId;
		COMMIT
		

	END TRY
	BEGIN CATCH
		print 'An error occured' + error_message()
		ROLLBACK 
	END CATCH

END