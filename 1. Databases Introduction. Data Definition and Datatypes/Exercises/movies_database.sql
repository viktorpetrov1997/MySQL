-- Problem 11 - Movies Database
create database movies;
use movies;

-- Create the directors table
CREATE TABLE directors 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    director_name VARCHAR(100) NOT NULL,
    notes TEXT
);

-- Populate the directors table
INSERT INTO directors (director_name, notes) VALUES
('Christopher Nolan', 'Renowned for his work on The Dark Knight trilogy.'),
('Quentin Tarantino', 'Known for his unique storytelling style.'),
('Steven Spielberg', 'Famous for directing blockbuster films like Jurassic Park.'),
('Martin Scorsese', 'Acclaimed director of films such as The Wolf of Wall Street.'),
('James Cameron', 'Legendary filmmaker behind Avatar and Titanic.');

-- Create the genres table
CREATE TABLE genres 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL,
    notes TEXT
);

-- Populate the genres table
INSERT INTO genres (genre_name, notes) VALUES
('Action', 'Genre focusing on high-octane, thrilling sequences.'),
('Drama', 'Genre known for its intense character development and emotional depth.'),
('Comedy', 'Genre aimed at providing laughter and entertainment.'),
('Science Fiction', 'Genre exploring futuristic concepts and technologies.'),
('Horror', 'Genre designed to evoke fear and suspense.');

-- Create the categories table
CREATE TABLE categories 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    notes TEXT
);

-- Populate the categories table
INSERT INTO categories (category_name, notes) VALUES
('Adventure', 'Category featuring exciting journeys and exploration.'),
('Romance', 'Category focusing on love and relationships.'),
('Thriller', 'Category known for its suspenseful plot twists.'),
('Fantasy', 'Category featuring magical or supernatural elements.'),
('Mystery', 'Category centered around solving puzzles and uncovering secrets.');

-- Create the movies table
CREATE TABLE movies 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    director_id INT,
    copyright_year INT,
    length TIME,
    genre_id INT,
    category_id INT,
    rating DECIMAL(3, 1),
    notes TEXT
);

-- Populate the movies table
INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes) VALUES
('Inception', 1, 2010, '02:28:00', 4, 1, 8.8, 'Mind-bending thriller directed by Christopher Nolan.'),
('Pulp Fiction', 2, 1994, '02:34:00', 2, 7, 8.9, 'Iconic crime drama directed by Quentin Tarantino.'),
('Jurassic Park', 3, 1993, '02:07:00', 1, 6, 8.1, 'Legendary science fiction adventure directed by Steven Spielberg.'),
('The Departed', 4, 2006, '02:31:00', 2, 3, 8.5, 'Gripping crime thriller directed by Martin Scorsese.'),
('Avatar', 5, 2009, '02:42:00', 4, 4, 7.8, 'Epic science fiction fantasy directed by James Cameron.');