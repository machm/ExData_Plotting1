#Plot2.R
##download and unzip file from source
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="curl")
unzip ("data.zip", exdir = "./")

##Read file as csv and get column names, header, and number of rows in dataset
fullData <- read.csv("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors=FALSE,na.strings="?")
colnames(fullData)
head(fullData)
nrow(fullData)

##Subset fullData to only include data between Feb 1 - Feb 2, 2007,
##then gather number of rows, and head of new object.
data <- fullData[(fullData$Date=="1/2/2007" | fullData$Date=="2/2/2007" ), ]
nrow(data)
head(data)

##format date column as a date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
##Create new variable that combines the Date and Time columns
dateTime <- paste(data$Date, data$Time)
##format the values in the colume to datetime format
data$DateTime <- as.POSIXct(dateTime)

##Create a line plot for the column "Global_active_power" and plots by DateTime column
##and add title and y-label
plot(data$Global_active_power~data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
##Copy and save the plot to png format

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

