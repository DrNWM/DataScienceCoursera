library(data.table)
library(lubridate)

# Download and unzip the dataset if it doesn't exist
if (!file.exists("household_power_consumption.txt")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "dataset.zip", mode = "wb")
  unzip("dataset.zip")
}

# Read in data
dt <- fread("household_power_consumption.txt", na.strings = "?", sep = ";")

# Convert Date column to Date class
dt[, Date := dmy(Date)]

# Filter for February 1-2, 2007
dt_filtered <- dt[Date %in% as.Date(c("2007-02-01", "2007-02-02"))]

# Convert Date and Time to DateTime
dt_filtered[, DateTime := dmy_hms(paste(Date, Time))]

# PNG graphics device
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Plot 1: Global Active Power
plot(
  dt_filtered$DateTime,
  dt_filtered$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

# Plot 2: Voltage
plot(
  dt_filtered$DateTime,
  dt_filtered$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)

# Plot 3: Sub-metering
plot(
  dt_filtered$DateTime,
  dt_filtered$Sub_metering_1,
  type = "l",
  xlab = "",
  ylab = "Energy sub metering",
  col = "black"
)
lines(dt_filtered$DateTime, dt_filtered$Sub_metering_2, col = "red")
lines(dt_filtered$DateTime, dt_filtered$Sub_metering_3, col = "blue")
legend(
  "topright",
  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n"
)

# Plot 4: Global Reactive Power
plot(
  dt_filtered$DateTime,
  dt_filtered$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)
dev.off()