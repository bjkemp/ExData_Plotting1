## plot1.R

require(sqldf)

url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
destFile = 'exdata.data.household_power_consumption.zip'

if (!file.exists(destFile)) {
    download.file(url= url, destfile= destFile, method= 'auto')
}
    
rawData = unzip(destFile)

query = 'SELECT * FROM file WHERE Date IN("1/2/2007","2/2/2007")'

data = read.csv.sql(rawData, query, sep= ';', header= TRUE)

#data$Date = lapply(data$Date, function(foo) as.Date(foo, format= '%d/%m/%Y'))
#data$Time = lapply(data$Time, function(foo) strptime(foo, format= '%H:%M:%S'))

data$Timestamp = strptime(paste(data$Date, data$Time, sep= ' '), format= '%d/%m/%Y %H:%M:%S')

plot = hist(data$Global_active_power, col= 'red', main= 'Global Active Power', xlab= 'Global Active Power (kilowatts)')