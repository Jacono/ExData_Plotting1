## plot4.R
# Plot 4 assignment of exploratory data analysis
# Marco Jacono 2015
# This script is load data of power cosumption and display and create a png file called plot4.png panel of plot

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
active <- subtblPowerConsumption$Global_active_power
reactive <- subtblPowerConsumption$Global_reactive_power
volt <- subtblPowerConsumption$Voltage
sub1 <- subtblPowerConsumption$Sub_metering_1
sub2 <- subtblPowerConsumption$Sub_metering_2
sub3 <- subtblPowerConsumption$Sub_metering_3

# Plot 4

png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

# Subplot 1
plot(t, active, type="l", xlab="", ylab="Global Active Power")

# Subplot 2
plot(t, volt, type="l", xlab="datetime", ylab="Voltage")

# Subplot 3
plot(t, sub1, type="l", ylab="Energy Submetering", xlab="")
lines(t, sub2, type="l", col="red")
lines(t, sub3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=1, col=c("black", "red", "blue"))

# Subplot 4
plot(t, reactive, type="l", xlab="datetime", ylab="Global_reactive_power")
