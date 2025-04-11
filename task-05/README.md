# Task 5: Subqueries and Nested Queries

**Objective:**

- Use subqueries to filter or compute values within a main query.

**Requirements:**

- Write a query that uses a subquery in the `WHERE` clause (e.g., select employees whose salary is above the department’s average salary).
- Alternatively, use subqueries in the `SELECT` list to compute dynamic columns.
- Understand the difference between correlated and non-correlated subqueries.



## Tasks Completed


### 1. Fetch employees whose salary is greater than or equal to the average salary of their department

**Query:**

```sql
SELECT det.Name, emp.Department, emp.`Salary` 
FROM `employee_details` det
JOIN `employees` emp ON det.EmployeeID = emp.`EmployeeID`
WHERE emp.`Salary` >= (
    SELECT AVG(Salary)
    FROM `employees`
    WHERE Department = emp.`Department`
);
```

**️ Output:**

| Name        | Department | Salary   |
|-------------|------------|----------|
| Srikanth M  | Sales      | 80000.00 |
| Mouly TN    | IT         | 75000.00 |
| Praveen A   | HR         | 60000.00 |

---

### 2. Report showing salary difference from department average and comparison flag

- The difference between the employee's salary and the average salary in their department

- A comparison flag that shows "Above Avg" if their salary is above the department average or "Below Avg" if it's below

**Query:**

```sql
SELECT 
    det.Name,
    emp.Department,
    (
        SELECT AVG(Salary)
        FROM `employees`
        WHERE Department = emp.Department
    ) AS Average,
    emp.Salary - (
        SELECT AVG(Salary)
        FROM `employees`
        WHERE Department = emp.`Department`
    ) AS SalaryDifference,
    CASE 
        WHEN emp.Salary > (
            SELECT AVG(Salary)
            FROM `employees`
            WHERE Department = emp.Department
        ) THEN 'Above Avg'
        ELSE 'Below Avg'
    END AS Flag
FROM `employee_details` det
JOIN `employees` emp ON det.EmployeeID = emp.`EmployeeID`;
```

**️ Output:**

| Name        | Department | Average     | SalaryDifference | Flag       |
|-------------|------------|-------------|------------------|------------|
| Srikanth M  | Sales      | 69000.000000 | 11000.000000     | Above Avg  |
| Mouly TN    | IT         | 73500.000000 | 1500.000000      | Above Avg  |
| Praveen A   | HR         | 60000.000000 | 0.000000         | Below Avg  |
| Sankar S    | Sales      | 69000.000000 | -11000.000000    | Below Avg  |
| Naveen N    | IT         | 73500.000000 | -1500.000000     | Below Avg  |

---

### 3. Contact list report with department stats
- The count of employees in their department

- The highest salary in their department

**Query:**

```sql
SELECT 
    det.Name,
    det.Phone,
    det.Email,
    emp.Department,
    (
        SELECT COUNT(Department) 
        FROM `employees` 
        WHERE emp.Department = Department
    ) AS DepartmentCount,
    (
        SELECT MAX(Salary) 
        FROM `employees` 
        WHERE emp.Department = Department
    ) AS DepartmentMaxSalary
FROM `employee_details` det
JOIN `employees` emp ON det.EmployeeID = emp.`EmployeeID`;
```

**Output:**

| Name        | Phone        | Email             | Department | DepartmentCount | DepartmentMaxSalary |
|-------------|--------------|-------------------|------------|------------------|----------------------|
| Srikanth M  | 9876543210   | srikanth@gmail.com | Sales      | 2                | 80000.00             |
| Mouly TN    | 9123456780   | praveen@gmail.com  | IT         | 2                | 75000.00             |
| Praveen A   | 9988776655   | sankar@gmail.com   | HR         | 1                | 60000.00             |
| Sankar S    | 9001122334   | mouly@gmail.com    | Sales      | 2                | 80000.00             |
| Naveen N    | 9871234567   | naveen@gmail.com   | IT         | 2                | 75000.00             |

---

### 4. Identify data inconsistency (employee in details but missing in main table)

**Query:**

```sql
SELECT det.Name
FROM `employee_details` det
WHERE NOT EXISTS (
    SELECT * FROM `employees` 
    WHERE EmployeeID = det.EmployeeID
);
```

**Output:**

| Name     |
|----------|
| Hari H   |
