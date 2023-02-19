INSERT INTO Customers
VALUES ('Jack', 'BLACK', 'jblack@example.com'),
	('Black', 'Adam', 'badadam@example.com'),
	('Face', 'Brick', 'bricks@example.com'),
	('Tate', 'Jackey', 'tj@example.com'),
	('McKenzie', 'Ezikiel', 'mcezik@example.com')

INSERT INTO PaymentDetails
VALUES ('008252471724652', '20271210', 'J Black', 1),
	('65826357617287252', '20281010', 'B Adam', 2),
	('01348252471724652', '20271210', 'F Brick', 3);


INSERT INTO RoomType
VALUES ('Single', 'Room meant for one person', 300),
	('Double', 'Room meant for 2 people', 450),
	('Studio', 'Room with a studio bed', 550),
	('Suite', 'Room with one or more bedrooms and a separate living space', 700),
	('President Suite', 'Most expensive room', 1000);

INSERT INTO Rooms(RoomDescription, RoomTypeId, Availability)
VALUES ('', 'Single', 1),
	('', 'Double', 1),
	('', 'Single', 1),
	('', 'Studio', 1),
	('', 'Single', 1),
	('', 'Single', 1),
	('', 'Double', 1),
	('', 'Double', 1),
	('', 'Double', 1),
	('', 'Suite', 1),
	('', 'Suite', 1),
	('', 'Suite', 1),
	('', 'President Suite', 1),
	('', 'President Suite', 1);

INSERT INTO ServiceCatalog
VALUES('Dry Cleaning', 100),
	('Room Cleaning', 0),
	('Wash Clothes', 70);

INSERT INTO StaffRoles
VALUES ('Cleaner', 'Cleaning staff'),
	('Security', 'Provide security detail for customer'),
	('General', 'Does geneal things such as takig clothes for washing, dry cleaning'),
	('Receptionist', 'Works at reception');

INSERT INTO Staff
VALUES ('Jack', 'Ryan', 2),
	('Syuss', 'Stamina', 3),
	('Zeus', 'Zeus', 3),
	('Odin', 'Borson', 1),
	('Hella', 'Overp', 1),
	('Asura', 'Asyts', 1),
	('Thor', 'Lightning', 4),
	('Amanda', 'Amy', 4);

INSERT INTO Payments
VALUES (getDate()),
	(getDate()),
	(getDate());

INSERT INTO ServiceRequest
VALUES ('Clothes dry cleaning', getDate(), 1, 1, 1, 1, 2),
	('Most expensive champagne', getDate(), 1, 1, 2, 1, 3);