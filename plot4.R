library(dplyr)
epc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
epc$dt <- as.POSIXct(paste(epc$Date, epc$Time), format = "%d/%m/%Y %H:%M:%S")
epc2 <- tbl_df(epc)
rm(epc)
epc <- filter(epc2, dt >= "2007-02-01 00:00:00", dt <= "2007-02-02 23:59:59")
rm(epc2)
epc$Global_active_power <- as.numeric(epc$Global_active_power)



png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2,2))
with(epc, plot(dt, Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)"))

epc$Sub_metering_1 <- as.numeric(epc$Sub_metering_1)
epc$Sub_metering_2 <- as.numeric(epc$Sub_metering_2)
epc$Sub_metering_3 <- as.numeric(epc$Sub_metering_3)
epc$Voltage <- as.numeric(epc$Voltage)
epc$Global_reactive_power <- as.numeric(epc$Global_reactive_power)

with(epc, plot(epc$dt,epc$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
lines(epc$dt, epc$Sub_metering_1, col="black")
lines(epc$dt, epc$Sub_metering_2, col="red")
lines(epc$dt, epc$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty=1, cex = .5, bty = "n")

with(epc, plot(epc$dt, epc$Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

with(epc, plot(epc$dt, epc$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()
