/*
Basic Queries
*/
-- 1
SELECT * FROM production.Product;

-- 2
SELECT FirstName, LastName, JobTitle FROM HumanResources.vEmployee;

-- 3
SELECT * FROM Sales.SalesOrderHeader
WHERE CustomerID = 29825;

-- 4
SELECT CustomerID, SUM(TotalDue) TotalDue FROM Sales.SalesOrderHeader
GROUP BY CustomerID;

-- 5
SELECT * FROM Purchasing.vVendorWithContacts;

-- 6
SELECT c.Name, s.Name FROM Production.ProductSubcategory s
JOIN Production.ProductCategory c ON c.ProductCategoryID = s.ProductCategoryID;

-- 7
SELECT * FROM Production.Product
WHERE DiscontinuedDate IS NOT NULL;

-- 8
SELECT ProductID, SUM(OrderQty) Total FROM Sales.SalesOrderDetail
GROUP BY ProductID;


/*
Challenging Queries
*/
-- 1 
SELECT FORMAT([Emp.StartDate], 'yyyy') [Year], 
	COUNT(*) [Hires] 
FROM HumanResources.vJobCandidateEmployment
GROUP BY FORMAT([Emp.StartDate], 'yyyy')
ORDER BY FORMAT([Emp.StartDate], 'yyyy');

-- 2
SELECT ProductID, AVG(LineTotal) AvgOrderAmt FROM Sales.SalesOrderDetail
GROUP BY ProductID;

-- 3
WITH t AS (
SELECT FORMAT(OrderDate, 'yyyy-MM') [Month], SUM(TotalDue) Total
FROM Sales.SalesOrderHeader
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
)

SELECT TOP 1 * FROM t
ORDER BY Total DESC;

