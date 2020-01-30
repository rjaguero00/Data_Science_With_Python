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