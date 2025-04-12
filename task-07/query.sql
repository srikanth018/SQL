-- 1. Max salary within each department

SELECT d.Name, e.Department, e.Salary, 
       MAX(e.`Salary`) OVER( PARTITION BY e.Department) Max_Salary
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`;

-- 2. Rank employees by salary within each department

SELECT d.Name, e.Department, e.Salary, 
       RANK() OVER( PARTITION BY e.Department ORDER BY e.Salary DESC) rnk
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`;

-- 3. Find the top 3 highest-paid employees in each department
SELECT * 
FROM (
SELECT d.Name, e.Department, e.Salary, 
       DENSE_RANK() OVER( PARTITION BY e.Department ORDER BY e.Salary DESC) rnk
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`) ran
WHERE ran.rnk <4

-- 4.  Employees whose salary is greater than the departments avg salary
SELECT avg_table.* 
FROM (
SELECT d.Name, e.Department, e.Salary, 
       AVG(e.Salary) OVER( PARTITION BY e.Department) average
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`) avg_table

WHERE avg_table.Salary > avg_table.average

-- 5. Calculate cumulative salary per department (a running total of salaries)

SELECT d.Name, e.Department, e.Salary, 
       SUM(e.Salary) OVER( PARTITION BY e.Department ORDER BY e.`EmployeeID` DESC) TotalSalary
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`

-- 6. Find the salary difference between each employee the next highest-paid in their department

SELECT d.Name, e.Department, e.Salary, 
       LEAD(e.Salary) OVER( PARTITION BY e.Department ORDER BY e.`Salary` DESC) NextHighest,
       e.Salary - LEAD(e.Salary) OVER( PARTITION BY e.Department ORDER BY e.`Salary` DESC) SalaryDifference
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`

-- 7. Identify employees who earn more than the previous employee in their department

SELECT d.Name, e.Department, e.Salary, 
       IFNULL(LAG(e.Salary) OVER( PARTITION BY e.Department ORDER BY e.`Salary` DESC),0) Previous
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`

-- 8. Divide employees into 4 salary quartiles (buckets) across the entire company

SELECT d.Name, e.Department, e.Salary, 
	NTILE(4) OVER(ORDER BY e.`Salary` DESC) quartiles 
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`

-- 9. Paginate employees by salary (show "page 2" of 5 employees per page)

SELECT rowNumTable.*
FROM (
SELECT d.Name, e.Department, e.Salary, 
	ROW_NUMBER() OVER(ORDER BY e.`Salary` DESC) AS RowNum
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`) AS rowNumTable
WHERE rowNumTable.RowNum BETWEEN 6 AND 10
