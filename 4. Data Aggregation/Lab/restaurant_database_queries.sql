CREATE DATABASE IF NOT EXISTS restaurant;
use restaurant;

CREATE TABLE departments 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE employees 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	department_id INT NOT NULL,
	salary DOUBLE NOT NULL,
	CONSTRAINT fk_department_id FOREIGN KEY(`department_id`) REFERENCES departments(`id`)
);

CREATE TABLE categories 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL
);

CREATE TABLE  products 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	category_id INT NOT NULL,
	price DOUBLE NOT NULL,
	CONSTRAINT fk_cateogory_id FOREIGN KEY(`category_id`) REFERENCES categories(`id`)
);

INSERT INTO departments(name) VALUES ("Management"), ("Kitchen Staff"), ("Wait Staff");

INSERT INTO employees (first_name, last_name, department_id, salary) VALUES ("Jasmine","Maggot",2,1250.00), 
("Nancy","Olson",2,1350.00), ("Karen","Bender",1,2400.00), ("Pricilia","Parker",2,980.00),
("Stephen","Bedford",2,780.00),("Jack","McGee",1,1700.00),("Clarence","Willis",3,650.00),
("Michael","Boren",3,780.00),("Michael","Boren",3,780.00);

INSERT INTO categories(name) VALUES("salads"),("appetizers"),("soups"),("main"),("desserts");

INSERT INTO products (name, category_id,price) VALUES ("Lasagne", 4,12.99),
("Linguine Positano with Chicken", 4,11.69),
("Chicken Marsala", 4,13.69),
("Calamari", 2,14.89),
("Tomato Caprese with Fresh Burrata", 2,7.99),
("Wood-Fired Italian Wings", 2,9.90),
("Caesar Side Salad", 1,8.79),
("House Side Salad", 1,6.79),
("Johny Rocco Salad", 1,6.90),
("Minestrone", 3,8.89),
("Sausage & Lentil", 3,7.90),
("Mama Mandola’s Sicilian Chicken Soup", 3,6.90),
("Tiramisú", 5,4.90),
("John Cole", 5,5.60),
("Mini Cannoli", 5,5.60);

-- Problem 1 - Departments Info
select department_id, count(id) as "Number of employees" from employees
group by department_id
order by department_id;

-- Problem 2 - Average Salary
SELECT department_id, ROUND(AVG(salary), 2) AS "Average Salary"
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- Problem 3 - Minimum Salary
SELECT department_id, ROUND(MIN(salary), 2) AS "Min Salary"
FROM employees
GROUP BY department_id
HAVING MIN(salary) > 800;

-- Problem 4 - Appetizers Count
SELECT COUNT(*) AS "Count of Appetizers"
FROM products
WHERE category_id = 2 AND price > 8;

-- Problem 5 - Menu Prices
SELECT 
category_id,
ROUND(AVG(price), 2) AS "Average Price",
MIN(price) AS "Cheapest Product",
MAX(price) AS "Most Expensive Product"
FROM products
GROUP BY category_id;