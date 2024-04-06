-- Problem 1 - Find All Information About Departments
select department_id, name, manager_id from departments
order by department_id;

-- Problem 2 - Find all Department Names
select name from departments
order by department_id;

-- Problem 3 - Find Salary of Each Employee
select first_name, last_name, salary from employees
order by employee_id;

-- Problem 4 - Find Full Name of Each Employee
select first_name, middle_name, last_name from employees
order by employee_id;

-- Problem 5 - Find Email Address of Each Employee
SELECT CONCAT(first_name, '.', last_name, '@softuni.bg') AS full_email_address FROM employees;

-- Problem 6 - Find All Different Employee’s Salaries
select distinct salary from employees;

-- Problem 7 - Find all Information About Employees
select * from employees
where job_title = 'Sales Representative'
order by employee_id;

-- Problem 8 - Find Names of All Employees by Salary in Range
SELECT first_name, last_name, job_title
FROM employees
WHERE salary BETWEEN 20000 AND 30000
ORDER BY employee_id;

-- Problem 9 - Find Names of All Employees
SELECT CONCAT(first_name, ' ', middle_name, ' ', last_name) AS `Full Name` FROM employees
where salary in (25000, 14000, 12500, 23600);

-- Problem 10 - Find All Employees Without Manager
select first_name, last_name from employees
where manager_id is null;

-- Problem 11 - Find All Employees with Salary More Than
select first_name, last_name, salary from employees
where salary > 50000
order by salary desc;

-- Problem 12 - Find 5 Best Paid Employees
SELECT first_name, last_name FROM employees
ORDER BY salary DESC
LIMIT 5;

-- Problem 13 - Find All Employees Except Marketing
select first_name, last_name from employees
where department_id != 4;

-- Problem 14 - Sort Employees Table
SELECT * FROM employees
ORDER BY 
salary DESC,
first_name ASC,
last_name DESC,
middle_name ASC,
employee_id;

-- Problem 15 - Create View Employees with Salaries
CREATE VIEW v_employees_salaries AS
SELECT first_name, last_name, salary FROM employees;

select * from v_employees_salaries;

-- Problem 16 - Create View Employees with Job Titles
CREATE VIEW v_employees_job_titles AS
SELECT CONCAT(first_name, IFNULL(CONCAT(' ', middle_name), ''), ' ', last_name) AS full_name, job_title
FROM employees;

select * from v_employees_job_titles;

-- Problem 17 - Distinct Job Titles
select distinct job_title from employees
order by job_title;

-- Problem 18 - Find First 10 Started Projects
SELECT * FROM projects
ORDER BY start_date, name, project_id
limit 10;

-- Problem 19 - Last 7 Hired Employees
select first_name, last_name, hire_date from employees
order by hire_date desc
limit 7;

-- Problem 20 - Increase Salaries
update employees
set salary = salary * 1.12
where department_id in (1, 2, 4, 11);

select salary from employees;
