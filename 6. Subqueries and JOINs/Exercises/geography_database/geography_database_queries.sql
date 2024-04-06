-- Problem 12 - Highest Peaks in Bulgaria
SELECT c.`country_code`, m.`mountain_range`, p.`peak_name`, p.`elevation`
FROM `peaks` AS p
INNER JOIN `mountains` AS m ON p.`mountain_id` = m.`id`
INNER JOIN `mountains_countries` AS c ON m.`id` = c.`mountain_id`
WHERE c.`country_code` = 'BG' AND p.`elevation` > 2835
ORDER BY p.`elevation` DESC;

-- Problem 13 - Count Mountain Ranges
select mc.country_code, count(m.mountain_range) as mountain_range from mountains_countries mc
join mountains m on mc.mountain_id = m.id
where mc.country_code in ("BG", "RU", "US")
group by mc.country_code
order by mountain_range desc;

-- Problem 14 - Countries with Rivers
select c.country_name, r.river_name from countries c
left join countries_rivers cr on c.country_code = cr.country_code
left join rivers r on cr.river_id = r.id
where c.continent_code = "AF"
order by c.country_name
limit 5;

-- Problem 15 - Continents and Currencies
SELECT d1.continent_code, d1.currency_code, d1.currency_usage FROM 
	(SELECT `c`.`continent_code`, `c`.`currency_code`,
    COUNT(`c`.`currency_code`) AS `currency_usage` FROM countries as c
	GROUP BY c.currency_code, c.continent_code HAVING currency_usage > 1) as d1
LEFT JOIN 
	(SELECT `c`.`continent_code`,`c`.`currency_code`,
    COUNT(`c`.`currency_code`) AS `currency_usage` FROM countries as c
	 GROUP BY c.currency_code, c.continent_code HAVING currency_usage > 1) as d2
ON d1.continent_code = d2.continent_code AND d2.currency_usage > d1.currency_usage
WHERE d2.currency_usage IS NULL
ORDER BY d1.continent_code, d1.currency_code;

-- Problem 16 - Countries without any Mountains
SELECT COUNT(c.`country_code`)
FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
LEFT JOIN `mountains` AS m ON mc.`mountain_id` = m.`id`
WHERE m.`id` IS NULL;

-- Problem 17 - Highest Peak and Longest River by Country
SELECT c.`country_name`, MAX(p.`elevation`) AS 'highest_peak_elevation',MAX(r.`length`) AS 'longest_river_length'
FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
LEFT JOIN `peaks` AS p ON mc.`mountain_id` = p.`mountain_id`
LEFT JOIN `countries_rivers` AS cr ON c.`country_code` = cr.`country_code`
LEFT JOIN `rivers` AS r ON cr.`river_id` = r.`id`
GROUP BY c.`country_name`
ORDER BY `highest_peak_elevation` DESC , `longest_river_length` DESC , c.`country_name`
LIMIT 5;