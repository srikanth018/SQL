/*
SQLyog Professional v13.1.1 (64 bit)
MySQL - 10.4.24-MariaDB : Database - presidiotask
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`presidiotask` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `presidiotask`;

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `CustomerID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

/*Data for the table `customers` */

insert  into `customers`(`CustomerID`,`FirstName`,`LastName`,`Email`,`Phone`,`City`) values 
(1,'John','Doe','john@example.com','1234567890','New York'),
(2,'Jane','Smith','jane@example.com','2345678901','Los Angeles'),
(3,'Mike','Brown','mike@example.com','3456789012','Chicago'),
(4,'Sara','Davis','sara@example.com','4567890123','Houston'),
(5,'Tom','Wilson','tom@example.com','5678901234','Phoenix'),
(6,'Emma','Johnson','emma@example.com','6789012345','Philadelphia'),
(7,'Liam','Lee','liam@example.com','7890123456','San Antonio'),
(8,'Olivia','Taylor','olivia@example.com','8901234567','San Diego'),
(9,'Noah','Martinez','noah@example.com','9012345678','Dallas'),
(10,'Ava','Garcia','ava@example.com','0123456789','San Jose'),
(11,'James','Rodriguez','james@example.com','1112223333','Austin'),
(12,'Sophia','Lopez','sophia@example.com','2223334444','Jacksonville'),
(13,'Mason','Gonzalez','mason@example.com','3334445555','Columbus'),
(14,'Isabella','Hernandez','isabella@example.com','4445556666','Charlotte'),
(15,'Logan','Nguyen','logan@example.com','5556667777','Fort Worth');

/*Table structure for table `orderdetails` */

DROP TABLE IF EXISTS `orderdetails`;

CREATE TABLE `orderdetails` (
  `OrderDetailID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderID` int(11) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `UnitPrice` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`OrderDetailID`),
  KEY `OrderID` (`OrderID`),
  KEY `idx_orderdetails_product` (`ProductID`),
  CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

/*Data for the table `orderdetails` */

insert  into `orderdetails`(`OrderDetailID`,`OrderID`,`ProductID`,`Quantity`,`UnitPrice`) values 
(1,1,1,2,25.99),
(2,1,4,5,5.49),
(3,2,3,1,159.99),
(4,2,2,1,45.00),
(5,3,5,2,35.00),
(6,4,6,2,75.00),
(7,5,10,4,15.00),
(8,6,13,1,95.00),
(9,7,7,1,49.99),
(10,8,11,2,22.00),
(11,9,8,1,199.99),
(12,10,9,2,15.00),
(13,11,14,1,105.50),
(14,12,12,1,89.99),
(15,13,15,1,130.00),
(16,16,15,1,130.00),
(17,17,15,2,130.00),
(18,18,15,2,130.00);

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerID` int(11) DEFAULT NULL,
  `OrderDate` date NOT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `idx_orders_customer` (`CustomerID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

/*Data for the table `orders` */

insert  into `orders`(`OrderID`,`CustomerID`,`OrderDate`,`TotalAmount`) values 
(1,1,'2024-04-01',125.50),
(2,2,'2024-04-02',210.00),
(3,3,'2024-04-03',85.99),
(4,4,'2024-04-04',150.75),
(5,5,'2024-04-05',60.00),
(6,1,'2024-04-06',130.20),
(7,6,'2024-04-07',200.00),
(8,7,'2024-04-08',50.00),
(9,8,'2024-04-09',99.99),
(10,9,'2024-04-10',189.00),
(11,10,'2024-04-11',75.49),
(12,11,'2024-04-12',240.00),
(13,12,'2024-04-13',125.00),
(14,13,'2024-04-14',65.00),
(15,14,'2024-04-15',110.00),
(16,3,'2025-04-17',130.00),
(17,3,'2025-04-17',260.00),
(18,4,'2025-04-17',260.00);

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `ProductID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(100) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Stock` int(11) NOT NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE KEY `ProductName` (`ProductName`),
  KEY `idx_product_name` (`ProductName`),
  KEY `idx_product_id` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

/*Data for the table `products` */

insert  into `products`(`ProductID`,`ProductName`,`Price`,`Stock`) values 
(1,'Wireless Mouse',25.99,100),
(2,'Keyboard',45.00,80),
(3,'Monitor 24in',159.99,50),
(4,'USB Cable',5.49,300),
(5,'Laptop Stand',35.00,40),
(6,'External HDD 1TB',75.00,60),
(7,'Webcam HD',49.99,45),
(8,'Gaming Chair',199.99,20),
(9,'Smartphone Charger',15.00,120),
(10,'Bluetooth Speaker',60.00,35),
(11,'LED Desk Lamp',22.00,70),
(12,'Router Dual-Band',89.99,25),
(13,'SSD 512GB',95.00,65),
(14,'Mechanical Keyboard',105.50,30),
(15,'Drawing Tablet',130.00,10);

/* Trigger structure for table `orderdetails` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `updateStock` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `updateStock` AFTER INSERT ON `orderdetails` FOR EACH ROW 
BEGIN
 UPDATE `products`
 set Stock = Stock - NEW.Quantity
 where ProductID = NEW.ProductID
 AND Stock >= NEW.Quantity;
END */$$


DELIMITER ;

/* Function  structure for function  `getProductID` */

/*!50003 DROP FUNCTION IF EXISTS `getProductID` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getProductID`(p_ProductName VARCHAR(100)) RETURNS int(11)
BEGIN
declare v_id int;

select ProductID into v_id
from products
where ProductName = p_ProductName
LIMIT 1;

return v_id;

END */$$
DELIMITER ;

/* Function  structure for function  `getTotalAmount` */

/*!50003 DROP FUNCTION IF EXISTS `getTotalAmount` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getTotalAmount`(p_ProductName VARCHAR(100),p_Quantity int) RETURNS int(11)
    DETERMINISTIC
BEGIN
DECLARE v_Amount INT;

SELECT Price INTO v_Amount
FROM products
WHERE ProductID = getProductID(p_ProductName);

set v_Amount = v_Amount * p_Quantity;

RETURN v_Amount;

END */$$
DELIMITER ;

/* Function  structure for function  `TotalOrderAmountByCustomer` */

/*!50003 DROP FUNCTION IF EXISTS `TotalOrderAmountByCustomer` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `TotalOrderAmountByCustomer`(p_CustomerID INT) RETURNS decimal(10,2)
BEGIN

declare v_amount decimal(10,2);
SELECT 
  Sum(o.TotalAmount) as TotalOrderAmountByCustomer
into v_amount
FROM customers c
JOIN orders o ON o.CustomerID = c.CustomerID
JOIN orderdetails od ON od.OrderID = o.OrderID
JOIN products p ON p.ProductID = od.ProductID
WHERE c.CustomerID = p_CustomerID;

return v_amount;

END */$$
DELIMITER ;

/* Procedure structure for procedure `CustomerOrders` */

/*!50003 DROP PROCEDURE IF EXISTS  `CustomerOrders` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `CustomerOrders`(p_CustomerID int)
begin

SELECT 
  concat(c.FirstName,' ',c.LastName) as FullName,c.Email,c.Phone,c.City,o.OrderDate,
  p.ProductName,od.Quantity,o.TotalAmount
FROM customers c
JOIN orders o ON o.CustomerID = c.CustomerID
JOIN orderdetails od ON od.OrderID = o.OrderID
JOIN products p ON p.ProductID = od.ProductID
where c.CustomerID = p_CustomerID;

end */$$
DELIMITER ;

/* Procedure structure for procedure `placeOrder` */

/*!50003 DROP PROCEDURE IF EXISTS  `placeOrder` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `placeOrder`(p_CustomerID int, p_ProductName varchar(100), p_Quantity int)
begin

declare v_checkQuantity int;
DECLARE latestID INT;

declare exit handler for sqlException
begin 
rollback;
SELECT 'Error occurred. Transaction rolled back.' AS Message;
end; 

start transaction;

SET v_checkQuantity = checkStock(p_ProductName,p_Quantity);

if v_checkQuantity = 1 then 

	insert into `orders` (CustomerID, OrderDate, TotalAmount)
	values (p_CustomerID, cast(now() as date), getTotalAmount(p_ProductName,p_Quantity));

	set latestID = LAST_INSERT_ID();

	insert into `orderdetails` (OrderID,ProductID,Quantity,UnitPrice)
	values (latestID,getProductID(p_ProductName),p_Quantity, getTotalAmount(p_ProductName,1));
	commit;
	SELECT 'Order placed successfully' AS Message;
else
	rollback;
	SELECT 'Insufficient product quantity' AS Message;
end if;
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
