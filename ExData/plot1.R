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

# PNG graphics device
png("plot1.png", width = 480, height = 480)

# Histogram
hist(
  dt_filtered$Global_active_power,
  xlab = "Global Active Power (kilowatts)",
  ylab = "Frequency",
  main = "Global Active Power",
  col = "Red"
)
dev.off()