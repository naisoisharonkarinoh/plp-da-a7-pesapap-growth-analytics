-- PesaPap Growth Analytics SQL Queries

-- Data validation: Check transactions that occurred before the user signed up.
SELECT
    COUNT(*) AS invalid_transaction_count
FROM transactions AS t
JOIN users AS u
    ON t.user_id = u.user_id
WHERE DATE(t.txn_date) < DATE(u.signup_date);
 
-- (a) Business question: What is the total transaction value and number of transactions for each product?
SELECT
    product,
    SUM(amount) AS total_transaction_value,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY product
ORDER BY total_transaction_value DESC;
 
-- (b) Business question: Which five counties have the highest total transaction value?
SELECT
    u.county,
    SUM(t.amount) AS total_transaction_value
FROM transactions AS t
JOIN users AS u
    ON t.user_id = u.user_id
GROUP BY u.county
ORDER BY total_transaction_value DESC
LIMIT 5;
 
-- (c) Business question: What is the monthly transaction value and cumulative running total?
WITH monthly_sales AS (
    SELECT
        strftime('%Y-%m', txn_date) AS month,
        SUM(amount) AS monthly_transaction_value
    FROM transactions
    GROUP BY strftime('%Y-%m', txn_date)
)
SELECT
    month,
    monthly_transaction_value,
    SUM(monthly_transaction_value) OVER (
        ORDER BY month
    ) AS running_total
FROM monthly_sales
ORDER BY month;
 
-- (d) Business question: Which acquisition channels generate the highest transaction value?
SELECT
    u.acquisition_channel,
    SUM(t.amount) AS total_transaction_value,
    COUNT(t.txn_id) AS transaction_count
FROM users AS u
JOIN transactions AS t
    ON u.user_id = t.user_id
GROUP BY u.acquisition_channel
ORDER BY total_transaction_value DESC;
 
-- (e) Business question: Who are the top 10 users by total transaction value?
SELECT
    t.user_id,
    SUM(t.amount) AS total_transaction_value,
    RANK() OVER (
        ORDER BY SUM(t.amount) DESC
    ) AS user_rank
FROM transactions AS t
GROUP BY t.user_id
ORDER BY user_rank
LIMIT 10;
 
-- (f) Business question: Which products have an average transaction amount above KES 1,300?
SELECT
    product,
    AVG(amount) AS average_transaction_value,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY product
HAVING AVG(amount) > 1300
ORDER BY average_transaction_value DESC;
 
-- (g) Business question: How many users fall into each transaction value tier?
WITH user_values AS (
    SELECT
        user_id,
        SUM(amount) AS total_value
    FROM transactions
    GROUP BY user_id
),
user_tiers AS (
    SELECT
        user_id,
        total_value,
        CASE
            WHEN total_value >= 10000 THEN 'High'
            WHEN total_value >= 4000 THEN 'Medium'
            ELSE 'Low'
        END AS value_tier
    FROM user_values
)
SELECT
    value_tier,
    COUNT(*) AS user_count
FROM user_tiers
GROUP BY value_tier
ORDER BY
    CASE value_tier
        WHEN 'High' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Low' THEN 3
    END;
