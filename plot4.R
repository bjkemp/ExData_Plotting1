## plot4.R

require(sqldf)

url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
destFile = 'exdata.data.household_power_consumption.zip'

if (!file.exists(destFile)) {
    download.file(url= url, destfile= destFile, method= 'auto')
}

rawData = unzip(destFile)

query = 'SELECT * FROM file WHERE Date IN("1/2/2007","2/2/2007")'

data = read.csv.sql(rawData, query, sep= ';', header= TRUE)

data$Timestamp = strptime(paste(data$Date, data$Time, sep= ' '), format= '%d/%m/%Y %H:%M:%S')

plot(data$Timestamp, data$Sub_metering_1, main='', ylab= 'Energy sub metering', xlab= '', type= 'n')
lines(data$Timestamp, data$Sub_metering_1, type='l')
lines(data$Timestamp, data$Sub_metering_2, type='l', col='red')
lines(data$Timestamp, data$Sub_metering_3, type='l', col='blue')

legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd= c(2.5, 2.5, 2.5), col= c('black', 'red', 'blue'))
