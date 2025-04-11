CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATETIME,
    ShipDate DATETIME,
    TotalAmount DECIMAL(10, 2)
);

INSERT INTO Orders (OrderID, CustomerName, OrderDate, ShipDate, TotalAmount)
VALUES
(1, 'Srikanth', '2025-03-05 10:15:00', '2025-03-07 14:00:00', 120.50),
(2, 'Mouly', '2025-03-15 08:45:00', '2025-03-18 13:30:00', 250.00),
(3, 'Praveen', '2025-03-25 16:00:00', '2025-03-28 11:45:00', 310.75),
(4, 'Sankar', '2025-04-01 09:20:00', '2025-04-03 15:10:00', 95.00),
(5, 'Naveen', '2025-04-05 12:00:00', '2025-04-08 17:00:00', 180.20),
(6, 'Dhanush', '2025-04-10 14:30:00', '2025-04-12 10:15:00', 275.90);


-- 1. Retrieve all orders along with the number of days taken to ship each order
SELECT CustomerName, DATEDIFF(ShipDate,OrderDate) DaysToShip 
FROM `orders`

-- 2. Retrieve all orders placed within the last 30 days from the current date.
SELECT * , DATE(NOW()) - DATE(OrderDate) AS Days
FROM `orders`
WHERE DATE(NOW()) - DATE(OrderDate) <= 30

-- 3. Display orders with OrderDate and ShipDate formatted as "YYYY-MM-DD" (without time).
SELECT DATE_FORMAT(OrderDate,'%d/%m/%y')AS OrderDate, DATE_FORMAT(ShipDate,'%d-%m-%y') ShipDate
FROM orders 

-- 4. List all orders that were placed on a Saturday or Sunday.
SELECT *
FROM orders
WHERE DAYOFWEEK(OrderDate) = 1 OR DAYOFWEEK(OrderDate)=7

-- 5. Assume orders take 2 business days to process. Calculate the expected ship date for each order.
SELECT DATE (DATE_ADD(OrderDate, INTERVAL 2 DAY)) Shipdate
FROM orders