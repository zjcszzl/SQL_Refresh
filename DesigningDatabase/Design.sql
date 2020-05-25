-- Data modeling: understand the requirements -> conceptual model -> logical model -> physical model

-- Student: first_name(string),last_name(string), email(string), dateRegistered(date)
-- Course: title(string), instructor(string), tags(string)
-- Enrollment: date(date), studentId(int), courseId(int), price(float)
-- Relationships: one-to-one, one-to-many, many-to-many

-- Create and Dropping Database
CREATE DATABASE IF NOT EXISTS sql_store2;

DROP DATABASE IF EXISTS sql_store2;

-- Create Table
USE sql_store2;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers
(
	customer_id	INT	PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) CHARACTER SET latin1 NOT NULL,
    points INT NOT NULL DEFAULT 0,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Modify Table
ALTER TABLE customers
	ADD last_name VARCHAR(50) NOT NULL;				-- `firtst name`

ALTER TABLE customers
	ADD city VARCHAR(50) NOT NULL,
    MODIFY COLUMN first_name VARCHAR(55) DEFAULT '',
    DROP COLUMN points;
    
-- Create relationships
CREATE TABLE IF NOT EXISTS orders
(
	order_id	INT	PRIMARY KEY AUTO_INCREMENT,
    customer_id	INT NOT NULL,
    FOREIGN KEY fk_orders_customers(customer_id)
		REFERENCES customers(customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Alter primary key and foreign key
ALTER TABLE orders
	ADD PRIMARY KEY (order_id),
    DROP PRIMARY KEY,
	DROP FOREIGN KEY fk_orders_customers,
    ADD FOREIGN KEY fk_orders_customers(customer_id)
		REFERENCES customers(customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT;
        
-- Character sets and collations
SHOW CHARSET;

CREATE DATABASE db_name CHARACTER SET latin1;

-- Storage Engines
SHOW ENGINES;
ALTER TABLE customers
ENGINE = InnoDB;