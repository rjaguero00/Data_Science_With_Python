-- QUESTION 1

WITH
    t1
    AS
    (
        SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
        FROM sales_reps s, accounts a, orders o, region r
        WHERE s.region_id = r.id AND s.id = a.sales_rep_id AND a.id = o.account_id
        GROUP BY 1,2
        ORDER BY 3 DESC
    ),

    t2
    AS
    (
        SELECT region_name, MAX(total_amt) total_amt
        FROM t1
        GROUP BY 1
    )

SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
    JOIN t2
    ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;

-- QUESTION 2

WITH
    t1
    AS
    (
        SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
        FROM sales_reps s, accounts a, orders o, region r
        WHERE s.region_id = r.id AND s.id = a.sales_rep_id AND a.id = o.account_id
        GROUP BY r.name
    ),

    t2
    AS
    (
        SELECT MAX(total_amt)
        FROM t1
    )

SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s, accounts a, orders o, region r
WHERE s.region_id = r.id AND s.id = a.sales_rep_id AND a.id = o.account_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT *
FROM t2);

-- QUESTION 3

WITH
    t1
    AS
    (
        SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
        FROM accounts a, orders o
        WHERE a.id = o.account_id
        GROUP BY 1
        ORDER BY 2 DESC
LIMIT 1
),

t2
    
     AS
(
    SELECT a.name
FROM accounts a, orders o
WHERE a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) > (SELECT total
FROM t1)
)

SELECT COUNT (*)
FROM t2;


-- QUESTION 4


WITH
    t1
    AS
    (
        SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
        FROM accounts a, orders o
        WHERE a.id = o.account_id
        GROUP BY 1, 2
        ORDER BY 3 DESC
LIMIT 1
)

SELECT a
    .name, w.channel, COUNT
(*)
FROM accounts a, web_events w
WHERE a.id = w.account_id AND a.id =
(SELECT id
FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC;

-- QUESTION 5

WITH
    t1
    AS
    (
        SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
        FROM accounts a, orders o
        WHERE a.id = o.account_id
        GROUP BY 1, 2
        ORDER BY 3 DESC
LIMIT 10  
)

SELECT AVG
    
    
    
     (tot_spent)
FROM t1;

-- QUESTION 6

WITH
    t1
    AS
    (
        SELECT AVG(o.total_amt_usd) avg_all
        FROM orders o, accounts a
        WHERE a.id = o.account_id
    ),
    t2
    AS
    (
        SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
        FROM orders o
        GROUP BY 1
        HAVING AVG(o.total_amt_usd) > (SELECT *
        FROM t1)
    )
SELECT AVG(avg_amt)
FROM t2;