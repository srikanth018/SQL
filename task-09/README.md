# Task 9: Stored Procedures and User-Defined Functions

## **Objective:**

- Encapsulate business logic using stored procedures and functions for modular, reusable, and efficient querying.

## **Requirements:**

-  Create a stored procedure that accepts parameters (e.g., a department or date range) and returns a result set.
-  Write a scalar user-defined function that performs a calculation (e.g., employee bonus based on salary and performance).
-  Demonstrate usage by calling procedures/functions and displaying their outputs.

---

##  1. Stored Procedure – Employees by Department

### **Task:**
> Create a stored procedure that accepts a department name as a parameter and returns all employees in that department along with their salary details, ordered by salary (highest to lowest).

### **Query:**

```sql
DELIMITER $$

CREATE PROCEDURE DeptSalaryDetails(department VARCHAR(50))
BEGIN
  SELECT ed.Name, e.Department, e.Salary
  FROM `employees` e
  JOIN `employee_details` ed ON e.EmployeeID = ed.EmployeeID
  WHERE e.Department = department;
END $$
```

### **Procedure Call:**
```sql
CALL DeptSalaryDetails("Sales");
```

### **Output:**

| Name        | Department | Salary   |
|-------------|------------|----------|
| Srikanth M  | Sales      | 80000.00 |
| Sankar S    | Sales      | 58000.00 |
| Arjun M     | Sales      | 81000.00 |
| Swathi B    | Sales      | 82000.00 |
| Lakshmi S   | Sales      | 85000.00 |
| Ayesha N    | Sales      | 79000.00 |
| Ritika D    | Sales      | 80000.00 |

---

##  2. Stored Procedure – Orders Within a Date Range

### **Task:**
> Create a stored procedure that accepts a date range (`start_date` and `end_date`) and returns the total sales (sum of `TotalAmount`) for orders placed within that range, along with order count.

### **Query:**

```sql
DELIMITER $$

CREATE PROCEDURE ordersPlaced(startDate DATETIME, endDate DATETIME)
BEGIN
  SELECT SUM(TotalAmount) AS TotalSales, COUNT(1) AS OrderCount
  FROM orders
  WHERE OrderDate BETWEEN startDate AND endDate;
END $$
```

### **Procedure Call:**
```sql
CALL ordersPlaced("2025-03-05 00:00:00", "2025-03-28 00:00:00");
```

### **Output:**

| TotalSales | OrderCount |
|------------|------------|
| 681.25     | 3          |

---

##  3. User-Defined Function – Employee Bonus

### **Task:**
> Create a scalar function that calculates an employee's bonus based on their salary and a performance multiplier. Bonus is `10% of salary * performance multiplier`, applied only if salary ≥ 70000.

### **Query:**

```sql
DELIMITER $$

CREATE FUNCTION bonus(Salary DECIMAL(10,2), P_Factor INT)
RETURNS DECIMAL(10,2)
BEGIN
  DECLARE v_bonus DECIMAL(10,2);

  IF Salary >= 70000 THEN 
    SET v_bonus = (Salary * 0.10) * P_Factor;
    RETURN v_bonus;
  ELSE 
    RETURN 0.00;
  END IF;
END $$
```

### **Function Usage:**
```sql
SELECT 
  Name, 
  Salary, 
  bonus(Salary, 1.5) AS PerformanceBonus 
FROM employees e
JOIN employee_details ed ON e.EmployeeID = ed.EmployeeID;
```

### **Output:**

| Name        | Salary   | PerformanceBonus |
|-------------|----------|------------------|
| Srikanth M  | 80000.00 | 16000.00         |
| Mouly TN    | 75000.00 | 15000.00         |
| Praveen A   | 60000.00 | 0.00             |
| Sankar S    | 58000.00 | 0.00             |
| Naveen N    | 72000.00 | 14400.00         |
| Divya R     | 77000.00 | 15400.00         |
| Arjun M     | 81000.00 | 16200.00         |
| Rekha K     | 59000.00 | 0.00             |
| Vinay P     | 63000.00 | 0.00             |
| Deepak L    | 70000.00 | 14000.00         |
| Swathi B    | 82000.00 | 16400.00         |
| Kiran J     | 64000.00 | 0.00             |
| Lakshmi S   | 85000.00 | 17000.00         |
| Rajiv B     | 73000.00 | 14600.00         |
| Ayesha N    | 79000.00 | 15800.00         |
| Manoj K     | 76000.00 | 15200.00         |
| Sneha P     | 61000.00 | 0.00             |
| Gokul V     | 78000.00 | 15600.00         |
| Ritika D    | 80000.00 | 16000.00         |
