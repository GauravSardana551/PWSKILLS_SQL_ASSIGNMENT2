use mavenmovies;
-- 1. Retrieve the total number of rentals made in the Sakila database
select count(rental_id) from rental;

-- 2. Find the average rental duration (in days) of movies rented from the Sakila database.
select avg(rental_duration) from film;

-- 3. Display the first name and last name of customers in uppercase. 
select upper(first_name), upper(last_name) from customer ;

-- 4 Extract the month from the rental date and display it alongside the rental ID.
select rental_id, month(rental_date) from rental;

-- 5. Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
select customer_id,count(rental_id) from rental group by customer_id;

-- 6 Find the total revenue generated by each store.
SELECT 
    c.store_id, SUM(amount) AS total_revenue
FROM
    payment AS a
        LEFT JOIN
    staff AS b ON a.staff_id = b.staff_id
        left JOIN
    store AS c ON b.store_id = c.store_id
GROUP BY c.store_id;

-- 7 Display the title of the movie, customer's first name, and last name who rented it.
SELECT 
    a.title, CONCAT(first_name, ' ', last_name) AS name
FROM
    film AS a
        INNER JOIN
    inventory AS b ON a.film_id = b.film_id
        INNER JOIN
    rental AS c ON b.inventory_id = c.inventory_id
        INNER JOIN
    customer AS d ON c.customer_id = d.customer_id;

-- 8 Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
SELECT 
    CONCAT(first_name, ' ', last_name) AS Actor_name, c.title
FROM
    actor AS a
        INNER JOIN
    film_actor AS b ON a.actor_id = b.actor_id
        INNER JOIN
    film AS c ON b.film_id = c.film_id
WHERE
    c.title = 'Gone with the Wind';
    
    -- 9 Determine the total number of rentals for each category of movies
SELECT 
    COUNT(rental_id), b.category_id
FROM
    rental AS a
        INNER JOIN
    film_category AS b ON a.inventory_id = b.category_id
        INNER JOIN
    film AS c ON b.film_id = c.film_id
GROUP BY b.category_id;

-- 10 Find the average rental rate of movies in each language. 
select avg( rental_rate),b.name from film as a left join language as b on a.language_id=b.language_id 
group by name;

-- 11 Retrieve the customer names along with the total amount they've spent on rentals
select concat(first_name," ", last_name) as name, sum(amount) as total_amaount from customer as a inner join rental as b on a.customer_id=b.customer_id
inner join payment as c on b.rental_id=c.rental_id group by name;

-- 12 List the titles of movies rented by each customer in a particular city (e.g., 'London'). 
select  a.title, f.city,concat(first_name," ",last_name) as name from film as a inner join inventory as b on a.film_id=b.film_id inner join rental as c on b.inventory_id=c.inventory_id
inner join customer as d on c.customer_id=d.customer_id inner join address as e on d.address_id=e.address_id
inner join city as f on e.city_id=f.city_id group by city;

-- 13 Display the top 5 rented movies along with the number of times they've been rented. 
SELECT 
    a.title, COUNT(a.film_id) AS no_of_times
FROM
    film AS a
        INNER JOIN
    inventory AS b ON a.film_id = b.film_id
        INNER JOIN
    rental AS c ON b.inventory_id = c.inventory_id
GROUP BY title
ORDER BY no_of_times DESC
LIMIT 5;

-- 14 Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
SELECT 
    a.customer_id, a.first_name, a.last_name
FROM
    customer AS a
        INNER JOIN
    rental AS b ON a.customer_id = b.customer_id
        INNER JOIN
    inventory AS c ON b.inventory_id = c.inventory_id
        INNER JOIN
    store AS d ON c.store_id = d.store_id
WHERE
    d.store_id IN (1 , 2)
GROUP BY a.customer_id , a.first_name , a.last_name
HAVING COUNT(DISTINCT d.store_id) = 2;