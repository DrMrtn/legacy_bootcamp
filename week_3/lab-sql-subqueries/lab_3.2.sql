-- ################################################################################################# --
-- ## For the sake of clarity and sanity of my mind,											   # --
-- ## I left on purpose the sakila or any other prefix to unterstand the whole concept better.	   # --
-- ## I also refrained from the typical SQL query structure,									   # --
-- ## and packed my queries in just a few lines of code (see my classmates solution for comparison)# --
-- ################################################################################################# --

use sakila;

-- ###### 1. How many copies of the film Hunchback Impossible exist in the inventory system?
select * from film; -- film_id = 439
select * from inventory;

select count(film_id) as "Copies" from inventory
where film_id =
	(select film_id from film
    where title = "Hunchback Impossible");


-- ###### 2. List all films whose length is longer than the average of all the films.

select film.title from film
where length > ( select avg(length) 
			from sakila.film
            );

-- ###### 3. Use subqueries to display all actors who appear in the film Alone Trip.


select first_name from sakila.actor;
select actor_id from film_actor;
select film_id from film
where title ="Alone Trip";

select first_name, last_name from sakila.actor
where actor_id in
			(select actor_id from film_actor 
            where film_id =
				(select film_id from film
				where title ="Alone Trip"));



-- ###### 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
-- select category_id from category
-- where name = "Family";
-- select * from film_category
-- where category_id =;

select title from film
where film_id in 
	( select film_id from film_category
    where category_id =
		(select category_id from category
		 where name = "Family"));
				

-- ###### 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
-- ##### with subquery
select city_id from address; -- where city_id in (
select country_id from city; -- where country_id =(
select country_id from country; -- where country = "Canada";


select first_name, last_name, email from customer
where address_id in
	( select address_id from address
    where city_id in
		(select city_id from city
        where country_id =
			(select country_id from country
            where country = "Canada")));

-- ##### with join -> that was so much faster to type

select first_name, last_name, email 
from customer
join address using (address_id)
join city using (city_id)
join country using (country_id)
where country = "Canada";


-- ###### 6. Which are films starred by the most prolific actor? 
-- 	         Most prolific actor is defined as the actor that has acted in the most number of films. 
-- 			 First you will have to find the most prolific actor and 
--           then use that actor_id to find the different films that he/she starred.
-- #### 
select * from film; -- title
select * from film_actor; -- actor_id, count(film_id)

select title from film
where film_id in
	(select film_id from film_actor
    where actor_id =
		(select actor_id from film_actor
        group by actor_id
        order by count(distinct film_id) desc
        limit 1));
        

-- ### Philips solution

SELECT 
	film.title
FROM 
	sakila.film
WHERE film_id IN
	(
    SELECT 
		film_actor.film_id
	FROM
		sakila.film_actor
	WHERE film_actor.actor_id IN
		(SELECT 
			foo.actor_id 
		FROM
			(
			SELECT
				actor_id
				, count(film_actor.film_id) AS counts
			FROM
				film_actor
			GROUP BY 
				actor_id
			ORDER BY
				counts DESC
			Limit
				1
		) as foo)
	)
;

-- ###### 7. Films rented by most profitable customer. 
-- 			 You can use the customer table and payment table to find the most profitable 
-- 			 customer ie the customer that has made the largest sum of payments

select * from payment; -- amount, rental_id
select * from customer; -- customer_id
select * from inventory; -- inventory_id
select * from film; -- title

select title from film
where film_id in	
	(select film_id from inventory
	where inventory_id in
		(select inventory_id from rental
		where customer_id =
			(select customer_id from payment
			group by customer_id
			order by sum(amount)desc
			limit 1)));

-- ### Philips solution
SELECT
	film.title
FROM
	sakila.film
WHERE film.film_id IN
	(
    SELECT 
		inventory.film_id
	FROM
		sakila.inventory
	WHERE inventory.inventory_id IN
		(
		SELECT
			rental.inventory_id
		FROM
			sakila.rental
		WHERE
			rental.customer_id IN
            (
            SELECT
				customer.customer_id
			FROM
				sakila.customer
			WHERE customer.customer_id IN
				(SELECT 
					foo.customer_id 
				FROM
					(
					SELECT 
						payment.customer_id
						, sum(payment.amount) AS pay
					FROM
						sakila.payment
					GROUP BY
						payment.customer_id
					ORDER BY 
						pay DESC
					LIMIT
						1
					) AS foo
				)
			)
        )    
     )       
;



-- ###### 8. Customers who spent more than the average payments.

select * from customer;
select * from payment;

select customer_id, first_name, last_name from customer
where customer_id in
	(select customer_id from payment
    where amount >
		(select avg(amount) from payment));



