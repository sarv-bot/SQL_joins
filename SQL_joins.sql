-- Creating and Inserting the data
CREATE database company_db;
USE company_db;

-- Table 1: Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(50)
);

INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'John Smith', 'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams', 'Los Angeles'),
(4, 'Nancy Miller', 'Houston'),
(5, 'Robert White', 'Miami');


-- Table 2: Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450),
(105, 4, '2024-10-12', 400);


-- Table 3: Payments
CREATE TABLE Payments (
    PaymentID VARCHAR(10) PRIMARY KEY,
    CustomerID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Payments (PaymentID, CustomerID, PaymentDate, Amount) VALUES
('P001', 1, '2024-10-02', 250),
('P002', 2, '2024-10-06', 300),
('P003', 3, '2024-10-11', 450),
('P004', 4, '2024-10-15', 200);


-- Table 4: Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    ManagerID INT
);

INSERT INTO Employees (EmployeeID, EmployeeName, ManagerID) VALUES
(1, 'Alex Green', NULL),
(2, 'Brian Lee', 1),
(3, 'Carol Ray', 1),
(4, 'David Kim', 2),
(5, 'Eva Smith', 2);

-- Q1. Retrieve all customers who have placed at least one order.
SELECT DISTINCT c.* 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- Q2. Retrieve all customers and their orders, including customers who have not placed any orders.
SELECT * 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- Q3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers.
SELECT * 
FROM Orders o 
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- Q4. Display all customers and orders, whether matched or not.
SELECT * 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
UNION 
SELECT * 
FROM Customers c 
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- Q5. Find customers who have not placed any orders.
SELECT c.* 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.OrderID IS NULL;

-- Q6. Retrieve customers who made payments but did not place any orders.
SELECT DISTINCT c.* 
FROM Customers c 
JOIN Payments p ON c.CustomerID = p.CustomerID 
WHERE c.CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- Q7. Generate a list of all possible combinations between Customers and Orders.
SELECT * 
FROM Customers 
CROSS JOIN Orders;

-- Q8. Show all customers along with order and payment amounts in one table.
SELECT c.CustomerID, c.CustomerName, o.Amount AS OrderAmount, p.Amount AS PaymentAmount 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN Payments p ON c.CustomerID = p.CustomerID;

-- Q9. Retrieve all customers who have both placed orders and made payments.
SELECT * 
FROM Customers 
WHERE CustomerID IN (SELECT CustomerID FROM Orders) 
AND CustomerID IN (SELECT CustomerID FROM Payments);