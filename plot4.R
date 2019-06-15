## This code was developed to for the Coursera Data Exploration course.
## Author:  Dayton, Jeff
## Date: 15 June 2019
## Assignment #1 (week 1), Part #4 (plot 4).  This code generates plot 4 only.

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
df2 <- df %>% 
  select(Sub_metering_3, Sub_metering_2, Sub_metering_1, Time, Date) %>% 
  mutate(Date = dmy(Date)) %>% 
  filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02")) %>%
  mutate(dtg = ymd_hms(paste(Date, Time))) %>% 
  rename(SM1 = Sub_metering_1) %>% 
  mutate(SM1 = as.numeric(SM1)) %>%
  rename(SM2 = Sub_metering_2) %>% 
  mutate(SM2 = as.numeric(SM2)) %>%
  rename(SM3 = Sub_metering_3) %>% 
  mutate(SM3 = as.numeric(SM3)) %>%
  select(dtg, SM1, SM2, SM3)

##Generate plot
#Specified png that is 480x480pixels - Although defealt; included for specificity
png(filename = "plot4.png",
    width = 480,
    height = 480,
    units = "px")

#Create plot 3
plot(SM1 ~ dtg, 
     data = df2,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(SM1 ~ dtg, data = df2, type = "l", col = "black")
lines(SM2 ~ dtg, data = df2, type = "l", col = "red")
lines(SM3 ~ dtg, data = df2, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", 
                              "Sub_metering_2", 
                              "Sub_metering_3"), 
       lty = c(1, 1, 1), 
       col = c("black", "red", "blue"))

#Turn off png device
dev.off()
