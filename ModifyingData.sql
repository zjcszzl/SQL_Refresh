-- Insert a single row
INSERT INTO customers
VALUES(default,'Jack','Zhan','1972-12-06',null,'707 Walnut Avenue','Rochester','CA',3000);

INSERT INTO customers(first_name,last_name,birth_date,address,city,state,points)
VALUES('Amy', 'Wang','1996-02-14','address','city','CA',4000);

-- Insert multiple rows
INSERT INTO shippers(name)
VALUES ('Shipper1'),('Shipper2'),('Shipper3');

INSERT INTO products(name,quantity_in_stock,unit_price)
VALUES ('Apple',70,3.24),('Huawei',80,7.56),('Samsung', 50,7.62);

-- Insert Hierarchical Rows
INSERT INTO orders(customer_id,order_date,status)
VALUES (2,'2020-03-22',1);
INSERT INTO order_items
VALUES (LAST_INSERT_ID(),1,1,2.25),(LAST_INSERT_ID(),2,1,2.85);
-- LAST_INSERT_ID()

-- Create a copy of table
CREATE TABLE orders_archived AS
SELECT * FROM orders;

INSERT INTO orders_archived 
SELECT * FROM Orders 
WHERE order_date < '2019-01-01';

USE sql_invoicing;
CREATE TABLE invoices_archived AS
SELECT i.invoice_id, i.number, c.name AS client, i.invoice_total, i.payment_total, i.invoice_date, i.due_date
FROM invoices i 
JOIN clients c USING (client_id)
WHERE i.payment_date IS NOT NULL;

-- Updating a single row
Update invoices
SET payment_total = 10, payment_date = '2020-05-11'
WHERE invoice_id = 1;

Update invoices
SET payment_total = invoice_total * 0.5,
	payment_Date = due_date
WHERE invoice_id = 3;

-- Updating multiple rows
Update invoices
SET payment_total = invoice_total * 0.5,
	payment_Date = due_date
WHERE client_id = 3;

Use sql_store;
Update customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

-- Using subqueries in update
Use sql_invoicing;
Update invoices
SET payment_total = invoice_total * 0.5,
	payment_Date = due_date
WHERE client_id = (
	SELECT client_id FROM clients
    WHERE name = 'MyWorks'
);

Update invoices
SET payment_total = invoice_total * 0.5,
	payment_Date = due_date
WHERE client_id IN (
	SELECT client_id FROM clients
    WHERE state IN('CA','NY')
);

Use sql_store;

UPDATE orders 
SET comments = 'Gold customer'
WHERE customer_id IN(
SELECT customer_id FROM Customers
WHERE points > 3000);

-- Delete rows
Use sql_invoicing;
DELETE FROM invoices
WHERE invoice_id = 1;





