#Plot3.R
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

##Plot a line graph that shows the data for sub_metering_1, sub_metering_2, and 
##sub_metering_3, distinguish by color, and provide a y-label title. 
with(data, {
        plot(Sub_metering_1~DateTime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
        lines(Sub_metering_2~DateTime, col='Red')
        lines(Sub_metering_3~DateTime, col='Blue')
})
##Create a legend that shows the data for each line in the top right corner
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)

##Copy and save the plot to png format
dev.copy(png, file="plot3.png", height=480, width=580)
dev.off()
