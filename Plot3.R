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
#Open PNG on device, create 'Plot3.png' in working directory
png("plot3.png", bg = "white", width = 480, height = 480)

#Send plot to the PNG file, no plot will appear in RStudio
plot(power$DateTime, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(power$DateTime, power$Sub_metering_2, col = "red")
lines(power$DateTime, power$Sub_metering_3, col = "blue")

legend("topright"
       , col = c("black", "red", "blue")
       , c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , lty = c(1,1), lwd = c(1,1))
#Close the PNG file device
dev.off()
