## Business Question and Solution:
**1. What is the Overall Sales Performance by Year?**
````sql
SELECT [Year], ROUND(SUM(Total_Profit),0) AS TotalProfit, 
			         ROUND(SUM(Total_Revenue),0) AS TotalRevenue
FROM sales_store
GROUP BY [Year]
ORDER BY TotalProfit, TotalRevenue
````
![image](https://github.com/minhducgon/SQL_PROJECT/assets/121803855/8ea11f6e-3566-4f1b-8303-749c9465ac98)

=> The year *2011* stands out as the *highest-performing* year, demonstrating exceptional sales growth. Conversely, *2017* experienced the *lowest sales figures*, reflecting a challenging period for the company

**2. Which month recorded the highest sales?**
````sql
SELECT TOP 1 [MONTH], ROUND(SUM(Total_Profit),0) AS TotalProfit,
					            ROUND(SUM(Total_Revenue),0) AS TotalRevenue
FROM sales_store
GROUP BY [MONTH]
ORDER BY TotalProfit DESC
````
![image](https://github.com/minhducgon/SQL_PROJECT/assets/121803855/9dd6071c-0506-4ddb-a99d-d0bcd2b63154)

=> The *Month of May* emerges as the top-performing month, exhibiting remarkable sales performance. It showcases the *highest sales* figures compared to other months, highlighting its significance in driving business success.

**3. Which day has the highest revenue contribution?**
````sql
SELECT TOP 1 [DAY], ROUND(SUM(Total_Profit),0) AS TotalProfit,
				    ROUND(SUM(Total_Revenue),0) AS TotalRevenue
FROM sales_store
GROUP BY [DAY]
ORDER BY TotalProfit DESC
````
![image](https://github.com/minhducgon/SQL_PROJECT/assets/121803855/1b2f4da8-46bc-42b5-b391-bdeea3bdac9d)

=> *Friday* takes the lead in terms of revenue contribution, making it the most lucrative day of the week. Its strong performance establishes Friday as the top revenue-generating day, showcasing its significance in driving business success.

**4. What it the Percentage of Orders received during Weekends?**
````sql
SELECT Isweekend, ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM sales_store),2) As PercentageOrders
FROM sales_store
GROUP BY IsWeekend
````
![image](https://github.com/minhducgon/SQL_PROJECT/assets/121803855/6b36bbf9-ed58-4b59-ad06-8b1170a88d1d)

=> Weekends accounted for only *28%* of the total orders received.

**5. Where is the most profitable Region?**
````sql
SELECT Region, COUNT(Order_ID) AS TotalOrders, 
				SUM(Units_Sold) AS QuantitySold,
				ROUND (SUM(Total_Revenue),0) AS TotalRevenue,
			    ROUND (SUM(Total_Profit),0) AS TotalProfit	
FROM sales_store
GROUP BY Region
ORDER BY TotalProfit DESC
````
![image](https://github.com/minhducgon/SQL_PROJECT/assets/121803855/2a09ab36-d7ad-40da-82a3-ea3af6007a8f)

=> The *Sub-Saharan Africa* region stands out as the most lucrative, showcasing the highest number of received orders, units sold, revenue generated, and profit earned. This indicates a strong market presence and successful performance in that region

 **6. What is the Percentage of Orders with late delivery (45 days and above)?**
````sql
SELECT  CASE WHEN Duration >= 45 THEN 'Late Delivery' ELSE 'Early Delivery' END AS DeliveryStatus, 
		COUNT (Order_ID) AS TotalOrders,
		(COUNT (*) * 100)/ (SELECT COUNT (*) FROM sales_store) AS StatusPercentage
FROM sales_store
GROUP BY CASE WHEN Duration >= 45 THEN 'Late Delivery' ELSE 'Early Delivery' END
````
![image](https://github.com/minhducgon/SQL_PROJECT/assets/121803855/54c95ca1-27aa-4f5a-a676-40553fc84694)

=> Approximately *11%* of the total orders received experienced delayed shipping, indicating a need for improved logistics and fulfillment processes to ensure timely delivery. Efforts should be made to minimize such delays and enhance the overall customer experience by focusing on efficient shipping practices.

**7. What is the Top performing Item Type by Revenue?**
````sql
SELECT Item_Type, ROUND(SUM(Total_Revenue),0) As TotalRevenue
FROM sales_store
GROUP BY Item_Type
ORDER BY TotalRevenue DESC
````
![image](https://github.com/minhducgon/SQL_PROJECT/assets/121803855/d50584dd-cded-4e78-9bd1-907d037139cb)

=> *Household* items have emerged as the top-performing category in terms of revenue, showcasing their strong demand and profitability. On the other hand, fruits items have shown comparatively lower performance in terms of revenue, suggesting potential areas for improvement or adjustments in pricing, marketing, or product offerings within this category.

**8. What is the Order Contribution by Sales Channel for the Top Performing Item by Revenue?**
````sql
SELECT Sales_Channel, COUNT (Order_ID) AS TotalOrders 
FROM sales_store
WHERE Item_Type = 'Household'
GROUP BY Sales_Channel
````
![image](https://github.com/minhducgon/SQL_PROJECT/assets/121803855/6477af13-98b4-49b6-ad3f-276ca8a4271d)

=> The *offline channel* has slightly contributed *more than* the *online channel* in terms of the number of orders received for the top-performing item (household) in terms of revenue. This indicates that customers are still inclined towards traditional brick-and-mortar stores when purchasing household items, despite the growing popularity of online shopping.

# RECOMMENDATIONS
1. Focus on leveraging the success of high-performing years, such as 2011, to identify and replicate strategies that drove exceptional sales growth.
2. Develop targeted marketing campaigns and promotions to capitalize on the high revenue months, particularly May, and devise strategies to drive sales during lower-performing months like February.
3. Implement strategies to optimize operations on Fridays, considering their significance in revenue generation. This may include increased staffing, special promotions, or tailored product offerings.
4. Explore ways to increase customer engagement and attract more orders during weekends, such as offering exclusive weekend deals or enhancing the online shopping experience.
5. Continuously monitor and improve the logistics and fulfillment processes to minimize late deliveries and ensure timely order fulfillment.
6. Further explore the potential of the Sub-Saharan Africa region by expanding marketing efforts, increasing product availability, and understanding local customer preferences and behaviors.
7. Consider the preferences and behaviors of customers in different sales channels, both online and offline, to optimize marketing efforts and enhance customer experience.
