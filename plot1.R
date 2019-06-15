## This code was developed to for the Coursera Data Exploration course.
## Author:  Dayton, Jeff
## Date: 15 June 2019
## Assignment #1 (week 1), Part #1 (plot 1).  This code generates plot 1 only.

##Clear environment
rm(list = ls())

##Call libraries
library(dplyr)
library(lubridate)

##Read-in and prepare data
#Read zip file from link, create initial df, cleanup environment
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileURL, temp)
con <- unzip(temp, "household_power_consumption.txt")
df <- read.table(con, header = TRUE, sep=";", stringsAsFactors = FALSE)
unlink(temp)
file.remove("household_power_consumption.txt")
rm(temp, con, fileURL) 

#sort and prepare df
df <- df %>% 
  select(Global_active_power, Date) %>% 
  mutate(Date = dmy(Date)) %>% 
  filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02")) %>% 
  rename(GAP = Global_active_power) %>% 
  mutate(GAP = as.numeric(GAP))

##Generate plot
#Specified png that is 480x480pixels - Although defealt; included for specificity
png(filename = "plot1.png",
    width = 480, 
    height = 480, 
    units = "px")
hist(df$GAP,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
dev.off()
