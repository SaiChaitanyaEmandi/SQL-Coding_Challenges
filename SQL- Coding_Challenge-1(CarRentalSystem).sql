CREATE DATABASE CarRentalSystem;
USE CarRentalSystem;

CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    dailyRate FLOAT(2),
    status INT,
    passengerCapacity INT,
    engineCapacity INT);

INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES
(1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450),
(2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500),
(3, 'Ford', 'Focus', 2022, 48.00, 0, 4, 1400),
(4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),	
(6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400),
(7, 'BMW', '3 Series', 2023, 60.00, 1, 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599),
(9, 'Audi', 'A4', 2022, 55.00, 0, 4, 2500),
(10, 'Lexus', 'ES', 2023, 54.00, 1, 4, 2500);

SELECT*FROM Vehicle;

CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100),
    phoneNumber VARCHAR(50));

INSERT INTO Customer
VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

SELECT*FROM Customer;

CREATE TABLE Lease (
    leaseID INT PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate DATE,
    endDate DATE,
    leaseType VARCHAR(20),
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, leaseType)
VALUES 
(1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

SELECT*FROM Lease;

CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    leaseID INT,
    paymentDate DATE,
    amount INT,
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID)
);

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00);

SELECT*FROM Payment;

--Q1
UPDATE Vehicle
SET dailyRate = 68.00
WHERE make = 'Mercedes';

--Q2
DELETE FROM Payment
WHERE leaseID IN (
    SELECT leaseID
    FROM Lease
    WHERE customerID = 1);

DELETE FROM Lease
WHERE customerID = 1;

DELETE FROM Customer
WHERE customerID = 1; 

--Q3
EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';
SELECT * FROM Payment;

--Q4
SELECT * FROM Customer WHERE email = 'robert@example.com';

--Q5
DECLARE @CustomerID_Value INT = 3;

SELECT Lease.*, Vehicle.make, Vehicle.model, Vehicle.year
FROM Lease
JOIN Customer ON Lease.customerID = Customer.customerID
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID
WHERE Customer.customerID = @CustomerID_Value
AND Lease.endDate >= GETDATE(); 

--Q6
SELECT P.paymentID, P.leaseID, P.transactionDate, P.amount
FROM Payment P
INNER JOIN Lease L ON P.leaseID = L.leaseID
INNER JOIN Customer C ON L.customerID = C.customerID
WHERE C.phoneNumber = '555-123-4567';

--Q7
SELECT AVG(dailyRate) AS AverageDailyRate
FROM Vehicle
WHERE status = 1;

--Q8
SELECT TOP 1 *
FROM Vehicle
ORDER BY dailyRate DESC;

--Q9
SELECT v.vehicleID, v.make, v.model, v.year
FROM Lease l
INNER JOIN Vehicle v ON l.vehicleID = v.vehicleID
INNER JOIN Customer c ON l.customerID = c.customerID
WHERE c.customerID = 2; 

--Q10
SELECT*FROM Lease
WHERE endDate = (SELECT MAX(endDate) FROM Lease);

--Q11
SELECT*FROM Payment
WHERE YEAR(transactionDate) = 2023;

--Q12
SELECT C.customerID, C.firstName, C.lastName
FROM Customer C
LEFT JOIN Lease L ON C.customerID = L.customerID
LEFT JOIN Payment P ON L.leaseID = P.leaseID
WHERE P.paymentID IS NULL
GROUP BY C.customerID, C.firstName, C.lastName;

--Q13
SELECT  V.make, V.model, V.year, SUM(P.amount) AS TotalPayments
FROM  Vehicle V
INNER JOIN  Lease L ON V.vehicleID = L.vehicleID
LEFT JOIN  Payment P ON L.leaseID = P.leaseID
GROUP BY  V.make, V.model, V.year
ORDER BY  V.make, V.model, V.year;

--Q14
SELECT c.customerID, c.firstName, c.lastName, SUM(p.amount) AS TotalPayments
FROM Customer c
LEFT JOIN Lease l ON c.customerID = l.customerID
LEFT JOIN Payment p ON l.leaseID = p.leaseID
GROUP BY c.customerID, c.firstName, c.lastName
ORDER BY c.customerID;


--Q15
SELECT  l.leaseID, v.make, v.model, v.year, v.dailyRate, v.passengerCapacity, v.engineCapacity
FROM  Lease l
INNER JOIN  Vehicle v ON l.vehicleID = v.vehicleID;

--Q16
SELECT  Lease.leaseID, Customer.firstName AS customerFirstName, Customer.lastName AS customerLastName, Vehicle.make,
    Vehicle.model, Vehicle.year, Lease.startDate, Lease.endDate FROM Lease
JOIN Customer ON Lease.customerID = Customer.customerID
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID
WHERE Lease.endDate >= '2023-04-30';

--Q17
SELECT Customer.customerID, Customer.firstName, Customer.lastName, SUM(Payment.amount) AS totalAmountSpent
FROM Customer
JOIN Lease ON Customer.customerID = Lease.customerID
JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY Customer.customerID, Customer.firstName, Customer.lastName
ORDER BY totalAmountSpent DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROW ONLY;

--Q18
SELECT Vehicle.vehicleID, Vehicle.make, Vehicle.model, Vehicle.year, Lease.leaseID, Lease.startDate, Lease.endDate,
    Customer.firstName AS customerFirstName, Customer.lastName AS customerLastName FROM Vehicle
LEFT JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
LEFT JOIN Customer ON Lease.customerID = Customer.customerID
WHERE Lease.endDate >= GETDATE() OR Lease.endDate IS NULL;