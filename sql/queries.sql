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
