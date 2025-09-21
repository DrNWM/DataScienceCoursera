library(data.table)
getwd()

if (!file.exists("M4.1")) {
  fileURL <- "d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "dataset.zip", mode = "wb")
  unzip("dataset.zip")
}


