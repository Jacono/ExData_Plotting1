## plot3.R
# Plot 3 assignment of exploratory data analysis
# Marco Jacono 2015
# This script is load data of power cosumption and display and create a png file called plot3.png of submetering

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

t  <- subtblPowerConsumption$fullDate
x1 <- subtblPowerConsumption$Sub_metering_1
x2 <- subtblPowerConsumption$Sub_metering_2
x3 <- subtblPowerConsumption$Sub_metering_3

# Plot 3
# For this plot I've troble to make the  excact copy in png. As suggestend in forum I try to open a png device directly
# instead creating graph and than copy it.

png(filename = "plot3.png", width = 480, height = 480)
plot(t, x1, type="l", col="black", ylab="Energy Submetering", xlab="")
lines(t, x2, col="red")
lines(t, x3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1, col=c("black", "red", "blue"))
dev.off()





