-- Create average columns for full months where data is available
-- Find average ELEMENT for certain year from a certain place (state or country)

WITH main_CTE AS
(
SELECT stationid, stateabbr, month, year, v1,v2,v3,v4,v5,v6,v7,v8,
		v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,v20,v21,v22,v23,v24,v25,v26,v27,v28,v29,v30,v31
FROM obs
INNER JOIN Stations USING(StationID)
INNER JOIN Countries USING(CountryAbbr)
WHERE Element IN('TMIN')
	AND StateAbbr = 'FL'
	--AND CountryAbbr = 'US'
),



average_CTE AS 
(

(
-- 31 day months
SELECT stationid, month, year,
	((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
	  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30+v31)/31) AS month_avg
FROM main_CTE
WHERE month IN(1,3,5,7,8,10,12)
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
		  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30+v31)/31) IS NOT NULL
)
	
UNION ALL
	
(
-- 30 day months
SELECT stationid, month, year,
	((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
	  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30)/30) AS month_avg
FROM main_CTE
WHERE month IN(4,6,9,11)
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
		  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30)/30) IS NOT NULL
)
	
UNION ALL

(
-- February, 28 days, NOT leap years
SELECT stationid, month, year,
	((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
	  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28)/28) AS month_avg
FROM main_CTE
WHERE month IN(2)
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
		  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28)/28) IS NOT NULL
	AND (year%4) != 0
)
	
UNION ALL

(
-- February, 29 days, leap years
SELECT stationid, month, year,
	((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
	  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29)/29) AS month_avg
FROM main_CTE
WHERE month IN(2)
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
		  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29)/29) IS NOT NULL
	AND (year%4) = 0
	AND (year%100) = 0
	AND (year%400) = 0
)

),


permonth_CTE AS
(
-- Averages per month
SELECT month, year, COUNT(DISTINCT(month)) AS nummonths, 
		AVG(month_avg) AS average_monthly
FROM average_CTE
GROUP BY month, year
),


peryear_CTE AS
(
-- Per year averages, all stations
-- Logic is correct: isolating one year to one month in permonth_CTE
-- lets me count the number of times that year appears as the number of months
SELECT year, AVG(average_monthly) AS average_yearly, 
		COUNT(year) AS num_months
FROM permonth_CTE
GROUP BY year
)

-- Only use data that has a full 12-month average
-- Convert to C, not tenths of C
SELECT year, (average_yearly/10) AS avg_yearly FROM peryear_CTE
WHERE num_months = 12
ORDER BY year;
