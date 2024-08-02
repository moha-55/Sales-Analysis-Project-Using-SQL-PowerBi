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
