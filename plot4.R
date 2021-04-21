#get data
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

if(!file.exists('./dlData')){
  dir.create('./dlData')
  download.file(url = fileUrl, destfile = './dlData/dlData.zip')
}

if(!file.exists('./extractedData')){
  dir.create('./extractedData')
  unzip('./dlData/dlData.zip', exdir = './extractedData')
}

#read in data
data <- read.csv('./extractedData/household_power_consumption.txt', header = TRUE, sep = ';', na.strings = "?")

#clean data
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')

#cleanedData <- subset(data, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))
cleanedData$datetime <- strptime(paste(cleanedData$Date, cleanedData$Time), format = '%Y-%m-%d %H:%M:%S')

#plot
png(filename = 'plot4.png')
par(mfrow = c(2,2))

plot(cleanedData$datetime, cleanedData$Global_active_power, type = 'l', xlab = '',
     ylab = 'Global Active Power')

plot(cleanedData$datetime, cleanedData$Voltage, type = 'l', xlab = 'datetime',
     ylab = 'Voltage')

plot(cleanedData$datetime, cleanedData$Sub_metering_1, type = 'l', xlab = '',
     ylab = 'Energy sub metering')
lines(cleanedData$datetime, cleanedData$Sub_metering_2, col = 'red')
lines(cleanedData$datetime, cleanedData$Sub_metering_3, col = 'blue')
legend('topright', 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'),
       lty = 1, bty = 'n')

plot(cleanedData$datetime, cleanedData$Global_reactive_power, type = 'l', xlab = 'datetime',
     ylab = 'Global_reactive_power')

dev.off()