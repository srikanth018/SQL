
# Task 4 - Multi-Table JOINs - SQL Task Execution

## **Objective**

The goal of this task is to demonstrate how to combine data from two related tables using various SQL JOIN operations, specifically **INNER JOIN** and **RIGHT JOIN**. This includes:

- Creating two related tables: `employee_details` and `employees`.
- Establishing a **foreign key** relationship between them.
- Executing **JOIN queries** to retrieve combined information like full names, email addresses, and phone numbers.

---

## **Steps to Execute the Task**

### Step 1: Create the Tables

#### **1.1 Create `employee_details` table**

```sql
CREATE TABLE employee_details (
  EmployeeID int(11) NOT NULL,
  Address varchar(255) DEFAULT NULL,
  Phone varchar(15) DEFAULT NULL,
  Email varchar(100) DEFAULT NULL,
  PRIMARY KEY (EmployeeID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### **1.2 Create `employees` table with foreign key**

```sql
CREATE TABLE employees (
  EmployeeID int(11) NOT NULL,
  FirstName varchar(50) DEFAULT NULL,
  LastName varchar(50) DEFAULT NULL,
  Department varchar(50) DEFAULT NULL,
  Salary decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (EmployeeID),
  CONSTRAINT employees_ibfk_1 FOREIGN KEY (EmployeeID) REFERENCES employee_details (EmployeeID) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

---

### Step 2: Insert Data

#### **2.1 Insert into `employee_details`**

```sql
INSERT INTO employee_details (EmployeeID, Address, Phone, Email) VALUES
(1, '123 Main St, Coimbatore', '9876543210', 'srikanth@gmail.com'),
(2, '456 Park Ave, Chennai', '9123456780', 'praveen@gmail.com'),
(3, '789 MG Road, Chennai', '9988776655', 'sankar@gmail.com'),
(4, '321 Lake View, Chennai', '9001122334', 'mouly@gmail.com'),
(5, '654 Green St, Salem', '9871234567', 'naveen@gmail.com'),
(6, '999 Beach Road, Pondicherry', '9009988776', 'hari@gmail.com');
```

#### **2.2 Insert into `employees`**

```sql
INSERT INTO employees (EmployeeID, FirstName, LastName, Department, Salary) VALUES
(1, 'Srikanth', 'M', 'Sales', 80000.00),
(2, 'Praveen', 'A', 'IT', 75000.00),
(3, 'Sankar', 'S', 'HR', 60000.00),
(4, 'Mouly', 'T', 'Sales', 58000.00),
(5, 'Naveen', 'N', 'IT', 72000.00);
```

---

###  Step 3: Execute JOIN Queries

#### **3.1 RIGHT JOIN Query**

```sql
SELECT emp.EmployeeID, CONCAT(emp.FirstName, ' ', emp.LastName) AS FullName, det.Email, det.Phone
FROM employees emp
RIGHT JOIN employee_details det ON emp.EmployeeID = det.EmployeeID;
```

#####  **Output:**

| EmployeeID | FullName         | Email              | Phone       |
|------------|------------------|--------------------|-------------|
| 1          | Srikanth M       | srikanth@gmail.com | 9876543210  |
| 2          | Praveen A        | praveen@gmail.com  | 9123456780  |
| 3          | Sankar S         | sankar@gmail.com   | 9988776655  |
| 4          | Mouly T          | mouly@gmail.com    | 9001122334  |
| 5          | Naveen N         | naveen@gmail.com   | 9871234567  |
| 6          | NULL             | hari@gmail.com     | 9009988776  |

 **Explanation:** The RIGHT JOIN returns all records from `employee_details` (right table), and matching records from `employees`. Since `EmployeeID = 6` is not present in `employees`, it returns NULL for `FullName`.

---

#### **3.2 INNER JOIN Query**

```sql
SELECT emp.EmployeeID, CONCAT(emp.FirstName, ' ', emp.LastName) AS FullName, det.Email, det.Phone
FROM employees emp
INNER JOIN employee_details det ON emp.EmployeeID = det.EmployeeID;
```

#####  **Output:**

| EmployeeID | FullName         | Email              | Phone       |
|------------|------------------|--------------------|-------------|
| 1          | Srikanth M       | srikanth@gmail.com | 9876543210  |
| 2          | Praveen A        | praveen@gmail.com  | 9123456780  |
| 3          | Sankar S         | sankar@gmail.com   | 9988776655  |
| 4          | Mouly T          | mouly@gmail.com    | 9001122334  |
| 5          | Naveen N         | naveen@gmail.com   | 9871234567  |

 **Explanation:** The INNER JOIN returns only the records where `EmployeeID` exists in both `employees` and `employee_details`. Hence, it excludes the unmatched record (EmployeeID 6).
