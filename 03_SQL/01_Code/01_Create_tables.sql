---------------------------------------------------------------------------
-- DUAL TABLE - DUMMY TABLE
--------------------------------------------------------------------------
'Dual table is something called out in oracle and in postgres you dont have 
call it out but they both mean the same thing. You can run some code without
any source table. Here is an example of ORACLE VS POSTGRES syntax. 
ORACLE
SELECT 1+1
FROM DUAL;

POSTGRES
SELECT 1+1;
;'
SELECT user;

SELECT COUNT(*)

SELECT 'ABCDEF123/5/6$';

SYSTEM DATE
SELECT 
statement_timestamp(),
now(),
current_timestamp, 
current_date;

-- check your math
SELECT (15+45)*2-(10/3),15+45*2-10/3


---------------------------------------------------------------------------
-- CREATE DROP INSERT VALUES BASIC SELECT
--------------------------------------------------------------------------
CREATE TABLE link (
 ID serial PRIMARY KEY,
 url VARCHAR (255) NOT NULL,
 name VARCHAR (255) NOT NULL,
 description VARCHAR (255),
 rel VARCHAR (50)
);

DROP TABLE link;

INSERT INTO link (url, name)
VALUES
 ('http://www.postgresqltutorial.com','PostgreSQL Tutorial')

SELECT
 *
FROM link;
 
INSERT INTO link (url, NAME)
VALUES
 ('http://www.oreilly.com','O''Reilly Media')

INSERT INTO link (url, name)
VALUES
 ('http://www.google.com','Google'),
 ('http://www.yahoo.com','Yahoo'),
 ('http://www.bing.com','Bing')

-- EXERCISE
'Create a table called color with the fields id and colors
Insert id 1,2,3,4 and colors Red, Purple, Yellow and Blue into the table
Run a SELECT * FROM to see if your inserts worked.'


CREATE TABLE public.titanic
(
	passengerid integer,
	survived integer,
	pclass integer,
	name character(225) ,
	sex character(30),
	age numeric,
	sibsp integer,
	parch integer,
	ticket character(30),
	fare money,
	cabin character(15),
	embarked character(1)
);

-- LOAD DATA INTO A TABLE
COPY titanic FROM 'C:\Users\Matthew\Desktop\DataScience\titanic.csv' DELIMITER ',' CSV HEADER;


-- ALTER SYNTAX:

-- Add column(s): 
ALTER TABLE titanic 
ADD test integer,
ADD	test2 character(30);


-- Drop column: 
ALTER TABLE titanic DROP COLUMN test2;


-- Rename column: 
ALTER TABLE titanic RENAME COLUMN test TO delete;

-- Rename table: 
ALTER TABLE titanic RENAME TO titanic02;


/* The SQL DROP TABLE statement is used to remove a table definition and all data, indexes, triggers,
constraints, and permission specifications for that table. 
NOTE: You have to be careful while using this command, because once a table is deleted, 
all the information available in the table will also be lost forever. */

DROP TABLE titanic03

CREATE TABLE public.titanic03 (
  	pclass integer,
	sex character(30),
    age integer,
    survived integer)

/* INSERT INTO  will extract data from a source table and transfer it to a target table. */

INSERT INTO titanic03 SELECT pclass, sex, age, survived FROM titanic02


-- EXERCISE
' FIND DATA OF INTEREST TO YOU, CREATE A TABLE AND LOAD THE DATA INTO YOUR RDBMS'