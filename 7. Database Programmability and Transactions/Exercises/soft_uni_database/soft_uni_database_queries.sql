-- Problem 1 - Employees with Salary Above 35000
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	select first_name, last_name from employees
    where salary > 35000
    order by first_name, last_name, employee_id;
END$$

call usp_get_employees_salary_above_35000();

-- Problem 2 - Employees with Salary Above Number
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(desired_salary DECIMAL(19,4))
BEGIN
	select first_name, last_name from employees
    where salary >= desired_salary
    order by first_name, last_name, employee_id;
END$$

call usp_get_employees_salary_above(45000);

-- Problem 3 - Town Names Starting With
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(town_substring VARCHAR(50))
BEGIN
  SELECT `name` 
  FROM `towns`
  WHERE `name` like CONCAT(town_substring,'%')
  order by `name`;
END$$

call usp_get_towns_starting_with("b");

-- Problem 4 - Employees from Town
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(searched_town VARCHAR(50))
BEGIN
  SELECT `first_name`, `last_name`
  FROM `employees` AS e
  JOIN `addresses` AS a USING (address_id)
  JOIN `towns` AS t USING (town_id)
  WHERE t.`name` = `searched_town`
  ORDER BY `first_name`,`last_name`;
END$$

call usp_get_employees_from_town("Sofia");

-- Problem 5 - Salary Level Function
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(19, 4))
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    DECLARE salary_level VARCHAR(8);
    IF salary < 30000 THEN SET salary_level := 'Low';
    ELSEIF salary <= 50000 THEN SET salary_level := 'Average';
    ELSE SET salary_level := 'High';
    END IF;
    RETURN salary_level;
END$$

select ufn_get_salary_level(10000);

-- Problem 6 - Employees by Salary Level
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(8)) 
BEGIN
    SELECT first_name, last_name
    FROM employees
    WHERE ufn_get_salary_level(salary) LIKE salary_level
    ORDER BY first_name DESC, last_name DESC;
END$$

call usp_get_employees_by_salary_level("High");

-- Problem 7 - Define Function
DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN word REGEXP (CONCAT('^[', set_of_letters, ']+$'));
END$$

select ufn_is_word_comprised("oistmiahf", "Sofia");