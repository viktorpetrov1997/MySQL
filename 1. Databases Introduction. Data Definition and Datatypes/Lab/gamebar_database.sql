CREATE DATABASE `gamebar`;

-- We can use 'USE `gamebar`' so that every SQL statement that is executed references the gamebar database
-- instead of writing `gamebar` explicitly

-- Problem 1 - Create Tables
CREATE TABLE `gamebar`.`employees`
(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL
);

CREATE TABLE `gamebar`.`categories`
(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL
);

CREATE TABLE `gamebar`.`products`
(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `category_id` INT NOT NULL
);

-- Problem 2 - Insert Data in Tables
INSERT INTO `employees`(`first_name`,`last_name`)
VALUES ("John", "Doe"),("Jane", "Doe"),("Martin", "Ivanov");

select * from employees;

-- Problem 3 - Alter Tables
ALTER TABLE `employees`
ADD COLUMN `middle_name` VARCHAR(50);

-- Problem 4 - Adding Constraints
ALTER TABLE `products`
ADD CONSTRAINT `fk_category_id_references_categories_id`
FOREIGN KEY(`category_id`) REFERENCES `categories`(`id`);

-- Problem 5 - Modifying Columns
ALTER TABLE `employees`
MODIFY COLUMN `middle_name` VARCHAR(100);

