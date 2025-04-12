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

/*Table structure for table `employee_details` */

DROP TABLE IF EXISTS `employee_details`;

CREATE TABLE `employee_details` (
  `Name` varchar(50) DEFAULT NULL,
  `EmployeeID` int(11) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `employee_details` */

insert  into `employee_details`(`Name`,`EmployeeID`,`Address`,`Phone`,`Email`) values 
('Srikanth M',1,'123 Main St, Coimbatore','9876543210','srikanth@gmail.com'),
('Mouly TN',2,'456 Park Ave, Chennai','9123456780','praveen@gmail.com'),
('Praveen A',3,'789 MG Road, Chennai','9988776655','sankar@gmail.com'),
('Sankar S',4,'321 Lake View, Chennai','9001122334','mouly@gmail.com'),
('Naveen N',5,'654 Green St, Salem','9871234567','naveen@gmail.com'),
('Hari H',6,'999 Beach Road, Pondicherry','9009988776','hari@gmail.com'),
('Divya R',7,'100 Lake Road, Bangalore','9112233445','divya@gmail.com'),
('Arjun M',8,'200 Ring Road, Hyderabad','9003322110','arjun@gmail.com'),
('Rekha K',9,'305 Cross St, Madurai','8887766554','rekha@gmail.com'),
('Vinay P',10,'111 Tech Park, Kochi','9445566778','vinay@gmail.com'),
('Deepak L',11,'222 Business Bay, Trichy','9554433221','deepak@gmail.com'),
('Swathi B',12,'789 Garden Road, Chennai','9667788990','swathi@gmail.com'),
('Kiran J',13,'555 Sunrise Ave, Chennai','9011122233','kiranj@gmail.com'),
('Lakshmi S',14,'77 Rose Park, Bangalore','9321456790','lakshmis@gmail.com'),
('Rajiv B',15,'404 Blue Hill, Hyderabad','9898123456','rajivb@gmail.com'),
('Ayesha N',16,'333 Jasmine Rd, Coimbatore','9123789456','ayesha@gmail.com'),
('Manoj K',17,'909 Ashok Nagar, Chennai','9876541230','manojk@gmail.com'),
('Sneha P',18,'221 Lotus Street, Salem','9567456321','sneha@gmail.com'),
('Gokul V',19,'888 Westend, Madurai','9345678901','gokulv@gmail.com'),
('Ritika D',20,'101 City Center, Pondicherry','9445566123','ritikad@gmail.com');

/*Table structure for table `employees` */

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `EmployeeID` int(11) NOT NULL,
  `Department` varchar(50) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employee_details` (`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `employees` */

insert  into `employees`(`EmployeeID`,`Department`,`Salary`) values 
(1,'Sales',80000.00),
(2,'IT',75000.00),
(3,'HR',60000.00),
(4,'Sales',58000.00),
(5,'IT',72000.00),
(7,'IT',77000.00),
(8,'Sales',81000.00),
(9,'HR',59000.00),
(10,'HR',63000.00),
(11,'IT',70000.00),
(12,'Sales',82000.00),
(13,'HR',64000.00),
(14,'Sales',85000.00),
(15,'IT',73000.00),
(16,'Sales',79000.00),
(17,'IT',76000.00),
(18,'HR',61000.00),
(19,'IT',78000.00),
(20,'Sales',80000.00);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
