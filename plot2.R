# plot2.R

# Load necessary library
library(data.table)

# Define the file path
file_path <- "household_power_consumption.txt"

# Read the data for the specified dates
data <- fread(file_path, sep = ";", na.strings = "?")
data <- data[Date %in% c("1/2/2007", "2/2/2007")]

# Combine Date and Time into a single DateTime column using as.POSIXct
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Convert Global_active_power to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# Plot 2: Global Active Power Over Time
png("plot2.png", width = 480, height = 480)
plot(data$DateTime, data$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")
axis(1, at = pretty(data$DateTime, n = 2), labels = format(pretty(data$DateTime, n = 2), "%a"))
