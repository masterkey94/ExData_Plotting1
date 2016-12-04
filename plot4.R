#  Exploratory Data Analysis Week 1 Course Project
#  R Code for Plot 4
#  data: UC Irvine Machine Learning Repository (https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption)


#  Load needed libraries
library(lubridate)


#  Load zip data file and unzip data files
zipfilename <- "data.zip"
if(!file.exists(zipfilename)) {
  FileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(FileURL, zipfilename)
}

if (!file.exists("household_power_consumption.txt")) { 
  unzip(zipfilename) 
}

print("data files downloaded and unzipped")

# Read data into table and subset data to only dates 2007-02-01 and 2007-02-02
alldata <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
alldata$Timestamp <- dmy_hms(paste(alldata$Date, alldata$Time))
alldata$Date <- dmy(alldata$Date)
alldata$Time <- hms(alldata$Time)



print("data loaded and date / time properly converted")

subdata <- subset(alldata, alldata$Date == "2007-02-01" | alldata$Date == "2007-02-02")

print("data subsetted to dates 2007-02-01 and 2007-02-02")


#  Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

plot(subdata$Timestamp, subdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(subdata$Timestamp, subdata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(subdata$Timestamp, subdata$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab ="")
points(subdata$Timestamp, subdata$Sub_metering_2, type = "l", col = "red")
points(subdata$Timestamp, subdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

plot(subdata$Timestamp, subdata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab="datetime")
dev.off()

print("plot created")