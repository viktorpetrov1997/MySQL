-- Problem 1 - Find Names of All Employees by First Name
select first_name, last_name from employees
where first_name like "Sa%"
order by employee_id;

-- Problem 2 - Find Names of All Employees by Last Name
SELECT first_name, last_name FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

-- Problem 3 - Find First Names of All Employess
SELECT first_name FROM employees
WHERE department_id IN (3, 10) AND YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

-- Problem 4 - Find All Employees Except Engineers
SELECT first_name, last_name FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

-- Problem 5 - Find Towns with Name Length
SELECT name FROM towns
WHERE LENGTH(name) BETWEEN 5 AND 6
ORDER BY name;

-- Problem 6 - Find Towns Starting With
SELECT town_id, name FROM towns
WHERE LOWER(SUBSTR(name, 1, 1)) IN ('m', 'k', 'b', 'e')
ORDER BY name;

-- Problem 7 - Find Towns Not Starting With
SELECT town_id, name FROM towns
WHERE LOWER(SUBSTR(name, 1, 1)) NOT IN ('r', 'b', 'd')
ORDER BY name;

-- Problem 8 - Create View Employees Hired After
create view v_employees_hired_after_2000 as
select first_name, last_name from employees
where year(hire_date) > 2000;

select * from v_employees_hired_after_2000;

-- Problem 9 - Length of Last Name
select first_name, last_name from employees
where length(last_name) = 5;
