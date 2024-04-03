-- Problem 5 - Project Management DB
create database project_management;
use project_management;

CREATE TABLE employees 
(
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    project_id int not null
);

alter table employees
add constraint fk_project_id
foreign key(project_id)
references projects(id);

CREATE TABLE projects 
(
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    client_id int not null,
    project_lead_id int not null
);

alter table projects
add constraint fk_client_id
foreign key(client_id)
references clients(id),
add constraint fk_project_lead_id
foreign key(project_lead_id)
references employees(id);

CREATE TABLE clients 
(
    id INT(11) PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(100)
);


