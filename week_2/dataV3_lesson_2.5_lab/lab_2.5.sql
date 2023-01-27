-- Select all the actors with the first name ‘Scarlett’.
use sakila;

select * from sakila.actor
where first_name = "SCARLETT";

-- How many films (movies) are available for rent and how many films have been rented?

-- number of available movies
select distinct(count(film_id)) as available_for_rent from sakila.inventory;

-- total of films rented
select * from rental;
select count(rental_id) from rental;

-- What are the shortest and longest movie duration? Name the values max_duration and min_duration.

select * from film;
-- shortest movie
select title, length from sakila.film
order by length
limit 1;

-- longest movie
select title, length as max_duration from sakila.film
order by length desc
limit 1;

-- What's the average movie duration expressed in format (hours, minutes)?

select convert(avg(length),time) as "hours:minutes" from sakila.film;

-- How many distinct (different) actors' last names are there?

select * from sakila.actor;
select count(distinct last_name) from sakila.actor;

-- Since how many days has the company been operating (check DATEDIFF() function)?

select rental_date from rental;
select datediff(max(rental_date), min(rental_date)) as "days" from rental;

-- Show rental info with additional columns month and weekday. Get 20 results.

SELECT *,
date_format(CONVERT(left(rental_date,23),date), '%M') AS 'Month',
date_format(CONVERT(left(rental_date,23),date), '%W') AS 'Weekday'
FROM sakila.rental limit 20;


-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

select * from rental;
select CONVERT(rental_date,date)  from rental;

-- from Ferreira
SELECT *, date_format(CONVERT(left(rental_date,23),date), '%M') AS 'Month',
date_format(CONVERT(left(rental_date,23),date), '%W') AS 'Weekday',
CASE
WHEN date_format(CONVERT(left(rental_date,23),date), '%W') = 'Tuesday' then 'Week'
WHEN date_format(CONVERT(left(rental_date,23),date), '%W') = 'Monday' then 'Week'
WHEN date_format(CONVERT(left(rental_date,23),date), '%W') = 'Wednesday' then 'Week'
WHEN date_format(CONVERT(left(rental_date,23),date), '%W') = 'Friday' then 'Week'
WHEN date_format(CONVERT(left(rental_date,23),date), '%W') = 'Thursday' then 'Week'
ELSE 'Weekend'
END AS 'day'
FROM sakila.rental limit 20;

-- Get release years.

select * from sakila.film;
select distinct(release_year) from sakila.film;

-- Get all films with ARMAGEDDON in the title.

select title from sakila.film
WHERE title LIKE "%ARMA%";

-- Get all films which title ends with APOLLO.

select title from sakila.film
WHERE title LIKE "%APOLLO";

-- where right(title,
-- Get 10 the longest films.

select * from film;
select title, length from sakila.film
order by length desc
limit 10;

-- How many films include Behind the Scenes content?

SELECT COUNT(*) FROM sakila.film 
WHERE special_features LIKE '%Behind the Scenes%';
-- where instr(special_features, "Behind the Scenes%")


-- 