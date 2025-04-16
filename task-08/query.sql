-- 1. Non-Recursive CTE Scenarios

-- 1. Write a CTE that first filters out employees earning less than 50,000, then calculates the average salary per department.

WITH less_Salary (NAME,EmployeeID,Address,Phone,Email,ManagerID,Department,Salary) AS
(
SELECT d.*, e.`Department`,e.`Salary`
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
WHERE e.`Salary` >=70000
)
SELECT s.Department,
AVG(s.Salary) Average
FROM less_Salary s
GROUP BY s.Department

-- 2. Use a CTE to rank employees by salary within their department and return the top 3 earners per department.
WITH rank_table (NAME,EmployeeID,Address,Phone,Email,ManagerID,Department,Salary,rnk) AS
(
SELECT d.*, e.`Department`,e.`Salary`,
DENSE_RANK() OVER(PARTITION BY e.`Department` ORDER BY e.`Salary`) rnk
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
)
SELECT NAME,Department, `Salary`,rnk
FROM rank_table
WHERE rnk<4

-- 3. Create a CTE to get the number of direct reports for each manager.

WITH managerCount( ManagerID, countbyID) AS
(
SELECT  d. ManagerID, COUNT(d.EmployeeID) countbyID
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.ManagerID 
GROUP BY d.ManagerID
)
SELECT m.ManagerID,d.Name,  m.countbyID
FROM employee_details d
JOIN managerCount m ON d.EmployeeID = m.ManagerID


-- 2. Recursive CTE Scenarios (Hierarchical Queries)

-- 1. Given a manager's EmployeeID, write a recursive CTE to return all employees (direct and indirect) reporting to them.

-- Example Input: ManagerID = 3
-- Expected Output: Names and IDs of all employees under 101, even across multiple levels.

WITH RECURSIVE employeesOnManagers (NAME,EmployeeID,Address,Phone,Email,ManagerID,Department,Salary) AS 
(
SELECT d.*, e.`Department`,e.`Salary`
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
WHERE d.ManagerID = 3

UNION ALL 

SELECT d.*, e.`Department`,e.`Salary`
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
JOIN  employeesOnManagers m ON d.ManagerID = m.EmployeeID
)
SELECT *
FROM employeesOnManagers;

-- 2. Write a recursive CTE that, given an EmployeeID, shows the full chain of managers above them until the top.

-- Example Input: EmployeeID = 14
-- Expected Output: A list of all managers in their reporting chain, up to the CEO (who has NULL ManagerID).

WITH RECURSIVE managerChain (NAME,EmployeeID,Address,Phone,Email,ManagerID,Department,Salary) AS
(
SELECT d.*, e.`Department`,e.`Salary`
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
WHERE d.EmployeeID = 14

UNION 

SELECT d.*, e.`Department`,e.`Salary`
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
JOIN managerChain m ON d.EmployeeID = m.ManagerID
)
SELECT * 
FROM managerChain;

-- 3. Generate a list of all employees with their level in the hierarchy starting from the CEO (ManagerID IS NULL).

WITH RECURSIVE levels (NAME,EmployeeID,Address,Phone,Email,ManagerID,Department,Salary , lvl) AS
(
SELECT d.*, e.`Department`,e.`Salary`, 1 AS lvl
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
WHERE d.ManagerID IS NULL

UNION ALL

SELECT  d.*, e.`Department`,e.`Salary`, l.lvl+1 AS lvl
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
JOIN levels l ON d.ManagerID = l.EmployeeID
)

SELECT l.EmployeeID, l.NAME, l.ManagerID, l.lvl
FROM levels l
ORDER BY l.lvl, l.EmployeeID;

-- 4. Find Depth of the Deepest Hierarchy
-- Question:
-- Use a recursive CTE to find the maximum depth of the hierarchy in the company. That is, what's the longest path from the top manager (CEO) down to the lowest-level employee?

WITH RECURSIVE levels (NAME,EmployeeID,Address,Phone,Email,ManagerID,Department,Salary , lvl) AS
(
SELECT d.*, e.`Department`,e.`Salary`, 1 AS lvl
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
WHERE d.ManagerID IS NULL

UNION ALL

SELECT  d.*, e.`Department`,e.`Salary`, l.lvl+1 AS lvl
FROM `employees` e
JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
JOIN levels l ON d.ManagerID = l.EmployeeID
)

SELECT MAX(l.lvl) MaxDepth
FROM levels l
