/*
SQLyog Professional v13.1.1 (64 bit)
MySQL - 10.4.24-MariaDB 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `employees` (
	`EmployeeID` int (11),
	`FirstName` varchar (150),
	`LastName` varchar (150),
	`Department` varchar (150),
	`Salary` Decimal (12)
); 
insert into `employees` (`EmployeeID`, `FirstName`, `LastName`, `Department`, `Salary`) values('1','Srikanth','M','Sales','80000.00');
insert into `employees` (`EmployeeID`, `FirstName`, `LastName`, `Department`, `Salary`) values('2','Praveen','A','IT','75000.00');
insert into `employees` (`EmployeeID`, `FirstName`, `LastName`, `Department`, `Salary`) values('3','Sankar','S','HR','60000.00');
insert into `employees` (`EmployeeID`, `FirstName`, `LastName`, `Department`, `Salary`) values('4','Mouly','T','Sales','58000.00');
insert into `employees` (`EmployeeID`, `FirstName`, `LastName`, `Department`, `Salary`) values('5','Naveen','N','IT','72000.00');
