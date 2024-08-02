# Sales-Analysis-Project-Using-SQL-PowerBi

The database used in this project is from Microsoft AdventureWorks sample databases, can get it from this link: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms

## This project aims to build a visual data using Power Bi to help sales manager to undertsand the sales from different customers comparing to the budget.

The business request for this data analyst project was an executive sales report for sales managers. Based on the request that was made from the business we following user stories were defined to fulfill delivery and ensure that acceptance criteria’s were maintained throughout the project.

# User Stories

| As a (role)         | I want (request / demand)                       | So that I (user value)                                    | Acceptance Criteria                                                      |
|---------------------|-------------------------------------------------|----------------------------------------------------------|--------------------------------------------------------------------------|
| Sales Manager       | To get a dashboard overview of internet sales   | Can follow better which customers and products sells the best | A Power BI dashboard which updates data once a day                       |
| Sales Representative| A detailed overview of Internet Sales per Customers | Can follow up my customers that buys the most and who we can sell more to | A Power BI dashboard which allows me to filter data for each customer    |
| Sales Representative| A detailed overview of Internet Sales per Products  | Can follow up my Products that sells the most             | A Power BI dashboard which allows me to filter data for each Product     |
| Sales Manager       | A dashboard overview of internet sales          | Follow sales over time against budget                     | A Power BI dashboard with graphs and KPIs comparing against budget       |

## Data Cleansing & Transformation (SQL)
To create the necessary data model for doing analysis and fulfilling the business needs defined in the user stories the following tables were extracted using SQL.

One data source (sales budgets) were provided in Excel format and were connected in the data model in a later step of the process.

Below are the SQL statements for cleansing and transforming necessary data.

#### DIM_DATE

--Cleansed DIM DATE TABLE
SELECT 
  [DateKey], 
  [FullDateAlternateKey] AS DATE,
  --,[DayNumberOfWeek]
  
  [EnglishDayNameOfWeek] AS DAY,
  --,[SpanishDayNameOfWeek]
  --,[FrenchDayNameOfWeek]
  --,[DayNumberOfMonth]
  --,[DayNumberOfYear]`
   
  [WeekNumberOfYear] AS WEEKNR, 
  [EnglishMonthName] AS MONTH,
  LEFT([EnglishMonthName], 3) AS MONTHSHORT,
  --,[SpanishMonthName]
  --,[FrenchMonthName]

  [MonthNumberOfYear] AS MONTHNO, 
  [CalendarQuarter]AS QUARTER, 
  [CalendarYear] AS YEAR
  --,[CalendarSemester]
  --,[FiscalQuarter]
  --,[FiscalYear]
  --,[FiscalSemester]
FROM 
  [AdventureWorksDW2022].[dbo].[DimDate]
  WHERE CalendarYear>=2019

#### DIM_CUSTOMER

-- DIM CUSTOMER CLEANSED--
SELECT 
  c.CustomerKey AS CUSTOMERKEY 
  --,[GeographyKey]
  --,[CustomerAlternateKey]
  --,[Title]
  , 
  c.FirstName 
  --,[MiddleName]
  , 
  c.LastName, 
  c.FirstName + ' ' + LastName AS [Full Name] 
  --,[NameStyle]
  --,[BirthDate]
  --,[MaritalStatus]
  --,[Suffix]
  , 
  CASE c.Gender WHEN 'M' THEN 'MALE' WHEN 'F' THEN 'FEMALE' END AS Gender 
  --,[EmailAddress]
  --,[YearlyIncome]
  --,[TotalChildren]
  --,[NumberChildrenAtHome]
  --,[EnglishEducation]
  --,[SpanishEducation]
  --,[FrenchEducation]
  --,[EnglishOccupation]
  --,[SpanishOccupation]
  -- ,[FrenchOccupation]
  --,[HouseOwnerFlag]
  --,[NumberCarsOwned]
  --,[AddressLine1]
  --,[AddressLine2]
  --,[Phone]
  , 
  c.DateFirstPurchase 
  --  ,[CommuteDistance]
  ,g.city AS CustomerCity  --joined in Customer city from geography table
FROM 
  dbo.DimCustomer AS c 
  LEFT JOIN dbo.DimGeography AS g ON g.GeographyKey = c.GeographyKey 
ORDER BY 
  CustomerKey ASC -- order by customerkey 

#### DIM_PRODUCT 

SELECT [ProductKey]
      ,[ProductAlternateKey] AS ProductCode
      --,[ProductSubcategoryKey]
      --,[WeightUnitMeasureCode]
      --,[SizeUnitMeasureCode]
      ,[EnglishProductName] AS ProductName
	  ,ps.[EnglishProductSubcategoryName] AS SubCategory,
	  pc.EnglishProductCategoryName AS ProductCategory
     -- ,[SpanishProductName]
      --,[FrenchProductName]
      --,[StandardCost]
      --,[FinishedGoodsFlag]
      ,[Color] AS Color
      --,[SafetyStockLevel]
      --,[ReorderPoint]
      --,[ListPrice]
      ,[Size] As ProdctSize
      --,[SizeRange]
      --,[Weight]
      --,[DaysToManufacture]
      ,[ProductLine]
      --,[DealerPrice]
      --,[Class]
      --,[Style]
      ,[ModelName] AS [Prdouct Model Name]
      --,[LargePhoto]
      ,[EnglishDescription]	AS [Product Description]
     -- ,[FrenchDescription]
      --,[ChineseDescription]
      --,[ArabicDescription]
      --,[HebrewDescription]
      --,[ThaiDescription]
      --,[GermanDescription]
      --,[JapaneseDescription]
      --,[TurkishDescription]
      --,[StartDate]
      --,[EndDate]
      ,ISNULL ([Status], 'Outdated' ) AS [Product Status]
  FROM [dbo].[DimProduct] as p
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductCategoryKey = p.ProductSubcategoryKey
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey

order by
p.ProductKey

#### FACT_INTERNET_SALES

SELECT 
	   [ProductKey]
      ,[OrderDateKey]
      ,[DueDateKey]
      ,[ShipDateKey]
      ,[CustomerKey]
      --,[PromotionKey]
      --,[CurrencyKey]
      --,[SalesTerritoryKey]
      ,[SalesOrderNumber]
      --,[SalesOrderLineNumber]
      --,[RevisionNumber]
      --,[OrderQuantity]
      --,[UnitPrice]
      ---,[ExtendedAmount]
      --,[UnitPriceDiscountPct]
      --,[DiscountAmount]
      --,[ProductStandardCost]
      --,[TotalProductCost]
      ,[SalesAmount]
      --,[TaxAmt]
      --,[Freight]
      --,[CarrierTrackingNumber]
      --,[CustomerPONumber]
      --,[OrderDate]
      --,[DueDate]
      --,[ShipDate]
  FROM [dbo].[FactInternetSales]
  WHERE
  LEFT (OrderDateKey, 4) >= YEAR(GETDATE())-2

  order by 
  OrderDateKey ASC

## Data Model
Below is a screenshot of the data model after cleansed and prepared tables were read into Power BI.

This data model also shows how FACT_Budget hsa been connected to FACT_InternetSales and other necessary DIM tables.
![image](https://github.com/user-attachments/assets/3386d4a3-560d-4e74-bada-0844a0f1c8d9)


## Sales Management Dashboard
The finished sales management dashboard with one page with works as a dashboard and overview, with two other pages focused on combining tables for necessary details and visualizations to show sales over time, per customers and per products.
![image](https://github.com/user-attachments/assets/db1f6db6-5517-4930-a7e4-a4f58a1674d0)

