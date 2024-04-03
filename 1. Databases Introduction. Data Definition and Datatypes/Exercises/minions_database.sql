create database minions;
use minions;

-- Problem 1 - Create Tables
create table minions 
(
    id INT AUTO_INCREMENT,
    name VARCHAR(255),
    age INT,
    PRIMARY KEY (id)
);

create table towns 
(
    town_id INT AUTO_INCREMENT,
    name VARCHAR(255),
    PRIMARY KEY (town_id)
);

-- Problem 2 - Alter Minions Table
ALTER TABLE minions
ADD COLUMN town_id INT,
ADD CONSTRAINT fk_town_id
FOREIGN KEY (town_id) REFERENCES towns(id);

-- Problem 3 - Insert Records in Both Tables
INSERT INTO towns (id, name) VALUES
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna');

INSERT INTO minions (id, name, age, town_id) VALUES
(1,'Kevin', 22, 1),
(2,'Bob', 15, 3),
(3,'Steward', NULL, 2);

select * from minions;

-- Problem 4 - Truncate Table Minions
truncate table minions;

-- Problem 5 - Drop All Tables
drop table minions;
drop table towns;