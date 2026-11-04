-- Checking total records in each table

SELECT 'customers' AS table_name, COUNT(*) FROM customers
UNION ALL
SELECT 'accounts', COUNT(*) FROM accounts
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL
SELECT 'loans', COUNT(*) FROM loans
UNION ALL
SELECT 'loan_payments', COUNT(*) FROM loan_payments
UNION ALL
SELECT 'cards', COUNT(*) FROM cards
UNION ALL
SELECT 'card_transactions', COUNT(*) FROM card_transactions
UNION ALL
SELECT 'branches', COUNT(*) FROM branches
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'support_tickets', COUNT(*) FROM support_tickets;


-- Checking duplicate primary key

-- table -> branches
SELECT branch_id, COUNT(*)
FROM branches
GROUP BY branch_id
HAVING COUNT(*) > 1;

-- table -> customers
SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- table -> employees
SELECT employee_id, COUNT(*)
FROM employees
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- table -> accounts
SELECT account_id, COUNT(*)
FROM accounts
GROUP BY account_id
HAVING COUNT(*) > 1;

-- table -> loans
SELECT loan_id, COUNT(*)
FROM loans
GROUP BY loan_id
HAVING COUNT(*) > 1;

-- table -> cards
SELECT card_id, COUNT(*)
FROM cards
GROUP BY card_id
HAVING COUNT(*) > 1;

-- table -> support_tickets
SELECT ticket_id, COUNT(*)
FROM support_tickets
GROUP BY ticket_id
HAVING COUNT(*) > 1;

-- table -> transactions
SELECT transaction_id, COUNT(*)
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- table -> loan_payments
SELECT payment_id, COUNT(*)
FROM loan_payments
GROUP BY payment_id
HAVING COUNT(*) > 1;

-- table -> card_transactions
SELECT card_txn_id, COUNT(*)
FROM card_transactions
GROUP BY card_txn_id
HAVING COUNT(*) > 1;

-- Checking null values 

-- Checking null values in table = branches

SELECT
    COUNT(*) FILTER (WHERE branch_id IS NULL) AS missing_branch_id,
    COUNT(*) FILTER (WHERE branch_name IS NULL) AS missing_branch_name,
    COUNT(*) FILTER (WHERE city IS NULL) AS missing_city,
    COUNT(*) FILTER (WHERE state IS NULL) AS missing_state,
    COUNT(*) FILTER (WHERE opened_date IS NULL) AS missing_opened_date,
    COUNT(*) FILTER (WHERE ifsc_code IS NULL) AS missing_ifsc_code
FROM branches;

-- Checking null values in table = customers

SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE name IS NULL) AS missing_name,
    COUNT(*) FILTER (WHERE gender IS NULL) AS missing_gender,
    COUNT(*) FILTER (WHERE date_of_birth IS NULL) AS missing_dob,
    COUNT(*) FILTER (WHERE city IS NULL) AS missing_city,
    COUNT(*) FILTER (WHERE state IS NULL) AS missing_state,
    COUNT(*) FILTER (WHERE phone IS NULL) AS missing_phone,
    COUNT(*) FILTER (WHERE email IS NULL) AS missing_email,
    COUNT(*) FILTER (WHERE occupation IS NULL) AS missing_occupation,
    COUNT(*) FILTER (WHERE annual_income IS NULL) AS missing_income,
    COUNT(*) FILTER (WHERE join_date IS NULL) AS missing_join_date,
    COUNT(*) FILTER (WHERE credit_score IS NULL) AS missing_credit_score
FROM customers;

-- Checking null values in table = employees

SELECT
    COUNT(*) FILTER (WHERE employee_id IS NULL) AS missing_employee_id,
    COUNT(*) FILTER (WHERE name IS NULL) AS missing_name,
    COUNT(*) FILTER (WHERE branch_id IS NULL) AS missing_branch_id,
    COUNT(*) FILTER (WHERE role IS NULL) AS missing_role,
    COUNT(*) FILTER (WHERE hire_date IS NULL) AS missing_hire_date,
    COUNT(*) FILTER (WHERE salary IS NULL) AS missing_salary
FROM employees;

-- Checking null values in table = accounts

SELECT
    COUNT(*) FILTER (WHERE account_id IS NULL) AS missing_account_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE branch_id IS NULL) AS missing_branch_id,
    COUNT(*) FILTER (WHERE account_type IS NULL) AS missing_account_type,
    COUNT(*) FILTER (WHERE balance IS NULL) AS missing_balance,
    COUNT(*) FILTER (WHERE open_date IS NULL) AS missing_open_date,
    COUNT(*) FILTER (WHERE status IS NULL) AS missing_status
FROM accounts;

-- Checking null values in table = loans

SELECT
    COUNT(*) FILTER (WHERE loan_id IS NULL) AS missing_loan_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE branch_id IS NULL) AS missing_branch_id,
    COUNT(*) FILTER (WHERE loan_type IS NULL) AS missing_loan_type,
    COUNT(*) FILTER (WHERE loan_amount IS NULL) AS missing_loan_amount,
    COUNT(*) FILTER (WHERE interest_rate IS NULL) AS missing_interest_rate,
    COUNT(*) FILTER (WHERE term_months IS NULL) AS missing_term,
    COUNT(*) FILTER (WHERE start_date IS NULL) AS missing_start_date,
    COUNT(*) FILTER (WHERE status IS NULL) AS missing_status
FROM loans;

-- Checking null values in table = cards

SELECT
    COUNT(*) FILTER (WHERE card_id IS NULL) AS missing_card_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE account_id IS NULL) AS missing_account_id,
    COUNT(*) FILTER (WHERE card_type IS NULL) AS missing_card_type,
    COUNT(*) FILTER (WHERE issue_date IS NULL) AS missing_issue_date,
    COUNT(*) FILTER (WHERE expiry_date IS NULL) AS missing_expiry_date,
    COUNT(*) FILTER (WHERE credit_limit IS NULL) AS missing_credit_limit,
    COUNT(*) FILTER (WHERE status IS NULL) AS missing_status
FROM cards;

-- Checking null values in table = support_tickets

SELECT
    COUNT(*) FILTER (WHERE ticket_id IS NULL) AS missing_ticket_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE issue_type IS NULL) AS missing_issue_type,
    COUNT(*) FILTER (WHERE date_opened IS NULL) AS missing_date_opened,
    COUNT(*) FILTER (WHERE date_resolved IS NULL) AS missing_date_resolved,
    COUNT(*) FILTER (WHERE status IS NULL) AS missing_status,
    COUNT(*) FILTER (WHERE satisfaction_score IS NULL) AS missing_satisfaction_score
FROM support_tickets;

-- Checking null values in table = transactions

SELECT
    COUNT(*) FILTER (WHERE transaction_id IS NULL) AS missing_transaction_id,
    COUNT(*) FILTER (WHERE account_id IS NULL) AS missing_account_id,
    COUNT(*) FILTER (WHERE txn_date IS NULL) AS missing_txn_date,
    COUNT(*) FILTER (WHERE txn_type IS NULL) AS missing_txn_type,
    COUNT(*) FILTER (WHERE amount IS NULL) AS missing_amount,
    COUNT(*) FILTER (WHERE channel IS NULL) AS missing_channel,
    COUNT(*) FILTER (WHERE merchant_category IS NULL) AS missing_merchant_category
FROM transactions;

-- Checking null values in table = loan_payments

SELECT
    COUNT(*) FILTER (WHERE payment_id IS NULL) AS missing_payment_id,
    COUNT(*) FILTER (WHERE loan_id IS NULL) AS missing_loan_id,
    COUNT(*) FILTER (WHERE payment_date IS NULL) AS missing_payment_date,
    COUNT(*) FILTER (WHERE amount_paid IS NULL) AS missing_amount_paid,
    COUNT(*) FILTER (WHERE principal_component IS NULL) AS missing_principal,
    COUNT(*) FILTER (WHERE interest_component IS NULL) AS missing_interest,
    COUNT(*) FILTER (WHERE late_payment_flag IS NULL) AS missing_late_flag
FROM loan_payments;

-- Checking null values in table = card_transactions

SELECT
    COUNT(*) FILTER (WHERE card_txn_id IS NULL) AS missing_card_txn_id,
    COUNT(*) FILTER (WHERE card_id IS NULL) AS missing_card_id,
    COUNT(*) FILTER (WHERE txn_date IS NULL) AS missing_txn_date,
    COUNT(*) FILTER (WHERE merchant_category IS NULL) AS missing_merchant_category,
    COUNT(*) FILTER (WHERE amount IS NULL) AS missing_amount,
    COUNT(*) FILTER (WHERE is_fraud IS NULL) AS missing_is_fraud
FROM card_transactions;

-- Checking invalid foreign keys

-- transactions -> accounts
SELECT t.*
FROM transactions t
LEFT JOIN accounts a
	ON t.account_id = a.account_id
WHERE a.account_id IS NULL;

-- accounts -> customers
SELECT a.*
FROM accounts a
LEFT JOIN customers c
	ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- accounts -> branches
SELECT a.*
FROM accounts a
LEFT JOIN branches b
	ON a.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

-- loans -> customers

SELECT l.*
FROM loans l
LEFT JOIN customers c
    ON l.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- loans -> branches

SELECT l.*
FROM loans l
LEFT JOIN branches b
    ON l.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

-- cards -> customers

SELECT ca.*
FROM cards ca
LEFT JOIN customers c
    ON ca.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- cards -> accounts 

SELECT ca.*
FROM cards ca
LEFT JOIN accounts a
    ON ca.account_id = a.account_id
WHERE a.account_id IS NULL;

-- loan_payments -> loans

SELECT lp.*
FROM loan_payments lp
LEFT JOIN loans l
    ON lp.loan_id = l.loan_id
WHERE l.loan_id IS NULL;

-- card_transactions -> cards

SELECT ct.*
FROM card_transactions ct
LEFT JOIN cards c
    ON ct.card_id = c.card_id
WHERE c.card_id IS NULL;

-- emoloyees -> branches

SELECT e.*
FROM employees e
LEFT JOIN branches b
    ON e.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

-- support_tickets -> customers

SELECT st.*
FROM support_tickets st
LEFT JOIN customers c
    ON st.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Checking invalid types or status

SELECT DISTINCT txn_type
FROM transactions;

SELECT DISTINCT status
FROM accounts;

SELECT DISTINCT status
FROM loans;

-- Checking invalid values

SELECT *
FROM transactions
WHERE amount < 0;

SELECT *
FROM accounts
WHERE open_date > CURRENT_DATE;

SELECT *
FROM cards
WHERE expiry_date < issue_date;

-- Logical inconsistencies

-- Credit scores outside the conventional 300–900 range
SELECT *
FROM customers
WHERE credit_score < 300 OR credit_score > 900;

-- Invalid loan amounts
SELECT *
FROM loans
WHERE loan_amount <= 0;

-- Invalid interest rates
SELECT *
FROM loans
WHERE interest_rate < 0;