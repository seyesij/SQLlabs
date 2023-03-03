USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country
SELECT s.store_id, ci.city, co.country  
FROM sakila.store s, sakila.city ci, sakila.country co, sakila.address a
WHERE s.address_id = a.address_id
AND ci.city_id = a.city_id
AND co.country_id = ci.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in
SELECT s.store_id, concat('$', FORMAT(SUM(p.amount), 2))  AS 'business_in_$'
FROM sakila.store s, sakila.staff st, sakila.payment p
WHERE s.store_id = st.store_id
AND st.staff_id = p.staff_id
GROUP BY s.store_id;

-- 3. Which film categories are longest
SELECT c.name AS category_name, AVG(f.length) AS average_duration
FROM sakila.film f, sakila.film_category fc, sakila.category c
WHERE f.film_id = fc.film_id
AND fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_duration DESC
LIMIT 5;

-- 4. Display the most frequently rented movies in descending order
SELECT f.title, count(r.inventory_id) AS num_of_rentals
FROM sakila.rental r, sakila.inventory i, sakila.film f
WHERE r.inventory_id = i.inventory_id
AND i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY num_of_rentals DESC;

-- 5. List the top five genres in gross revenue in descending order
SELECT c.name AS genre, SUM(p.amount) AS gross_revenue
FROM sakila.payment p, sakila.rental r, sakila.inventory i, sakila.film_category fc, sakila.category c
WHERE p.rental_id = r.rental_id
AND r.inventory_id = i.inventory_id
AND i.film_id = fc.film_id
AND fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY gross_revenue DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1
SELECT f.title, s.store_id, COUNT(i.inventory_id) AS inventory
FROM sakila.store s 
JOIN sakila.inventory i USING(store_id)
JOIN sakila.film f USING(film_id)
WHERE f.title = 'Academy Dinosaur' AND store_id = 1
GROUP BY store_id;

-- 7. Get all pairs of actors that worked together
