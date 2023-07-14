select * from sales_store
--I. DATA PREPARATION
--1. Standardizing the Date column 
UPDATE sales_store
SET Order_Date = CONVERT (Date, Order_Date),
	Ship_Date = CONVERT (Date, Ship_Date)

/* Adding The Day, Month,Year, Quarter, Duration and IsWeekend Colum */
ALTER TABLE sales_store
ADD [Day] VARCHAR (255);
UPDATE sales_store
SET [Day] = DATENAME(WEEKDAY, Order_Date)

ALTER TABLE sales_store
ADD [Month] VARCHAR (255);
UPDATE sales_store
SET [Month] = DATENAME(MONTH, Order_Date)

ALTER TABLE sales_store
ADD [Year] INT;
UPDATE sales_store
SET [Year] = DATENAME(YEAR, Order_Date)

ALTER TABLE sales_store
ADD Duration INT;
UPDATE sales_store
SET Duration = DATEDIFF(Day,Order_Date, Ship_Date)

ALTER TABLE sales_store
ADD IsWeekend VARCHAR(255);
UPDATE sales_store
SET IsWeekend = CASE WHEN DATEPART(WEEKDAY, Order_Date) IN (1,7) THEN 'YES' ELSE 'NO' END

ALTER TABLE sales_store
ADD [Quarter] NVARCHAR(255);
UPDATE sales_store
SET [Quarter] = CASE WHEN DATEPART(QUARTER,Order_Date) = 1 THEN 'Q1'
					 WHEN DATEPART(QUARTER,Order_Date) = 2 THEN 'Q2'
					 WHEN DATEPART(QUARTER,Order_Date) = 3 THEN 'Q3'
					 WHEN DATEPART(QUARTER,Order_Date) = 4 THEN 'Q4'
		             END

--II. DATA ANALYSIS
-- 1. What is the Overall Sales Performance by Year?
SELECT [Year], ROUND(SUM(Total_Profit),0) AS TotalProfit, 
			   ROUND(SUM(Total_Revenue),0) AS TotalRevenue
FROM sales_store
GROUP BY [Year]
ORDER BY TotalProfit, TotalRevenue

-- 2. Which month recorded the highest sales? 
SELECT TOP 1 [MONTH], ROUND(SUM(Total_Profit),0) AS TotalProfit,
					  ROUND(SUM(Total_Revenue),0) AS TotalRevenue
FROM sales_store
GROUP BY [MONTH]
ORDER BY TotalProfit DESC

--3. Which day has the highest revenue contribution?
SELECT TOP 1 [DAY], ROUND(SUM(Total_Profit),0) AS TotalProfit,
				    ROUND(SUM(Total_Revenue),0) AS TotalRevenue
FROM sales_store
GROUP BY [DAY]
ORDER BY TotalProfit DESC

--4. What is the Revenue Trend in 2015?
SELECT [Quarter], ROUND(SUM(Total_Revenue),0) AS TotalRevenue
FROM sales_store
WHERE [Year] = 2015
GROUP BY [Quarter]
ORDER BY TotalRevenue 

--5. What it the Percentage of Orders received during Weekends?
SELECT Isweekend, ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM sales_store),2) As PercentageOrders
FROM sales_store
GROUP BY IsWeekend

--6. Where is the most profitable Region?
SELECT Region, COUNT(Order_ID) AS TotalOrders, 
				SUM(Units_Sold) AS QuantitySold,
				ROUND (SUM(Total_Revenue),0) AS TotalRevenue,
			    ROUND (SUM(Total_Profit),0) AS TotalProfit	
FROM sales_store
GROUP BY Region
ORDER BY TotalProfit DESC

 --7. What is the Percentage of Orders with late delivery (45 days and above)?
SELECT  CASE WHEN Duration >= 45 THEN 'Late Delivery' ELSE 'Early Delivery' END AS DeliveryStatus, 
		COUNT (Order_ID) AS TotalOrders,
		(COUNT (*) * 100)/ (SELECT COUNT (*) FROM sales_store) AS StatusPercentage
FROM sales_store
GROUP BY CASE WHEN Duration >= 45 THEN 'Late Delivery' ELSE 'Early Delivery' END

--8. What is the Top performing Item Type by Revenue?
SELECT Item_Type, ROUND(SUM(Total_Revenue),0) As TotalRevenue
FROM sales_store
GROUP BY Item_Type
ORDER BY TotalRevenue DESC
--9. What is the Order Contribution by Sales Channel for the Top Performing Item by Revenue?
SELECT Sales_Channel, COUNT (Order_ID) AS TotalOrders 
FROM sales_store
WHERE Item_Type = 'Household'
GROUP BY Sales_Channel

