-- Overall transaction performance

SELECT
	COUNT(*) AS total_transactions,
	SUM(amount) AS total_transaction_amount,
	ROUND(AVG(amount), 2) AS avg_transaction_amount,
	MAX(amount) AS max_transaction_amount,
	MIN(amount) AS min_transaction_amount
FROM transactions;

-- Transaction type analysis

SELECT 
	txn_type,
	COUNT(*) AS transaction_count,
	SUM(amount) AS total_amount,
	ROUND(AVG(amount), 2) AS avg_amount
FROM transactions
GROUP BY txn_type
ORDER BY total_amount DESC;

-- Transaction channel analysis

SELECT 
	channel,
	COUNT(*) AS transaction_count,
	SUM(amount) AS total_amount,
	ROUND(AVG(amount), 2) AS avg_amount
FROM transactions
GROUP BY channel
ORDER BY total_amount DESC;

-- Merchant Category/purpose analysis

SELECT 
	merchant_category,
	COUNT(*) AS transaction_count,
	SUM(amount) AS total_amount,
	ROUND(AVG(amount), 2) AS avg_amount
FROM transactions
GROUP BY merchant_category
ORDER BY total_amount DESC;

-- Monthly and yearly transaction trends

SELECT 
	DATE_TRUNC('month', txn_date)::DATE AS transaction_month,
	COUNT(*) AS transaction_count,
	SUM(amount) AS total_amount
FROM transactions
GROUP BY transaction_month
ORDER BY transaction_month;

-- Customer-level transaction analysis

SELECT 
	c.customer_id,
	c.name,
	COUNT(t.transaction_id) AS transaction_count,
	SUM(t.amount) AS total_amount,
	ROUND(AVG(t.amount), 2) AS avg_amount
FROM customers c
JOIN accounts a 
	ON c.customer_id = a.customer_id
JOIN transactions t
	ON a.account_id = t.transaction_id
GROUP BY c.customer_id, c.name
ORDER BY total_amount DESC
LIMIT 10;

-- Account_level analysis

SELECT 
	a.account_type,
	COUNT(t.transaction_id) AS transaction_count,
	SUM(t.amount) AS total_amount,
	ROUND(AVG(t.amount), 2) AS avg_amount
FROM accounts a
LEFT JOIN transactions t 
	ON a.account_id = t.account_id
GROUP BY a.account_type
ORDER BY total_amount DESC;
	