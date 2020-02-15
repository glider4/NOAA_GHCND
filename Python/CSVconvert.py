# -*- coding: utf-8 -*-
"""
Convert raw NOAA .txt (and .dly) files to .csv to easily import into Postgres

Using fixed-width format with pd.read_fwf because of spaces in delims
and in entries.

"""

import pandas as pd
import glob

# Stations data
stations = pd.read_fwf('C:/Users/dell/Documents/GitHub/NOAA_BigData/data/text_files/ghcnd-stations.txt',
                widths=[12,9,9,7,3,31,4,4,5], header=None)

# Convert to csv for PG import
stations.to_csv('C:/Users/dell/Documents/GitHub/NOAA_BigData/data/ghcnd-stations.csv',
                   sep=',', encoding='utf-8', header=None)


# States data
states = pd.read_fwf('C:/Users/dell/Documents/GitHub/NOAA_BigData/data/text_files/ghcnd-states.txt',
                widths=[3,35], header=None)

# Convert to csv for PG import
states.to_csv('C:/Users/dell/Documents/GitHub/NOAA_BigData/data/ghcnd-states.csv',
                   sep=',', encoding='utf-8', header=None)


# Countries data
countries = pd.read_fwf('C:/Users/dell/Documents/GitHub/NOAA_BigData/data/text_files/ghcnd-countries.txt',
                widths=[3,200], header=None)

# Convert to csv for PG import
countries.to_csv('C:/Users/dell/Documents/GitHub/NOAA_BigData/data/ghcnd-countries.csv',
                   sep=',', encoding='utf-8', header=None)


# Inventory data
countries = pd.read_fwf('C:/Users/dell/Documents/GitHub/NOAA_BigData/data/text_files/ghcnd-inventory.txt',
                widths=[12,9,9,5,5,5], header=None)

# Convert to csv for PG import
countries.to_csv('/Users/mm19864/Documents/BU_assignments/CS779/TermProj/NOAA_BigData/data/ghcnd-inventory.csv',
                   sep=',', encoding='utf-8', header=None)

#################################

# Concat all .dly files in directory together
# Credit: https://stackoverflow.com/questions/17749058/
read_files = glob.glob("D:/ghcnd_all/*.dly")

with open("D:/result.txt", "wb") as outfile:
    for f in read_files:
        with open(f, "rb") as infile:
            outfile.write(infile.read())

# OBS Data - 31 days (if less than read null) of 4 columns each, plus initial 4 info columns
# Credit: https://stackoverflow.com/questions/45870220

# For each chunk of data, convert to CSV and append into single file 'ghcnd-all.csv'
for chunk in pd.read_fwf('D:/result.txt',
                widths=[11,4,2,4,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1
                        ,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1
                        ,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1],
                        header=None, chunksize=15000):
    
    chunk.to_csv('D:/ghcnd-all.csv',
                       mode='a', sep=',', encoding='utf-8', header=None)
    
    
#################################
    
# Another approach: convert to .csv FIRST, then concat

## Under construction
for file in read_files:
    pd.read_fwf(file,
                widths=[11,4,2,4,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1
                        ,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1
                        ,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1,5,1,1,1],
                        header=None)
    file.to_csv('D:/ghcnd_csv', sep=',', encoding='utf-8', header=None)

