/*
E03 - Queries
*/

-- Exercise 1

SELECT c.customer_id, c.customer_fname, c.customer_lname, COUNT(*) AS num_orders FROM orders o
LEFT JOIN customers c ON o.order_customer_id = c.customer_id
WHERE o.order_date >= '20140101' AND o.order_date < '20140201'
GROUP BY o.order_customer_id, c.customer_id, c.customer_fname, c.customer_lname
ORDER BY num_orders DESC, c.customer_id;
GO

-- Exercise 2

SELECT c.* FROM customers c
WHERE c.customer_id NOT IN (
	SELECT c.customer_id FROM orders o
	LEFT JOIN customers c ON o.order_customer_id = c.customer_id
	WHERE MONTH(o.order_date) = 1 AND YEAR(o.order_date) = 2014
	GROUP BY c.customer_id
);
GO

-- Exercise 3

SELECT c.customer_id, c.customer_fname, c.customer_lname, 
	COALESCE(SUM(i.order_item_subtotal), 0) as customer_revenue 
	FROM order_items i
JOIN orders o ON i.order_item_order_id = o.order_id
	AND MONTH(o.order_date) = 1 AND YEAR(o.order_date) = 2014
	AND (o.order_status LIKE 'COMPLETED%' OR o.order_status LIKE 'CLOSED%')
RIGHT JOIN customers c ON o.order_customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_fname, c.customer_lname
ORDER BY customer_revenue DESC, c.customer_id;
GO

-- Exercise 4

SELECT c.*, SUM(i.order_item_subtotal) as category_revenue FROM categories c
JOIN products p ON c.category_id = p.product_category_id
JOIN order_items i ON i.order_item_product_id = p.product_id
JOIN orders o ON i.order_item_order_id = o.order_id 
	AND MONTH(o.order_date) = 1 AND YEAR(o.order_date) = 2014
	AND (o.order_status LIKE 'COMPLETED%' OR o.order_status LIKE 'CLOSED%')
GROUP BY c.category_id, c.category_department_id, c.category_name
ORDER BY c.category_id;
GO

-- Exercise 5
SELECT d.department_id, d.department_name, COUNT(*) AS product_count FROM products p
JOIN categories c ON p.product_category_id = c.category_id
JOIN departments d ON c.category_department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;
GO
