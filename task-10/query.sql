-- functions and procedures

-- Get Product
DELIMITER $$

CREATE FUNCTION getProductID(p_ProductName VARCHAR(100))
RETURNS INT
BEGIN
DECLARE v_id INT;

SELECT ProductID INTO v_id
FROM products
WHERE ProductName = p_ProductName
LIMIT 1;

RETURN v_id;

END $$
DELIMITER ;

-- Get Total Amount for order

DELIMITER $$

CREATE FUNCTION getTotalAmount(p_ProductName VARCHAR(100),p_Quantity INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE v_Amount INT;

SELECT Price INTO v_Amount
FROM products
WHERE ProductID = getProductID(p_ProductName);

SET v_Amount = v_Amount * p_Quantity;

RETURN v_Amount;

END $$
DELIMITER ;

-- Check for sufficient product quantity
DELIMITER $$
CREATE FUNCTION checkStock(p_ProductName VARCHAR(100), p_Quantity INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE v_checker INT;

SELECT COUNT(1) 
INTO v_checker
FROM `products`
WHERE ProductID = getProductID(p_ProductName) 
AND Stock >= p_Quantity;

IF v_checker>0 THEN
	RETURN 1;
ELSE
	RETURN 0;
END IF;

END $$
DELIMITER ;

-- place order 
DELIMITER $$

CREATE PROCEDURE placeOrder(p_CustomerID INT, p_ProductName VARCHAR(100), p_Quantity INT)
BEGIN

DECLARE v_checkQuantity INT;
DECLARE latestID INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN 
ROLLBACK;
SELECT 'Error occurred. Transaction rolled back.' AS Message;
END; 

START TRANSACTION;

SET v_checkQuantity = checkStock(p_ProductName,p_Quantity);

IF v_checkQuantity = 1 THEN 

	INSERT INTO `orders` (CustomerID, OrderDate, TotalAmount)
	VALUES (p_CustomerID, CAST(NOW() AS DATE), getTotalAmount(p_ProductName,p_Quantity));

	SET latestID = LAST_INSERT_ID();

	INSERT INTO `orderdetails` (OrderID,ProductID,Quantity,UnitPrice)
	VALUES (latestID,getProductID(p_ProductName),p_Quantity, getTotalAmount(p_ProductName,1));
	COMMIT;
	SELECT 'Order placed successfully' AS Message;
ELSE
	ROLLBACK;
	SELECT 'Insufficient product quantity' AS Message;
END IF;
END $$
DELIMITER ;

-- trigger to update stock
DELIMITER $$
CREATE TRIGGER updateStock
AFTER INSERT ON orderdetails
FOR EACH ROW
BEGIN
 UPDATE `products`
 SET Stock = Stock - NEW.Quantity
 WHERE ProductID = NEW.ProductID
 AND Stock >= NEW.Quantity;
END$$
DELIMITER ;


-- Get Details of the customer and their order details

DELIMITER $$

CREATE PROCEDURE CustomerOrders(p_CustomerID INT)
BEGIN

SELECT 
  CONCAT(c.FirstName,' ',c.LastName) AS FullName,c.Email,c.Phone,c.City,o.OrderDate,
  p.ProductName,od.Quantity,o.TotalAmount
FROM customers c
JOIN orders o ON o.CustomerID = c.CustomerID
JOIN orderdetails od ON od.OrderID = o.OrderID
JOIN products p ON p.ProductID = od.ProductID
WHERE c.CustomerID = p_CustomerID;

END $$
DELIMITER ;

DELIMITER $$

CREATE FUNCTION TotalOrderAmountByCustomer(p_CustomerID INT)
RETURNS DECIMAL(10,2)
BEGIN

DECLARE v_amount DECIMAL(10,2);
SELECT 
  SUM(o.TotalAmount) AS TotalOrderAmountByCustomer
INTO v_amount
FROM customers c
JOIN orders o ON o.CustomerID = c.CustomerID
JOIN orderdetails od ON od.OrderID = o.OrderID
JOIN products p ON p.ProductID = od.ProductID
WHERE c.CustomerID = p_CustomerID;

RETURN v_amount;

END $$
DELIMITER ;


-- indexes

CREATE INDEX idx_product_name ON products(ProductName);
CREATE INDEX idx_product_id ON products(ProductID);
CREATE INDEX idx_orderdetails_product ON orderdetails(ProductID);
CREATE INDEX idx_orders_customer ON orders(CustomerID);


-- Testing Queries

CALL placeOrder(4,"Drawing Tablet",20);

CALL CustomerOrders(4);

SELECT TotalOrderAmountByCustomer(4);
