-- Problem 12 - Car Rental Database
create database car_rental;
use car_rental;

-- Create the categories table
CREATE TABLE categories 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    daily_rate DECIMAL(8, 2) NOT NULL,
    weekly_rate DECIMAL(8, 2) NOT NULL,
    monthly_rate DECIMAL(8, 2) NOT NULL,
    weekend_rate DECIMAL(8, 2) NOT NULL
);

-- Populate the categories table
INSERT INTO categories (category, daily_rate, weekly_rate, monthly_rate, weekend_rate) VALUES
('Economy', 35.00, 210.00, 800.00, 80.00),
('Compact', 40.00, 240.00, 900.00, 90.00),
('SUV', 50.00, 300.00, 1100.00, 100.00);

-- Create the cars table
CREATE TABLE cars 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    plate_number VARCHAR(20) NOT NULL,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    car_year YEAR NOT NULL,
    category_id INT,
    doors INT,
    picture LONGBLOB,
    car_condition VARCHAR(100),
    available BOOLEAN
);

-- Populate the cars table
INSERT INTO cars (plate_number, make, model, car_year, category_id, doors, car_condition, available) VALUES
('ABC123', 'Toyota', 'Corolla', 2019, 2, 4, 'Excellent', true),
('DEF456', 'Honda', 'Civic', 2018, 2, 4, 'Good', true),
('GHI789', 'Ford', 'Escape', 2020, 3, 4, 'Excellent', true);

-- Create the employees table
CREATE TABLE employees 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    notes TEXT
);

-- Populate the employees table
INSERT INTO employees (first_name, last_name, title, notes) VALUES
('John', 'Doe', 'Manager', 'Responsible for overseeing operations.'),
('Jane', 'Smith', 'Clerk', 'Handles customer inquiries and bookings.'),
('Michael', 'Johnson', 'Mechanic', 'Responsible for maintaining fleet of vehicles.');

-- Create the customers table
CREATE TABLE customers
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    driver_licence_number VARCHAR(20) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(50),
    zip_code VARCHAR(10),
    notes TEXT
);

-- Populate the customers table
INSERT INTO customers (driver_licence_number, full_name, address, city, zip_code, notes) VALUES
('DL123456', 'Alice Johnson', '123 Main St', 'New York', '10001', 'Frequent renter'),
('DL654321', 'Bob Smith', '456 Elm St', 'Los Angeles', '90001', NULL),
('DL987654', 'Eva Brown', '789 Oak St', 'Chicago', '60601', NULL);

-- Create the rental_orders table
CREATE TABLE rental_orders 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    customer_id INT,
    car_id INT,
    car_condition VARCHAR(100),
    tank_level DECIMAL(5, 2),
    kilometrage_start INT,
    kilometrage_end INT,
    total_kilometrage INT,
    start_date DATE,
    end_date DATE,
    total_days INT,
    rate_applied DECIMAL(8, 2),
    tax_rate DECIMAL(5, 2),
    order_status VARCHAR(50),
    notes TEXT
);

-- Populate the rental_orders table
INSERT INTO rental_orders (employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes) VALUES
(1, 1, 1, 'Excellent', 95.00, 10000, 10500, 500, '2024-03-01', '2024-03-10', 9, 40.00, 7.00, 'Closed', NULL),
(2, 2, 2, 'Good', 90.00, 20000, 20500, 500, '2024-03-05', '2024-03-15', 10, 45.00, 7.00, 'Closed', NULL),
(3, 3, 3, 'Excellent', 100.00, 15000, 15500, 500, '2024-03-10', '2024-03-20', 10, 50.00, 7.00, 'Closed', NULL);