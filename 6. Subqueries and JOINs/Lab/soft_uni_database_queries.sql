-- Problem 1 - Managers
select e.employee_id, concat(e.first_name, ' ', e.last_name) as full_name, d.department_id, 
d.name as department_name from employees e join departments d on e.employee_id = d.manager_id
order by e.employee_id
limit 5;

-- Problem 2 - Towns and Addresses
select t.town_id, t.name, a.address_text from towns t
join addresses a on t.town_id = a.town_id
where t.name in ("San Francisco", "Sofia", "Carnation")
order by t.town_id, a.address_id;

-- Problem 3 - Employees Without Managers
select employee_id, first_name, last_name, department_id, salary from employees
where manager_id is null;

-- Problem 4 - High Salary
select count(*) as count from employees
where salary > (select avg(salary) from employees);