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