-- Aggregate Funcations
-- Max(), Min(), Avg(), Sum(), Count()

Use sql_invoicing;
SELECT 
Max(invoice_total) AS Highest, 
Min(invoice_total) AS Lowest,
Avg(invoice_total) AS Average,
Sum(invoice_total) AS Total,
Count(invoice_total) AS number_of_invoices		-- count ignore NULL value
FROM invoices
WHERE invoice_date > '2019-07-01';

SELECT
'First half of 2019' AS date_range,
SUM(invoice_total) AS total_sales,
SUM(payment_total) AS total_payments,
SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT
'Second half of 2019' AS date_range,
SUM(invoice_total) AS total_sales,
SUM(payment_total) AS total_payments,
SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT
'All of 2019' AS date_range,
SUM(invoice_total) AS total_sales,
SUM(payment_total) AS total_payments,
SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31';

-- Group By
SELECT state, city, SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients USING (client_id)
-- WHERE invoice_date >= '2019-07-01'
Group By state,city
Order By total_sales DESC;

SELECT date, pm.name AS payment_method, sum(amount) AS total_payments
FROM payments p
JOIN payment_methods pm ON p.payment_method = pm.payment_method_id
Group By date, payment_method
Order By date;

-- Having
SELECT client_id, SUM(invoice_total) AS total_sales, COUNT(*) AS number_of_invoices
FROM invoices
Group By client_id
Having total_sales > 500 AND number_of_invoices >= 5;

Use sql_store;
SELECT c.first_name, c.last_name, SUM(oi.quantity * oi.unit_price) AS total_spend
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE c.state = 'VA'
Group By c.first_name, c.last_name
Having total_spend > 100;

-- Rollup operator  --> MySQL
Use sql_invoicing;
SELECT state, city, SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients c Using (client_id)
Group By state, city With Rollup;

SELECT pm.name AS payment_method, sum(p.amount) AS total
FROM payments p 
JOIN payment_methods pm ON p.payment_method = pm.payment_method_id
Group by pm.name With RollUP;


