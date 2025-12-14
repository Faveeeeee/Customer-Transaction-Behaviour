CREATE DATABASE Customer_Transaction_Behaviour;

-- 1) Who are the highest-value customers?
SELECT 
    customer_id,
    ROUND(SUM(amount), 2) AS total_spent
FROM transactions
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- 2) Which countries hold the most financial value?
SELECT 
    country,
    ROUND(AVG(balance), 2) AS avg_balance,
    COUNT(*) AS customer_count
FROM customers
GROUP BY country
ORDER BY avg_balance DESC;

-- 3)How does transaction activity evolve over time?
SELECT 
    YEAR(transaction_date) AS year,
    MONTH(transaction_date) AS month,
    ROUND(SUM(amount), 2) AS total_volume
FROM transactions
GROUP BY year, month
ORDER BY year, month;

-- 4)Which customers are at risk of inactivity (churn)?
SELECT 
    c.customer_id,
    c.balance
FROM customers c
LEFT JOIN transactions t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.balance
HAVING MAX(t.transaction_date) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    OR MAX(t.transaction_date) IS NULL;
    
-- 5)Do Premium accounts behave differently?
SELECT 
    c.account_type,
    ROUND(AVG(t.amount), 2) AS avg_transaction,
    COUNT(t.transaction_id) AS transaction_count
FROM transactions t
JOIN customers c
    ON t.customer_id = c.customer_id
GROUP BY c.account_type;

-- 6)Customer engagement score
SELECT 
    customer_id,
    COUNT(transaction_id) AS txn_count,
    ROUND(SUM(amount), 2) AS total_spent
FROM transactions
GROUP BY customer_id
ORDER BY txn_count DESC;

-- 7)Products driving engagement
SELECT 
    product_category,
    COUNT(DISTINCT customer_id) AS users
FROM products
GROUP BY product_category
ORDER BY users DESC;







