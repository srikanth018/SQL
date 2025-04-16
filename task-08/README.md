
# Task 8: CTE and Recursive Queries 

#### **Objective**

- Simplify complex queries and process hierarchical data using CTEs.

#### **Requirements**

- Write a non-recursive CTE to structure a multi-step query for readability (e.g., breaking down a complex aggregation).
- Create a recursive CTE to display hierarchical data (e.g., an organizational chart or a category tree).
- Ensure proper termination of the recursive CTE to avoid infinite loops.

---

## **1. Non-Recursive CTE Scenarios**

### **1. Write a CTE that first filters out employees earning less than 50,000, then calculates the average salary per department.**

```sql
WITH less_Salary (Name, EmployeeID, Address, Phone, Email, ManagerID, Department, Salary) AS (
  SELECT d.*, e.`Department`, e.`Salary`
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
  WHERE e.`Salary` >= 70000
)
SELECT s.Department,
       AVG(s.Salary) AS Average
FROM less_Salary s
GROUP BY s.Department;
```

**Output:**

| Department | Average        |
|------------|----------------|
| IT         | 74428.571429   |
| Sales      | 81166.666667   |

---

### **2. Use a CTE to rank employees by salary within their department and return the top 3 earners per department.**

```sql
WITH rank_table (NAME, EmployeeID, Address, Phone, Email, ManagerID, Department, Salary, rnk) AS (
  SELECT d.*, e.`Department`, e.`Salary`,
         DENSE_RANK() OVER (PARTITION BY e.`Department` ORDER BY e.`Salary`) rnk
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
)
SELECT NAME, Department, `Salary`, rnk
FROM rank_table
WHERE rnk < 4;
```

**Output:**

| NAME        | Department | Salary   | rnk |
|-------------|------------|----------|-----|
| Rekha K     | HR         | 59000.00 | 1   |
| Praveen A   | HR         | 60000.00 | 2   |
| Sneha P     | HR         | 61000.00 | 3   |
| Deepak L    | IT         | 70000.00 | 1   |
| Naveen N    | IT         | 72000.00 | 2   |
| Rajiv B     | IT         | 73000.00 | 3   |
| Sankar S    | Sales      | 58000.00 | 1   |
| Ayesha N    | Sales      | 79000.00 | 2   |
| Ritika D    | Sales      | 80000.00 | 3   |
| Srikanth M  | Sales      | 80000.00 | 3   |

---

### **3. Create a CTE to get the number of direct reports for each manager.**

```sql
WITH managerCount (ManagerID, countbyID) AS (
  SELECT d.ManagerID, COUNT(d.EmployeeID) countbyID
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.ManagerID 
  GROUP BY d.ManagerID
)
SELECT m.ManagerID, d.Name, m.countbyID
FROM employee_details d
JOIN managerCount m ON d.EmployeeID = m.ManagerID;
```

**Output:**

| ManagerID | Name         | countbyID |
|-----------|--------------|-----------|
| 1         | Srikanth M   | 3         |
| 2         | Mouly TN     | 2         |
| 3         | Praveen A    | 3         |
| 4         | Sankar S     | 2         |
| 8         | Arjun M      | 2         |
| 10        | Vinay P      | 2         |
| 14        | Lakshmi S    | 5         |

---

## **2. Recursive CTE Scenarios (Hierarchical Queries)**

### **1. Given a manager's EmployeeID, write a recursive CTE to return all employees (direct and indirect) reporting to them.**

**Example Input:** `ManagerID = 3`

```sql
WITH RECURSIVE employeesOnManagers (NAME, EmployeeID, Address, Phone, Email, ManagerID, Department, Salary) AS (
  SELECT d.*, e.`Department`, e.`Salary`
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
  WHERE d.ManagerID = 3

  UNION ALL

  SELECT d.*, e.`Department`, e.`Salary`
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
  JOIN employeesOnManagers m ON d.ManagerID = m.EmployeeID
)
SELECT *
FROM employeesOnManagers;
```

**Output:**

| NAME      | EmployeeID | Address                  | Phone        | Email              | ManagerID | Department | Salary   |
|-----------|------------|--------------------------|--------------|--------------------|-----------|------------|----------|
| Divya R   | 7          | 100 Lake Road, Bangalore | 9112233445   | divya@gmail.com    | 3         | IT         | 77000.00 |
| Arjun M   | 8          | 200 Ring Road, Hyderabad | 9003322110   | arjun@gmail.com    | 3         | Sales      | 81000.00 |
| Rekha K   | 9          | 305 Cross St, Madurai    | 8887766554   | rekha@gmail.com    | 3         | HR         | 59000.00 |
| Lakshmi S | 14         | 77 Rose Park, Bangalore  | 9321456790   | lakshmis@gmail.com | 8         | Sales      | 85000.00 |
| Rajiv B   | 15         | 404 Blue Hill, Hyderabad | 9898123456   | rajivb@gmail.com   | 8         | IT         | 73000.00 |
| Ayesha N  | 16         | 333 Jasmine Rd, Coimbatore | 9123789456 | ayesha@gmail.com   | 14        | Sales      | 79000.00 |
| Manoj K   | 17         | 909 Ashok Nagar, Chennai | 9876541230   | manojk@gmail.com   | 14        | IT         | 76000.00 |
| Sneha P   | 18         | 221 Lotus Street, Salem  | 9567456321   | sneha@gmail.com    | 14        | HR         | 61000.00 |
| Gokul V   | 19         | 888 Westend, Madurai     | 9345678901   | gokulv@gmail.com   | 14        | IT         | 78000.00 |
| Ritika D  | 20         | 101 City Center, Pondicherry | 9445566123 | ritikad@gmail.com | 14        | Sales      | 80000.00 |

---

### **2. Write a recursive CTE that, given an EmployeeID, shows the full chain of managers above them until the top.**

**Example Input:** `EmployeeID = 14`

```sql
WITH RECURSIVE managerChain (NAME, EmployeeID, Address, Phone, Email, ManagerID, Department, Salary) AS (
  SELECT d.*, e.`Department`, e.`Salary`
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
  WHERE d.EmployeeID = 14

  UNION 

  SELECT d.*, e.`Department`, e.`Salary`
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
  JOIN managerChain m ON d.EmployeeID = m.ManagerID
)
SELECT * 
FROM managerChain;
```

**Output:**

| NAME        | EmployeeID | Address                  | Phone        | Email              | ManagerID | Department | Salary   |
|-------------|------------|--------------------------|--------------|--------------------|-----------|------------|----------|
| Lakshmi S   | 14         | 77 Rose Park, Bangalore  | 9321456790   | lakshmis@gmail.com | 8         | Sales      | 85000.00 |
| Arjun M     | 8          | 200 Ring Road, Hyderabad | 9003322110   | arjun@gmail.com    | 3         | Sales      | 81000.00 |
| Praveen A   | 3          | 789 MG Road, Chennai     | 9988776655   | sankar@gmail.com   | 1         | HR         | 60000.00 |
| Srikanth M  | 1          | 123 Main St, Coimbatore  | 9876543210   | srikanth@gmail.com | NULL      | Sales      | 80000.00 |

---

### **3. Generate a list of all employees with their level in the hierarchy starting from the CEO (ManagerID IS NULL).**

```sql
WITH RECURSIVE levels (NAME, EmployeeID, Address, Phone, Email, ManagerID, Department, Salary, lvl) AS (
  SELECT d.*, e.`Department`, e.`Salary`, 1 AS lvl
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
  WHERE d.ManagerID IS NULL

  UNION ALL

  SELECT d.*, e.`Department`, e.`Salary`, l.lvl + 1
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
  JOIN levels l ON d.ManagerID = l.EmployeeID
)
SELECT l.EmployeeID, l.NAME, l.ManagerID, l.lvl
FROM levels l
ORDER BY l.lvl, l.EmployeeID;
```

**Output:**

| EmployeeID | NAME        | ManagerID | lvl |
|------------|-------------|-----------|------|
| 1          | Srikanth M  | NULL      | 1    |
| 2          | Mouly TN    | 1         | 2    |
| 3          | Praveen A   | 1         | 2    |
| 4          | Sankar S    | 1         | 2    |
| 5          | Naveen N    | 2         | 3    |
| 7          | Divya R     | 3         | 3    |
| 8          | Arjun M     | 3         | 3    |
| 9          | Rekha K     | 3         | 3    |
| 10         | Vinay P     | 4         | 3    |
| 11         | Deepak L    | 4         | 3    |
| 12         | Swathi B    | 10        | 4    |
| 13         | Kiran J     | 10        | 4    |
| 14         | Lakshmi S   | 8         | 4    |
| 15         | Rajiv B     | 8         | 4    |
| 16         | Ayesha N    | 14        | 5    |
| 17         | Manoj K     | 14        | 5    |
| 18         | Sneha P     | 14        | 5    |
| 19         | Gokul V     | 14        | 5    |
| 20         | Ritika D    | 14        | 5    |

---

### **4. Use a recursive CTE to find the maximum depth of the hierarchy in the company.**

```sql
WITH RECURSIVE levels (NAME, EmployeeID, Address, Phone, Email, ManagerID, Department, Salary, lvl) AS (
  SELECT d.*, e.`Department`, e.`Salary`, 1 AS lvl
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
  WHERE d.ManagerID IS NULL

  UNION ALL

  SELECT d.*, e.`Department`, e.`Salary`, l.lvl + 1
  FROM `employees` e
  JOIN `employee_details` d ON e.EmployeeID = d.EmployeeID 
  JOIN levels l ON d.ManagerID = l.EmployeeID
)
SELECT MAX(l.lvl) MaxDepth
FROM levels l;
```

**Output:**

| MaxDepth |
|----------|
| 5        |