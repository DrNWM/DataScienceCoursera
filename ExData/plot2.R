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

# Inspect raw Date and Time columns
print("Raw Date and Time columns:")
head(dt[, .(Date, Time)])

# Filter for February 1-2, 2007
dt <- dt[Date %in% c("1/2/2007", "2/2/2007"), ]

# Convert Date and Time to DateTime
dateTime <- dmy_hms(paste(dt$Date, dt$Time, sep = " "), tz = "UTC")

# PNG graphics device
png("plot2.png", width = 480, height = 480)

# Plot
plot(
  dateTime,
  dt$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

# Close device
dev.off()
