#Customer status: Joined, Stayed, and Churned
SELECT
    `Customer Status`,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM telecom_customer_churn), 2
    ) AS percentage
FROM telecom_customer_churn
GROUP BY `Customer Status`;


#Compare customer profiles

SELECT
    `Customer Status`,
    COUNT(*) AS total_customers,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(AVG(`Tenure in Months`), 1) AS avg_tenure_months,
    ROUND(AVG(`Monthly Charge`), 2) AS avg_monthly_charge,
    ROUND(AVG(`Total Revenue`), 2) AS avg_total_revenue
FROM telecom_customer_churn
GROUP BY `Customer Status`
ORDER BY total_customers DESC;


#Identify the key churn drivers

#A. Analyze the actual reasons customers left
SELECT
    `Churn Category`,
    `Churn Reason`,
    COUNT(*) AS customer_count
FROM telecom_customer_churn
WHERE `Customer Status` = 'Churned'
GROUP BY `Churn Category`, `Churn Reason`
ORDER BY customer_count DESC;

#B.Compare internet service types
SELECT
    `Internet Type`,
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN `Customer Status` = 'Churned' THEN 1
        ELSE 0
    END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE
            WHEN `Customer Status` = 'Churned' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS churn_rate_percent
FROM telecom_customer_churn
GROUP BY `Internet Type`
ORDER BY churn_rate_percent DESC;

#C. Compare payment methods
SELECT
    `Payment Method`,
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN `Customer Status` = 'Churned' THEN 1
        ELSE 0
    END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE
            WHEN `Customer Status` = 'Churned' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS churn_rate_percent
FROM telecom_customer_churn
GROUP BY `Payment Method`
ORDER BY churn_rate_percent DESC;

#D. Compare support and security services

SELECT
    `Premium Tech Support`,
    `Online Security`,
    COUNT(*) AS total_customers,
    SUM(CASE
        WHEN `Customer Status` = 'Churned' THEN 1
        ELSE 0
    END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE
            WHEN `Customer Status` = 'Churned' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS churn_rate_percent
FROM telecom_customer_churn
GROUP BY `Premium Tech Support`, `Online Security`
ORDER BY churn_rate_percent DESC;




#Is the company losing high-value customers? If so, how can it retain them?
#1. Compare customer value by status

SELECT
    `Customer Status`,
    COUNT(*) AS total_customers,
    ROUND(AVG(`Monthly Charge`), 2) AS avg_monthly_charge,
    ROUND(AVG(`Total Revenue`), 2) AS avg_total_revenue,
    ROUND(SUM(`Total Revenue`), 2) AS total_revenue,
    ROUND(AVG(`Tenure in Months`), 1) AS avg_tenure_months
FROM telecom_customer_churn
GROUP BY `Customer Status`
ORDER BY avg_total_revenue DESC;

#2. Identify high-value customers who churned
SELECT
    COUNT(*) AS high_charge_churned_customers,
    ROUND(AVG(`Monthly Charge`), 2) AS avg_monthly_charge,
    ROUND(SUM(`Monthly Charge`), 2) AS combined_monthly_charges,
    ROUND(AVG(`Total Revenue`), 2) AS avg_total_revenue
FROM telecom_customer_churn
WHERE `Customer Status` = 'Churned'
  AND `Monthly Charge` > (
      SELECT AVG(`Monthly Charge`)
      FROM telecom_customer_churn
  );
  
#3. Find which high-value customers the company is losing

WITH customer_value AS (
    SELECT
        `Customer ID`,
        `Customer Status`,
        `Monthly Charge`,
        `Total Revenue`,
        NTILE(4) OVER (
            ORDER BY `Monthly Charge` DESC
        ) AS value_quartile
    FROM telecom_customer_churn
)
SELECT
    COUNT(*) AS high_value_churned_customers,
    ROUND(AVG(`Monthly Charge`), 2) AS avg_monthly_charge,
    ROUND(SUM(`Monthly Charge`), 2) AS combined_monthly_charges,
    ROUND(SUM(`Total Revenue`), 2) AS historical_total_revenue
FROM customer_value
WHERE value_quartile = 1
  AND `Customer Status` = 'Churned';


