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
