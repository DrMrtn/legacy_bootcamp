-- ##### 1 How many films are there for each of the categories in the category table. Use appropriate join to write this query.
USE sakila;

select * from category;

select count(f.film_id), fc.category_id
from sakila.film f
join sakila.category fc
on f.film_id = fc.film_id
group by name;

-- ##### 2 2Display the total amount rung up by each staff member in August of 2005.
select convert(month(payment_date),datetime), year(payment_date) -- testing
from sakila.payment;

select sum(p.amount), s.staff_id -- month(p.payment_date) as "month", year(payment_date) as "year" -- doesnt work if both are in select
from sakila.payment p
join sakila.staff s
on p.staff_id = s.staff_id
where month(p.payment_date) = 8 and year(payment_date) = 2005
group by staff_id;


-- ##### 3 Which actor has appeared in the most films?

SELECT a.actor_id, concat(a.first_name, ' ', a.last_name) as 'Name', count(distinct (fa.film_id))as appearence
FROM sakila.film f
JOIN sakila.film_actor fa using (film_id)
JOIN sakila.actor a using (actor_id)
GROUP BY actor_id
ORDER BY appearence desc;
-- limit 1;

-- ##### 4 Most active customer (the customer that has rented the most number of films)
-- looking for right tables
select * from sakila.rental; -- costumer_id
select * from sakila.payment;

-- raw
select *
from sakila.rental r
join sakila.payment p using (rental_id);

-- refinded
select count(r.rental_id), r.customer_id
from sakila.rental r
join sakila.payment p using (rental_id)
GROUP BY r.customer_id
order by count(r.rental_id) desc
limit 1;


-- ##### 5 Display the first and last names, as well as the address, of each staff member.
-- looking for right tables
select * from sakila.staff; -- first + last name
select * from sakila.address; -- adresses

-- raw
select *
from sakila.staff s
join sakila.address a using (address_id);

-- refined
select concat(s.first_name,' ',s.last_name) as "Name", a.address as "Address"
from sakila.staff s
join sakila.address a using (address_id)
group by staff_id;

-- ##### 6 List each film and the number of actors who are listed for that film.
-- looking for right tables
select * from film; -- list of all films
select * from film_actor; -- show what actor in which film

-- raw
select *
from sakila.film f
join sakila.film_actor fa using (film_id);

-- refined
select title, actor_id
from sakila.film f
join sakila.film_actor fa using (film_id)
group by film_id;

-- ##### 7 Using the tables payment and customer and the JOIN command, 
-- 		   List the total paid by each customer. 
-- 		   List the customers alphabetically by last name.
-- looking for right tables
select * from payment; -- amount of payments
select * from customer; -- last name

-- raw
select *
from sakila.payment p
join sakila.customer c using (customer_id);

-- refined
select sum(amount), last_name
from sakila.payment p
join sakila.customer c using (customer_id)
group by last_name
order by last_name asc;

-- ##### 8 List number of films per category.
-- looking for right tables
select * from sakila.film; -- film_id
select * from sakila.film_category; -- rating

-- raw
select *
from sakila.film f
join sakila.film_category fc using (film_id);

-- refined
select  count(f.film_id) as "number of films", rating
from sakila.film f
join sakila.film_category fc using (film_id)
group by rating;