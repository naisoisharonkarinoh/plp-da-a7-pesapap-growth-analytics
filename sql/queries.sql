-- PesaPap Growth Analytics SQL Queries

-- Data validation: Check transactions that occurred before the user signed up.
SELECT
    COUNT(*) AS invalid_transaction_count
FROM transactions AS t
JOIN users AS u
    ON t.user_id = u.user_id
WHERE DATE(t.txn_date) < DATE(u.signup_date);
