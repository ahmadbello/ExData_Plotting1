# Unzip and read data
unzip("exdata_data_household_power_consumption.zip")
HH <- read.table("household_power_consumption.txt", header = TRUE, nrows = 20000, 
                 sep = ";", na.strings = "?")
colClasses <- sapply(HH, class)
HHData <- read.table("household_power_consumption.txt", header = TRUE,
                     colClasses = colClasses, sep = ";", na.strings = "?")

# Subset data and convert Date-Time columns
HHData$Date <- as.Date(HHData$Date, "%d/%m/%Y")
startDate <- as.Date("2007-02-01")
stopDate <- as.Date("2007-02-02")
HHDataSub <- HHData[which(HHData$Date %in% c(startDate, stopDate)), ]
rm(HHData, HH, colClasses)
HHDataSub$DateTime <- paste(HHDataSub$Date, HHDataSub$Time, sep = " ")
HHDataSub$DateTime <- strptime(HHDataSub$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Plot
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))

# First plot
with(HHDataSub, plot(DateTime, Global_active_power, type = "l",
                     ylab = "Global Active Power", xlab = ""))

# Second plot
with(HHDataSub, {
    plot(DateTime, Sub_metering_1, type = "n",
         ylab = "Energy sub metering", xlab = "")
    lines(DateTime, Sub_metering_1)
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"), lty = 1, bty = "n")
})

# Third plot
with(HHDataSub, plot(DateTime, Voltage, type = "l",
                     ylab = "Voltage", xlab = "datetime"))

# Fourth plot
with(HHDataSub, plot(DateTime, Global_reactive_power, type = "l",
                     ylab = "Global_reactive_power", xlab = "datetime"))
dev.off()
