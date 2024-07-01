/*
Join then Aggregate
*/
SELECT c.customer_id, c.customer_fname, c.customer_lname, 
	COALESCE(SUM(i.order_item_subtotal), 0) as customer_revenue 
	FROM order_items i
JOIN orders o ON i.order_item_order_id = o.order_id
	AND MONTH(o.order_date) = 1 AND YEAR(o.order_date) = 2014
	AND (o.order_status LIKE 'CO%' OR o.order_status LIKE 'CL%')
RIGHT JOIN customers c ON o.order_customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_fname, c.customer_lname
ORDER BY customer_revenue DESC, c.customer_id;
GO

/*
Aggregate then Join
*/
SELECT c.customer_id, c.customer_fname, c.customer_lname, o.customer_revenue
FROM customers c
JOIN (SELECT COALESCE(SUM(i.order_revenue), 0) as customer_revenue, order_customer_id 
	FROM orders
	JOIN (SELECT COALESCE(SUM(order_item_subtotal), 0) as order_revenue, order_item_order_id
		FROM order_items
		GROUP BY order_item_order_id) i ON i.order_item_order_id = order_id
	WHERE MONTH(order_date) = 1 AND YEAR(order_date) = 2014
	AND (order_status LIKE 'CO%' OR order_status LIKE 'CL%')
	GROUP BY order_customer_id) o ON o.order_customer_id = c.customer_id
ORDER BY o.customer_revenue DESC, c.customer_id;

