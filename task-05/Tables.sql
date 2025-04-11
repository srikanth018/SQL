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
('Hari H',6,'999 Beach Road, Pondicherry','9009988776','hari@gmail.com');

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
(5,'IT',72000.00);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
