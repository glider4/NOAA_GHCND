# NOAA GHCN-D
### Conversion, ingestion, PostgreSQL database build, querying
 
Objective of this project: Make NOAA's Global Historical Climatalogy Network Daily (GHCN-D)
data readily available to query for all locations on a range of granularity levels.  NOAA 
provides free access to this data which is updated on a daily basis.  Using Python and SQL 
to convert the files to .csv and then build a database for querying.

LINK TO DATA FILES - download "ghcnd_all.tar.gz" --> ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily

### Read the doc about data structure, contents, etc.
Highly recommended, at least skim it.   [CLICK LINK TO SEE .TXT FILE](./data/text_files/DataInfo_readme.txt)

### Converting `.dly` files to `.csv`
For an overview on converting the `ghcnd-all.tar.gz` dataset to .csv, 
[see my other repo by clicking here](https://github.com/mathemacode/NOAA_GHCND_IMPORT).

### Project scope
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

### Database Schema - PostgreSQL
![ERD](./vis/NOAA_GHCND_ERD.png)

### GSN Max & Min Temp Records (USA) 1925-2019
![gsn-usa](./vis/USA_min_max_GSN.png)
