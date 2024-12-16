CREATE DATABASE Practice

SELECT * FROM [dbo].[AutoSalesdata]

------Calculate total sales and total quantity ordered for each product------
SELECT Productline, SUM(Sales) AS SalesPerProduct , SUM(QuantityOrdered) AS QuantityPerProduct
FROM [dbo].[AutoSalesdata]
GROUP BY Productline
ORDER BY 2 DESC

------Get the details of the product with highest price tag------
SELECT TOP 1 * FROM [dbo].[AutoSalesData]
ORDER BY PriceEach DESC

------Calculate the total sales of each sales year------
SELECT YEAR(OrderDate) AS SalesYear, SUM(Sales) AS TotalSales
FROM [dbo].[AutoSalesData]
GROUP BY YEAR(OrderDate)
ORDER BY 2 DESC

------Find the total number of orders made by each customer------
SELECT CustomerName, COUNT(OrderNumber) AS TotalOrder FROM [dbo].[AutoSalesData]
GROUP BY CustomerName
ORDER BY 2 DESC

------Calculate total sales by customer------
SELECT CustomerName, SUM(Sales) AS TotalSales, SUM(QuantityOrdered) AS TotalQuantity FROM [dbo].[AutoSalesData]
GROUP BY CustomerName
ORDER BY 2 DESC


------Find the occurrence of each dealsize------
SELECT DealSize, COUNT(DealSize) AS TotalDeal FROM [dbo].[AutoSalesData]
GROUP BY DealSize
ORDER BY 2 DESC

------What is the total number of orders for each order status------
SELECT Status AS OrderStatus, COUNT(Status) AS TotalNumber FROM [dbo].[AutoSalesData]
GROUP BY Status
ORDER BY 2 DESC

------Calculate the total number of each status by product------
SELECT S.ProductLine, ISNULL(S.Shipped, 0) AS Shipped, ISNULL(C.Cancelled, 0) AS Cancelled, ISNULL(R.Resolved, 0) AS Resolved, 
ISNULL(H.OnHold, 0) AS 'On hold', ISNULL(P.InProcess, 0) AS 'In Process', ISNULL(D.Disputed, 0) AS 'Disputed'
FROM 
(SELECT ProductLine, COUNT(Status) AS Cancelled FROM AutoSalesData WHERE Status='Cancelled' GROUP BY ProductLine) AS C
FULL OUTER JOIN (SELECT ProductLine, COUNT(Status) AS Shipped FROM AutoSalesData WHERE Status='Shipped' GROUP BY ProductLine) AS S
ON C.PRODUCTLINE = S.PRODUCTLINE
FULL OUTER JOIN (SELECT ProductLine, COUNT(Status) AS Resolved FROM AutoSalesData WHERE Status='Resolved' GROUP BY ProductLine) AS R
ON S.PRODUCTLINE = R.PRODUCTLINE
FULL OUTER JOIN (SELECT ProductLine, COUNT(Status) AS OnHold FROM AutoSalesData WHERE Status='On Hold' GROUP BY ProductLine) AS H
ON S.PRODUCTLINE = H.PRODUCTLINE
FULL OUTER JOIN (SELECT ProductLine, COUNT(Status) AS InProcess FROM AutoSalesData WHERE Status='In Process' GROUP BY ProductLine) AS P
ON S.PRODUCTLINE = P.PRODUCTLINE
FULL OUTER JOIN (SELECT ProductLine, COUNT(Status) AS Disputed FROM AutoSalesData WHERE Status='Disputed' GROUP BY ProductLine) AS D
ON S.PRODUCTLINE = D.PRODUCTLINE

------Calculate total sales and total quantity ordered by Country------
SELECT Country, SUM(Sales) AS SalesPerProduct , SUM(QuantityOrdered) AS QuantityPerCountry
FROM [dbo].[AutoSalesdata]
GROUP BY Country
ORDER BY 2 DESC