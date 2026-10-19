use retail_sales;

#Total quantity sold
select sum(Quantity) as Total_Quantity_Sold from sales

#Number of unique orders
select count(distinct Order_Number) from sales

#Number of unique customers
select count(distinct Name) from customers

#Sales quantity by year and month
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Quantity)
FROM Sales
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

#Top 10 products by quantity sold
SELECT
    p.Product_Name,
    SUM(s.Quantity) AS Total_Quantity
FROM Sales as s
JOIN Products as p
    ON s.ProductKey = p.ProductKey
GROUP BY p.Product_Name
ORDER BY Total_Quantity DESC
LIMIT 10;

#Countries with the most customers
select 
	Country,
    count(distinct CustomerKey) as most_customers
    from customers
group by country
order by most_customers desc


