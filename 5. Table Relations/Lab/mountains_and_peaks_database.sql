create database mountains_and_peaks;
use mountains_and_peaks;

-- Problem 1 - Mountains and Peaks
CREATE TABLE mountains 
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

CREATE TABLE peaks 
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    mountain_id INT,
    FOREIGN KEY (mountain_id) REFERENCES mountains(id)
);

-- Problem 4 - Delete Mountains
CREATE TABLE mountains 
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

CREATE TABLE peaks 
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    mountain_id INT,
    FOREIGN KEY (mountain_id) REFERENCES mountains(id) ON DELETE CASCADE
);
