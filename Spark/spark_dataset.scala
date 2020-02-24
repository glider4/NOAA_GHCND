// Importing Dataset from NOAA GHCND data - GSN only .csv file

val noaa = spark.read
  .option("inferSchema", "true")
  .option("header", "true")
  .csv("/FileStore/tables/ghcnd_GSNonly-9c790.csv")

display(noaa)

// Test query, filtering dataset

val filterDF = noaa
  .filter($"year" > 1960)

display(filterDF)

// Use ===
// Can do || for multiple filtering elements

// Query 1
val filterDF1 = noaa
  .select("year")
  .filter($"stateabbr".isNotNull)
  .distinct()
  .sort($"year".desc)

display(filterDF1)

// Query 2
val filterDF2 = noaa
  .filter($"latitude" > 50 || $"longtitude" > 25 || $"gsn_flag" === "GSN")

display(filterDF2)

// Query 3
val filterDF3 = noaa
  .select("year", "month", "v1")
  .groupBy("year", "month")
  .count()
  .sort("year")


display(filterDF3)

// Query 4
val filterDF4 = noaa
  .select("stationid", "obsnum", "v1", "v2", "v3", "v4")
  .filter($"stateabbr".isNotNull)
  .filter($"countryabbr" isin ("US"))


display(filterDF4)

// Query 5
val filterDF5 = noaa
  .select("stationid", "stateabbr", "month", "year", "v1", "v2", "v3", "v4","v5","v6","v7","v8",
		"v9","v10","v11","v12","v13","v14","v15","v16","v17","v18","v19","v20","v21","v22","v23","v24","v25","v26","v27","v28","v29","v30","v31")
  .filter($"month" isin (1,3,5,7,8,10,12))
  .filter($"v1".isNotNull || $"v2".isNotNull || $"v3".isNotNull || $"v4".isNotNull || $"v5".isNotNull || $"v6".isNotNull || $"v7".isNotNull || $"v8".isNotNull || $"v9".isNotNull || $"v10".isNotNull || $"v11".isNotNull || $"v12".isNotNull || $"v13".isNotNull || $"v14".isNotNull || $"v15".isNotNull || $"v16".isNotNull || $"v17".isNotNull || $"v18".isNotNull || $"v19".isNotNull || $"v20".isNotNull || $"v21".isNotNull || $"v22".isNotNull || $"v23".isNotNull || $"v24".isNotNull || $"v25".isNotNull || $"v26".isNotNull || $"v27".isNotNull || $"v28".isNotNull || $"v29".isNotNull || $"v30".isNotNull || $"v31".isNotNull)


display(filterDF5)