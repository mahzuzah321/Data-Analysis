#Products with the highest total profit
SELECT
    p.Product_Name,
    SUM(
        s.Quantity *
        (p.Unit_Price_USD - p.Unit_Cost_USD)
    ) AS Total_Profit
FROM Sales s
JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY p.ProductKey, p.Product_Name
ORDER BY Total_Profit DESC;

#Categories with the highest profit margin
SELECT
    p.Category,
    SUM(s.Quantity * p.Unit_Price_USD) AS Revenue,
    SUM(
        s.Quantity *
        (p.Unit_Price_USD - p.Unit_Cost_USD)
    ) AS Profit,
    ROUND(
        SUM(
            s.Quantity *
            (p.Unit_Price_USD - p.Unit_Cost_USD)
        )
        /
        NULLIF(SUM(s.Quantity * p.Unit_Price_USD), 0)
        * 100,
        2
    ) AS Profit_Margin_Percent
FROM Sales s
JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY Profit_Margin_Percent DESC;


#High-revenue but low-profit-margin products
SELECT
    p.Product_Name,
    SUM(s.Quantity * p.Unit_Price_USD) AS Revenue,
    SUM(
        s.Quantity *
        (p.Unit_Price_USD - p.Unit_Cost_USD)
    ) AS Profit,
    ROUND(
        SUM(
            s.Quantity *
            (p.Unit_Price_USD - p.Unit_Cost_USD)
        )
        /
        NULLIF(SUM(s.Quantity * p.Unit_Price_USD), 0)
        * 100,
        2
    ) AS Profit_Margin_Percent
FROM Sales s
JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY p.ProductKey, p.Product_Name
ORDER BY Revenue DESC;

#Revenue and profit over time
SELECT
    YEAR(s.Order_Date) AS Year,
    MONTH(s.Order_Date) AS Month,
    SUM(s.Quantity * p.Unit_Price_USD) AS Revenue,
    SUM(
        s.Quantity *
        (p.Unit_Price_USD - p.Unit_Cost_USD)
    ) AS Profit
FROM Sales s
JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY
    YEAR(s.Order_Date),
    MONTH(s.Order_Date)
ORDER BY
    Year,
    Month;
    
#Revenue contribution of top 10 customers
SELECT
    c.CustomerKey,
    c.Name,
    SUM(s.Quantity * p.Unit_Price_USD) AS Revenue
FROM Sales s
JOIN Customers c
    ON s.CustomerKey = c.CustomerKey
JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY c.CustomerKey, c.Name
ORDER BY Revenue DESC
LIMIT 10;