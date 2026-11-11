-- Overall branch analysis
SELECT 
	COUNT(*) AS total_branches,
	COUNT(DISTINCT city) AS total_cities,
	COUNT(DISTINCT state) AS total_states,
	MIN(opened_date) AS oldest_branch_date,
	MAX(opened_date) AS newest_branch_date
FROM branches;

-- Employee distribution by branch
SELECT 
	b.branch_id,
	b.branch_name,
	b.city,
	COUNT(e.employee_id) AS total_employees,
	ROUND(AVG(e.salary), 2) AS avg_salary,
	SUM(e.salary) AS total_salary_exposure
FROM branches b
LEFT JOIN employees e
	ON b.branch_id = e.branch_id
GROUP BY b.branch_id, b.branch_name, b.city
ORDER BY total_employees DESC;

-- Customer distribution by branch
SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.state,
    COUNT(DISTINCT a.customer_id) AS total_customers
FROM branches b
LEFT JOIN accounts a
    ON b.branch_id = a.branch_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.city,
    b.state
ORDER BY total_customers DESC;

-- Account and deposit analysis by branch
SELECT
    b.branch_id,
    b.branch_name,
    COUNT(a.account_id) AS total_accounts,
    SUM(a.balance) AS total_account_balance,
    ROUND(AVG(a.balance), 2) AS avg_account_balance
FROM branches b
LEFT JOIN accounts a
    ON b.branch_id = a.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_account_balance DESC;

-- Account type distribution

SELECT
	b.branch_name,
	a.account_type,
	COUNT(*) AS total_accounts,
	SUM(a.balance) AS total_balance
FROM branches b
JOIN accounts a
	ON b.branch_id = a.branch_id
GROUP BY b.branch_name, a.account_type
ORDER BY b.branch_name, a.account_type

-- Transaction performance by branch
SELECT 
	b.branch_id,
	b.branch_name,
	COUNT(t.transaction_id) AS total_transactions,
	SUM(t.amount) AS total_transaction_amount,
	ROUND(AVG(t.amount), 2) AS avg_transaction_amount
FROM branches b
LEFT JOIN accounts a
	ON b.branch_id = a.branch_id
LEFT JOIN transactions t
	ON a.account_id = t.account_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_transaction_amount DESC;

-- Transaction channel analysis

SELECT
    b.branch_name,
    t.channel,
    COUNT(*) AS transaction_count,
    SUM(t.amount) AS total_amount
FROM branches b
JOIN accounts a
    ON b.branch_id = a.branch_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY b.branch_name, t.channel
ORDER BY transaction_count DESC;

-- Loan portfolio performance by branch
SELECT
	b.branch_id,
	b.branch_name,
	COUNT(l.loan_id) AS total_loans,
	SUM(l.loan_amount) AS total_loan_amount,
	ROUND(AVG(l.loan_amount), 2) AS avg_loan_amount
FROM branches b
LEFT JOIN loans l
	ON b.branch_id = l.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_loan_amount DESC;

-- Loan repayment performance by branch

SELECT
    b.branch_id,
    b.branch_name,
    COUNT(lp.payment_id) AS total_payments,
    COALESCE(SUM(lp.amount_paid), 0) AS total_collected,
    COALESCE(SUM(lp.principal_component), 0) AS principal_collected,
    COALESCE(SUM(lp.interest_component), 0) AS interest_collected,
    COUNT(*) FILTER (
        WHERE lp.late_payment_flag = 1
    ) AS late_payments
FROM branches b
LEFT JOIN loans l
    ON b.branch_id = l.branch_id
LEFT JOIN loan_payments lp
    ON l.loan_id = lp.loan_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_collected DESC;

-- Branch-wise monthly performance

SELECT 
	b.branch_name,
	DATE_TRUNC('month', t.txn_date)::DATE AS transaction_month,
	COUNT(*) AS transaction_count,
	SUM(t.amount) AS total_transaction_amount
FROM branches b
JOIN accounts a
	ON b.branch_id = a.branch_id
JOIN transactions t
	ON a.account_id = t.account_id
GROUP BY b.branch_name, transaction_month
ORDER BY transaction_month, b.branch_name;