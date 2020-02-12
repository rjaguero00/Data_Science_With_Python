-- 1.

SELECT a.first_name, a.last_name,
    CONCAT(first_name, ' ', last_name)full_name, f.title, f.description, f.length
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

-- 1.

SELECT full_name,
    filmtitle,
    filmlen,
    CASE WHEN filmlen <= 60 THEN '1 hour or less'
       WHEN filmlen > 60 AND filmlen <= 120 THEN 'Between 1-2 hours'
       WHEN filmlen > 120 AND filmlen <= 180 THEN 'Between 2-3 hours'
       ELSE 'More than 3 hours' END AS filmlen_groups
FROM
    (SELECT a.first_name, a.last_name,
        CONCAT(first_name, ' ', last_name)full_name, f.title filmtitle, f.description, f.length filmlen
    FROM actor a, film_actor fa, film f
    WHERE a.actor_id = fa.actor_id AND f.film_id = fa.film_id
    ORDER BY filmlen) t1;

-- 2.

SELECT DISTINCT (filmlen_groups), COUNT(title) OVER (PARTITION BY filmlen_groups) AS filmcount_bylencat
FROM (SELECT title, length,
        CASE WHEN length <= 60 THEN '1 hour or less'
          WHEN length > 60 AND length <= 120 THEN 'Between 1-2 hours'
          WHEN length > 120 AND length <= 180 THEN 'Between 2-3 hours'
          ELSE 'More than 3 hours' END AS filmlen_groups
    FROM film) t1
ORDER BY filmlen_groups;
