-- ---------------------------------------------------------
-- Project: Quantigration Sales & RMA Analysis
-- Author: Erwing Augustin
-- ---------------------------------------------------------

-- 1. Identify the largest customer base by State
SELECT State, COUNT(CustomerID) AS CustomerCount 
FROM Customers 
GROUP BY State 
ORDER BY CustomerCount DESC;

-- 2. Top 3 products sold in the United States
SELECT o.SKU, o.Description, COUNT(*) AS ProductCount 
FROM Orders o 
JOIN Customers c ON o.CustomerID = c.CustomerID 
WHERE c.State IS NOT NULL 
GROUP BY o.SKU, o.Description 
ORDER BY ProductCount DESC 
LIMIT 3;

-- 3. Analyze regional returns to pinpoint quality concerns
SELECT c.State, COUNT(r.RMAID) AS number_of_returns 
FROM RMA r 
JOIN Orders o ON r.OrderID = o.OrderID 
JOIN Customers c ON o.CustomerID = c.CustomerID 
GROUP BY c.State 
ORDER BY number_of_returns DESC;

-- 4. Data Security: Creating a view to mask sensitive info
CREATE VIEW Collaborator AS 
SELECT CustomerID AS CollaboratorID, FirstName, LastName, City, State 
FROM Customers;
