# NOAA GHCN-D
#### Conversion, ingestion, PostgreSQL database build, querying, Spark implementation, Scala
 
Objective of this project: Make NOAA's Global Historical Climatalogy Network Daily (GHCN-D)
data readily available to query for all locations on a range of granularity levels.  NOAA 
provides free access to this data which is updated on a daily basis.  I used Python here 
to convert the files to .csv and then SQL to build a database for querying.  Later on I subsetted
the data and uploaded it into DataBricks community edition using Python, then Scala to explore lambda
functions.

**LINK TO DATA FILES**: download "ghcnd_all.tar.gz" --> `ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily`

### Read the doc about data structure, contents, etc.
Highly recommended, at least skim it.   [CLICK LINK TO SEE .TXT FILE](./data/text_files/DataInfo_readme.txt)

### Converting `.dly` files to `.csv` and upload to Postgres Database
For an overview on converting the `ghcnd-all.tar.gz` dataset to .csv, 
[see my other repo by clicking here](https://github.com/mathemacode/NOAA_GHCND_IMPORT).  This
guide also includes information about uploading this dataset into a Postgres database, which
can then be used in conjunction with the SQL queries in [the SQL folder](./SQL).

### Possible use cases
This database hosts an extensive amount of climate records and individual characteristics that could prove
useful to diverse research projects and study.  I have tried to make the process of setting this up as simple
as possible to understand to benefit other researchers who want to work with it.  Some possible use cases:

1. Subsetting this data for a certain region or set of stations to support research
2. Querying this data for wind power research (best areas with steady, fast wind?)
3. Querying this data for solar power research
4. Tracking effects of climate change worldwide based on any characteristic (see doc about data contents)

### Project scope
Complete:
- Convert NOAA's .txt fact files into .csv (fixed-width, using Pandas)
- Fact file imports into Postgres database using COPY
- SQL script to build Postgres DB, tables for fact files
- Entity-Relationship Diagram / ERD below
- Postgres import of full dataset (roughly 25gb after `.csv` conversion)
- Optimized queries for entire country yearly averages
- Exported GSN-station-only data to `.csv`
- Ingested GSN-station-only data into Apache Spark as Dataframe using Python
- Ingested GSN-station-only data back into PostgreSQL as a separate entity
- Compared query execution times running on Spark SQL vs. PostgreSQL
- Ingested GSN-station-only data into Apache Spark as DataSet using Scala
- Mimicked SQL queries in Spark in Scala using `lambda` functions

Need to add to this ReadMe:
- Intro to NOAA, the data, limitations, etc
- Use of sed & stat error
- Query performance (20 min down to 5!)
- Main query explanation (`buildAVERAGES.sql`)

TODO Coding:
- Queries for #-year averages (of all stations or GSN, etc.)
- Check temperature **anomalies** with query for entire dataset on Postgres

### Database Schema - PostgreSQL
![ERD](./vis/NOAA_GHCND_ERD.png)

### GSN Max & Min Temp Records (USA) 1925-2019
![gsn-usa](./vis/USA_min_max_GSN.png)

### GSN Average Temp Records (Global) 1925-2019
![gsn-global](./vis/Global_AVG_GSN.png)
