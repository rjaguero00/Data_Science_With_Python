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








SELECT f.title, c.name, COUNT(r.rental_id)
FROM film f, category c, film_category fc, rental r, inventory i
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND r.inventory_id = i.inventory_id AND f.film_id = i.film_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY 1, 2
ORDER BY 3 DESC;



SELECT name, COUNT(name) cat_total
FROM (SELECT f.title, c.name
    FROM film f, category c, film_category fc
    WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND c.name IN ('Action', 'Animation', 'Children', 'Classics', 'Comedy', 'Documentary', 'Drama', 'Foreign', 'Games', 'Horror', 'New', 'Sci-Fi', 'Sports', 'Travel', 'Family', 'Music')
    GROUP BY 1, 2
    ORDER BY 2) t1
GROUP BY 1;


SELECT name, COUNT(name) cat_total
FROM (SELECT f.title, c.name, COUNT(r.rental_id)
    FROM film f, category c, film_category fc, rental r, inventory i
    WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND r.inventory_id = i.inventory_id AND f.film_id = i.film_id AND c.name IN ('Action', 'Animation', 'Children', 'Classics', 'Comedy', 'Documentary', 'Drama', 'Foreign', 'Games', 'Horror', 'New', 'Sci-Fi', 'Sports', 'Travel', 'Family', 'Music')
    GROUP BY 1, 2
    ORDER BY 2, 3 DESC) t1
GROUP BY 1
ORDER BY 2 DESC;




-- 2. 
SELECT name, COUNT(name) cat_total
FROM (SELECT f.title, c.name
    FROM film f, category c, film_category fc
    WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
    GROUP BY 1, 2
    ORDER BY 2) t1
GROUP BY 1;


SELECT f.title, c.name, COUNT(r.rental_id)
FROM film f, category c, film_category fc, rental r, inventory i
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND r.inventory_id = i.inventory_id AND f.film_id = i.film_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY 1, 2
ORDER BY 3 DESC;

SELECT f.title, c.name, COUNT(r.rental_id)
FROM film f, category c, film_category fc, rental r, inventory i
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND r.inventory_id = i.inventory_id AND f.film_id = i.film_id AND c.name IN ('Action', 'Animation', 'Children', 'Classics', 'Comedy', 'Documentary', 'Drama', 'Foreign', 'Games', 'Horror', 'New', 'Sci-Fi', 'Sports', 'Travel', 'Family', 'Music')
GROUP BY 1, 2
ORDER BY 3 DESC;

SELECT f.title, c.name, COUNT(r.rental_id)
FROM film f, category c, film_category fc, rental r, inventory i
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND r.inventory_id = i.inventory_id AND f.film_id = i.film_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY 1, 2
ORDER BY 3 DESC;

SELECT name, COUNT(name) cat_total
FROM (SELECT f.title, c.name
    FROM film f, category c, film_category fc
    WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
    GROUP BY 1, 2
    ORDER BY 2) t1
GROUP BY 1;