CREATE DATABASE softuni_imdb;
USE softuni_imdb;

-- Problem 1 - Table Design
CREATE TABLE countries 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL UNIQUE,
    continent VARCHAR(30) NOT NULL,
    currency VARCHAR(5) NOT NULL
);

CREATE TABLE genres 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE actors 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE,
    height INT,
    awards INT,
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES countries (id)
);

CREATE TABLE movies_additional_info 
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	rating DECIMAL(10, 2) NOT NULL,
    runtime INT NOT NULL,
    picture_url VARCHAR(80) NOT NULL,
    budget DECIMAL(10,2),
    release_date DATE NOT NULL,
    has_subtitles TINYINT(1),
    description TEXT
);

CREATE TABLE movies
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(70) NOT NULL UNIQUE,
    country_id INT NOT NULL,
    movie_info_id INT NOT NULL UNIQUE,
    FOREIGN KEY (country_id) REFERENCES countries (id),
    FOREIGN KEY (movie_info_id) REFERENCES movies_additional_info (id)
);

CREATE TABLE movies_actors
(
	movie_id INT,
    actor_id INT,
    FOREIGN KEY (movie_id) REFERENCES movies (id),
    FOREIGN KEY (actor_id) REFERENCES actors (id)
);

CREATE TABLE genres_movies
(
	genre_id INT,
    movie_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres (id),
    FOREIGN KEY (movie_id) REFERENCES movies (id)
);

-- Problem 2 - Insert
INSERT INTO actors(first_name, last_name, birthdate, height, awards, country_id)
SELECT REVERSE(first_name), REVERSE(last_name), DATE_SUB(birthdate, INTERVAL 2 DAY), height + 10, 
country_id, 3 FROM actors WHERE id <= 10;

-- Problem 3 - Update
UPDATE movies_additional_info
SET runtime = runtime - 10
WHERE id >= 15 AND id <= 25;

-- Problem 4 - Delete
DELETE c FROM countries c
LEFT JOIN movies m ON c.id = m.country_id
WHERE m.country_id IS NULL;

-- Problem 5 - Countries
SELECT id, name, continent, currency FROM countries
ORDER BY currency DESC, id;

-- Problem 6 - Old movies
SELECT m.id, m.title, mai.runtime, mai.budget, mai.release_date FROM movies m
JOIN movies_additional_info mai ON m.id = mai.id
WHERE mai.release_date BETWEEN '1996-01-01' AND '1999-12-31'
ORDER BY mai.runtime, m.id
LIMIT 20;

-- Problem 7 - Movie casting
SELECT CONCAT(first_name, ' ', last_name) as full_name, CONCAT(REVERSE(last_name), LENGTH(last_name), "@cast.com") 
AS email, (2022 - YEAR(birthdate)) AS age, height FROM actors a
LEFT JOIN movies_actors ma ON a.id = ma.actor_id
WHERE ma.actor_id IS NULL
ORDER BY height;

-- Problem 8 - International festival
SELECT c.name, count(m.country_id) AS movies_count FROM countries c
JOIN movies m ON c.id = m.country_id
GROUP BY c.name
HAVING movies_count >= 7
ORDER BY c.name DESC;

-- Problem 9 - Rating system
SELECT m.title, IF(mai.rating <= 4, "poor", IF(mai.rating > 4 and mai.rating <= 7, 'good', 'excellent')),
IF(mai.has_subtitles = 1, "english", "-"), budget FROM movies m
JOIN movies_additional_info mai ON m.id = mai.id
ORDER BY mai.budget DESC;

-- Problem 10 - History movies
DELIMITER  $$

CREATE FUNCTION udf_actor_history_movies_count(full_name VARCHAR(50)) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE history_movies_count INT;
    
    SELECT COUNT(*)
    INTO history_movies_count
    FROM movies_actors ma
    JOIN actors a ON ma.actor_id = a.id
    JOIN genres_movies gm ON ma.movie_id = gm.movie_id
    JOIN genres g ON gm.genre_id = g.id
    WHERE g.name = 'History'
    AND CONCAT(a.first_name, ' ', a.last_name) = full_name;
    
    RETURN history_movies_count;
END $$

SELECT udf_actor_history_movies_count('Stephan Lundberg') AS history_movies;

-- Problem 11 - Movie awards
DELIMITER $$
CREATE PROCEDURE udp_award_movie(movie_title varchar(50))
BEGIN
	UPDATE actors a
    JOIN movies_actors ma ON a.id = ma.actor_id
    JOIN movies m ON ma.movie_id = m.id
    SET a.awards = a.awards + 1
    WHERE m.title = movie_title;
END$$