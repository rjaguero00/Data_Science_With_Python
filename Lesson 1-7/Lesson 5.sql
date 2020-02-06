-- QUIZ LEFT & RIGHT

-- QUESTION 1

SELECT RIGHT(website, 3) AS domain, COUNT(*) domain_total
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

-- QUESTION 2

SELECT LEFT(name, 1), COUNT(*) diff_comp
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

-- QUESTION 3

SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 1 ELSE 0 END AS num,
        CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 0 ELSE 1 END AS letter
    FROM accounts) t1;


-- QUESTION 4

SELECT SUM(vowel) vowels, SUM(nope) no_vowel
FROM (
    SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('A', 'E', 'I', 'O', 'U') THEN 1 ELSE 0 END AS vowel,
        CASE WHEN LEFT(UPPER(name), 1) IN ('A', 'E', 'I', 'O', 'U') THEN 0 ELSE 1 END AS nope
    FROM accounts
) t1;

QUIZ POSITION, STRPOS, & SUBSTR

-- QUESTION 1

SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) AS first_name,
    RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM accounts;

-- QUESTION 2

SELECT LEFT(name, STRPOS(name, ' ') -1) AS first_name,
    RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM sales_reps;

-- QUIZ 3 CONCAT

-- QUESTION 1
WITH
    t1
    AS
    (
        SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
            RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
        FROM accounts
    )
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com')
FROM t1;

-- QUESTION 2
WITH
    t1
    AS
    (
        SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
            RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
        FROM accounts
    )
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', REPLACE(name, ' ', ''), '.com')
FROM t1;

-- QUESTION 3

WITH
    t1
    AS
    (
        SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name, RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
        FROM accounts
    )
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com'), LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;


-- QUIZ CAST

-- QUESTION 1

SELECT *
FROM sf_crime_data
LIMIT
10;

-- QUESTION 2

SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2)) new_date
FROM sf_crime_data;

--QUESTION 3

SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2))
::DATE new_date
FROM sf_crime_data;

-- QUIZ COALESCE

-- QUESTION 1

SELECT *
FROM accounts a
    LEFT JOIN orders o
    ON a.id = o.account_id
WHERE o.total IS NULL;

-- QUESTION 2

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
    LEFT JOIN orders o
    ON a.id = o.account_id
WHERE o.total IS NULL;

-- QUESTION 3

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, o.total, o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
FROM accounts a
    LEFT JOIN orders o
    ON a.id = o.account_id
WHERE o.total IS NULL;

-- QUESTION 4

SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty, COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
    LEFT JOIN orders o
    ON a.id = o.account_id
WHERE o.total IS NULL;

-- QUESTION 5
