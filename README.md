# NOAA GHCN-D
#### NOAA Global Historical Climate Network - Daily
 
Objective of this project: Make NOAA's Global Historical Climatalogy Network Daily (GHCN-D)
data readily available to query for all locations on a range of granularity levels.  NOAA 
provides free access to this data which is updated on a daily basis.  Using Python and SQL 
to convert the files to .csv and then build a database for querying.

For an overview on converting the `ghcnd-all.tar.gz` dataset to .csv, see my other repo:
https://github.com/mathemacode/NOAA_GHCND_IMPORT

Complete:
- convert NOAA's .txt fact files into .csv (fixed-width, using Pandas)
- fact file imports into Postgres database using COPY
- SQL script to build Postgres DB, tables for fact files
- ERD
- Postgres import of full dataset
- optimized queries for entire country yearly averages

Need to add to this ReadMe:
- intro to NOAA, the data, limitations, etc
- use of sed & stat error
- query performance (20 min down to 5!)

![ERD](./vis/NOAA_GHCND_ERD.png)
