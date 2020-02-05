-- Use this table to find the count of each movie category

SELECT name, COUNT(name) cat_total
FROM (SELECT f.title, c.name
    FROM film f, category c, film_category fc
    WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
    GROUP BY 1, 2
    ORDER BY 2) t1
GROUP BY 1;

-- 1. 

SELECT f.title, c.name, COUNT(r.rental_id)
FROM film f, category c, film_category fc, rental r, inventory i
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND r.inventory_id = i.inventory_id AND f.film_id = i.film_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY 1, 2
ORDER BY 3 DESC;

-- 2. 
