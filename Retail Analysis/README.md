# 📊 Telecom Customer Churn Analysis Using SQL and Python

## 📌 Project Overview

This project analyzes telecom customer data to understand customer churn, identify the factors associated with customer departures, and investigate whether the company is losing high-value customers. Using **MySQL and Python**, the project explores customer demographics, tenure, service subscriptions, payment methods, monthly charges, and total revenue to derive meaningful business insights.

The analysis focuses on three key business questions: **What are the key churn drivers? How do customer profiles and revenue differ by customer status? Is the company losing high-value customers?** The findings can help support data-driven customer retention strategies and improve customer relationship management.

## 🎯 Key Business Questions

### 1. What are the key customer churn drivers?

- Analyze the distribution of customers across Joined, Stayed, and Churned statuses.
- Identify the most frequently reported churn categories and reasons.
- Compare churn rates across internet service types and payment methods.
- Examine the relationship between premium technical support, online security, and customer churn.

### 2. How do customer profiles and revenue differ by customer status?

- Compare the number of customers in each status group.
- Analyze average customer age and tenure.
- Compare average monthly charges and average total revenue.
- Examine total revenue across Joined, Stayed, and Churned customers.

### 3. Is the company losing high-value customers?

- Identify churned customers whose monthly charges exceed the overall customer average.
- Divide customers into four value quartiles based on monthly charges using SQL's `NTILE()` window function.
- Measure the number of churned customers in the highest-charge quartile.
- Analyze their average monthly charges, combined monthly charges, and historical total revenue.

## 🛠️ Tools & Technologies

- **MySQL** — Database creation, data cleaning, validation, and business analysis.
- **SQL** — Aggregations, subqueries, conditional calculations, Common Table Expressions (CTEs), and window functions.
- **Python** — Notebook-based data analysis.
- **Jupyter Notebook** — Executing and documenting Python analysis.

## 🔄 Project Workflow

1. **Database Design:** Created structured tables with appropriate data types, primary keys, and relationships.
2. **Data Import:** Imported the telecom customer dataset through a staging table.
3. **Data Cleaning:** Converted empty numeric values into `NULL` values and transferred records into the main table.
4. **Data Validation:** Checked missing values, duplicate customer IDs, record counts, and ZIP code relationships.
5. **Exploratory Data Analysis:** Analyzed customer status, demographics, churn reasons, service types, payment methods, and revenue.
6. **High-Value Customer Analysis:** Used conditional filtering and quartile-based segmentation to investigate high-charge customers who churned.
7. **Business Recommendations:** Identified areas for further investigation and potential customer retention improvements.

## 📈 Analysis Highlights

The SQL analysis produces results covering:

- Customer counts and percentages by status.
- Customer profile comparisons by age, tenure, monthly charges, and total revenue.
- Churn counts by category and reason.
- Churn rate comparisons across internet types and payment methods.
- Churn rate comparisons by technical support and online security availability.
- High-value churned customer counts and associated revenue metrics.

## 💼 Business Value

This project demonstrates how SQL-based analysis can turn raw customer records into business-focused insights. The results can help a telecom company investigate why customers leave, understand differences between customer groups, evaluate revenue associated with churned customers, and develop more targeted retention initiatives.

## 📂 Repository Contents

- `Table Create and Cleaning.sql` — Database creation, staging table setup, data import, cleaning, and validation.
- `Question Analysis.sql` — SQL queries for churn drivers, customer profile comparisons, revenue analysis, and high-value customer segmentation.
- `Customer_Churn_Analysis.ipynb` — Jupyter Notebook for Python-based analysis.

## 🚀 Future Improvements

- Create an interactive dashboard to visualize churn patterns and revenue metrics.
- Develop a machine learning model to predict customer churn.
- Evaluate prediction performance using appropriate classification metrics.
- Design targeted retention strategies based on customer behavior and value.

---

**Project Category:** Data Analytics | SQL | Python | Customer Churn | Business Intelligence

