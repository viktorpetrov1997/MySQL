-- Problem 13 - Basic Insert

-- Create the soft_uni database
create database soft_uni;

-- Use the soft_uni database
use  soft_uni;

-- Create the towns table
CREATE TABLE towns 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Insert data into the towns table
INSERT INTO towns (name) VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

-- Create the addresses table
CREATE TABLE addresses 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    address_text VARCHAR(255) NOT NULL,
    town_id INT NOT NULL,
    FOREIGN KEY (town_id) REFERENCES towns(id)
);

-- Create the departments table
CREATE TABLE departments 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Insert data into the departments table
INSERT INTO departments (name) VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

-- Create the employees table
CREATE TABLE employees 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    job_title VARCHAR(255) NOT NULL,
    department_id INT NOT NULL,
    hire_date DATE,
    salary DECIMAL,
    address_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (address_id) REFERENCES addresses(id)
);

-- Insert data into the employees table
INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary) VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01 00:00:00', 3500.00), 
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02 00:00:00', 4000.00), 
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28 00:00:00', 525.25), 
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09 00:00:00', 3000.00), 
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28 00:00:00', 599.88); 

select * from employees;

-- Problem 14 - Basic Select All Fields
SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM employees;

-- Problem 15 - Basic Select All Fields and Order Them
SELECT * FROM towns ORDER BY name ASC;
SELECT * FROM departments ORDER BY name ASC;
SELECT * FROM employees ORDER BY salary DESC;

-- Problem 16 - Basic Select Some Fields
SELECT name FROM towns ORDER BY name ASC;
SELECT name FROM departments ORDER BY name ASC;
SELECT first_name, last_name, job_title, salary FROM employees ORDER BY salary DESC;

-- Problem 17 - Increase Employees Salary
UPDATE employees SET salary = salary * 1.1;
SELECT salary FROM employees;




