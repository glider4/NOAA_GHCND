# Ingest GSN data into Spark

# File location and type
file_location = "/FileStore/tables/ghcnd_GSNonly.csv"
file_type = "csv"

# CSV options
infer_schema = "true"
first_row_is_header = "true"
delimiter = ","

# The applied options are for CSV files. For other file types, these will be ignored.
NOAA_GSN = spark.read.format(file_type) \
  .option("inferSchema", infer_schema) \
  .option("header", first_row_is_header) \
  .option("sep", delimiter) \
  .load(file_location)

display(NOAA_GSN)

# -------------------------------------------------------------- #

# Create a view or table
temp_table_name = "GSN_TEMP"
NOAA_GSN.createOrReplaceTempView(temp_table_name)

# This lets us query the table to make sure it's good before making permanent
'''
%sql
select * from `GSN_TEMP`
'''

# -------------------------------------------------------------- #

# Make ingested table permanent in cluster
permanent_table_name = "NOAA_GHCND_GSN"
NOAA_GSN.write.format("parquet").saveAsTable(permanent_table_name)
