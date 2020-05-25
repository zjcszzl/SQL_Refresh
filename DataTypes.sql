-- String
-- CHAR(x) -> fix length, VARCHAR(x), MEDIUMTEXT, LONGTEXT
-- TINYTEXT, TEXT

-- Numeric
-- Integer types: TINYINT -> 1 byte, -128 - 127, UNSIGNED TINYINT -> 0 - 255,
-- SMALLINT: 2b MEDIUMINT INT BIGINT
-- ZEROFILL: INT(4) -> 0001, use the smallest data type that suits needs to increase speed 
-- Rationals: DECIMAL(p,s) -> DECIMAL(9,2)=> 1234567.89  DEC NUMERIC FIXED FLOAT(4b) DOUBLE(8b)

-- Boolean: BOOL, BOOLEAN(True False / 1 0)

-- Enum and Set Types: 
-- Enum('small','medium','large')

-- Date and time
-- DATE, TIME, DATETIME, TIMESTAMP, YEAR

-- Blob: TINYBLOB, BLOB, MEDIUMBLOB, LONGBLOB

-- Spatial

-- JSON: lightweight format for storing and transfering data over the internet
-- {"key": value}
UPDATE products SET properties ='
{
	"dimensions": [1,2,3],
    "weight": 10,
    "manufacturer": {"name":"sony"}
}
'
WHERE product_id = 1;

UPDATE products SET properties = JSON_OBJECT(
'weight',10, 
'dimensions',JSON_ARRAY(1,2,3),
'manufacturer',JSON_OBJECT('name','sony')
)
WHERE product_id = 1;

SELECT product_id, 
JSON_EXTRACT(properties,'$.weight'), 
properties->'$.dimensions[0]',
properties->> '$.manufacturer.name'
FROM products;

UPDATE products SET properties = JSON_SET(
	properties,
    '$.weight',20,
    '$.age', 12
)
WHERE product_id = 1;

-- JSON_REMOVE(properties, '$.age')   would remove age properties