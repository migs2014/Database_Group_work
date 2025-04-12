-- creating database	
    CREATE DATABASE bookstoredb;
    -- using the database bookstoredb
USE bookstoredb;
    -- table for languges 
CREATE TABLE book_language(
languageId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
language VARCHAR(50) NOT NULL
);
-- Creating a publisher table
CREATE TABLE publisher(
publisherId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
publisherName VARCHAR (100) NOT NULL
);
-- Creating book table referencing to publisher and book_language table
CREATE TABLE book (
    bookId INT NOT NULL PRIMARY KEY,
    Year INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    languageId INT,
    publisherId INT,
    FOREIGN KEY (LanguageId) REFERENCES book_language (LanguageID),
    FOREIGN KEY (publisherId) REFERENCES publisher(PublisherID)
);

-- creating a table of authors
CREATE TABLE author(
authorId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
authorName VARCHAR(255) NOT NULL,
bookId INT,
FOREIGN KEY (bookId) REFERENCES book(bookId)
);
-- creating a table book_author
CREATE TABLE book_author(
bookAuthorId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
bookId INT,
authorId INT,
FOREIGN KEY (bookId) REFERENCES book(bookId),
FOREIGN KEY (authorId) REFERENCES author(authorId)
);
-- creating table country
CREATE TABLE country(
countryId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
countryName VARCHAR (150) NOT NULL
);

-- Creating table called customer
CREATE TABLE customer(
customerId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
firstName VARCHAR(50) NOT NULL,
lastName VARCHAR (50) NOT NULL,
countryId INT,
FOREIGN KEY (countryId) REFERENCES country(countryId)
);

-- Creating a table called customer_address
CREATE TABLE customer_address(
addressId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
customerId INT,
countryId INT,
address1  VARCHAR (50) NOT NULL,
town1 VARCHAR (50) NOT NULL,
phone1 VARCHAR (13) NOT NULL,
address2  VARCHAR (50),
town2 VARCHAR (50),
phone2 VARCHAR (13),
FOREIGN KEY (customerId) REFERENCES customer(customerId),
FOREIGN KEY (countryId) REFERENCES country (countryId)
);

-- Creating a table called address_status
CREATE TABLE address_status(
statusId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
addressId INT,
FOREIGN KEY (addressId) REFERENCES customer_address(addressId),
addressStatus VARCHAR(20) NOT NULL,
    CHECK (addressStatus IN ('current address', 'Old address'))
);
-- creating table address to hold all the addresses -This is act as a bridge for customer address and address_status tables
CREATE TABLE address(
addressAllId INT PRIMARY KEY AUTO_INCREMENT,
statusId INT,
addressId INT,
FOREIGN KEY (statusId) REFERENCES address_status(statusId),
FOREIGN KEY (addressId) REFERENCES customer_address(addressId)
);

-- Creating cust_order table to hold customers
CREATE TABLE cust_order(
orderId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
customerId INT,
orderDate TIMESTAMP NOT NULL,
bookId INT,
FOREIGN KEY(customerId) REFERENCES customer(customerId),
FOREIGN KEY (bookId) REFERENCES book(bookId) 
);

-- Creating TABLE orderline
CREATE TABLE order_line(
orderLineId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
orderId INT,
bookId INT,
quantity INT NOT NULL,
price DECIMAL (10,2),
subtotal DECIMAL AS (quantity * price)
FOREIGN KEY (orderId) REFERENCES cust_order (orderId),
FOREIGN KEY (bookId) REFERENCES book(bookId)
);
-- create order_status table
CREATE TABLE order_status(
orderStatusId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
orderStatus VARCHAR(20) NOT NULL,
    CHECK (orderStatus IN ('Pending', 'Shipped','Delivered'))
);
-- Creating order history table
CREATE TABLE order_history(
historyId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
orderId INT,
orderStatusId INT,
remarks TEXT,
FOREIGN KEY (orderId) REFERENCES cust_order(orderId),
FOREIGN KEY (orderStatusId) REFERENCES order_status(orderStatusId)
);
	/*
    CREATING USERS
    CREATING ROLES
    CREATING PRIVILIGES
    */
-- Create user 'jane' with password '1234'
CREATE USER 'jane'@'localhost' IDENTIFIED BY '1234';

-- Create user 'mark' with password '5678'
CREATE USER 'mark'@'localhost' IDENTIFIED BY '5678';

-- Create user 'joyce' with password '123456'
CREATE USER 'joyce'@'localhost' IDENTIFIED BY '123456';

-- Create roles
CREATE ROLE 'admin';
CREATE ROLE 'hr';
CREATE ROLE 'clerk';

-- Grant privileges to 'admin' role
GRANT ALL PRIVILEGES ON *.* TO 'admin' WITH GRANT OPTION;

-- Grant specific privileges to 'hr' role
GRANT SELECT, INSERT, UPDATE ON bookstore.* TO 'hr';

-- Grant limited privileges to 'clerk' role
GRANT SELECT ON bookstore.* TO 'clerk';

-- Assign roles to users
GRANT 'admin' TO 'jane'@'localhost';
GRANT 'hr' TO 'mark'@'localhost';
GRANT 'clerk' TO 'joyce'@'localhost';


