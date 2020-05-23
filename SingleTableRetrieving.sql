USE sql_store;
-- Basic Operation of Retriving Data from Single Table

-- Select Statement
SELECT * FROM Customers
-- WHERE customer_id = 1
ORDER BY first_name;

-- Select Clause
SELECT 
	first_name, 
    last_name, 
    points, 
    points + 10 AS "updated points"
FROM Customers;

SELECT DISTINCT state FROM Customers;

SELECT
	name,
    unit_price,
    unit_price * 1.1 AS new_price
FROM products;

-- Where clause
SELECT * FROM Customers
WHERE points > 3000;
-- >, >=, <, <=, =, !=, <>

SELECT * FROM Customers
WHERE birth_date > '1990-01-01';

SELECT * FROM Orders
WHERE '2018-12-31' >= order_date >= '2018-01-01';

-- Operators: AND, OR, NOT
SELECT * FROM Customers 
WHERE birth_date > '1990-01-01' OR 
		(points > 1000 AND state = 'VA');
        
SELECT * FROM Order_items
WHERE product_id = 6 and (quantity * unit_price) > 30;

-- In 
SELECT * FROM Customers
WHERE state NOT IN ('VA','GA','FL');

SELECT name FROM products
WHERE quantity_in_stock in (49,38,72);

-- Between
SELECT * FROM Customers
WHERE points between 1000 and 2000;

SELECT * FROM Customers
WHERE birth_date between '1990-01-01' and '2000-01-01';

-- Like: %, _
SELECT * FROM Customers
WHERE last_name like '%b%';

SELECT * FROM Customers
WHERE (address like '%trail%' or address like '%avenue%') and phone like '%9';

-- Regexp: regular expression
SELECT * FROM Customers
WHERE last_name REGEXP 'field';
-- ^:beginning of the string; $:end of the string

SELECT * FROM Customers
WHERE last_name REGEXP 'field$|mac|rose';

SELECT * FROM Customers
WHERE last_name REGEXP '[gim]e';	-- '[a-h]e'

SELECT * FROM Customers
WHERE first_name REGEXP 'elka|ambur';

SELECT * FROM Customers
WHERE last_name REGEXP 'EY$|ON$';

SELECT * FROM Customers
WHERE last_name REGEXP '^MY|SE';

SELECT * FROM Customers
WHERE last_name REGEXP 'B[RU]';

-- IS NULL
SELECT * FROM Customers
WHERE phone IS NULL;

SELECT * FROM Orders
WHERE shipped_date is NULL;

-- Order By
SELECT * FROM Customers
Order By state ASC, first_name DESC;

SELECT *, quantity*unit_price AS total_price FROM Order_items
WHERE order_id = 2
Order By total_price DESC;

-- Limit
SELECT * FROM Customers
LIMIT 6,3;
-- limit: start point, size

SELECT * FROM Customers
Order By points DESC
LIMIT 3;







