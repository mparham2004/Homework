 -- 1a. Display the first and last names of all actors from the table actor.

use sakila;
select first_name, last_name from sakila.actor;

 -- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
ALTER TABLE sakila.actor
ADD COLUMN Full_name VARCHAR(45) First;
SELECT CONCAT(first_name, ' ', last_name) AS 'Full_name' FROM sakila.actor;


 -- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select actor_id, first_name, last_name from sakila.actor
where first_name = "Joe";

 -- 2b. Find all actors whose last name contain the letters GEN:
select actor_id, first_name, last_name from sakila.actor
where last_name like '%GEN%';

 -- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
select last_name, first_name, actor_id from sakila.actor
where last_name like '%LI%'
order by last_name;

 -- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:

select country_id, country from sakila.country
where country in ("Afghanistan", "Bangladesh" , "China");

 -- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).
ALTER TABLE sakila.actor
ADD COLUMN description blob(400);

 -- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE sakila.actor
drop COLUMN description;

 -- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name from sakila.actor;

 -- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT last_name, GROUP_CONCAT(first_name)
FROM sakila.actor
GROUP BY last_name
HAVING COUNT(*) > 1;

 -- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
 
UPDATE sakila.actor SET first_name='Harpo' WHERE first_name='Groucho' and last_name = 'Williams';

 -- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
UPDATE sakila.actor SET first_name='Groucho' WHERE first_name ='Harpo';

 -- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?

show create table sakila.address;

 -- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT first_name, last_name, address
FROM sakila.staff
LEFT JOIN sakila.address
ON staff.address_id = address.address_id;


 -- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT first_name, last_name, amount, payment_date
FROM sakila.staff
LEFT JOIN sakila.payment
ON staff.staff_id = payment.staff_id;

where str_to_date(payment_date, 'August 2005')
between 2005-08-01 2005-08-31;



 -- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT title, count(distinct(actor_id))
FROM  sakila.film
INNER JOIN sakila.film_actor ON film.film_id = film_actor.film_id
group by title;



 -- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select film_id
from sakila.film
where title = 'Hunchback Impossible';

select count(inventory_id)
from sakila.inventory
where film_id = 439;

 -- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:

SELECT last_name, amount
FROM sakila.customer
LEFT JOIN sakila.payment
ON customer.customer_id = payment.customer_id;


 -- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
select title, original_language_id
from sakila.film
where title like 'K%' or 'Q%';

 -- 7b. Use subqueries to display all actors who appear in the film Alone Trip.


SELECT actor_id
FROM sakila.film_actor
LEFT JOIN sakila.film
ON sakila.film.film_id = sakila.film_actor.film_id
where title = 'Alone Trip';


 -- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.


7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.


7e. Display the most frequently rented movies in descending order.


7f. Write a query to display how much business, in dollars, each store brought in.


7g. Write a query to display for each store its store ID, city, and country.


7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)


8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.


8b. How would you display the view that you created in 8a?


8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
