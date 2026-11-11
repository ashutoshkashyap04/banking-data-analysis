-- Overall banking KPIs

SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,

    (SELECT COUNT(*) FROM accounts) AS total_accounts,

    (SELECT COUNT(*) FROM branches) AS total_branches,

    (SELECT COUNT(*) FROM employees) AS total_employees,

    (SELECT COALESCE(SUM(balance), 0)
     FROM accounts) AS total_account_balance,

    (SELECT COUNT(*) FROM loans) AS total_loans,

    (SELECT COALESCE(SUM(loan_amount), 0)
     FROM loans) AS total_loan_amount,

    (SELECT COUNT(*) FROM transactions) AS total_transactions,

    (SELECT COALESCE(SUM(amount), 0)
     FROM transactions) AS total_transaction_amount,

    (SELECT COUNT(*) FROM cards) AS total_cards;

-- Customer and account overview

SELECT
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT a.customer_id) AS customers_with_accounts,
    COUNT(a.account_id) AS total_accounts,

    COUNT(DISTINCT c.customer_id)
        - COUNT(DISTINCT a.customer_id) AS customers_without_accounts,

    ROUND(
        COUNT(a.account_id)::NUMERIC /
        NULLIF(COUNT(DISTINCT a.customer_id), 0),
        2
    ) AS avg_accounts_per_customer

FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id;

-- Transaction Overview

SELECT
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_transaction_amount,
    ROUND(AVG(amount), 2) AS avg_transaction_amount,
    MAX(amount) AS highest_transaction,
    MIN(amount) AS lowest_transaction
FROM transactions;

-- Loan portfolio and repayment performance

SELECT
    (SELECT COUNT(*) FROM loans) AS total_loans,

    (SELECT COALESCE(SUM(loan_amount), 0)
     FROM loans) AS total_loan_amount,

    (SELECT COALESCE(SUM(amount_paid), 0)
     FROM loan_payments) AS total_repayments,

    (SELECT COALESCE(SUM(principal_component), 0)
     FROM loan_payments) AS principal_collected,

    (SELECT COALESCE(SUM(interest_component), 0)
     FROM loan_payments) AS interest_collected,

    (SELECT COUNT(*)
     FROM loans
     WHERE LOWER(status) = 'defaulted') AS defaulted_loans;

-- Card usage and fraud risk

SELECT
    COUNT(*) AS total_card_transactions,

    SUM(amount) AS total_card_transaction_amount,

    COUNT(*) FILTER (
        WHERE is_fraud = 1
    ) AS fraudulent_transactions,

    ROUND(
        COUNT(*) FILTER (
            WHERE is_fraud = 1
        ) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS fraud_percentage,

    COALESCE(
        SUM(amount) FILTER (WHERE is_fraud = 1),
        0
    ) AS fraudulent_transaction_amount

FROM card_transactions;

-- Customer support performance

SELECT
    COUNT(*) AS total_tickets,

    COUNT(*) FILTER (
        WHERE LOWER(status) = 'resolved'
    ) AS resolved_tickets,

    COUNT(*) FILTER (
        WHERE LOWER(status) <> 'resolved'
    ) AS unresolved_tickets,

    ROUND(
        COUNT(*) FILTER (
            WHERE LOWER(status) = 'resolved'
        ) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS resolution_percentage,

    ROUND(AVG(satisfaction_score), 2)
        AS avg_satisfaction_score

FROM support_tickets;

-- Branch performance comparison

SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    COUNT(a.account_id) AS total_accounts,
    COUNT(DISTINCT a.customer_id) AS total_customers,
    COALESCE(SUM(a.balance), 0) AS total_account_balance
FROM branches b
LEFT JOIN accounts a
    ON b.branch_id = a.branch_id
GROUP BY b.branch_id, b.branch_name, b.city
ORDER BY total_account_balance DESC;