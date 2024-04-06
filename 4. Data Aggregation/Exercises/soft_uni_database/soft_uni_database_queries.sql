-- Problem 12 - Employees Minimum Salaries
SELECT `department_id`, min(`salary`) AS 'minimum_salary'
FROM `employees`
WHERE `hire_date` > '2000-01-01'
GROUP BY `department_id`
HAVING `department_id` IN (2, 5, 7)
ORDER BY `department_id`;

-- Problem 13 - Employees Average Salaries
CREATE TABLE `salary_more_than` AS
SELECT *
FROM `employees`
WHERE `salary` > 30000;
 
DELETE 
FROM `salary_more_than`
WHERE `manager_id` = 42;
 
UPDATE `salary_more_than`
SET `salary` = `salary` + 5000
WHERE `department_id` = 1;
 
SELECT `department_id`, avg(`salary`) AS `avg_salary`
FROM `salary_more_than`
GROUP BY `department_id`
ORDER BY `department_id`;

-- Problem 14 - Employees Maximum Salaries
select department_id, max(salary) as max_salary from employees
group by department_id
having max_salary not between 30000 and 70000
order by department_id;

-- Problem 15 - Employees Count Salaries
select count(salary) from employees
where manager_id is null;

-- Problem 16 - 3rd Highest Salary
SELECT DISTINCT `department_id`,
        (
        SELECT  DISTINCT `salary`
        FROM    `employees` e
        WHERE   e.`department_id` = `employees`.`department_id`
        ORDER BY `salary` DESC
        LIMIT 1 OFFSET 2
        ) AS `third_highest_salary`
FROM    `employees`
HAVING `third_highest_salary` IS NOT NULL
ORDER BY `department_id`;

-- Problem 17 - Salary Challenge
select first_name, last_name, department_id from employees f
where salary > (select avg(salary) from employees e where e.department_id = f.department_id)
order by department_id, employee_id
limit 10;

-- Problem 18 - Departments Total Salaries
select department_id, sum(salary) from employees
group by department_id
order by department_id;