-- Problem 6 - Create Table People
CREATE TABLE people 
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height DOUBLE(10, 2),
    weight DOUBLE(10, 2),
    gender char(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT,
    CONSTRAINT chk_gender CHECK (gender IN ('m', 'f'))
);

-- Insert sample records into the people table
INSERT INTO people (name, picture, height, weight, gender, birthdate, biography) VALUES
('John Doe', NULL, 1.75, 70.5, 'm', '1990-05-15', 'John Doe is a fictional character.'),
('Jane Smith', NULL, 1.65, 60.3, 'f', '1985-12-20', 'Jane Smith is another fictional character.'),
('Michael Johnson', NULL, 1.82, 80.2, 'm', '1978-09-25', NULL),
('Emily Brown', NULL, 1.70, 65.8, 'f', '1995-03-10', NULL),
('David Miller', NULL, NULL, NULL, 'm', '2000-07-08', NULL);

select * from people;

-- Problem 7 - Create Table Users
CREATE TABLE users 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) UNIQUE NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB,
    last_login_time DATETIME,
    is_deleted BOOLEAN,
    CONSTRAINT chk_is_deleted CHECK (is_deleted IN (0, 1))
);

-- Insert sample records into the users table
INSERT INTO users (username, password, profile_picture, last_login_time, is_deleted) VALUES
('user1', 'password1', NULL, '2024-03-30 10:00:00', false),
('user2', 'password2', NULL, '2024-03-29 12:30:00', false),
('user3', 'password3', NULL, '2024-03-28 08:45:00', false),
('user4', 'password4', NULL, '2024-03-27 15:20:00', false),
('user5', 'password5', NULL, '2024-03-26 17:55:00', false);

select * from users;

-- Problem 8 - Change Primary Key
ALTER TABLE users
DROP PRIMARY KEY,
ADD PRIMARY KEY pk_users (id, username);

-- Problem 9 - Set Default Value of a Field
ALTER TABLE users MODIFY COLUMN last_login_time DATETIME DEFAULT CURRENT_TIMESTAMP;

-- Problem 10 - Set Unique Field
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY users(id),
MODIFY COLUMN username varchar(30) unique;







