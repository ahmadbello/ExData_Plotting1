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
png(filename = "plot2.png", width = 480, height = 480)
with(HHDataSub, plot(DateTime, Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
