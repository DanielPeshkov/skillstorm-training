-- Exercise 1
SELECT categories.category_name, COUNT(*) FROM products
JOIN categories ON categories.category_id = products.product_category_id
WHERE product_category_id IS NOT NULL
GROUP BY categories.category_name
HAVING COUNT(*) > 5;

-- Exercise 2
SELECT * FROM customers c
WHERE EXISTS (
	SELECT 1 FROM orders o
	WHERE o.order_customer_id = c.customer_id
	GROUP BY o.order_customer_id
	HAVING COUNT(*) > 10
);

-- Exercise 3
SELECT product_name, 
ROUND((SELECT AVG(product_price) FROM products), 2, 2) [average_price] 
FROM products;

-- Exercise 4
WITH a AS(
SELECT AVG(price) price
FROM (
	SELECT order_item_order_id, SUM(order_item_subtotal) AS price 
	FROM order_items
	GROUP BY order_item_order_id
) AS p
)

SELECT o.order_id, order_date, order_customer_id, order_status FROM orders o
JOIN order_items i ON o.order_id = i.order_item_order_id
CROSS JOIN a
GROUP BY order_id, order_date, order_customer_id, order_status, price
HAVING SUM(order_item_subtotal) > price;

-- Exercise 5
WITH best AS (
SELECT TOP 3 product_category_id id FROM products
GROUP BY product_category_id
ORDER BY COUNT(*) DESC
)

SELECT category_name FROM categories
JOIN best ON category_id = best.id;

-- Exercise 6
WITH t AS (
SELECT AVG(totals.total) price FROM (
SELECT customer_id, SUM(total) total FROM orders o
JOIN (SELECT order_item_order_id, SUM(order_item_subtotal) total 
		FROM order_items
		GROUP BY order_item_order_id) AS i 
	ON i.order_item_order_id = o.order_id
JOIN customers c ON c.customer_id = o.order_customer_id
GROUP BY customer_id) as totals)

SELECT customer_id, SUM(total) total FROM orders o
JOIN (SELECT order_item_order_id, SUM(order_item_subtotal) total 
		FROM order_items
		GROUP BY order_item_order_id) AS i 
	ON i.order_item_order_id = o.order_id
JOIN customers c ON c.customer_id = o.order_customer_id
CROSS JOIN t
GROUP BY customer_id, t.price
HAVING SUM(total) > price;
