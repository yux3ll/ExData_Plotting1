# plot4.R

# Load necessary library
library(data.table)

# Define the file path
file_path <- "household_power_consumption.txt"

# Read the data for the specified dates
data <- fread(file_path, sep = ";", na.strings = "?")
data <- data[Date %in% c("1/2/2007", "2/2/2007")]

# Combine Date and Time into a single DateTime column using as.POSIXct
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Convert columns to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Plot 4: Multiple Plots
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Top-left plot
plot(data$DateTime, data$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power", xaxt = "n")
axis(1, at = pretty(data$DateTime, n = 2), labels = format(pretty(data$DateTime, n = 2), "%a"))

# Top-right plot
plot(data$DateTime, data$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage", xaxt = "n")
axis(1, at = pretty(data$DateTime, n = 2), labels = format(pretty(data$DateTime, n = 2), "%a"))

# Bottom-left plot
plot(data$DateTime, data$Sub_metering_1, type = "l", col = "black", 
     xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")
axis(1, at = pretty(data$DateTime, n = 2), labels = format(pretty(data$DateTime, n = 2), "%a"))

# Bottom-right plot
plot(data$DateTime, data$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n")
axis(1, at = pretty(data$DateTime, n = 2), labels = format(pretty(data$DateTime, n = 2), "%a"))

dev.off()