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
WITH t1 AS (
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com')
FROM t1;

-- QUESTION 2
WITH t1 AS (
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', REPLACE(name, ' ', ''), '.com')
FROM t1;

-- QUESTION 3

WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com'), LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;
