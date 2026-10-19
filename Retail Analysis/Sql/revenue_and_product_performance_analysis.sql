#Categories with the highest revenue
SELECT
    p.Category,
    SUM(s.Quantity * p.Unit_Price_USD) AS Revenue
FROM Sales s
JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY Revenue DESC;

#Brands with the highest revenue
SELECT
    p.Brand,
    SUM(s.Quantity * p.Unit_Price_USD) AS Revenue
FROM Sales s
JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY p.Brand
ORDER BY Revenue DESC;

#Countries with the highest revenue
SELECT
    c.Country,
    SUM(s.Quantity * p.Unit_Price_USD) AS Revenue
FROM Sales s
JOIN Customers c
    ON s.CustomerKey = c.CustomerKey
JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY c.Country
ORDER BY Revenue DESC;

#top 10 Customers with the highest revenue
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
limit 10;

#Online vs physical-store sales
SELECT
    CASE
        WHEN s.StoreKey = 0 THEN 'Online'
        ELSE 'Physical Store'
    END AS Sales_Channel,
    SUM(s.Quantity * p.Unit_Price_USD) AS Revenue,
    SUM(s.Quantity) AS Quantity
FROM Sales s
JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY
    CASE
        WHEN s.StoreKey = 0 THEN 'Online'
        ELSE 'Physical Store'
    END;

#Categories with the highest units sold
SELECT
    p.Category,
    SUM(s.Quantity) AS Total_Quantity
FROM Sales s
JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY Total_Quantity DESC;

