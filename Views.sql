USE sql_invoicing;

CREATE VIEW sales_by_client AS(
	SELECT c.client_id, c.name, SUM(invoice_total) AS total_sales 
	FROM clients c
	JOIN invoices i USING(client_id)
	Group By client_id, name
);

SELECT * FROM sales_by_client
ORDER BY total_sales DESC;

SELECT * FROM sales_by_client
JOIN clients USING (client_id);

CREATE VIEW clients_balance AS(
	SELECT c.client_id, c.name, SUM(invoice_total - payment_total) AS balance
    FROM clients c
    JOIN invoices i USING(client_id)
    Group By client_id, name
);

SELECT * FROM clients_balance;

DROP VIEW clients_balance;

CREATE OR REPLACE VIEW clients_balance AS(
	SELECT c.client_id, c.name, SUM(invoice_total - payment_total) AS balance
    FROM clients c
    JOIN invoices i USING(client_id)
    Group By client_id, name
);

-- Updatable Views
-- No DISTINCT, Aggregate Functions, Group By/Having, UNION

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT invoice_id, number, client_id, invoice_total, payment_total, invoice_total - payment_total AS balance,
		invoice_date, due_date, payment_date
FROM invoices WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION;




