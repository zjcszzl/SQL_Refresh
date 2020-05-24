-- Subqueries
Use sql_store;
SELECT * FROM products
WHERE unit_price > (
	SELECT unit_price FROM products
    WHERE product_id = 3
);

Use sql_hr;
SELECT employee_id FROM employees
WHERE salary > (
	SELECT AVG(salary) FROM employees
);

-- In operator
Use sql_store;
SELECT * FROM products
WHERE product_id NOT IN(
	SELECT DISTINCT product_id 
	FROM order_items
);

Use sql_invoicing;
SELECT * FROM clients
WHERE client_id NOT IN(
	SELECT DISTINCT client_id
	FROM invoices
);

-- Subqueries vs. Join
SELECT * FROM clients
LEFT JOIN invoices USING(client_id)
WHERE invoice_id IS NULL;

Use sql_store;
SELECT * FROM customers
WHERE customer_id IN(
	SELECT o.customer_id FROM order_items oi
    JOIN orders o USING(order_id)
    WHERE product_id = 3
);

SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN orders o USING(customer_id)
JOIN order_items oi USING(order_id)
WHERE oi.product_id = 3;

-- All
Use sql_invoicing;
-- Slect invoices larger than all invoices of client 3
SELECT * FROM invoices 
WHERE invoice_total >(
	SELECT MAX(invoice_total) 
	FROM invoices
	WHERE client_id = 3
);

SELECT * FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
);

-- Any
SELECT * FROM clients
WHERE client_id = ANY(
	SELECT client_id
	FROM invoices
	Group By client_id
	Having COUNT(*) >= 2
);

-- Correlated Subqueries
USE sql_hr;
SELECT * FROM employees e
WHERE salary >(
	SELECT AVG(salary)
    FROM employees 
    WHERE office_id = e.office_id
);

Use sql_invoicing;
SELECT *
FROM invoices i
WHERE invoice_total >(
	SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id
);

-- Exists operator
SELECT * FROM clients c
WHERE EXISTS(
	SELECT client_id FROM invoices
    WHERE client_id = c.client_id
);

Use sql_store;
SELECT * FROM products p
WHERE NOT EXISTS(
	SELECT product_id FROM order_items oi
    WHERE p.product_id = oi.product_id
);

-- Subquery in the SELECT
USE sql_invoicing;
SELECT 
	invoice_id, 
	invoice_total,
	(SELECT AVG(invoice_total) FROM invoices) AS invoice_average,
	invoice_total - (SELECT invoice_average) AS difference
FROM invoices;

SELECT
	client_id,
    name,
    (SELECT SUM(invoice_total) FROM invoices WHERE client_id = c.client_id) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices) AS average,
    (SELECT total_sales - average) AS difference
FROM clients c;




