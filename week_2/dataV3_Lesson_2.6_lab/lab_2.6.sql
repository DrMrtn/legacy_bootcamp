-- In the table actor, which are the actors whose last names are not repeated? For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.
USE sakila;

SELECT first_name,last_name from sakila.actor;
SELECT first_name, last_name
FROM sakila.actor
GROUP BY  last_name
HAVING COUNT(last_name) = 1;

-- Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once

SELECT first_name, last_name, count(*)
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;


--  Using the rental table, find out how many rentals were processed by each employee.

select * from sakila.rental;
SELECT count(DISTINCT rental_id), staff_id FROM sakila.rental
GROUP BY staff_id;

-- Using the film table, find out how many films were released each year.

SELECT * from sakila.film;
select count(title), release_year from sakila.film
GROUP BY release_year;


-- Using the film table, find out for each rating how many films were there.

SELECT count(title) as films, rating from sakila.film
group by rating;

--  What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT count(title) as films, rating, round(avg(length),2) as mean_length
from sakila.film
GROUP BY rating
having mean_length;


-- Which kind of movies (rating) have a mean duration of more than two hours?

SELECT count(title) as films, rating, round(avg(length),2) as mean_length -- round(avg(length),2) ist ein aggregat
from sakila.film
GROUP BY rating
having mean_length > 120;

-- Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.

select count(length) over (partition by title) as "rank" -- does not work
from sakila.film
 where length > 0 and length is not null
GROUP BY title asc;

-- from Philip
SELECT
	RANK() OVER(ORDER BY sakila.film.length DESC) AS ‘Rank’
    ,sakila.film.title
    , sakila.film.length
    #rank
FROM
    sakila.film
WHERE
	length is not null
AND
	length > 0
ORDER BY
	length desc;
    
    select title, length
    from film
    where length != 0 and length is not null
    order by length desc