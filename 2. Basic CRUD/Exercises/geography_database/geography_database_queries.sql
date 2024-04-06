-- Problem 21 - All Mountain Peaks
select peak_name from peaks
order by peak_name;

-- Problem 22 - Biggest Countries by Populations
select country_name, population from countries
where continent_code = "EU"
order by population desc, country_name
limit 30;

-- Problem 23 - Countries and Currency (Euro / Not Euro)
SELECT country_name, country_code,
CASE WHEN currency_code = 'EUR' THEN 'Euro' ELSE 'Not Euro' END AS currency
FROM countries
order by country_name;
