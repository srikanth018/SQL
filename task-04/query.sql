SELECT emp.`EmployeeID`, CONCAT(emp.FirstName, ' ', emp.LastName) AS FullName, det.Email, det.Phone
FROM `employees` emp
RIGHT JOIN `employee_details` det ON emp.`EmployeeID` = det.`EmployeeID`



SELECT emp.`EmployeeID`, CONCAT(emp.FirstName, ' ', emp.LastName) AS FullName, det.Email, det.Phone
FROM `employees` emp
INNER JOIN `employee_details` det ON emp.`EmployeeID` = det.`EmployeeID`
