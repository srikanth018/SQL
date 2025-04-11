-- 1. Fetching employee whose salary is greater than the department avg salary
SELECT det.Name, emp.Department, emp.`Salary` FROM `employee_details` det

JOIN `employees` emp ON det.EmployeeID = emp.`EmployeeID`

WHERE emp.`Salary` >=(
SELECT AVG(Salary)
FROM `employees`
WHERE Department = emp.`Department`
);


-- 2.  Create a report that shows each employee's name, department, and salary along with two dynamic columns:

-- The difference between the employee's salary and the average salary in their department

-- A comparison flag that shows "Above Avg" if their salary is above the department average or "Below Avg" if it's below

SELECT 
det.Name,
emp.Department,
(
SELECT AVG(Salary)
		FROM `employees`
		WHERE Department = emp.Department) AS Average,
emp.Salary - (SELECT AVG(Salary)
FROM `employees`
WHERE Department = emp.`Department`) AS SalaryDifference,
CASE 
WHEN emp.Salary > (SELECT AVG(Salary)
		FROM `employees`
		WHERE Department = emp.Department) 
THEN 'Above Avg'
ELSE 'Below Avg'
END AS Flag

FROM `employee_details` det
JOIN `employees` emp ON det.EmployeeID = emp.`EmployeeID`

-- 3. Create a contact list report showing each employee's name, phone, and email, along with:

-- The count of employees in their department

-- The highest salary in their department

SELECT 
det.Name,
det.Phone,
det.Email,
emp.Department,
(SELECT COUNT(Department) FROM `employees` WHERE emp.Department = Department) AS DepartmentCount,
(SELECT MAX(Salary) FROM `employees` WHERE emp.Department = Department) AS DepartmentMaxSalary


FROM `employee_details` det
JOIN `employees` emp ON det.EmployeeID = emp.`EmployeeID`

-- 4. Find employees who exist in employee_details but do not have a corresponding record in the employees table (possible data inconsistency).
SELECT det.Name
FROM `employee_details` det
WHERE NOT EXISTS (
SELECT * FROM `employees` WHERE EmployeeID = det.EmployeeID)


