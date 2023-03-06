USE sakila;

-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT f.title, count(i.film_id) AS copies
FROM film f JOIN inventory i
ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
GROUP BY f.title;

-- 2. List all films whose length is longer than the average of all the films
SELECT * FROM film
WHERE length > (SELECT AVG(length) FROM film);

-- 3. Use subqueries to display all actors who appear in the film Alone Trip

SELECT first_name, last_name FROM actor WHERE actor_id IN 
	(SELECT actor_id FROM film_actor WHERE film_id = 
		(SELECT film_id FROM film WHERE title = 'Alone Trip'));
        
-- 4. Identify all movies categorized as family films
SELECT title FROM film WHERE film_id IN
	(SELECT film_id FROM film_category WHERE category_id =
		(SELECT category_id FROM category WHERE name = 'Family'));
        
-- 5. Get name and email from customers from Canada using subqueries
SELECT first_name, last_name, email FROM customer WHERE address_id IN
	(SELECT address_id FROM address WHERE city_id IN 
		(SELECT city_id FROM city WHERE country_id =
			(SELECT country_id FROM country WHERE country = 'Canada')));

-- Using JOINS
SELECT c.first_name, c.last_name, c.email
FROM customer c, address a, country co, city ci
WHERE c.address_id = a.address_id
AND a.city_id = ci.city_id
AND ci.country_id = co.country_id
AND co.country = 'Canada';

-- 6. Which are films starred by the most prolific actor?
SELECT title from film WHERE film_id IN
	(SELECT film_id FROM film_actor WHERE actor_id =
		(SELECT actor_id FROM
			(SELECT actor_id, count(film_id) AS films
			FROM film_actor
			GROUP BY actor_id
			ORDER BY films DESC
			LIMIT 1) topactor));

-- 7. Films rented by most profitable customer
SELECT title FROM film WHERE film_id IN
	(SELECT film_id FROM inventory WHERE inventory_id IN
		(SELECT inventory_id FROM rental WHERE customer_id =
			(SELECT customer_id FROM
				(SELECT customer_id, sum(amount) AS payments FROM payment
				GROUP BY customer_id
				ORDER by payments DESC
				LIMIT 1) topcustomer)));

-- 8. Customers who spent more than the average payments
-- I first calculated the average of all payments made by each customer

SELECT first_name, last_name FROM customer WHERE customer_id IN
	(SELECT customer_id FROM
		(SELECT customer_id, sum(amount) AS 'totalspend' FROM payment
		GROUP BY customer_id
		HAVING totalspend > 
			(SELECT avg(totalpaid) FROM
				(SELECT customer_id, sum(amount) as 'totalpaid' FROM payment
				GROUP BY customer_id) avgpayments)
		)customers
	);