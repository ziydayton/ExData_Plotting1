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
df <- df %>% 
  select(Global_reactive_power,
         Sub_metering_3, Sub_metering_2, Sub_metering_1,
         Voltage,
         Global_active_power,
         Time, Date) %>% 
  mutate(Date = dmy(Date)) %>% 
  filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02")) %>%
  mutate(dtg = ymd_hms(paste(Date, Time))) %>% 
  rename(GAP = Global_active_power) %>% 
  mutate(GAP = as.numeric(GAP)) %>%
  mutate(Voltage = as.numeric(Voltage)) %>% 
  rename(SM1 = Sub_metering_1) %>% 
  mutate(SM1 = as.numeric(SM1)) %>%
  rename(SM2 = Sub_metering_2) %>% 
  mutate(SM2 = as.numeric(SM2)) %>%
  rename(SM3 = Sub_metering_3) %>% 
  mutate(SM3 = as.numeric(SM3)) %>%
  rename(GRP = Global_reactive_power) %>% 
  mutate(GRP = as.numeric(GRP)) %>%
  select(dtg, GAP, Voltage, SM1, SM2, SM3, GRP)

##Generate plot
#Specified png that is 480x480pixels - Although defealt; included for specificity
png(filename = "plot4.png",
    width = 480,
    height = 480,
    units = "px")

#Set plot pallette
par(mfrow = c(2,2))

#Create 1st plot
plot(GAP ~ dtg, 
     data = df,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

#Create 2nd plot
plot(Voltage ~ dtg, 
     data = df,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

#Create 3rd plot
plot(SM1 ~ dtg, 
     data = df,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(SM1 ~ dtg, data = df, type = "l", col = "black")
lines(SM2 ~ dtg, data = df, type = "l", col = "red")
lines(SM3 ~ dtg, data = df, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", 
                              "Sub_metering_2", 
                              "Sub_metering_3"), 
       lty = c(1, 1, 1), 
       col = c("black", "red", "blue"),
       bty = "n")
#Create 4th plot
plot(GRP ~ dtg, 
     data = df,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

#Turn off png device
dev.off()
