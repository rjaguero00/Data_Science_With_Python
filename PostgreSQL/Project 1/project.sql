-- Use this table to find the count of each movie category

SELECT name, COUNT(name) cat_total
FROM (SELECT f.title, c.name
    FROM film f, category c, film_category fc
    WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
    GROUP BY 1, 2
    ORDER BY 2) t1
GROUP BY 1;

-- 1. What are the Top 5 rented categories?

SELECT f.title, c.name, COUNT(r.rental_id) retntal_count
FROM film f, category c, film_category fc, rental r, inventory i
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND r.inventory_id = i.inventory_id AND f.film_id = i.film_id AND c.name IN ('Action', 'Animation', 'Children', 'Classics', 'Comedy', 'Documentary', 'Drama', 'Foreign', 'Games', 'Horror', 'New', 'Sci-Fi', 'Sports', 'Travel', 'Family', 'Music')
GROUP BY 1, 2
ORDER BY 2, 3 DESC;

-- 2. What are the total sales for these top 5 categories or what categories bring in the most sales?

-- Total sales from all categories
SELECT c.name, SUM(p.amount) total_rev
FROM category c, film_category fc, film f, inventory i, rental r, payment p
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND r.inventory_id = i.inventory_id AND f.film_id = i.film_id AND p.rental_id = r.rental_id
GROUP BY 1
ORDER BY 2 DESC;

-- Rental count and total sales 
WITH
    t1
    AS
    (
        SELECT c.name categories, COUNT(r.rental_id) retntal_count
        FROM film f, category c, film_category fc, rental r, inventory i
        WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND r.inventory_id = i.inventory_id AND f.film_id = i.film_id
        GROUP BY 1
        ORDER BY 2 DESC
    ),

    t2
    AS
    (
        SELECT c.name categories, SUM(p.amount) total_rev
        FROM category c, film_category fc, film f, inventory i, rental r, payment p
        WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND r.inventory_id = i.inventory_id AND f.film_id = i.film_id AND p.rental_id = r.rental_id
        GROUP BY 1
        ORDER BY 2 DESC
    )

SELECT t1.categories, t1.retntal_count, t2.total_rev
FROM t1, t2
WHERE t1.categories = t2.categories
ORDER BY 3 DESC;


-- 3. How many films were returned early, late, and on time?

WITH
    t1
    AS
    (
        SELECT rental_duration - DATE_PART('day', return_date - rental_date) AS days_rented
        FROM rental r, inventory i, film f
        WHERE r.inventory_id = i.inventory_id AND f.film_id = i.film_id
    )
SELECT CASE WHEN days_rented > 0 THEN 'Early'
            WHEN days_rented = 0 THEN 'On Time'
            ELSE 'Late' END AS rental_status,
    count(*),
    (100*count(*))/sum(count(*)) OVER () AS percentage
FROM t1
GROUP BY 1
ORDER BY 3 DESC;

-- Finds the number of days the film was rented for 
WITH
    t1
    AS
    (
        SELECT *, DATE_PART('day', return_date - rental_date) AS days_rented
        FROM rental
    ),
    -- We then use the days rented to find if the film was returned early, late, or on time 
    t2
    AS
    (
        SELECT rental_duration, days_rented,
            CASE WHEN rental_duration > days_rented THEN 'Early'
      WHEN rental_duration = days_rented THEN 'On Time'
      ELSE 'Late'
      END AS rental_return_status
        FROM film f, inventory i, t1
        WHERE f.film_id = i.film_id AND t1.inventory_id = i.inventory_id
    )
-- A count of the all movies rented and the status of their return 
SELECT rental_return_status, COUNT(*) AS total_films_rented
FROM t2
GROUP BY 1
ORDER BY 2 DESC;

-- 4. Is there a difference in inventory based on top categories?

WITH
    t1
    AS
    (
        SELECT f.title, f.film_id film, fc.category_id fc_category_id, c.name categories
        FROM film f, film_category fc, inventory i, category c
        WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND f.film_id = i.film_id
    )

SELECT categories, COUNT(*) num_copies
FROM t1
GROUP BY 1
ORDER BY 2 DESC;