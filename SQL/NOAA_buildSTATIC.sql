-- Build database to support importing static/fact files from NOAA GHCN-D
-- ghcn- "stations", "states", "countries", "inventory" .txt

----------------------------------------------------------

-- Create staging tables for STATIONS, STATES, COUNTRIES, INVENTORY

-- DROP TABLE STATIONS;
CREATE TABLE STATIONS (
	StationNum INTEGER NOT NULL,
	StationID CHAR(11) PRIMARY KEY NOT NULL,
	Latitude NUMERIC NOT NULL,
	Longtitude NUMERIC NOT NULL,
	Elevation NUMERIC NOT NULL,
	StateAbbr CHAR(2) NULL,
	StationName VARCHAR(30) NOT NULL,
	GSN_Flag CHAR(3) NULL,
	HCN_CRN_Flag CHAR(3) NULL,
	WMO_ID NUMERIC NULL);
	
-- DROP TABLE STATES;
CREATE TABLE STATES (
	StateNum INTEGER NOT NULL,
	StateAbbr CHAR(2) PRIMARY KEY NOT NULL,
	StateLong VARCHAR(50) NOT NULL);
	
-- DROP TABLE COUNTRIES;
CREATE TABLE COUNTRIES (
	CountryNum INTEGER NOT NULL,
	CountryAbbr CHAR(2) PRIMARY KEY NOT NULL,
	CountryLong VARCHAR(200) NOT NULL);
	
-- DROP TABLE INVENTORY;
CREATE TABLE INVENTORY (
	InventoryNum INTEGER PRIMARY KEY NOT NULL,
	StationID CHAR(11) NOT NULL,
	Latitude NUMERIC NOT NULL,
	Longtitude NUMERIC NOT NULL,
	Element CHAR(4) NOT NULL,
	BeginYear INTEGER,
	EndYear INTEGER,
	FOREIGN KEY (StationID) REFERENCES STATIONS(StationID));
	
----------------------------------------------------------

-- CSV conversion done in Python: import data into staging tables using COPY
COPY STATIONS FROM 'C:/Users/dell/Documents/GitHub/NOAA_GHCND/data/ghcnd-stations.csv' (FORMAT CSV, DELIMITER(','));
COPY STATES FROM 'C:/Users/dell/Documents/GitHub/NOAA_GHCND/data/ghcnd-states.csv' (FORMAT CSV, DELIMITER(','));
COPY COUNTRIES FROM 'C:/Users/dell/Documents/GitHub/NOAA_GHCND/data/ghcnd-countries.csv' (FORMAT CSV, DELIMITER(','));
COPY INVENTORY FROM 'C:/Users/dell/Documents/GitHub/NOAA_GHCND/data/ghcnd-inventory.csv' (FORMAT CSV, DELIMITER(','));

-- Add in CountryAbbr based on StationID
ALTER TABLE STATIONS
ADD CountryAbbr CHAR(2);

UPDATE STATIONS
SET CountryAbbr = SUBSTRING(StationID, 1, 2);

-- Add Foreign Key to Countries table
ALTER TABLE STATIONS
ADD CONSTRAINT fk_countryabbr
FOREIGN KEY (CountryAbbr)
REFERENCES COUNTRIES(CountryAbbr);


-- Check data was imported properly, try some simple queries/joins
SELECT * FROM STATIONS
WHERE stationstate = 'FL';

SELECT StationNum, StationID, StationName, Elevation, StateAbbr, StateLong
FROM Stations
JOIN States USING(StateAbbr)
WHERE Stations.StateAbbr = 'AK';

SELECT StationNum, StationID, StationName, StateAbbr, CountryAbbr, CountryLong
FROM Stations
JOIN Countries USING(CountryAbbr)
ORDER BY StationNum;