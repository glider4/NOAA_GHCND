-- Export GHCN-D data to .csv, only for GSN 
-- (Global Surface Network) stations

COPY (
	SELECT * FROM OBS
	INNER JOIN Stations USING(StationID)
	WHERE gsn_flag = 'GSN'
	)

TO 'D:/ghcnd-GSNonly.csv' (FORMAT CSV, DELIMITER(','));
