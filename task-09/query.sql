-- Stored Procedure Scenarios
-- 1. Create a stored procedure that accepts a department name as a parameter and returns all employees in that department along with their salary details, ordered by salary (highest to lowest).

Delimiter $$

create procedure DeptSalaryDetails(department varchar(50))
begin

select ed.Name, e.Department, e.Salary
from `employees` e
join `employee_details` ed on e.EmployeeID = ed.EmployeeID
where e.Department = department;

end $$

call DeptSalaryDetails("Sales")

-- 2. Create a stored procedure that accepts a date range (start_date and end_date) and returns the total sales (sum of TotalAmount) for orders placed within that range, along with order count.
Delimiter $$

create procedure ordersPlaced(startDate datetime, endDate datetime)
begin

select sum(TotalAmount) TotalSales , count(1) OrderCount
from orders
where OrderDate between startDate and endDate;

end $$

call ordersPlaced( "2025-03-05 00:00:00", "2025-03-28 00:00:00")

-- User Defined Functions
-- 1. Create a scalar function that calculates an employee's bonus based on their salary and whose salary is above 70000 and a performance multiplier. The bonus should be 10% of salary multiplied by the performance factor.


DELIMITER $$

CREATE Function bonus(Salary decimal(10,2), P_Factor int)
returns decimal(10,2)
BEGIN

declare v_bonus decimal(10,2);

if Salary >= 70000 then 
	set v_bonus = (Salary * (10/100))*P_Factor;
	return v_bonus;
else 
	return 0.00;
end if;

END $$


SELECT 
    Name, 
    Salary, 
    bonus(Salary, 1.5) AS PerformanceBonus 
FROM employees e
JOIN employee_details ed ON e.EmployeeID = ed.EmployeeID;