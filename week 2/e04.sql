-- Exercise 1
SELECT
	(SELECT MAX(order_id) FROM orders) [Order ID],
	(SELECT MAX(order_item_id) FROM order_items) [Order Items ID],
	(SELECT MAX(customer_id) FROM customers) [Customer ID], 
	(SELECT MAX(product_id) FROM products) [Product ID], 
	(SELECT MAX(category_id) FROM categories) [Category ID], 
	(SELECT MAX(department_id) FROM departments) [Department ID];
GO


-- Exercise 2
ALTER TABLE orders
ADD CONSTRAINT order_customer_id_FK FOREIGN KEY (order_customer_id) REFERENCES customers(customer_id);

ALTER TABLE order_items
ADD CONSTRAINT order_items_order_id_FK FOREIGN KEY (order_item_order_id) REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT order_items_product_id_FK FOREIGN KEY (order_item_product_id) REFERENCES products(product_id);

-- product_category_id has values not in category_id
SELECT * FROM products p
LEFT JOIN categories c ON p.product_category_id = c.category_id;

-- allow null
ALTER TABLE products
ALTER COLUMN product_category_id int NULL;

-- set values not in category_id to null
UPDATE products
SET product_category_id = NULL
WHERE product_category_id NOT IN 
(SELECT category_id FROM categories);

-- Foreign Key constraint
ALTER TABLE products
ADD CONSTRAINT product_category_id_FK FOREIGN KEY (product_category_id) REFERENCES categories(category_id);

-- category_department_id has values not in department_id
SELECT * FROM categories c
LEFT JOIN departments d ON c.category_department_id = d.department_id;

-- allow null
ALTER TABLE categories
ALTER COLUMN category_department_id int NULL;

-- set values not in department_id to null
UPDATE categories
SET category_department_id = NULL
WHERE category_department_id NOT IN 
(SELECT department_id FROM departments);

ALTER TABLE categories
ADD CONSTRAINT category_department_id_FK FOREIGN KEY (category_department_id) REFERENCES departments(department_id);

GO


-- Exercise 3
SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE;
GO
