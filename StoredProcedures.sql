-- Creating a Stored Procedure
DELIMITER $$
CREATE PROCEDURE get_clients()
BEGIN
	SELECT * FROM clients;
END$$
DELIMITER ;

CALL get_clients();

DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
	SELECT * FROM invoices
	WHERE invoice_total - payment_total > 0;
END$$
DELIMITER ;

CALL get_invoices_with_balance();

CALL get_payments();

-- Drop stored procedures
DROP PROCEDURE IF EXISTS get_clients;

-- Stored Procedures With Parameters
DROP PROCEDURE IF EXISTS get_clients_by_state;
DELIMITER $$
CREATE PROCEDURE get_clients_by_state(
	state CHAR(2)
)
BEGIN
	SELECT * FROM Clients c
    WHERE c.state = state;
END $$
DELIMITER ;

CALL get_clients_by_state('NY');

DROP PROCEDURE IF EXISTS get_invoices_by_client;
DELIMITER $$
CREATE PROCEDURE get_invoices_by_client(
	client_id INT
)
BEGIN
	SELECT * FROM Invoices i
    WHERE i.client_id = client_id;
END $$
DELIMITER ;

CALL get_invoices_by_client(1);

-- Default Parameters
DROP PROCEDURE IF EXISTS get_clients_by_state;
DELIMITER $$
CREATE PROCEDURE get_clients_by_state(
	state CHAR(2)
)
BEGIN
	IF state IS NULL THEN
		-- SET state = 'CA';
        SELECT * FROM clients;
	ELSE
		SELECT * FROM Clients c
		WHERE c.state = state;
	END IF;
END $$
DELIMITER ;

CALL get_clients_by_state(NULL);

DROP PROCEDURE IF EXISTS get_payments;
DELIMITER $$
CREATE PROCEDURE get_payments(
	client_id INT,
    payment_method_id TINYINT
)
BEGIN
	SELECT * FROM payments p
    WHERE 
		p.client_id = IFNULL(client_id, p.client_id) 
        AND
		p.payment_method = IFNULL(payment_method_id,p.payment_method);
END$$
DELIMITER ;

CALL get_payments(5,null);

-- Parameters Validation: better do it before hitting the database level
DROP PROCEDURE IF EXISTS make_payment;
DELIMITER $$
CREATE PROCEDURE make_payment(
	invoice_id INT,
    payment_amount DECIMAl(9,2),
    payment_date DATE
)
BEGIN
	IF payment_amount <= 0 THEN
		SIGNAL SQLSTATE '22003' 
        SET MESSAGE_TEXT = 'Invalid Payment amount';
	END IF;
	UPDATE invoices i
    SET
		i.payment_total = payment_amount,
        i.payment_date = payment_date
	WHERE i.invoice_id = invoice_id;
END$$
DELIMITER ;

CALL make_payment(2,100,'2019-01-01');

-- Output parameters
DROP PROCEDURE IF EXISTS get_unpaid_invoices;
DELIMITER $$
CREATE PROCEDURE get_unpaid_invoices(
	client_id INT,
    OUT invoices_count TINYINT,
    OUT invoices_total DECIMAL(9,2)
)
BEGIN
	SELECT COUNT(*), SUM(invoice_total) INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id AND payment_total = 0;
END$$
DELIMITER ;

SET @invoices_count = 0;		-- session variables
SET @invoices_total = 0;
CALL get_unpaid_invoices(5,@invoices_count,@invoices_total);
SELECT @invoices_count,@invoices_total;

DROP PROCEDURE IF EXISTS get_risk_factor;
DELIMITER $$
CREATE PROCEDURE get_risk_factor(
)
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9,2);		-- local variables
    DECLARE invoices_count INT;
    SELECT count(*), SUM(invoice_total) INTO invoices_count, invoices_total
    FROM invoices;
    SET risk_factor = invoices_total / invoices_count * 5;
    SELECT risk_factor;
END$$
DELIMITER ;

CALL get_risk_factor();

-- Functions
DROP FUNCTION IF EXISTS get_risk_client;
DELIMITER $$
CREATE FUNCTION get_risk_client(
	client_id INT
)
RETURNS INTEGER
-- DETERMINISTIC
READS SQL DATA
-- MODIFIES SQL DATA 
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9,2);		-- local variables
    DECLARE invoices_count INT;
    SELECT count(*), SUM(invoice_total) INTO invoices_count, invoices_total
    FROM invoices i WHERE i.client_id = client_id; 
    SET risk_factor = invoices_total / invoices_count * 5;
    return IFNULL(risk_factor,0);
END$$
DELIMITER ;

SELECT client_id, name, get_risk_client(client_id) AS Risk_Factor
FROM clients;



