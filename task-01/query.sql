
CREATE DATABASE presidiotask;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);  

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES
(1, 'Srikanth', 'M', 'Sales', 80000.00),
(2, 'Praveen', 'A', 'IT', 75000.00),
(3, 'Sankar', 'S', 'HR', 60000.00),
(4, 'Mouly', 'T', 'Sales', 58000.00),
(5, 'Naveen', 'N', 'IT', 72000.00);

SELECT * FROM Employees;