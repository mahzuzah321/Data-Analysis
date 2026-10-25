# Retail Sales Data Analysis using SQL

## 📌 Project Overview

This project focuses on analyzing retail sales data using **MySQL** to uncover business insights related to sales performance, customer behavior, product profitability, and revenue trends.

The project includes data quality assessment, duplicate detection, validation of relationships between tables, sales and customer analysis, and advanced profitability analysis.

Query results and dashboard visualizations are included to demonstrate how SQL can transform raw retail data into meaningful business insights.

## 🎯 Project Objectives

- Assess data quality by identifying missing values and duplicate records.
- Validate sales transactions, product pricing, and exchange-rate information.
- Analyze sales quantity and order trends over time.
- Identify top-performing products, brands, and categories.
- Calculate revenue, profit, and profit margins.
- Identify high-revenue customers and countries.
- Compare online and physical-store sales performance.
- Present analytical results through query outputs and visualizations.

## 🛠️ Tools & Technologies

- **MySQL** — SQL querying, data validation, and analysis.
- **MySQL Workbench** — Query execution and result inspection.
- **Power BI** — Data visualization and dashboard reporting.
- **Git & GitHub** — Version control and project documentation.

## 🗂️ Database Tables

The project works with the following tables:

| Table | Purpose |
|---|---|
| `Sales` | Order details, dates, product keys, quantities, and currency codes |
| `Products` | Product names, brands, categories, costs, and prices |
| `Customers` | Customer details and geographic information |
| `Stores` | Store information and sales-channel identification |
| `Exchange_Rates` | Currency exchange rates by date |

## 🧹 Data Cleaning & Quality Assessment

The data quality assessment uses SQL queries to investigate:

- Missing values in important columns.
- Duplicate sales line items and duplicate keys.
- Invalid or non-positive quantities.
- Products with selling prices below their unit costs.
- Missing or invalid order and delivery dates.
- Inconsistent text formatting, such as leading or trailing spaces.
- Missing customer, product, store, or exchange-rate references.
- Duplicate exchange rates for the same date and currency.

These checks help identify potential data quality issues before interpreting the analytical results.

### Example: Missing-value assessment

```sql
SELECT
    COUNT(*) AS Total_Rows,
    SUM(Order_Number IS NULL) AS Missing_Order_Number,
    SUM(Order_Date IS NULL) AS Missing_Order_Date,
    SUM(CustomerKey IS NULL) AS Missing_CustomerKey,
    SUM(StoreKey IS NULL) AS Missing_StoreKey,
    SUM(ProductKey IS NULL) AS Missing_ProductKey,
    SUM(Quantity IS NULL) AS Missing_Quantity,
    SUM(Currency_Code IS NULL) AS Missing_Currency
FROM Sales;
```

**Query output:** See `images/data-quality-results.png`.

## 📊 Sales & Customer Analysis

This section explores sales activity and customer distribution.

Key analyses include:

- Total quantity sold.
- Number of unique orders.
- Number of unique customers.
- Monthly and yearly sales quantities.
- Top 10 products by quantity sold.
- Countries with the largest customer populations.

### Example: Top 10 products by quantity sold

```sql
SELECT
    p.Product_Name,
    SUM(s.Quantity) AS Total_Quantity
FROM Sales AS s
JOIN Products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY p.ProductKey, p.Product_Name
ORDER BY Total_Quantity DESC
LIMIT 10;
```

**Query output:** See `images/top-products-output.png`.

## 💰 Profitability & Advanced Sales Analysis

Using product unit prices and costs, the project calculates product-level and category-level profitability.

Key analyses include:

- Products with the highest total profit.
- Categories with the highest profit margins.
- High-revenue products with relatively low profit margins.
- Monthly revenue and profit trends.
- Top 10 customers by revenue contribution.

### Example: Products with the highest total profit

```sql
SELECT
    p.Product_Name,
    SUM(
        s.Quantity *
        (p.Unit_Price_USD - p.Unit_Cost_USD)
    ) AS Total_Profit
FROM Sales AS s
JOIN Products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY p.ProductKey, p.Product_Name
ORDER BY Total_Profit DESC;
```

**Query output:** See `images/product-profit-output.png`.

*Note: These calculations use unit prices and costs in USD. If the source sales records contain multiple transaction currencies, revenue and profit should be calculated using consistently converted amounts and the appropriate exchange rates.*

## 📈 Revenue & Product Performance

This section compares business performance across products, categories, brands, countries, and sales channels.

The analysis includes:

- Categories generating the highest revenue.
- Brands generating the highest revenue.
- Countries contributing the most revenue.
- Top 10 customers by revenue.
- Online versus physical-store revenue and sales quantity.
- Categories with the highest units sold.

### Example: Online vs. physical-store sales

```sql
SELECT
    CASE
        WHEN s.StoreKey = 0 THEN 'Online'
        ELSE 'Physical Store'
    END AS Sales_Channel,
    SUM(s.Quantity * p.Unit_Price_USD) AS Revenue,
    SUM(s.Quantity) AS Quantity
FROM Sales AS s
JOIN Products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY
    CASE
        WHEN s.StoreKey = 0 THEN 'Online'
        ELSE 'Physical Store'
    END;
```

**Query output:** See `images/sales-channel-output.png`.

## 🖼️ Visualizations Results

### Power BI Dashboard

![Power BI dashboard](images/retail-sales-dashboard.png)

*Replace this image with a screenshot of your actual Power BI dashboard.*



```

## 💡 Key Skills Demonstrated

- SQL data quality assessment
- Aggregate functions and conditional logic
- Joins across relational tables
- Duplicate and referential-integrity checks
- Date-based analysis
- Business KPI calculations
- Revenue, profit, and profit-margin analysis
- Ranking and top-N analysis
- Data visualization and reporting

## 🚀 Conclusion

This project demonstrates how SQL can be used to assess retail data quality, analyze customer and product performance, and calculate business metrics that support data-driven decisions.

Combining SQL analysis with Power BI visualizations provides a clear way to communicate findings and turn query results into actionable business insights.

---

**Author:** Mahzuzah Afrin

**Tools:** MySQL | MySQL Workbench | Power BI | GitHub
