library(data.table)
install.packages("lubridate")
library(lubridate)
library(dplyr)

#Read the data file
power <- fread(input = "household_power_consumption.txt", na.strings = "?")

#Converting from factor to date
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

#Subsetting data
power <- power[power$Date >= as.Date("2007-02-01") & power$Date <= as.Date("2007-02-02"), ]

power$DateTime <- as.POSIXct(paste(power$Date, power$Time), 
                             format = "%Y-%m-%d %H:%M:%S")

head(power)
dim(power)

##Plot histogram into a PNG file
#Open PNG on device, create 'Plot4.png' in working directory
png("plot4.png", bg = "white", width = 480, height = 480)

par(mfrow = c(2,2))

##Send plot to the PNG file, no plot will appear in RStudio

#Plot1
plot(power$DateTime, power$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power")

#Plot2
plot(power$DateTime, power$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

#Plot3
plot(power$DateTime, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(power$DateTime, power$Sub_metering_2, col = "red")
lines(power$DateTime, power$Sub_metering_3, col = "blue")

legend("topright"
       , col = c("black", "red", "blue")
       , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , lty = c(1,1)
       , bty = "n"
       , cex = .5)

#Plot4
plot(power$DateTime, power$Global_reactive_power, type = "l", xlab = "datetime"
     , ylab = "Global_reactive_power")
#Close the PNG file device
dev.off()
