USE PropertyDB;
Go

CREATE TABLE Customers(
	CustomerID int IDENTITY(1,1) PRIMARY KEY,
	FirstName varchar(40), 
	LastName varchar(40),
	Email varchar(40)
);

CREATE TABLE PaymentDetails(
	DetailID int IDENTITY(1,1) PRIMARY KEY,
	CardNumber varchar(40) UNIQUE NOT NULL,
	ExpDate date NOT NULL,
	HolderName varchar(60) NOT NULL,
	CustomerId int FOREIGN KEY REFERENCES Customers(CustomerID)
);

CREATE TABLE RoomType(
	RoomTypeId varchar(100) PRIMARY KEY,
	TypeDescription varchar(1000),
	RoomPrice money,
);

CREATE TABLE Rooms(
	RoomID int IDENTITY(1,1) PRIMARY KEY,
	RoomDescription varchar(500),
	Availability bit DEFAULT 1,
	RoomTypeId varchar(100) FOREIGN KEY REFERENCES RoomType(RoomTypeId) 
);

CREATE TABLE Payments(
	PaymentID int IDENTITY(1,1) PRIMARY KEY,
	PaymentDate datetime,
);

CREATE TABLE Bookings(
	BookingID int IDENTITY(1,1) PRIMARY KEY, 
	BookDate date, 
	ChargeAmount money,
	CheckInDate datetime, 
	CheckOutDate datetime,
	IsCheckedOut bit DEFAULT 0,
	IsCheckedIn bit DEFAULT 0,
	RoomID int FOREIGN KEY REFERENCES Rooms(RoomID),
	CustomerID int FOREIGN KEY REFERENCES Customers(CustomerID),
	PaymentID int FOREIGN KEY REFERENCES Payments(PaymentID),
	CONSTRAINT CHK_CheckOutDate CHECK (CheckOutDate > CheckInDate)
);


CREATE TABLE ServiceCatalog(
	ServiceID int IDENTITY(1,1) PRIMARY KEY,
	ServiceName varchar(50),
	ServiceAmount money
);

CREATE TABLE StaffRoles(
	RoleID int IDENTITY(1,1) PRIMARY KEY,
	RoleName varchar(50),
	RoleDesc varchar(100)
);

CREATE TABLE Staff(
	StaffID int IDENTITY(1,1) PRIMARY KEY, 
	FirstName varchar(40),
	LastName varchar(50), 
	RoleID int FOREIGN KEY REFERENCES StaffRoles(RoleID)
);

CREATE TABLE ServiceRequest(
	RequestID int IDENTITY(1,1) PRIMARY KEY, 
	ProblemDesc varchar(2000),
	RequestDate datetime,
	IsComplete bit DEFAULT 0,
	ServiceId int FOREIGN KEY REFERENCES ServiceCatalog(ServiceID),
	AssignedTo int FOREIGN KEY REFERENCES Staff(StaffID),
	PaymentID int FOREIGN KEY REFERENCES Payments(PaymentID),
	RoomID int FOREIGN KEY REFERENCES Rooms(RoomID)
);

Go