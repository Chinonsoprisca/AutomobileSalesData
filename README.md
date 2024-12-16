# Automobile_Sales_Data
Documentation of my personal work.

## Project Title
Sales Performance Analysis for a Retail Store 
 
[Project Overview](#project-overview)

[Data Source](#data-source)

[Tools Used](#tools-used)

[Data Cleaning and Preparations](#data-cleaning-and-preparations)

[Exploratory Data Analysis](#exploratory-data-analysis)

[Data Analysis](#data-analysis)

[Data Visualization](#data-visualization)

[Finding and Recommendation](#finding-and-recommendation)




### Project Overview
---
This is a personal project where i tasked myself to expolre an automobile sales data, which contained the sales of different kinds of automobile products accross a number of countries, discovering the sales trend and relavant insights using Power BI visuals and SQL queries.  

### Data Source
---
Automobile Sales Data downloaded from Kaggle was used.

### Tools Used
---
- Microsoft Excel for Data Cleaning
     
- SQL - Structured Query Language for Querying of Data

- Power BI - Power Business Intelligence for Data Visualization 

### Data Cleaning and Preparations
---
This involves identifying data errors and then changing, updating or removing data to correct them.
1. Data loading and Inspection
2. Verifying blank cells
3. Formatting

### Exploratory Data Analysis
---
- What is the ovarall sales trend
- Which product and counry are top sellers
- Status of the ordered products
  

### Data Analysis
---

![Screenshot 2024-12-14 191248](https://github.com/user-attachments/assets/03c7b178-3e38-4d0e-8a64-0c9f49bc3562)
SQL screenshot 1

![Screenshot 2024-12-14 191935](https://github.com/user-attachments/assets/337c6fa1-9437-43d8-b523-3d3506d19bdf)
SQL screenshot 2

![Screenshot 2024-12-14 185811](https://github.com/user-attachments/assets/cb450528-9876-4a39-8fd6-3d90cd95ce8a)
SQL screenshot 3

![Screenshot 2024-12-14 190943](https://github.com/user-attachments/assets/97486a13-b8c0-4818-959b-d23f0e1672f1)
SQL screenshot 4


```SQL
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

```

### Data Visualization
---

![Screenshot 2024-12-06 215907](https://github.com/user-attachments/assets/3fa25c8b-0c96-498c-8462-292259b85582)

![Screenshot 2024-12-06 215819](https://github.com/user-attachments/assets/c77daa2a-e0ad-4ed2-aa59-ed259f485563)


### Finding and Recommendation
- 92.41% (2541) of the ordered goods were shipped and the rest were either cancelled, on hold, disputed e.t.c
- Classic Cars had the highest sales (3,842,869) while Train had the lowest sales (226,243).
- USA had the highest sales (3,355,576) and Ireland had the lowest sales (490).
-Vintage Car had the highest price tag of 252.87. This made it the most costly product in the 2020 sales year.
-⁠The data contained 3 consecutive yearly sales (2018 to 2020).⁠
-⁠2019 had the highest sales (4,669,924.56) while 2020 had lowest sales (1,737,283.09).
-⁠Euro Shopping Channel is the top 1 customer in quantity ordered and sales.





The Status of the order was used as the slicer.
I went further to filter total sales by Productline (e.g Classic Cars) categorized by Dealsize, and discovered that Ships had only medium and small sales.
- More goods should be supplied to the South since it generates more revenue, this will help to increase sales turnover, more branches can also be established in the South.
- Different brands of shoes should be supplied to all regions, because customers seem to purchase more of it, and their purchasing interest should be sustained with multi-brand choice.
- I suggest that more investigation should be carried out on the West store to know the cause of its low sales.
- it could be that people don't wear Socks much, which causes the sales to be low. If the revenue is not more than the capital, I suggest it should be removed from the stores.
