-- Overall card portfolio analysis
SELECT
    COUNT(*) AS total_cards,
    SUM(credit_limit) AS total_credit_limit,
    ROUND(AVG(credit_limit), 2) AS avg_credit_limit,
    MAX(credit_limit) AS max_credit_limit,
    MIN(credit_limit) AS min_credit_limit
FROM cards;

-- Card type analysis

SELECT
    card_type,
    COUNT(*) AS total_cards,
    SUM(credit_limit) AS total_credit_limit,
    ROUND(AVG(credit_limit), 2) AS avg_credit_limit,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS card_percentage
FROM cards
GROUP BY card_type
ORDER BY total_cards DESC;

-- Card status analysis

SELECT
	status,
	COUNT(*) AS total_cards,
	ROUND(
		COUNT(*) * 100 / SUM(COUNT(*)) OVER (),
		2
	) AS percentage
FROM cards
GROUP BY status
ORDER BY total_cards DESC;

-- Expired cards
SELECT
    COUNT(*) AS expired_cards
FROM cards
WHERE expiry_date < CURRENT_DATE;


-- Card issuance trends
SELECT
    DATE_TRUNC('month', issue_date)::DATE AS issue_month,
    COUNT(*) AS cards_issued
FROM cards
GROUP BY issue_month
ORDER BY issue_month;

-- Overall card transaction analysis
SELECT
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_transaction_amount,
    ROUND(AVG(amount), 2) AS avg_transaction_amount,
    MAX(amount) AS max_transaction_amount,
    MIN(amount) AS min_transaction_amount
FROM card_transactions;

-- Merchant category analysis
SELECT
    merchant_category,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount), 2) AS avg_amount
FROM card_transactions
GROUP BY merchant_category
ORDER BY total_amount DESC;

-- Card transaction trends
SELECT
    DATE_TRUNC('month', txn_date)::DATE AS transaction_month,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount), 2) AS avg_amount
FROM card_transactions
GROUP BY transaction_month
ORDER BY transaction_month;

-- Fraud analysis
SELECT
    COUNT(*) AS total_transactions,

    COUNT(*) FILTER (
        WHERE is_fraud = 1
    ) AS fraudulent_transactions,

    ROUND(
        COUNT(*) FILTER (
            WHERE is_fraud = 1
        ) * 100.0 / COUNT(*),
        2
    ) AS fraud_percentage,

    SUM(amount) FILTER (
        WHERE is_fraud = 1
    ) AS fraudulent_amount

FROM card_transactions;

-- Fraud by merchant category
SELECT
    merchant_category,
    COUNT(*) FILTER (
        WHERE is_fraud = 1
    ) AS fraud_count,
    SUM(amount) FILTER (
        WHERE is_fraud = 1
    ) AS fraud_amount
FROM card_transactions
GROUP BY merchant_category
ORDER BY fraud_count DESC;

-- Card level transaction analysis
SELECT
    c.card_type,
    COUNT(ct.card_txn_id) AS transaction_count,
    SUM(ct.amount) AS total_amount,
    ROUND(AVG(ct.amount), 2) AS avg_transaction_amount
FROM cards c
LEFT JOIN card_transactions ct
    ON c.card_id = ct.card_id
GROUP BY c.card_type
ORDER BY total_amount DESC;