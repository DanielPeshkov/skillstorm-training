-- Exercise 1
WITH s AS (
SELECT CAST(AVG(e.salary) AS NUMERIC(10,2)) avg_salary_expense, 
	d.department_id FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id
)

SELECT e.employee_id, d.department_name, e.salary, s.avg_salary_expense FROM departments d
JOIN s ON s.department_id = d.department_id
JOIN employees e ON e.department_id = d.department_id
WHERE salary > avg_salary_expense
ORDER BY d.department_id, e.salary DESC;

-- Exercise 2
SELECT e.employee_id, d.department_name, e.salary, 
	sum(e.salary) over 
	( partition by d.department_id ORDER BY e.salary ) cum_salary_expense
FROM departments d
JOIN employees e ON e.department_id = d.department_id
WHERE d.department_name = 'Finance' or d.department_name = 'IT'
ORDER BY d.department_name, e.salary;

-- Exercise 3
WITH r AS (
SELECT e.employee_id, e.department_id, d.department_name, e.salary, 
	DENSE_RANK() over (partition by e.department_id ORDER BY e.salary DESC) AS employee_rank
FROM employees e
JOIN departments d ON d.department_id = e.department_id
)

SELECT * FROM r
WHERE r.employee_rank < 4;

-- Exercise 4
WITH r AS (
SELECT product_id, product_name, 
	CAST(SUM(order_item_subtotal) AS DECIMAL(8, 2)) revenue
FROM products p
JOIN order_items i ON i.order_item_product_id = p.product_id
JOIN orders o ON o.order_id = i.order_item_order_id
WHERE o.order_date >= '20140101' AND o.order_date < '20140201'
AND (order_status = 'COMPLETE' OR order_status = 'CLOSED')
GROUP BY product_id, product_name
)
SELECT TOP 3 *, 
	RANK() OVER (ORDER BY revenue DESC) product_rank
FROM r;

-- Exercise 5
WITH r AS (
Select product_category_id, product_id, product_name, SUM(order_item_subtotal) revenue FROM products p
JOIN order_items i ON i.order_item_product_id = p.product_id
JOIN orders o ON o.order_id = i.order_item_order_id AND o.order_date BETWEEN '20140101' AND '20140131'
AND order_status IN ('Complete', 'Closed')
WHERE product_category_id = 9 OR product_category_id = 10
GROUP BY product_category_id, product_id, product_name
)

SELECT c.category_id, category_name, product_id, product_name, revenue, 
	RANK() OVER (PARTITION BY category_id ORDER BY revenue DESC) product_rank
FROM r
JOIN categories c ON r.product_category_id = c.category_id;
