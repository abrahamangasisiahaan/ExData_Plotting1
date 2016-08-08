##unzip file
unzip("exdata-data-household_power_consumption.zip")

##read file into data frame
hpc <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

##subset data frame for Date from 2007-02-01 and 2007-02-02
sub.hpc <- subset(hpc, as.Date(hpc$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01", "%Y-%m-%d") & as.Date(hpc$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02", "%Y-%m-%d"))

##change data type from factor to numeric for Global Active Power
sub.hpc$Global_active_power <- as.numeric(as.character(sub.hpc$Global_active_power))

##Combine Date and Time column, then change its datatype
sub.hpc$Date.Time <- strptime(paste(sub.hpc$Date, " ", sub.hpc$Time), format = "%d/%m/%Y %H:%M:%S")

##change data type from factor to numeric for Sub Metering measurements
sub.hpc$Sub_metering_1 <- as.numeric(as.character(sub.hpc$Sub_metering_1))
sub.hpc$Sub_metering_2 <- as.numeric(as.character(sub.hpc$Sub_metering_2))
sub.hpc$Sub_metering_3 <- as.numeric(as.character(sub.hpc$Sub_metering_3))

##change data type from factor to numeric for Voltage & Global Reactive Power
sub.hpc$Voltage <- as.numeric(as.character(sub.hpc$Voltage))
sub.hpc$Global_reactive_power <- as.numeric(as.character(sub.hpc$Global_reactive_power))

##open png device, size 480 x 480
png("plot4.png", 480, 480)

##setting the layout to be 2 x 2
par(mfrow = c(2,2))

##create plot datetime vs Global Active Power
with(sub.hpc, plot(Date.Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

##create plot datetime vs Voltage
with(sub.hpc, plot(Date.Time, Voltage, xlab = "datetime", type = "l"))

##create empty canvas
with(sub.hpc, plot(Date.Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))

##put line for sub_metering_1, sub_metering_2, and sub_metering_3
with(sub.hpc, points(Date.Time, Sub_metering_1, type = "l"))
with(sub.hpc, points(Date.Time, Sub_metering_2, type = "l", col = "red"))
with(sub.hpc, points(Date.Time, Sub_metering_3, type = "l", col = "blue"))

##put legends in
legend("toprigh", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")

##create plot datetime vs Global Reactive Power
with(sub.hpc, plot(Date.Time, Global_reactive_power, xlab = "datetime", type = "l"))

##close the device, create file
dev.off()