-- Query database as desired

-- Find full data 
SELECT *, SF1 FROM INVENTORY
JOIN OBS USING(StationID, Element)
WHERE endyear = 2020 AND SF2 IS NULL
AND INVENTORY.Element = 'TMAX'
LIMIT 100;

-- Station data
SELECT * FROM OBS
WHERE StationID = 'AEM00041194'
AND Element = 'TMAX';

-- Join Stations, Countries, States
SELECT obsnum, stationid, stationname, year, month, element, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, StateLong, CountryLong 
FROM OBS
JOIN Stations USING(StationID)
JOIN States USING(StateAbbr)
JOIN Countries USING(CountryAbbr)
WHERE Element = 'TMAX' OR Element = 'TMIN'
ORDER BY obsnum
LIMIT 10000;


-- Find TMAX and TMIN information for certain state
SELECT obsnum, stationid, stationname, year, month, element, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, StateAbbr, StateLong, CountryLong 
FROM OBS
JOIN Stations USING(StationID)
JOIN States USING(StateAbbr)
JOIN Countries USING(CountryAbbr)
WHERE Element IN('TMAX','TMIN') AND StateAbbr = 'FL'
ORDER BY year DESC
LIMIT 2000;

-- Find average max temp for a certain state (and month / station if desired)
SELECT obsnum, stationid, stationname, year, month, element,
((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30+v31)/310) AS Month_AVG, StateAbbr, StateLong, CountryLong 
FROM obs
JOIN Stations USING(StationID)
JOIN States USING(StateAbbr)
JOIN Countries USING(CountryAbbr)
WHERE Element IN('TMAX')
	--AND StationID = 'AGM00060457'
	AND ((v1+v2+v3+v4+v5+v6+v7+v8+v9+v10+v11+v12+v13+v14+v15+v16+v17+v18+v19+v20+v21+v22+v23+v24+v25+v26+v27+v28+v29+v30+v31)/31) IS NOT NULL
	AND month IN(1,3,5,7,8,10,12)
	AND StateAbbr = 'CA'
ORDER BY year DESC, month;






































