## plot2.R

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

plot(data$Timestamp, data$Global_active_power, main='', ylab= 'Global Active Power (kilowatts)', xlab= '', type= 'n')
lines(data$Timestamp, data$Global_active_power, type='l')