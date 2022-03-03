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

head(power)
dim(power)

##Plot histogram into a PNG file
#Open PNG on device, create 'Plot1.png' in working directory
png("plot1.png", bg = "transparent", width = 480, height = 480)

#Send plot to the PNG file, no plot will appear in RStudio
hist(x = power$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")

#Close the PNG file device
dev.off()
