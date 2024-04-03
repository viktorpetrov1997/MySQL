-- Problem 1 - Mountains and Peaks

-- Create Mountains table
CREATE TABLE mountains 
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

-- Create Peaks table
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
