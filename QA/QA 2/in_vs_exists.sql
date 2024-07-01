/*
In vs Exists
*/

DECLARE @start DATETIME = GETDATE()
-- Start of Block to be measured

SELECT c.* FROM customers c WHERE NOT EXISTS (
SELECT 1 FROM orders o
WHERE o.order_customer_id = c.customer_id 
AND o.order_date >= '20140101' AND o.order_date < '20140201');

-- End of Block to be measured
SELECT DATEDIFF(ms,@start,GETDATE()) [Runtime (ms)]
GO

DECLARE @start DATETIME = GETDATE()
-- Start of Block to be measured

SELECT c.* FROM customers c
WHERE c.customer_id NOT IN (
	SELECT c.customer_id FROM orders o
	LEFT JOIN customers c ON o.order_customer_id = c.customer_id
	WHERE o.order_date >= '20140101' AND o.order_date < '20140201'
	GROUP BY c.customer_id
);

-- End of Block to be measured
SELECT DATEDIFF(ms,@start,GETDATE()) [Runtime (ms)]
GO