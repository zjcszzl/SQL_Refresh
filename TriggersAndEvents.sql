-- Trigger: insert, update, delete, before, after, new, old
DROP TRIGGER IF EXISTS payments_after_insert;
DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END $$
DELIMITER ;

INSERT INTO payments
VALUES (DEFAULT,5,3,'2020-05-22',10,1);

DROP TRIGGER IF EXISTS payments_after_delete;
DELIMITER $$
CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    INSERT INTO payments_audit
    VALUES(OLD.client_id,OLD.date,OLD.amount,'Delete',NOW());
END $$
DELIMITER ;

DELETE FROM payments WHERE payment_id = 9;

SHOW TRIGGERS LIKE 'payments%';
-- table_beofe|after_insert|delete

-- Triggers for Auditing
USE sql_invoicing;
CREATE TABLE payments_audit(
	client_id	INT		NOT NULL,
    date		DATE	NOT NULL,
    amount		DECIMAL(9,2)	NOT NULL,
    action_type	VARCHAR(50)		NOT NULL,
    action_date	DATETIME		NOT NULL
);
DROP TRIGGER IF EXISTS payments_after_insert;
DELIMITER $$
CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    INSERT INTO payments_audit
    VALUES(NEW.client_id,NEW.date,NEW.amount,'Insert',NOW());
END $$
DELIMITER ;

INSERT INTO payments 
VALUES(DEFAULT,5,3,'2020-02-28',88,2);
DELETE FROM payments WHERE payment_id = 10;

-- Events: SQL codes being executed according to a schedule

SHOW Variables LIKE 'event%';
-- SET GLOBAL event_scheduler = OFF

DELIMITER $$
CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
	-- AT '2020-05-28'			-- once
    EVERY 1 MONTH STARTS '2020-03-28' ENDS '2020-12-06'					-- Frequently
DO BEGIN
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
END $$
DELIMITER ;

SHOW EVENTS;
-- DROP EVENT IF EXISTS yearly_delete_stale_audit_rows
-- ALTER EVENT yearly_delete_stale_audit_rows DISABLE  ENABLE

