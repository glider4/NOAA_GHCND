-- Testing queries to compare with Spark execution times

-- Query 1
SELECT DISTINCT(year) FROM OBS_GSN
WHERE StateAbbr IS NOT NULL
ORDER BY year DESC;

-- Query 2
SELECT * FROM OBS_GSN
WHERE Latitude > 50
	AND Longtitude > 25
	AND GSN_FLAG = 'GSN';
	
-- Query 3
SELECT Year, Month, COUNT(V1) FROM OBS_GSN
GROUP BY Year, Month
ORDER BY Year;

-- Query 4
SELECT StationID, OBSNUM, v1, v2, v3, v4 FROM OBS_GSN
WHERE StateAbbr IS NOT NULL
	AND CountryAbbr IN('US')

-- Query 5
SELECT stationid, stateabbr, month, year, v1,v2,v3,v4,v5,v6,v7,v8,
		v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,v20,v21,v22,v23,v24,v25,v26,v27,v28,v29,v30,v31
FROM OBS_GSN
WHERE month IN(1,3,5,7,8,10,12)
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+
		  v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30+v31)/31) IS NOT NULL
		  