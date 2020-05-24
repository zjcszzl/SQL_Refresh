-- Numeric Function
SELECT ROUND(5.7345, 2);
SELECT TRUNCATE(5.7267,2);
-- CEILING(), FLOOR(), ABS(), RAND() --> between 0 and 1

-- String Function
SELECT LENGTH('sky');
SELECT LTRIM('  sky'); -- RTRIM(), TRIM()
-- UPPER(), LOWER()
SELECT LEFT('kingder',3);	-- RIGHT()
SELECT SUBSTRING('england',2,3);
SELECT LOCATE('gl','england');	-- Not found: 0
SELECT REPLACE('england', 'land','lant');
SELECT CONCAT('first','last');
Use sql_store;
SELECT CONCAT(first_name,' ',last_name) FROM customers;

-- Date Function
SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();
SELECT YEAR(NOW());		-- MONTH(), DAY(), HOUR()...
SELECT DAYNAME(NOW());		-- MONTHNAME()
SELECT EXTRACT(DAY FROM NOW());

-- Formatting Date and Time
SELECT DATE_FORMAT(NOW(),'%Y %M');				-- captial: 4 digits, small: 2 digits
SELECT TIME_FORMAT(NOW(), '%H:%i %p');

-- Calculate Date
SELECT DATE_ADD(NOW(),INTERVAL 1 DAY);
SELECT DATE_SUB(NOW(),INTERVAL 1 DAY);
SELECT DATEDIFF('2019-01-03','2019-03-28');
SELECT TIME_TO_SEC('09:00');

-- IFNULL and COALESCE
USE sql_store;
SELECT order_id, IFNULL(shipper_id,'Not Assigned') AS Shipper
FROM orders;

SELECT order_id, COALESCE(shipper_id, comments, 'Not Assigned') AS Shipper
FROM orders;

SELECT CONCAT(first_name, ' ', last_name) AS Full_name, IFNULL(phone,'Unknown') AS Phone
FROM customers;

-- IF Function
SELECT  order_id, order_date,
	IF(YEAR(order_date) = YEAR(NOW()),'Active','Archived') AS Status
FROM orders;

SELECT product_id, name, COUNT(*) AS orders,
	IF(COUNT(*) > 1, 'Many times', 'Once') AS Frequency
FROM products
JOIN order_items USING(product_id)
Group By product_id, name;

-- Case Function
SELECT  order_id, order_date,
	CASE
		WHEN YEAR(order_date) = YEAR(NOW()) THEN 'Active'
        WHEN YEAR(order_date) = YEAR(NOW())-1 THEN 'Last Year'
        ELSE 'Archived'
	END AS Category
FROM orders;

SELECT CONCAT(first_name,' ',last_name) AS customer, points,
	CASE
		WHEN points > 3000 THEN 'Gold'
        WHEN points > 2000 THEN 'Silver'
        ELSE 'Broze'
	END AS Category
FROM customers;

