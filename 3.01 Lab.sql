USE sakila;
-- Activity 1
-- 1. Drop column picture from staff.
ALTER TABLE sakila.staff
DROP COLUMN picture;

SELECT * FROM sakila.staff;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO staff 
VALUES
(3,"Tammy", "Sanders", 79, "TAMMY.SANDERS@sakilacustomer.org", 2, 1, "Tammy", NULL, "2006-02-15 04:57:20");

SELECT * FROM sakila.staff;
-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. 

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; -- customr_id = 130, rental_id = 16050 (the last one was 16049), rental date = '2023-03-06 13:23:23', inventory_id = 1, return_date null, Staff_id =1, last_update = '2023-03-06 13:23:23'

INSERT INTO sakila.rental 
VALUES
(16050,'2023-03-06 13:23:23', 1,  130, NULL, 1,'2023-03-06 13:23:23');

SELECT * FROM sakila.rental;

-- Activity 2
-- Use dbdiagram.io or draw.io to propose a new structure for the Sakila database. # Solo quiere que demos 3 proposals, para eso podemos usar los join para demostrar la proposal. Define primary keys and foreign keys for the new database.

-- I will concat film_actor and actor tables where film_id will be the primary key and I will only have one actor_id. In this case helps me to know which actor is working in each film.
-- SELECT f.film_id, a.first_name, a.last_name,a.actor_id, f.last_update 
-- FROM sakila.actor a
-- JOIN sakila.film_actor f
-- ON a.actor_id = f.actor_id
-- ORDER BY f.film_id;

-- I will concat film_category and cateogry tables where film_id will be the primary key and I will only have one category_id. In this case helps me to know the category name itself.
-- SELECT f.film_id, c.category_id, c.name AS category, f.last_update 
-- FROM sakila.category c
-- JOIN sakila.film_category f
-- ON c.category_id = f.category_id
-- ORDER BY f.film_id;

-- I will concat city and country tables where city_id will be the primary key and I will only have one country_id. In this case I don't think these tables are very relevant, so I prefer to join them together.
-- SELECT c.city_id, c.city, c.country_id, co.country, c.last_update 
-- FROM sakila.city c
-- JOIN sakila.country co
-- ON c.country_id = co.country_id
-- ORDER BY c.city_id;