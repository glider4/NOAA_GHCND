-- Implement indexes on NOAA DB

CREATE INDEX stations_idx1
ON STATIONS(CountryAbbr);

CREATE INDEX countries_idx1
ON Countries(CountryAbbr);
