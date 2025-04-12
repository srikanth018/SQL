# Task 7: Window Functions and Ranking

## Objective
Leverage window functions to perform calculations across a set of rows.

## Requirements

1. Use ranking functions (`ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`)
2. Utilize `PARTITION BY` to define groups
3. Apply `ORDER BY` to specify ranking order
4. Experiment with other window functions like `LEAD()` and `LAG()`

## SQL Queries and Outputs

### 1. Max salary within each department
```sql
SELECT d.Name, e.Department, e.Salary, 
       MAX(e.`Salary`) OVER(PARTITION BY e.Department) Max_Salary
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`;
```

**Output:**
```
Name        Department  Salary    Max_Salary
Sneha P     HR          61000.00  64000.00
Rekha K     HR          59000.00  64000.00
Kiran J     HR          64000.00  64000.00
Vinay P     HR          63000.00  64000.00
Praveen A   HR          60000.00  64000.00
Rajiv B     IT          73000.00  78000.00
Naveen N    IT          72000.00  78000.00
Mouly TN    IT          75000.00  78000.00
Manoj K     IT          76000.00  78000.00
Deepak L    IT          70000.00  78000.00
Gokul V     IT          78000.00  78000.00
Divya R     IT          77000.00  78000.00
Swathi B    Sales       82000.00  85000.00
Ritika D    Sales       80000.00  85000.00
Lakshmi S   Sales       85000.00  85000.00
Arjun M     Sales       81000.00  85000.00
Sankar S    Sales       58000.00  85000.00
Srikanth M  Sales       80000.00  85000.00
Ayesha N    Sales       79000.00  85000.00
```

### 2. Rank employees by salary within each department
```sql
SELECT d.Name, e.Department, e.Salary, 
       Rank() OVER(PARTITION BY e.Department ORDER BY e.Salary DESC) rnk
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`;
```

**Output:**
```
Name        Department  Salary    rnk
Kiran J     HR          64000.00  1
Vinay P     HR          63000.00  2
Sneha P     HR          61000.00  3
Praveen A   HR          60000.00  4
Rekha K     HR          59000.00  5
Gokul V     IT          78000.00  1
Divya R     IT          77000.00  2
Manoj K     IT          76000.00  3
Mouly TN    IT          75000.00  4
Rajiv B     IT          73000.00  5
Naveen N    IT          72000.00  6
Deepak L    IT          70000.00  7
Lakshmi S   Sales       85000.00  1
Swathi B    Sales       82000.00  2
Arjun M     Sales       81000.00  3
Ritika D    Sales       80000.00  4
Srikanth M  Sales       80000.00  4
Ayesha N    Sales       79000.00  6
Sankar S    Sales       58000.00  7
```

### 3. Find the top 3 highest-paid employees in each department
```sql
SELECT * 
FROM (
  SELECT d.Name, e.Department, e.Salary, 
         DENSE_RANK() OVER(PARTITION BY e.Department ORDER BY e.Salary DESC) rnk
  FROM `employee_details` d
  JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`
) ran
WHERE ran.rnk < 4;
```

**Output:**
```
Name        Department  Salary    rnk
Kiran J     HR          64000.00  1
Vinay P     HR          63000.00  2
Sneha P     HR          61000.00  3
Gokul V     IT          78000.00  1
Divya R     IT          77000.00  2
Manoj K     IT          76000.00  3
Lakshmi S   Sales       85000.00  1
Swathi B    Sales       82000.00  2
Arjun M     Sales       81000.00  3
```

### 4. Employees whose salary is greater than the department's average salary
```sql
SELECT avg_table.* 
FROM (
  SELECT d.Name, e.Department, e.Salary, 
         Avg(e.Salary) OVER(PARTITION BY e.Department) average
  FROM `employee_details` d
  JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`
) avg_table
WHERE avg_table.Salary > avg_table.average;
```

**Output:**
```
Name        Department  Salary    average
Kiran J     HR          64000.00  61400.000000
Vinay P     HR          63000.00  61400.000000
Mouly TN    IT          75000.00  74428.571429
Manoj K     IT          76000.00  74428.571429
Gokul V     IT          78000.00  74428.571429
Divya R     IT          77000.00  74428.571429
Swathi B    Sales       82000.00  77857.142857
Ritika D    Sales       80000.00  77857.142857
Lakshmi S   Sales       85000.00  77857.142857
Arjun M     Sales       81000.00  77857.142857
Srikanth M  Sales       80000.00  77857.142857
Ayesha N    Sales       79000.00  77857.142857
```

### 5. Calculate cumulative salary per department (running total)
```sql
SELECT d.Name, e.Department, e.Salary, 
       SUM(e.Salary) OVER(PARTITION BY e.Department ORDER BY e.`EmployeeID` DESC) TotalSalary
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`;
```

**Output:**
```
Name        Department  Salary    TotalSalary
Sneha P     HR          61000.00  61000.00
Kiran J     HR          64000.00  125000.00
Vinay P     HR          63000.00  188000.00
Rekha K     HR          59000.00  247000.00
Praveen A   HR          60000.00  307000.00
Gokul V     IT          78000.00  78000.00
Manoj K     IT          76000.00  154000.00
Rajiv B     IT          73000.00  227000.00
Deepak L    IT          70000.00  297000.00
Divya R     IT          77000.00  374000.00
Naveen N    IT          72000.00  446000.00
Mouly TN    IT          75000.00  521000.00
Ritika D    Sales       80000.00  80000.00
Ayesha N    Sales       79000.00  159000.00
Lakshmi S   Sales       85000.00  244000.00
Swathi B    Sales       82000.00  326000.00
Arjun M     Sales       81000.00  407000.00
Sankar S    Sales       58000.00  465000.00
Srikanth M  Sales       80000.00  545000.00
```

### 6. Salary difference with next highest-paid in department
```sql
SELECT d.Name, e.Department, e.Salary, 
       LEAD(e.Salary) OVER(PARTITION BY e.Department ORDER BY e.`Salary` DESC) NextHighest,
       e.Salary - LEAD(e.Salary) OVER(PARTITION BY e.Department ORDER BY e.`Salary` DESC) SalaryDifference
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`;
```

**Output:**
```
Name        Department  Salary    NextHighest  SalaryDifference
Kiran J     HR          64000.00  63000.00     1000.00
Vinay P     HR          63000.00  61000.00     2000.00
Sneha P     HR          61000.00  60000.00     1000.00
Praveen A   HR          60000.00  59000.00     1000.00
Rekha K     HR          59000.00  NULL         NULL
Gokul V     IT          78000.00  77000.00     1000.00
Divya R     IT          77000.00  76000.00     1000.00
Manoj K     IT          76000.00  75000.00     1000.00
Mouly TN    IT          75000.00  73000.00     2000.00
Rajiv B     IT          73000.00  72000.00     1000.00
Naveen N    IT          72000.00  70000.00     2000.00
Deepak L    IT          70000.00  NULL         NULL
Lakshmi S   Sales       85000.00  82000.00     3000.00
Swathi B    Sales       82000.00  81000.00     1000.00
Arjun M     Sales       81000.00  80000.00     1000.00
Ritika D    Sales       80000.00  80000.00     0.00
Srikanth M  Sales       80000.00  79000.00     1000.00
Ayesha N    Sales       79000.00  58000.00     21000.00
Sankar S    Sales       58000.00  NULL         NULL
```

### 7. Compare with previous employee's salary in department
```sql
SELECT d.Name, e.Department, e.Salary, 
       IFNULL(LAG(e.Salary) OVER(PARTITION BY e.Department ORDER BY e.`Salary` DESC), 0) Previous
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`;
```

**Output:**
```
Name        Department  Salary    Previous
Kiran J     HR          64000.00  0.00
Vinay P     HR          63000.00  64000.00
Sneha P     HR          61000.00  63000.00
Praveen A   HR          60000.00  61000.00
Rekha K     HR          59000.00  60000.00
Gokul V     IT          78000.00  0.00
Divya R     IT          77000.00  78000.00
Manoj K     IT          76000.00  77000.00
Mouly TN    IT          75000.00  76000.00
Rajiv B     IT          73000.00  75000.00
Naveen N    IT          72000.00  73000.00
Deepak L    IT          70000.00  72000.00
Lakshmi S   Sales       85000.00  0.00
Swathi B    Sales       82000.00  85000.00
Arjun M     Sales       81000.00  82000.00
Srikanth M  Sales       80000.00  81000.00
Ritika D    Sales       80000.00  80000.00
Ayesha N    Sales       79000.00  80000.00
Sankar S    Sales       58000.00  79000.00
```

### 8. Divide employees into 4 salary quartiles
```sql
SELECT d.Name, e.Department, e.Salary, 
       NTILE(4) OVER(ORDER BY e.`Salary` DESC) quartiles 
FROM `employee_details` d
JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`;
```

**Output:**
```
Name        Department  Salary    quartiles
Lakshmi S   Sales       85000.00  1
Swathi B    Sales       82000.00  1
Arjun M     Sales       81000.00  1
Ritika D    Sales       80000.00  1
Srikanth M  Sales       80000.00  1
Ayesha N    Sales       79000.00  2
Gokul V     IT          78000.00  2
Divya R     IT          77000.00  2
Manoj K     IT          76000.00  2
Mouly TN    IT          75000.00  2
Rajiv B     IT          73000.00  3
Naveen N    IT          72000.00  3
Deepak L    IT          70000.00  3
Kiran J     HR          64000.00  3
Vinay P     HR          63000.00  3
Sneha P     HR          61000.00  4
Praveen A   HR          60000.00  4
Rekha K     HR          59000.00  4
Sankar S    Sales       58000.00  4
```

### 9. Paginate employees by salary (page 2 of 5 employees per page)
```sql
SELECT rowNumTable.*
FROM (
  SELECT d.Name, e.Department, e.Salary, 
         ROW_NUMBER() OVER(ORDER BY e.`Salary` DESC) AS RowNum
  FROM `employee_details` d
  JOIN `employees` e ON e.`EmployeeID` = d.`EmployeeID`
) AS rowNumTable
WHERE rowNumTable.RowNum BETWEEN 6 AND 10;
```

**Output:**
```
Name        Department  Salary    RowNum
Ayesha N    Sales       79000.00  6
Gokul V     IT          78000.00  7
Divya R     IT          77000.00  8
Manoj K     IT          76000.00  9
Mouly TN    IT          75000.00  10
```