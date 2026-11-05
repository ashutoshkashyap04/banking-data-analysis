-- Overall customer overview

SELECT
    COUNT(*) AS total_customers,
    ROUND(AVG(annual_income), 2) AS avg_annual_income,
    ROUND(AVG(credit_score), 2) AS avg_credit_score,
    MIN(annual_income) AS min_income,
    MAX(annual_income) AS max_income
FROM customers;

-- Customer demographic analysis

-- By gender
SELECT
	gender,
	COUNT(*) AS customer_count,
	ROUND(
		COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),
		2
	) AS customer_percentage
FROM customers
GROUP BY gender
ORDER BY customer_count DESC;

-- By occupation
SELECT 
	occupation,
	COUNT(*) AS customer_count
FROM customers
GROUP BY occupation
ORDER BY customer_count DESC;

-- By age-groups
SELECT
	CASE 
		WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) < 25 THEN 'Below 25'
		WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) BETWEEN 25 AND 35 THEN '25-35'
		WHEN EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_birth)) BETWEEN 36 AND 50 THEN '36-50'
		ELSE 'Above 50'
	END AS age_group,
	COUNT(*) AS customer_count
FROM customers
GROUP BY age_group
ORDER BY customer_count DESC;

-- Income and Credit analysis

SELECT 
	CASE 
		WHEN annual_income < 600000 THEN 'Low Income'
		WHEN annual_income BETWEEN 600000 AND 2000000 THEN 'Middle Income'
		ELSE 'High Income'
	END AS income_group,
	COUNT(*) AS customer_count,
	ROUND(AVG(credit_score), 2) as avg_credit_score
FROM customers
GROUP BY income_group
ORDER BY avg_credit_score DESC;

-- Customer acquisition analysis

SELECT 
	DATE_TRUNC('year', join_date)::DATE AS joining_year,
	COUNT(*) AS new_customers
FROM customers
GROUP BY joining_year
ORDER BY joining_year;

-- account type distribution
SELECT
	account_type,
	COUNT(*) AS total_accounts,
	ROUND(AVG(balance), 2) AS avg_balance,
	SUM(balance) AS total_balance
FROM accounts
GROUP BY account_type
ORDER BY total_accounts DESC;

-- customers with multiple accounts

SELECT 
	c.customer_id,
	c.name,
	COUNT(a.account_id) AS total_accounts
FROM customers c
JOIN accounts a
	ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(a.account_id) > 1
ORDER BY total_accounts DESC;

-- Customer-level financial analysis

-- top 10 customers by total account balance
SELECT
	c.customer_id,
	c.name,
	c.occupation,
	c.annual_income,
	COUNT(a.account_id) AS total_accounts,
	SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a
	ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name, c.occupation, c.annual_income
ORDER BY total_balance DESC
LIMIT 10;

-- customers without accounts
SELECT
    c.customer_id,
    c.name
FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id
WHERE a.account_id IS NULL;