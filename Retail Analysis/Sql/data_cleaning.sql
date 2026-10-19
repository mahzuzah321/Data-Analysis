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

SELECT
    COUNT(*) AS Total_Rows,
    SUM(Product_Name IS NULL) AS Missing_Product_Name,
    SUM(Brand IS NULL) AS Missing_Brand,
    SUM(Unit_Cost_USD IS NULL) AS Missing_Cost,
    SUM(Unit_Price_USD IS NULL) AS Missing_Price,
    SUM(Category IS NULL) AS Missing_Category
FROM Products;

SELECT
    Order_Number,
    Line_Item,
    COUNT(*) AS Duplicate_Count
FROM Sales
GROUP BY Order_Number, Line_Item
HAVING COUNT(*) > 1;

SELECT
    CustomerKey,
    COUNT(*) AS Duplicate_Count
FROM Customers
GROUP BY CustomerKey
HAVING COUNT(*) > 1;

SELECT
    ProductKey,
    COUNT(*) AS Duplicate_Count
FROM Products
GROUP BY ProductKey
HAVING COUNT(*) > 1;

SELECT *
FROM Sales
WHERE Quantity <= 0;

SELECT
    ProductKey,
    Product_Name,
    Unit_Cost_USD,
    Unit_Price_USD
FROM Products
WHERE Unit_Price_USD < Unit_Cost_USD;

SELECT *
FROM Sales
WHERE Order_Date IS NULL
   OR Delivery_Date < Order_Date;
   
SELECT DISTINCT Currency_Code
FROM Sales;

SELECT DISTINCT s.Currency_Code
FROM Sales s
LEFT JOIN Exchange_Rates e
    ON s.Currency_Code = e.Currency
WHERE e.Currency IS NULL;

SELECT DISTINCT s.CustomerKey
FROM Sales s
LEFT JOIN Customers c
    ON s.CustomerKey = c.CustomerKey
WHERE c.CustomerKey IS NULL;

SELECT DISTINCT s.ProductKey
FROM Sales s
LEFT JOIN Products p
    ON s.ProductKey = p.ProductKey
WHERE p.ProductKey IS NULL;

SELECT DISTINCT s.StoreKey
FROM Sales s
LEFT JOIN Stores st
    ON s.StoreKey = st.StoreKey
WHERE st.StoreKey IS NULL;

SELECT DISTINCT Brand
FROM Products
WHERE Brand <> TRIM(Brand);

SELECT
    LOWER(Gender) AS Gender,
    COUNT(*) AS Count
FROM Customers
GROUP BY LOWER(Gender);

SELECT
    Date,
    Currency,
    COUNT(*) AS Count
FROM Exchange_Rates
GROUP BY Date, Currency
HAVING COUNT(*) > 1;

SELECT *
FROM Exchange_Rates
WHERE Exchange IS NULL
   OR Exchange <= 0;
   
SELECT
    s.Order_Date,
    s.Currency_Code,
    COUNT(*) AS Sales_Rows
FROM Sales s
LEFT JOIN Exchange_Rates e
    ON s.Order_Date = e.Date
    AND s.Currency_Code = e.Currency
WHERE e.Date IS NULL
GROUP BY
    s.Order_Date,
    s.Currency_Code;