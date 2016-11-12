#Plot4.R
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

#Create a single image with 4 plots
par(mfrow=c(2,2), mar=c(4,4,2,2), oma=c(0,0,2,0))
with(data, {
        #Line plot of Global active power over time
        plot(Global_active_power~DateTime, type="l", 
             ylab="Global Active Power", xlab="", cex=0.8)
        #Line plot of voltage over time
        plot(Voltage~DateTime, type="l", 
             ylab="Voltage", xlab="datetime", cex=0.8)
        #Line plot of global active power, by submeter, over time
        plot(Sub_metering_1~DateTime, type="l", 
             ylab="Global Active Power", xlab="", cex=0.8)
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5)
        #Line plot of global reactive power over time
        plot(Global_reactive_power~DateTime, type="l", 
             ylab="Global Rective Power",xlab="datetime", cex=0.8)
})

##Copy and save the plot to png format
dev.copy(png, file="plot4.png", height=480, width=580)
dev.off()
