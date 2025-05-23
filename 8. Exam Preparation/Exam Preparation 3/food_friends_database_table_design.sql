CREATE DATABASE food_friends;
USE food_friends;

-- Problem 1 - Table Design
CREATE TABLE restaurants 
(
     id INT AUTO_INCREMENT PRIMARY KEY,
     name VARCHAR(40) NOT NULL UNIQUE,
     type VARCHAR(20) NOT NULL,
     non_stop BOOLEAN NOT NULL
);

CREATE TABLE offerings 
(
     id INT AUTO_INCREMENT PRIMARY KEY,
     name VARCHAR(40) NOT NULL UNIQUE,
     price DECIMAL(19,2) NOT NULL,
     vegan BOOLEAN NOT NULL,
     restaurant_id INT NOT NULL,
     FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

CREATE TABLE customers 
(
     id INT AUTO_INCREMENT PRIMARY KEY,
     first_name VARCHAR(40) NOT NULL,
     last_name VARCHAR(40) NOT NULL,
     phone_number VARCHAR(20) NOT NULL UNIQUE,
     regular BOOLEAN NOT NULL,
     UNIQUE (first_name, last_name)
);

CREATE TABLE orders 
(
     id INT AUTO_INCREMENT PRIMARY KEY,
     number VARCHAR(10) NOT NULL UNIQUE,
     priority VARCHAR(10) NOT NULL,
     customer_id INT NOT NULL,
     restaurant_id INT NOT NULL,
     FOREIGN KEY (customer_id) REFERENCES customers(id),
     FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);

CREATE TABLE orders_offerings 
(
	order_id INT NOT NULL,
	offering_id INT NOT NULL,
	restaurant_id INT NOT NULL,
	PRIMARY KEY(order_id, offering_id),
	FOREIGN KEY (order_id) REFERENCES orders(id),
	FOREIGN KEY (offering_id) REFERENCES offerings(id),
	FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);