-- Create average columns for full months where data is available
-- Find average ELEMENT for certain year from a certain place (state or country)

WITH main_CTE AS
(
SELECT stationid, stationname, stateabbr, month, year, v1,v2,v3,v4,v5,v6,v7,v8,
		v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,v20,v21,v22,v23,v24,v25,v26,v27,v28,v29,v30,v31
FROM obs
INNER JOIN Stations USING(StationID)
INNER JOIN Countries USING(CountryAbbr)
WHERE Element IN('TMIN')
	--AND StateAbbr = 'FL'
	AND CountryAbbr = 'US'
),



average_CTE AS 
(

(
-- 31 day months
SELECT stationid, stationname, stateabbr, month, year,
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
SELECT stationid, stationname, stateabbr, month, year,
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
SELECT stationid, stationname, stateabbr, month, year,
	((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
	  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28)/28) AS month_avg
FROM main_CTE
WHERE month IN(2)
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
		  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28)/28) IS NOT NULL
	AND year NOT IN(1704, 1708, 1712, 1716, 1720, 1724, 1728, 1732, 1736, 
				1740, 1744, 1748, 1752, 1756, 1760, 1764, 1768, 1772, 
				1776, 1780, 1784, 1788, 1792, 1796, 1804, 1808, 1812, 
				1816, 1820, 1824, 1828, 1832, 1836, 1840, 1844, 1848, 
				1852, 1856, 1860, 1864, 1868, 1872, 1876, 1880, 1884, 
				1888, 1892, 1896, 1904, 1908, 1912, 1916, 1920, 1924, 1928, 1932, 
				1936, 1940, 1944, 1948, 1952, 1956, 1960, 1964, 
				1968, 1972, 1976, 1980, 1984, 1988, 1992, 1996, 
				2000, 2004, 2008, 2012, 2016, 2020)
)
	
UNION ALL

(
-- February, 29 days, leap years
SELECT stationid, stationname, stateabbr, month, year,
	((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
	  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29)/29) AS month_avg
FROM main_CTE
WHERE month IN(2)
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
		  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29)/29) IS NOT NULL
	AND year IN(1704, 1708, 1712, 1716, 1720, 1724, 1728, 1732, 1736, 
				1740, 1744, 1748, 1752, 1756, 1760, 1764, 1768, 1772, 
				1776, 1780, 1784, 1788, 1792, 1796, 1804, 1808, 1812, 
				1816, 1820, 1824, 1828, 1832, 1836, 1840, 1844, 1848, 
				1852, 1856, 1860, 1864, 1868, 1872, 1876, 1880, 1884, 
				1888, 1892, 1896, 1904, 1908, 1912, 1916, 1920, 1924, 1928, 1932, 
				1936, 1940, 1944, 1948, 1952, 1956, 1960, 1964, 
				1968, 1972, 1976, 1980, 1984, 1988, 1992, 1996, 
				2000, 2004, 2008, 2012, 2016, 2020)
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
