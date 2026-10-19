# 📊 Telecom Customer Churn Analysis Using SQL and Python

## 📌 Project Overview
This project converts raw telecom subscriber logs into actionable business insights. By isolating critical churn drivers and measuring financial leakages, this analysis provides data-driven strategies to improve customer retention, optimize service offerings, and protect company revenue.

The analysis answers three core commercial questions: **What triggers customer departures? How do demographics affect revenue? Is the company leaking its highest-paying accounts?**

---

## 📊 Key Analytical Discoveries (SQL & Python Results)

### 1. The Churn Landscape
* **Overall Status:** Out of the entire subscriber base, 26.54 % of customers have churned, 67.02% stayed, and 6.45% are newly acquired accounts.
  ![Alternative Text Description](Screenshot 2026-10-19 230700.png)

* **The Demographics Drop-off:** Churned customers had a remarkably short average lifespan of only 18 months compared to active accounts 41 months.

### 2. Primary Churn Drivers
* **Top Revenue Drain:** The single most frequently reported reason customers gave for leaving was **Competitor had better devices**, accounting for **313** total lost accounts.
* **Infrastructure Risks:** Subscribers utilizing **Fiber Optic** internet churned at a significantly higher rate (**40.72%**) than any other connection tier.
* **Support Vulnerabilities:** Customers who did **not** opt for **Premium Tech Support** or **Online Security** exhibited a massive churn spike of **48.96%**, identifying a critical service gap.
* **Billing Friction:** The highest channel attrition occurred among users paying via **Mailed Check** at **36.88%**.

### 3. High-Value Account Leakage
* Using SQL window functions (`NTILE(4)`), a deep-dive segmentation isolated the highest-paying 25% billing bracket.
* The company lost **582** top-tier customers, resulting in an immediate drop of **\$57829.95** in **Monthly Recurring Revenue (MRR)**.
* This high-value segment accounts for a staggering historical revenue loss of **2267922.68**.

---

## 🛠️ Tools & Advanced SQL Implementations
* **MySQL:** Database schema construction, staging tables, data validation, and business logic execution.
* **Advanced SQL:** Leveraged Common Table Expressions (CTEs), conditional aggregations (`CASE WHEN`), and window functions (`NTILE`) to isolate financial loss.
* **Python (Jupyter Notebook):** Exploratory data analysis, handling data type anomalies, and plotting core demographic distributions.

### Technical Snippet: High-Value Revenue Leak Isolation
```sql
WITH customer_value AS (
    SELECT
        `Customer ID`,
        `Customer Status`,
        `Monthly Charge`,
        `Total Revenue`,
        NTILE(4) OVER (ORDER BY `Monthly Charge` DESC) AS value_quartile
    FROM telecom_customer_churn
)
SELECT
    COUNT(*) AS high_value_churned_customers,
    ROUND(AVG(`Monthly Charge`), 2) AS avg_monthly_charge,
    ROUND(SUM(`Monthly Charge`), 2) AS combined_monthly_charges,
    ROUND(SUM(`Total Revenue`), 2) AS historical_total_revenue
FROM customer_value
WHERE value_quartile = 1 AND `Customer Status` = 'Churned';
```

---

## 📈 Data-Backed Strategic Recommendations
Based on the hard metrics generated, a business should execute three immediate retention pathways:
1. **Automated VIP Alerts:** Set up automated database flags for the top 25% billing quartile when their tenure hits the **41** month danger-zone to deploy proactive loyalty offers.
2. **Tech Support Inclusions:** Bundle **Premium Tech Support** directly into the **Fiber Optic** internet plans to mitigate the high churn rates seen in unassisted profiles.
3. **Auto-Pay Migration Incentives:** Offer a one-time invoice credit to transition customers using high-friction payment methods over to low-churn automated credit card billing.

---

**Project Category:** Data Analytics | SQL Architecture | Customer Attrion | Revenue Intelligence
