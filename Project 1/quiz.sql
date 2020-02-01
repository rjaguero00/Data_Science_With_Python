-- 1.

SELECT a.first_name, a.last_name, 
CONCAT(first_name, ' ', last_name)full_name, f.title,f.description, f.length
FROM actor a, film_actor fa, film f
WHERE a.actor_id = fa.actor_id AND f.film_id = fa.film_id;

-- 2.

SELECT CONCAT(first_name, ' ', last_name)full_name, f.title, f.length
FROM actor a, film_actor fa, film f
WHERE a.actor_id = fa.actor_id AND f.film_id = fa.film_id AND f.length > 60
ORDER BY 3;

-- 3.

SELECT a.actor_id, CONCAT(first_name, ' ', last_name)full_name, COUNT(*) test_test
FROM actor a, film_actor fa, film f
WHERE a.actor_id = fa.actor_id AND f.film_id = fa.film_id
GROUP BY 1
ORDER BY 3 DESC;