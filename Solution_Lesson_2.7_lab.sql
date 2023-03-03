USE sakila;

-- 1. How many films are there for each of the categories in the category table
SELECT c.name AS category, COUNT(f.film_id) AS num_of_films
FROM sakila.film f, sakila.film_category fc, sakila.category c
WHERE f.film_id = fc.film_id
AND c.category_id = fc.category_id
GROUP BY c.name
ORDER BY num_of_films DESC;

-- 2. Display the total amount rung up by each staff member in August of 2005
SELECT staff_id, SUM(amount) AS 'total sales'
FROM sakila.payment
WHERE MONTH(payment_date) = '8'
AND YEAR(payment_date) = '2005'
GROUP BY staff_id;

-- 3. Which actor has appeared in the most films
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS movies
FROM actor a
JOIN film_actor fa
USING(actor_id)
GROUP BY actor_id
ORDER BY movies DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)
select c.customer_id, c.first_name, count(r.rental_id) as total_rental
from customer c
JOIN rental r
USING(customer_id)
GROUP BY customer_id
ORDER BY total_rental DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member
SELECT s.first_name, s.last_name, a.address
FROM sakila.staff s
JOIN sakila.address a
USING(address_id);

-- 6. List each film and the number of actors who are listed for that film
SELECT f.film_id, f.title, COUNT(fa.actor_id) AS total_actors
FROM sakila.film f
JOIN sakila.film_actor fa
USING(film_id)
GROUP BY f.film_id
ORDER BY total_actors DESC;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS 'total-paid'
FROM sakila.customer c
JOIN sakila.payment p
USING(customer_id)
GROUP BY customer_id
ORDER BY c.last_name ASC;

-- 8. List number of films per category
SELECT c.name AS category, COUNT(f.film_id) AS num_of_films
FROM sakila.film f, sakila.film_category fc, sakila.category c
WHERE f.film_id = fc.film_id
AND c.category_id = fc.category_id
GROUP BY c.name
ORDER BY num_of_films DESC;


