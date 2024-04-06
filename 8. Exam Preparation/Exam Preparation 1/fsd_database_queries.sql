CREATE DATABASE fsd;
USE fsd;

-- Problem 1 - Table Design
CREATE TABLE countries 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL
);

CREATE TABLE towns 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries(id)
);

CREATE TABLE stadiums 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    capacity INT NOT NULL,
    town_id INT NOT NULL,
    FOREIGN KEY (town_id) REFERENCES towns(id)
);

CREATE TABLE skills_data 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    dribbling INT DEFAULT 0,
    pace INT DEFAULT 0,
    passing INT DEFAULT 0,
    shooting INT DEFAULT 0,
    speed INT DEFAULT 0,
    strength INT DEFAULT 0
);

CREATE TABLE teams 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    established DATE NOT NULL,
    fan_base BIGINT DEFAULT 0 NOT NULL,
    stadium_id INT NOT NULL,
    FOREIGN KEY (stadium_id) REFERENCES stadiums(id)
);

CREATE TABLE players 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(10) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    age INT DEFAULT 0 NOT NULL,
    position CHAR(1) NOT NULL,
    salary DECIMAL(10, 2) DEFAULT 0.00 NOT NULL,
    hire_date DATETIME,
    skills_data_id INT NOT NULL,
    team_id INT,
    FOREIGN KEY (skills_data_id) REFERENCES skills_data(id),
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

CREATE TABLE coaches 
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(10) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    salary DECIMAL(10, 2) DEFAULT 0.00 NOT NULL,
    coach_level INT DEFAULT 0 NOT NULL
);

CREATE TABLE players_coaches 
(
    player_id INT,
    coach_id INT,
    FOREIGN KEY (player_id) REFERENCES players(id),
    FOREIGN KEY (coach_id) REFERENCES coaches(id)
);

-- Problem 2 - Insert
INSERT INTO coaches (first_name, last_name, salary, coach_level)
SELECT first_name, last_name, salary * 2, LENGTH(first_name) AS coach_level
FROM players
WHERE age >= 45;

-- Problem 3 - Update
UPDATE coaches 
SET coach_level = coach_level + 1
WHERE id IN (SELECT coach_id FROM players_coaches) and first_name LIKE 'A%';

-- Problem 4 - Delete
DELETE FROM players
WHERE age >= 45;

-- Problem 5 - Players
select first_name, age, salary from players
order by salary desc;

-- Problem 6 - Young offense players without contract
select p.id, concat(first_name, ' ', last_name) as full_name, age, position, hire_date from players p
join skills_data sd on p.skills_data_id = sd.id
where p.age < 23 and p.position = "A" and p.hire_date is null and sd.strength > 50
order by p.salary,age;

-- Problem 7 - Detail info for all teams
select t.name, t.established, t.fan_base, count(p.id) as players_count from teams t
left join players p on t.id = p.team_id
group by t.name, t.established, t.fan_base
order by players_count desc, t.fan_base desc;

-- Problem 8 - The fastest player by towns
select max(sd.speed) as max_speed, tw.name
from skills_data as sd
right join players p on sd.id = p.skills_data_id
right join teams as t on t.id = p.team_id
join stadiums as s on s.id = t.stadium_id
right join towns as tw on tw.id = s.town_id
where t.name != 'Devify'
group by tw.id
order by max_speed desc, tw.name;

-- Problem 9 - Total salaries and players by country
SELECT 
    c.name AS country,
    COUNT(p.id) AS total_count_of_players,
    SUM(p.salary) AS total_sum_of_salaries
FROM 
    countries c
LEFT JOIN 
    towns t ON c.id = t.country_id
LEFT JOIN 
    stadiums s ON t.id = s.town_id
LEFT JOIN 
    teams tm ON s.id = tm.stadium_id
LEFT JOIN 
    players p ON tm.id = p.team_id
GROUP BY 
    c.name
ORDER BY 
    total_count_of_players DESC, c.name;

-- Problem 10 - Find all players that play on stadium
DELIMITER $$
CREATE FUNCTION udf_stadium_players_count (stadium_name VARCHAR(30))
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE count_players INT;
    select count(p.id) into count_players from players p
    join teams t on p.team_id = t.id
    join stadiums s on t.stadium_id = s.id
    where s.name = stadium_name;
    RETURN count_players;
END$$

SELECT udf_stadium_players_count ('Jaxworks') as `count`;

-- Problem 11 - Find good playmaker by teams
DELIMITER $$
CREATE PROCEDURE udp_find_playmaker(min_dribble_points int, team_name varchar(45))
BEGIN
    select concat(p.first_name, ' ', p.last_name) as full_name, p.age, p.salary, sd.dribbling, sd.speed, t.name as team_name
    from players p
    join skills_data sd on p.skills_data_id = sd.id
    join teams t on p.team_id = t.id
    where t.name = team_name and sd.dribbling > min_dribble_points and sd.speed > (select avg(sd.speed) from skills_data sd
    join players p on sd.id = p.skills_data_id)
    order by sd.speed desc
    limit 1;
END$$

call udp_find_playmaker(20,"Skyble");
