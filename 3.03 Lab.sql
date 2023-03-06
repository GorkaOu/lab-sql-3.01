USE sakila;
-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT film_id, COUNT(inventory_id) AS copy
FROM inventory
WHERE film_id IN
   (SELECT film_id
   FROM film
   WHERE title LIKE 'Hunchback Impossible')
GROUP BY film_id;


-- 2. List all films whose length is longer than the average of all the films.
SELECT title AS film, length
FROM film
WHERE length > (SELECT avg(length) AS average
FROM film);
      

-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name 
FROM sakila.actor
WHERE actor_id IN (SELECT actor_id 
FROM sakila.film_actor 
WHERE film_id = 17);

-- Another way
 
SELECT first_name, last_name 
FROM sakila.actor
WHERE actor_id IN (SELECT actor_id 
FROM sakila.film_actor 
WHERE film_id = (SELECT film_id FROM sakila.film WHERE title = 'Alone Trip'));

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT title 
FROM sakila.film
WHERE film_id IN (SELECT film_id 
FROM sakila.film_category 
WHERE category_id = (SELECT category_id FROM sakila.category WHERE name = 'Family'));

-- Another way 
SELECT title 
FROM sakila.film
WHERE film_id IN (SELECT film_id 
FROM sakila.film_category 
WHERE category_id = 8);

-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
-- Subqueries 
SELECT first_name, last_name, email FROM sakila.customer
WHERE address_id IN (SELECT address_id FROM sakila.address
WHERE city_id IN (SELECT city_id FROM sakila.city
WHERE country_id IN (SELECT country_id 
FROM sakila.country
WHERE country ="Canada")));

-- Joins
SELECT first_name, last_name, email
FROM country c
JOIN city ci
USING(country_id)
JOIN address
USING(city_id)
JOIN customer
USING(address_id)
WHERE COUNTRY = 'Canada';
-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT film_id,title FROM film 
WHERE film_id IN
(SELECT film_id FROM film_actor 
WHERE actor_id=(SELECT actor_id FROM film_actor
 GROUP BY actor_id 
 ORDER BY COUNT(film_id) 
 DESC LIMIT 1));


-- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
SELECT film_id, title FROM film
WHERE film_id IN
(SELECT film_id FROM inventory
WHERE inventory_id IN 
(SELECT inventory_id FROM rental 
WHERE customer_id=
(SELECT customer_id FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 1)));

-- 8. Customers who spent more than the average payments.
SELECT first_name, last_name
FROM customer
WHERE customer.customer_id IN (
    SELECT payment.customer_id
    FROM payment
    GROUP BY payment.customer_id
    HAVING AVG(payment.amount) > (
        SELECT AVG(amount)
        FROM payment
 ));