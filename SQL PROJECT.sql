
-- KPI Cards
/* KPI_1 */
SELECT COUNT(DISTINCT `Finance_1.member_id`) AS no_of_customers
FROM financedata;

/* KPI_2 */
SELECT SUM(`Finance_1.loan_amnt`) / 1000000 AS ttl_loan_amnt
FROM financedata;

/* KPI_3 */
SELECT AVG(`Finance_1.int_rate`) * 100 AS avg_int_rate
FROM financedata;

/* KPI_4 */
SELECT SUM(revol_bal) / 1000000 AS total_rev_bal
FROM financedata;

/* KPI_5 */
SELECT AVG(`Finance_1.dti`) AS average_dti
FROM financedata;

-- CHARTS
/* 1_Year-wise Loan Amount Status */
SELECT YEAR(STR_TO_DATE(earliest_cr_line, '%d-%m-%Y')) AS year,
       SUM(`Finance_1.loan_amnt`) / 1000000 AS ttl_loan_amt
FROM financedata
GROUP BY YEAR(STR_TO_DATE(earliest_cr_line, '%d-%m-%Y'))
ORDER BY year;

/* 2_Verified vs Not Verified Loan Payment */
SELECT `Finance_1.verification_status`,
       SUM(total_pymnt) AS total_pymnt,
       ROUND(SUM(total_pymnt) * 100.0 / (SELECT SUM(total_pymnt) 
       FROM financedata), 2) AS percentage
FROM financedata
GROUP BY `Finance_1.verification_status`;

/* 3_Grade and Subgrade-wise Revolve Balance */
SELECT `Finance_1.grade`,
       `Finance_1.sub_grade`,
       SUM(revol_bal) / 1000000 AS ttl_rev_bal
FROM financedata
GROUP BY `Finance_1.grade`, `Finance_1.sub_grade`
ORDER BY `Finance_1.grade`, `Finance_1.sub_grade`;

/* 4_State-wise Loan Status */
SELECT `Finance_1.addr_state`,
       COUNT(*) AS total_loans
FROM financedata
GROUP BY `Finance_1.addr_state`
ORDER BY total_loans DESC;

/* 5_Home Ownership vs Last Payment Date */
SELECT YEAR(STR_TO_DATE(last_pymnt_d, '%d-%m-%Y')) AS year,
       `Finance_1.home_ownership`,
       SUM(total_pymnt) AS total_payment
FROM financedata
WHERE last_pymnt_d IS NOT NULL
GROUP BY YEAR(STR_TO_DATE(last_pymnt_d, '%d-%m-%Y')),
 `Finance_1.home_ownership`
ORDER BY year, `Finance_1.home_ownership`;
