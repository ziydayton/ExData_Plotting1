## This code was developed to for the Coursera Data Exploration course.
## Author:  Dayton, Jeff
## Date: 15 June 2019
## Assignment #1 (week 1), Part #2 (plot 2).  This code generates plot 2 only.

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
  select(Global_active_power, Time, Date) %>% 
  mutate(Date = dmy(Date)) %>% 
  filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02")) %>%
  mutate(dtg = ymd_hms(paste(Date, Time))) %>% 
  rename(GAP = Global_active_power) %>% 
  mutate(GAP = as.numeric(GAP)) %>% 
  select(dtg, GAP)

##Generate plot
#Specified png that is 480x480pixels - Although defealt; included for specificity
png(filename = "plot2.png",
    width = 480,
    height = 480,
    units = "px")
#Create plot
plot(GAP ~ dtg, 
     data = df,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
#Turn off png device
dev.off()
