## plot1.R
# Plot 1 assignment of exploratory data analysis
# Marco Jacono 2015
# This script is load data of power cosumption and display and create a png file called plot1.png of histogram of power consumption

# Clean up workspace
rm(list=ls())
# Download data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "./powerconsumption.zip"
download.file(url,destfile)

# Unzip Data
unzip(destfile)

# import file in a table : It's seems not very efficient. Are there some other way to read large dataset ?

tblPowerConsumption <- read.table("household_power_consumption.txt",sep = ";", header = TRUE, stringsAsFactors = FALSE, dec = ".",na.strings = "?") 

# As suggested we need to do some operation on time and date. To increase speed of computation and to avoid to make 
# operations on data that we will not consider in our test, first of all I subset data and than apply operation required.

subtblPowerConsumption <- tblPowerConsumption[tblPowerConsumption$Date %in% c("1/2/2007","2/2/2007") ,]

# As expected there are 2880 obs <- 24H * 2 Days * 60 minutes 

subtblPowerConsumption$Date <- as.Date(subtblPowerConsumption$Date, format="%d/%m/%Y")

# Paste $Date and $Time and convert in a posix time class
datetime <- paste(subtblPowerConsumption$Date, subtblPowerConsumption$Time)
subtblPowerConsumption$fullDate <- as.POSIXct(datetime)

x <- subtblPowerConsumption$Global_active_power
# Plot 1
# First I plot on visible device to have a look if everything it's ok and then
# I copy on png file
hist(x, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Save on png device
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()




