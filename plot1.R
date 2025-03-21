# plot1.R

# Load necessary library
library(data.table)

# Define the file path
file_path <- "household_power_consumption.txt"

# Read the data for the specified dates
data <- fread(file_path, sep = ";", na.strings = "?")
data <- data[Date %in% c("1/2/2007", "2/2/2007")]

# Convert Global_active_power to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# Plot 1: Global Active Power Histogram
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()