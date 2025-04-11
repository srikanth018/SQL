
# Task 6: Date and Time Functions

**Objective**

The goal of this task was to understand and use SQL **date and time functions** effectively for querying and manipulating temporal data.


**Requirements**

- Use built-in date functions like `DATEDIFF`, `DATE_ADD`, `DATE_FORMAT`, etc.
- Filter records based on relative date ranges.
- Format date output for user-friendly display.
- Perform logical operations involving days, weeks, and processing times.


## ️ Setup

**Table Created:**

```sql
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATETIME,
    ShipDate DATETIME,
    TotalAmount DECIMAL(10, 2)
);
```

**Sample Data Inserted:**

```sql
INSERT INTO Orders (OrderID, CustomerName, OrderDate, ShipDate, TotalAmount)
VALUES
(1, 'Srikanth', '2025-03-05 10:15:00', '2025-03-07 14:00:00', 120.50),
(2, 'Mouly', '2025-03-15 08:45:00', '2025-03-18 13:30:00', 250.00),
(3, 'Praveen', '2025-03-25 16:00:00', '2025-03-28 11:45:00', 310.75),
(4, 'Sankar', '2025-04-01 09:20:00', '2025-04-03 15:10:00', 95.00),
(5, 'Naveen', '2025-04-05 12:00:00', '2025-04-08 17:00:00', 180.20),
(6, 'Dhanush', '2025-04-10 14:30:00', '2025-04-12 10:15:00', 275.90);
```

---

## Queries & Outputs

### 1. Calculate number of days taken to ship each order

**Query:**

```sql
SELECT CustomerName, DATEDIFF(ShipDate, OrderDate) AS DaysToShip 
FROM `orders`;
```

**Output:**

| CustomerName | DaysToShip |
|--------------|------------|
| Srikanth     | 2          |
| Mouly        | 3          |
| Praveen      | 3          |
| Sankar       | 2          |
| Naveen       | 3          |
| Dhanush      | 2          |

---

### 2. Retrieve orders placed in the last 30 days

**Query:**

```sql
SELECT *, DATE(NOW()) - DATE(OrderDate) AS Days
FROM `orders`
WHERE DATE(NOW()) - DATE(OrderDate) <= 30;
```

**Output:**

| OrderID | CustomerName | OrderDate           | ShipDate           | TotalAmount | Days |
|---------|--------------|---------------------|--------------------|-------------|------|
| 4       | Sankar       | 2025-04-01 09:20:00 | 2025-04-03 15:10:00| 95.00       | 10   |
| 5       | Naveen       | 2025-04-05 12:00:00 | 2025-04-08 17:00:00| 180.20      | 6    |
| 6       | Dhanush      | 2025-04-10 14:30:00 | 2025-04-12 10:15:00| 275.90      | 1    |

---

### 3. Format order and ship dates as `DD/MM/YY` and `DD-MM-YY`

**Query:**

```sql
SELECT 
    DATE_FORMAT(OrderDate, '%d/%m/%y') AS OrderDate, 
    DATE_FORMAT(ShipDate, '%d-%m-%y') AS ShipDate
FROM `orders`;
```

**Output:**

| OrderDate | ShipDate  |
|-----------|-----------|
| 05/03/25  | 07-03-25  |
| 15/03/25  | 18-03-25  |
| 25/03/25  | 28-03-25  |
| 01/04/25  | 03-04-25  |
| 05/04/25  | 08-04-25  |
| 10/04/25  | 12-04-25  |

---

### 4. List orders placed on a **Saturday or Sunday**

**Query:**

```sql
SELECT *
FROM `orders`
WHERE DAYOFWEEK(OrderDate) = 1 OR DAYOFWEEK(OrderDate) = 7;
```

**Output:**

| OrderID | CustomerName | OrderDate           | ShipDate           | TotalAmount |
|---------|--------------|---------------------|--------------------|-------------|
| 2       | Mouly        | 2025-03-15 08:45:00 | 2025-03-18 13:30:00| 250.00      |
| 5       | Naveen       | 2025-04-05 12:00:00 | 2025-04-08 17:00:00| 180.20      |

---

### 5. Calculate expected ship date assuming 2 business days processing time

**Query:**

```sql
SELECT DATE(DATE_ADD(OrderDate, INTERVAL 2 DAY)) AS Shipdate
FROM `orders`;
```

**Output:**

| Shipdate   |
|------------|
| 2025-03-07 |
| 2025-03-17 |
| 2025-03-27 |
| 2025-04-03 |
| 2025-04-07 |
| 2025-04-12 |

---

## Learnings

- Learned to use `DATEDIFF()` to measure days between two dates.
- Practiced using `DATE()` and `NOW()` to filter recent records.
- Utilized `DATE_FORMAT()` for user-friendly date display.
- Applied `DAYOFWEEK()` to identify weekend dates.
- Used `DATE_ADD()` to project future dates based on business logic.
