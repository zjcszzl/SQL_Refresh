USE sql_store;

-- Inner Join
SELECT O.order_id, O.customer_id, C.first_name, C.last_name 
FROM Orders AS O JOIN Customers AS C
ON O.customer_id = C.customer_id;

SELECT OI.order_id, OI.product_id, P.name, OI.quantity, OI.unit_price
FROM order_items OI JOIN products P 
ON OI.product_id = P.product_id
Order By OI.order_id;

-- Join Across Database
SELECT * 
FROM order_items OI
JOIN sql_inventory.products p
ON OI.product_id = p.product_id;

-- Self Join
Use sql_hr;
SELECT e1.employee_id,e1.first_name,e1.last_name,e2.first_name,e2.last_name 
FROM employees e1
JOIN employees e2
ON e1.reports_to = e2.employee_id;

-- Join multiple tables
Use sql_store;
SELECT o.order_id, o.order_date, c.first_name,c.last_name,os.name AS status
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_statuses os ON o.status = os.order_status_id;

Use sql_invoicing;
SELECT p.date, p.invoice_id, p.amount,c.name,pm.name
FROM payments p
JOIN clients c ON p.client_id = c.client_id
JOIN payment_methods pm on p.payment_method = pm.payment_method_id;

-- Compound Join Condition
Use sql_store;
SELECT *
FROM order_items oi
JOIN order_item_notes oin ON oi.order_id = oin.order_id AND oi.product_id = oin.product_id;

-- Implicit Join Syntax in MySQL
SELECT *
FROM Orders O
JOIN Customers c ON o.customer_id = c.customer_id;

SELECT *
FROM Orders O, Customers C
WHERE O.customer_id = C.customer_id;

-- Outer Join
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT p.product_id, p.name, oi.quantity
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id;

-- Outer Join among multiple tables
SELECT c.customer_id, c.first_name, o.order_id, sh.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
ON sh.shipper_id = o.shipper_id
ORDER BY c.customer_id;

SELECT o.order_date, o.order_id, c.first_name, sh.name, os.name
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN shippers sh ON o.shipper_id = sh.shipper_id
LEFT JOIN order_statuses os ON o.status = os.order_status_id;

-- Selft outer join
Use sql_hr;
SELECT *
FROM employees e
LEFT JOIN employees m
ON e.reports_to = m.employee_id;

-- Using clause: use only for same column name in diffferent tables
Use sql_store;
SELECT c.customer_id, c.first_name, o.order_id, sh.name
FROM customers c
JOIN orders o
USING (customer_id)
JOIN shippers sh
USING (shipper_id);

-- Natural Join
SELECT o.order_id, c.first_name
FROM orders o
NATURAL JOIN customers c;

-- Cross Join
SELECT *
FROM customers c
CROSS JOIN products p;

SELECT sh.name AS shipper, p.name AS product
FROM shippers sh
CROSS JOIN products p
Order By sh.name;

-- Unions
SELECT order_id, order_date, 'Active' AS Status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT order_id, order_date, 'Archived' AS Status
FROM orders
WHERE order_date < '2019-01-01';






