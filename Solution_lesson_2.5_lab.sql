USE sakila;
-- 1. actors with firstname 'Scarlett'
SELECT * FROM sakila.actor
WHERE first_name LIKE '%Scarlett%';

-- 2. films available for rent
SELECT COUNT(rental_duration) FROM sakila.film
WHERE rental_duration >0;

-- films that have been rented
SELECT COUNT(rental_id) FROM sakila.rental;

-- 3. shortest film duration
SELECT MIN(length) AS 'min_duration'
FROM sakila.film;

-- longest film duration
SELECT MAX(length) AS 'max_duration'
FROM sakila.film;

-- 4. what's the average movie duration expressed in format (hours, minutes)
SELECT SEC_TO_TIME(AVG(length)*60) AS 'average_movie_duration' 
FROM sakila.film;

-- 5. distinct actors' last names
SELECT COUNT(DISTINCT last_name)
FROM sakila.actor;

-- 6. how many days has the company been operating (check DATEDIFF() function)
SELECT DATEDIFF(MAX(last_update), MIN(rental_date)) AS DateDiff
FROM sakila.rental;

-- 7. show rental info with additional columns month and weekday. Get 20 results
SELECT *, MONTH(rental_date) AS 'month', DAYOFWEEK(rental_date) AS 'weekday'
FROM sakila.rental;

-- 8. add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week
SELECT *, DAYOFWEEK(rental_date) AS 'weekday',
CASE
WHEN DAYOFWEEK(rental_date) = 1 then 'weekend'
WHEN DAYOFWEEK(rental_date) BETWEEN 2 AND 6 then 'workday'
WHEN DAYOFWEEK(rental_date) = 7 then 'weekend'
ELSE 'n/a'
END AS 'day_type'
FROM sakila.rental;

-- 9. Get release years
SELECT DISTINCT release_year FROM sakila.film;

-- 10. all films with ARMAGEDDON in the title
SELECT * FROM sakila.film
WHERE title LIKE '%ARMAGEDDON%';

-- 11. all films which title ends with APOLLO
SELECT * FROM sakila.film
WHERE title LIKE '%APOLLO';

-- 12. Get 10 the longest films
SELECT title, length FROM sakila.film
WHERE length BETWEEN 175 AND 185
ORDER BY length desc;

-- 12. (another interpretation)
SELECT title, length FROM sakila.film
ORDER BY length desc
LIMIT 10;

-- 13. how many films include Behind the Scenes content?
SELECT COUNT(special_features) FROM sakila.film
WHERE special_features LIKE '%Behind the Scenes%';

