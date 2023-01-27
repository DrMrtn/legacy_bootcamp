use sakila;

-- ##### Activity 1
-- ###### 1.Drop column picture from staff.
alter table sakila.staff
drop column picture;

select * from sakila.staff;

-- ###### 2.A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from sakila.customer
where first_name = "TAMMY";

select * from sakila.staff;
insert into sakila.staff(first_name, last_name,address_id, store_id, active, username) 
values 					('Tammy'   ,'Sanders' ,79        ,        1,      1,"Tammy");

select * from sakila.staff;

-- ###### 3.Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
--        You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and 
--        see what information you would need to add there. You can query those pieces of information. 
--        For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
select * from customer; -- her id = 130
select * from sakila.rental;
select * from film; -- film_id =1 | 2 | 3 | 4
select * from inventory; -- inventory_id = 1

insert into sakila.rental (rental_date, inventory_id, customer_id, staff_id)
values ( "2021-06-27 04:13:17",1,130, 1);


-- Activity 2

-- merging actor with film_actor -> less joins, 2 relativly small tables
-- merging category with film_category -> see above
-- merging language with film -> see above
-- merging country with city -> see above
-- result: database is more compact
