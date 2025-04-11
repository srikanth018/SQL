
# Task 3: Simple Aggregation and Grouping

### **Objective:**

- Summarize data using aggregate functions and grouping.

### **Requirements:**

- Write a query that uses aggregate functions such as `COUNT()`, `SUM()`, or `AVG()` to calculate totals or averages.
- Use the `GROUP BY` clause to aggregate data by a specific column (e.g., count the number of employees per department).
- Optionally, filter grouped results using the `HAVING` clause.

## Execution


```sql
SELECT Department, COUNT(EmployeeID) AS no_of_employees
FROM `employees`
WHERE Salary > 70000
GROUP BY Department;
```

### Output:

| Department | no_of_employees |
|------------|------------------|
| IT         | 1                |
| Sales      | 1                |

---


```sql
SELECT Department, SUM(Salary) AS Total_salary
FROM `employees`
GROUP BY Department
HAVING COUNT(Department) > 1;
```

### Output:

| Department | Total_salary |
|------------|---------------|
| IT         | 147000.00     |
| Sales      | 138000.00     |

---


```sql
SELECT Department, AVG(Salary) AS Average_salary
FROM `employees`
GROUP BY Department;
```

### Output:

| Department | Average_salary |
|------------|-----------------|
| HR         | 60000.00        |
| IT         | 73500.00        |
| Sales      | 69000.00        |

---