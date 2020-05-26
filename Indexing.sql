-- Create index
Explain
SELECT customer_id 
FROM customers 
WHERE state = 'CA';

CREATE INDEX idx_state ON customers (state);

Explain
SELECT customer_id
FROM customers
WHERE points > 1000;

CREATE INDEX idx_points ON customers (points);

-- View index
SHOW INDEXES IN customers;
ANALYZE TABLE customers;
SHOW INDEXES IN orders;

-- Prefix index
-- string columns: cost more memory, may include few characters
CREATE INDEX idx_lastname ON customers (last_name(20));

SELECT COUNT(*) FROM customers;

SELECT COUNT(DISTINCT LEFT(last_name,1)) FROM customers;
SELECT COUNT(DISTINCT LEFT(last_name,5)) FROM customers;
-- 5 is optimal pre fix length

-- Full-text index
USE sql_blog;
SELECT * FROM posts
WHERE title LIKE '%react redux%' OR
		body LIKE '%react redux%';
        
CREATE FULLTEXT INDEX idx_title_body ON posts(title,body);
SELECT *,MATCH(title,body) AGAINST('react redux') AS relevant_score 
FROM posts
WHERE MATCH(title,body) AGAINST('react redux');

SELECT *,MATCH(title,body) AGAINST('react redux') AS relevant_score 
FROM posts
WHERE MATCH(title,body) AGAINST('react -redux +form' IN BOOLEAN MODE);			-- contains react but no redux, must have form
-- '"handling a form"'    exact order and word

-- Composite Index
USE sql_store;
SHOW INDEXES IN customers;
EXPLAIN SELECT customer_id FROM customers WHERE state = 'CA' and points > 1000;

CREATE INDEX idx_state_points ON customers(state,points);
EXPLAIN SELECT customer_id FROM customers USE INDEX(idx_state_points) WHERE state = 'CA' and points > 1000;

DROP INDEX idx_state ON customers;
DROP INDEX idx_points ON customers;

-- Order of columns in composite index: depend on the query and data
-- frequently used furst, high cardinality, taken queries into account

-- When indexes are ignored
CREATE INDEX idx_points ON customers(points);

EXPLAIN 
SELECT customer_id FROM customers WHERE state = 'CA' 
UNION
SELECT customer_id FROM customers WHERE points > 1000;

EXPLAIN SELECT customer_id FROM customers WHERE points + 10 > 2010;		-- 1012 rows
EXPLAIN SELECT customer_id FROM customers WHERE points > 2000;			-- 6 rows

-- Index for sorting
SHOW INDEX IN customers;

EXPLAIN SELECT customer_id FROM customers
Order By state;					-- filesort is expensive
SHOW STATUS LIKE 'last_query_cost';

-- Covering indexes
EXPLAIN SELECT customer_id FROM customers
ORDER BY state;			-- id, state, points, automatically include the primary key in the index

-- Index Maintenance
-- Duplicte indexes: (A,B,C) 
-- Redudant indexes


