-- Overall loan portfolio analysis

SELECT
	COUNT(*) AS total_loans,
	SUM(loan_amount) AS total_loan_amount,
	ROUND(AVG(loan_amount), 2) AS avg_loan_amount,
	MAX(loan_amount) AS max_loan_amount,
	MIN(loan_amount) AS min_loan_amount,
	ROUND(AVG(interest_rate), 2) AS avg_interest_rate,
	ROUND(AVG(term_months), 2) AS avg_loan_tenure
FROM loans;

-- loan type analysis

SELECT
    loan_type,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount,
    ROUND(AVG(loan_amount), 2) AS avg_loan_amount,
    ROUND(AVG(interest_rate), 2) AS avg_interest_rate
FROM loans
GROUP BY loan_type
ORDER BY total_loan_amount DESC;

-- loan status analysis

SELECT 
	status,
	COUNT(*) AS loan_count,
	SUM(loan_amount) AS total_loan_amount,
	ROUND(
		COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
		2
	) AS loan_percentage
FROM loans
GROUP BY status
ORDER BY loan_count DESC;

-- Loan disbursed trends 

SELECT 
	DATE_TRUNC('month', start_date)::DATE AS loan_month,
	COUNT(*) AS total_loans,
	SUM(loan_amount) AS total_disbursed
FROM loans
GROUP BY loan_month
ORDER BY loan_month;

-- loan payment analysis

SELECT
    COUNT(*) AS total_payments,
    SUM(amount_paid) AS total_amount_collected,
    SUM(principal_component) AS total_principal_collected,
    SUM(interest_component) AS total_interest_collected,
    ROUND(AVG(amount_paid), 2) AS avg_payment_amount
FROM loan_payments;

-- loan repayment performance

SELECT 
	l.status,
	COALESCE(SUM(lp.amount_paid), 0) AS total_paid,
	COALESCE(SUM(lp.principal_component), 0) AS principal_paid,
	COALESCE(SUM(lp.interest_component), 0) AS interest_paid
FROM loans l
LEFT JOIN loan_payments lp
	ON l.loan_id = lp.loan_id
GROUP BY 
	l.status
ORDER BY total_paid DESC;

-- late payment analysis

SELECT
	COUNT(*) AS total_payments,
	COUNT(*) FILTER (
		WHERE late_payment_flag = 1
	) AS late_payments,
	ROUND(
		COUNT(*) FILTER (
			WHERE late_payment_flag = 1
		) * 100.0 / COUNT(*),
		2
	) AS late_payment_percentage
FROM loan_payments;