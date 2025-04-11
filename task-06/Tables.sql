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

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `CustomerName` varchar(100) DEFAULT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `ShipDate` datetime DEFAULT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `orders` */

insert  into `orders`(`OrderID`,`CustomerName`,`OrderDate`,`ShipDate`,`TotalAmount`) values 
(1,'Srikanth','2025-03-05 10:15:00','2025-03-07 14:00:00',120.50),
(2,'Mouly','2025-03-15 08:45:00','2025-03-18 13:30:00',250.00),
(3,'Praveen','2025-03-25 16:00:00','2025-03-28 11:45:00',310.75),
(4,'Sankar','2025-04-01 09:20:00','2025-04-03 15:10:00',95.00),
(5,'Naveen','2025-04-05 12:00:00','2025-04-08 17:00:00',180.20),
(6,'Dhanush','2025-04-10 14:30:00','2025-04-12 10:15:00',275.90);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
