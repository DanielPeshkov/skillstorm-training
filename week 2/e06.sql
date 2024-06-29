-- Exercise 1
SELECT YEAR(created_ts) [created_year], COUNT(*) [user_count] FROM users
GROUP BY YEAR(created_ts)
ORDER BY YEAR(created_ts);

-- Exercise 2
SELECT [user_id], user_dob, user_email_id, DATENAME(dw, user_dob) [user_day_of_birth] 
FROM users
WHERE MONTH(user_dob) = 5
ORDER BY DAY(user_dob);

-- Exercise 3
SELECT [user_id], UPPER(CONCAT_WS(' ', user_first_name, user_last_name)) [user_name], user_email_id, created_ts, YEAR(created_ts) [created_year] 
FROM users
WHERE YEAR(created_ts) = 2019
ORDER BY [user_name];

-- Exercise 4
WITH g AS (
SELECT CASE user_gender
	WHEN 'F' THEN 'Female'
	WHEN 'M' THEN 'Male'
	WHEN 'N' THEN 'Non-Binary'
	ELSE 'Not Specified'
	END gender
FROM users
)

SELECT gender, COUNT(*) FROM g
GROUP BY gender;

-- Exercise 5
WITH u AS (
SELECT [user_id], [user_unique_id], REPLACE(user_unique_id, '-', '') [u]
FROM users
)

SELECT u.[user_id], u.[user_unique_id], 
	CASE
		WHEN LEN(u.u) >= 9 THEN RIGHT(u.u, 4)
		WHEN u.u IS NULL THEN 'Not Specified'
		ELSE 'Invalid Unique ID'
	END [user_unique_id_last4]
	
FROM u
ORDER BY [user_id];

-- Exercise 6
WITH codes AS (
	SELECT SUBSTRING(user_phone_no, 2, CHARINDEX(' ', user_phone_no)-2) [country_code]
	FROM users
	WHERE user_phone_no IS NOT NULL
)

SELECT country_code, COUNT(*) FROM codes
GROUP BY country_code
ORDER BY CAST(country_code AS int);

-- Exercise 7
SELECT 
	CAST(SUM(CAST(order_item_quantity AS NUMERIC(8, 2)) * 
		CAST(order_item_product_price AS NUMERIC(8, 2)) - 
		CAST(order_item_subtotal AS NUMERIC(8, 2))) AS INT) [count]
FROM order_items;

-- Exercise 8
WITH d AS (
SELECT CASE DATENAME(dw, order_date) 
	WHEN 'Saturday' THEN 'Weekend days'
	WHEN 'Sunday' THEN 'Weekend days'
	ELSE 'Week days'
	END d
FROM orders
WHERE order_date >= '20140101' AND order_date < '20140201')

SELECT d.d, COUNT(*) [order_count] FROM d
GROUP BY d.d
ORDER BY d.d DESC;
