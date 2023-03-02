USE sakila;
-- 1. lastnames not repeated
SELECT last_name 
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;

-- 2. last names that appear more than once
SELECT last_name 
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- 3. how many rentals were processed by each employee
SELECT staff_id, count(rental_id) AS 'films_processed'
FROM sakila.rental
GROUP BY staff_id;

-- 4. how many films were released each year
SELECT release_year, count(title) AS 'films_released'
FROM sakila.film
GROUP BY release_year;

-- 5. find out for each rating how many films were there
SELECT rating, COUNT(film_id) AS 'number_of_films'
FROM sakila.film
GROUP BY rating;

-- 6. mean length of the film for each rating type
SELECT rating, ROUND(AVG(length), 2) AS 'mean_duration'
FROM sakila.film
GROUP BY rating;

-- 7. movies (rating) that have a mean duration of more than two hours?
SELECT rating, ROUND(AVG(length), 2) as 'average_duration'
FROM sakila.film
GROUP BY rating
HAVING AVG(length) > 120;

-- 8. Rank films by length (filter out the rows that have nulls or 0s in length column)
SELECT title, length, DENSE_RANK() OVER(ORDER BY length) film_rank
FROM sakila.film
WHERE (length IS NOT NULL) AND (length != 0);

