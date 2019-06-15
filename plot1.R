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
  
##Generate plot
