# Import average min and average max per YEAR based on GSN from GHCN-D

library(dplyr)
library(ggplot2)

usamin <- read_csv("C:/Users/dell/Desktop/NOAA_DATA/usamin.csv", col_names = c('year', 'min_c'))
usamax <- read_csv("C:/Users/dell/Desktop/NOAA_DATA/usamax.csv", col_names = c('year', 'max_c'))

usa_all <- inner_join(usamin, usamax, by='year')
usa_all <- filter(usa_all, usa_all$year > 1925)

USAChart <- ggplot(usa_all, aes(x=year)) + 
  geom_line(aes(y=min_c), color='navy') + 
  geom_line(aes(y=max_c), color='red') + 
  xlab('Year') + 
  ylab('Temp in C') + 
  ggtitle('Min and Max USA Temps from GSN')

USAChart
