-- Modified SQL Schema with intentional violations of SQL Coding Conventions
-- 1. Using lowercase keywords (create table instead of CREATE TABLE)
-- 2. Standalone identifier 'id' (violating Celko / SQL style rule 11)
-- 3. Inconsistent indentation (tabs and 2-space indents instead of 4 spaces)
-- 4. Unnecessary whitespace before '(' and before ';'
-- 5. Missing semicolons
-- 6. Prefix 'tbl_' used for table name

create table users (
	id int primary key,
  user_name varchar (30) not null,
    user_email varchar(50)
) ;

create table tbl_sensors (
  sensor_id int,
  type varchar(30)
)
