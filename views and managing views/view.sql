DROP VIEW IF EXISTS OrderSummary;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100)
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- insert data-----------------------------------------------------------------
INSERT INTO Customers (CustomerID, Name, Email) VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com');


INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES
(101, 1, '2025-06-01', 250.00),
(102, 2, '2025-06-05', 150.00),
(103, 1, '2025-06-10', 300.00),
(104, 3, '2025-06-12', 200.00);

--  create a view that combines Customers and Orders data---------------------------
CREATE VIEW OrderSummary AS
SELECT
    C.CustomerID,
    C.Name AS CustomerName,
    C.Email,
    O.OrderID,
    O.OrderDate,
    O.Amount
FROM
    Customers C
JOIN
    Orders O ON C.CustomerID = O.CustomerID;

SELECT * FROM OrderSummary;
-- check column and data types--------------------------------------------------------------
DESCRIBE OrderSummary;

-- show all views by different methods -------------------------------------------------------------------
SHOW FULL TABLES WHERE Table_type = 'VIEW';
-----------------
SHOW FULL TABLES IN supply_chains WHERE Table_type = 'VIEW';
-----------------
SELECT 
    TABLE_SCHEMA AS database_name, 
    TABLE_NAME AS view_name 
FROM 
    information_schema.TABLES 
WHERE 
    TABLE_TYPE = 'VIEW'
ORDER BY 
    database_name, view_name;
------------- --
SELECT 
    TABLE_SCHEMA AS database_name, 
    TABLE_NAME AS view_name, 
    VIEW_DEFINITION, 
    IS_UPDATABLE 
FROM 
    information_schema.VIEWS;
-- WHERE 
    -- TABLE_SCHEMA = 'your_database_name';
-----------------
