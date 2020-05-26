-- Creating a user
CREATE USER john@127.0.0.1;
CREATE USER mary@localhost;
CREATE USER ding@abc.com;

CREATE USER dang IDENTIFIED BY '1234';

-- Viewing user
SELECT * FROM mysql.user;

-- Dropping user
DROP USER dang;

-- Changing passwords
CREATE USER dang IDENTIFIED BY '1234';
SET PASSWORD FOR dang = '12345';

-- Granring privileges
-- web/desktop application: read only
CREATE USER moon_app IDENTIFIED BY '1234';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON sql_store.* 
TO moon_app;

-- admin
GRANT ALL
ON sql_store.*
TO dang;

-- Viewing privileges
SHOW GRANTS FOR dang;

-- Revoking privilegs
GRANT CREATE VIEW 
ON sql_store.*
TO moon_app;

REVOKE CREATE VIEW
ON sql_store.*
FROM moon_app;