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

cleanedData <- subset(data, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))
cleanedData$datetime <- strptime(paste(cleanedData$Date, cleanedData$Time), format = '%Y-%m-%d %H:%M:%S')

#plot line chart of global active power
png(filename = 'plot2.png')
plot(cleanedData$datetime, cleanedData$Global_active_power, type = 'l', xlab = '',
     ylab = 'Global Active Power (kilowatts)')
dev.off()