-- Problem 1 - Count Employees by Town
DELIMITER $$
CREATE FUNCTION ufn_count_employees_by_town(town_name varchar(50))
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
    SELECT COUNT(employee_id) INTO e_count FROM employees AS e
        JOIN addresses AS a ON a.address_id = e.address_id
        JOIN towns AS t ON t.town_id = a.town_id
    WHERE t.name = town_name;
    RETURN e_count;
END$$

select ufn_count_employees_by_town("Sofia");

-- Problem 2 - Employees Promotion
DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name varchar(50))
BEGIN
	UPDATE employees AS e 
	 JOIN departments AS d 
	ON e.department_id = d.department_id 
	SET salary = salary * 1.05
	WHERE d.name = department_name;
END$$

call usp_raise_salaries("Finance");

-- Problem 3 - Employees Promotion By ID
DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id int)
BEGIN
	START TRANSACTION;
	IF((SELECT count(employee_id) FROM employees WHERE employee_id like id) <> 1) THEN
	ROLLBACK;
	ELSE
		UPDATE employees AS e SET salary = salary + salary * 0.05 
		WHERE e.employee_id = id;
	END IF; 
END$$

call usp_raise_salary_by_id(17);

-- Problem 4 - Triggered
CREATE TABLE deleted_employees
(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	middle_name VARCHAR(20),
	job_title VARCHAR(50),
	department_id INT,
	salary DOUBLE 
);

DELIMITER $$
CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees (first_name,last_name,middle_name,job_title,department_id,salary)
	VALUES(OLD.first_name,OLD.last_name,OLD.middle_name,OLD.job_title,OLD.department_id,OLD.salary);
END$$