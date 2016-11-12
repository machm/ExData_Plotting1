#Plot1.R
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

##Plot histogram of column "Global_active_power", along with title, x and y legend labels
##and give a red color
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red", cex.sub=0.8)

##Copy and save the plot to png format
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
