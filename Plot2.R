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
#Open PNG on device, create 'Plot2.png' in working directory
png("plot2.png", bg = "white", width = 480, height = 480)

#Send plot to the PNG file, no plot will appear in RStudio
plot(x = power$DateTime, y = power$Global_active_power, xlab = "", ylab = 
       "Global Active Power (kilowatts)", type = "l")

#Close the PNG file device
dev.off()
