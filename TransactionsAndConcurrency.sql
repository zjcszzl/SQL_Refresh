-- Group of SQL statements that represent a single unit of work
-- Atomocity, consistency, isolation, durability 

-- Creating Transaction
USE sql_store;

START TRANSACTION;
INSERT INTO orders(customer_id, order_date,status)
VALUES (1,'2020-03-28',2);
INSERT INTO order_items
VALUES(last_insert_id(),1,1,1);
COMMIT;
-- ROLLBACK;

-- Concurrency and Locking
START TRANSACTION;
UPDATE customers
SET points = points + 10
WHERE customer_id = 1;
COMMIT;

SHOW VARIABLES LIKE 'transaction_isolation';
-- Global
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

USE sql_store;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;	-- cause problem
SELECT points FROM customers WHERE customer_id = 1;

USE sql_store;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;	     -- no dirty reads, but read twice two values
SELECT points FROM customers WHERE customer_id = 1;

USE sql_store;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;	
START TRANSACTION;
SELECT * FROM customers WHERE state = 'VA';
COMMIT;



