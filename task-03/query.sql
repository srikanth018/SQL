SELECT Department, COUNT(EmployeeID) no_of_employees
FROM `employees`
WHERE Salary > 70000
GROUP BY Department

SELECT Department, SUM(Salary) Total_salary
FROM `employees`
GROUP BY Department
HAVING COUNT(Department) > 1

SELECT Department, AVG(Salary) Average_salary
FROM `employees`
GROUP BY Department