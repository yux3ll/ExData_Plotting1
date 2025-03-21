# plot3.R

# Load necessary library
library(data.table)

# Define the file path
file_path <- "household_power_consumption.txt"

# Read the data for the specified dates
data <- fread(file_path, sep = ";", na.strings = "?")
data <- data[Date %in% c("1/2/2007", "2/2/2007")]

# Combine Date and Time into a single DateTime column using as.POSIXct
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Convert Sub_metering columns to numeric
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Plot 3: Energy Sub Metering Over Time
png("plot3.png", width = 480, height = 480)
plot(data$DateTime, data$Sub_metering_1, type = "l", col = "black", 
     xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
axis(1, at = pretty(data$DateTime, n = 2), labels = format(pretty(data$DateTime, n = 2), "%a"))
dev.off()