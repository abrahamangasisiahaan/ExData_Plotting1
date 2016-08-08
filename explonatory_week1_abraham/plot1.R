##unzip file
unzip("exdata-data-household_power_consumption.zip")

##read file into data frame
hpc <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";")

##subset data frame for Date from 2007-02-01 and 2007-02-02
sub.hpc <- subset(hpc, as.Date(hpc$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01", "%Y-%m-%d") & as.Date(hpc$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02", "%Y-%m-%d"))

##change data type from factor to numeric
sub.hpc$Global_active_power <- as.numeric(as.character(sub.hpc$Global_active_power))

##open png device, size 480 x 480
png("plot1.png", 480, 480)

##create histogram plot
hist(sub.hpc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

##close the device, create file
dev.off()
