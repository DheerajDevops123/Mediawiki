-- Create a user 'wiki'@'localhost' with the specified password
CREATE USER 'wiki'@'localhost' IDENTIFIED BY 'THISpasswordSHOULDbeCHANGED';

-- Create a database named 'database_name'
CREATE DATABASE database_name;

-- Create a database named 'wikidatabase'
CREATE DATABASE wikidatabase;

-- Grant all privileges on the 'wikidatabase' to the 'wiki' user
GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost';

-- Flush privileges to apply the changes
FLUSH PRIVILEGES;

-- Show list of databases
SHOW DATABASES;

-- Show grants for the 'wiki' user
SHOW GRANTS FOR 'wiki'@'localhost';
