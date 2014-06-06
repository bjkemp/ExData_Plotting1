## plot4.R

## This file downloads the source data, subsets the data via
## read.csv.sql from sqldf, then creates plot 4 of the assignment.

## Variables used:
## url - the location of the source data
## destFile - the filename of the downloaded file
## rawData - the filename of the file extracted from the downloaded zip
## query - the SQL query used to subset the extracted file
## data - the data.frame which contains the imported data


## We're using sqldf to subset the data before creating the data.frame
require(sqldf)

url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
destFile = 'exdata.data.household_power_consumption.zip'

## If this file has already been downloaded, don't do it again.
if (!file.exists(destFile)) {
    download.file(url= url, destfile= destFile, method= 'auto')
}

## Unzip the downloaded file and store the filename in rawData.
rawData = unzip(destFile)

query = 'SELECT * FROM file WHERE Date IN("1/2/2007","2/2/2007")'

## Read the lines from rawData using the constraint: WHERE Date IN("1/2/2007","2/2/2007")
data = read.csv.sql(rawData, query, sep= ';', header= TRUE)

## Create a new column, Timestamp, by combining the columns Date and Time and format it
## using strptime.
data$Timestamp = strptime(paste(data$Date, data$Time, sep= ' '), 
                          format= '%d/%m/%Y %H:%M:%S')

##  Open a png and send the plot to it when finished.
png(file= 'plot4.png', width= 480, height= 480)

par(mfrow= c(2,2))

# Plot 1
plot(data$Timestamp, data$Global_active_power, main='', 
     ylab= 'Global Active Power', xlab= '', type= 'n')
lines(data$Timestamp, data$Global_active_power, type='l')

# Plot 2
plot(data$Timestamp, data$Voltage, main='', ylab= 'Voltage', 
     xlab= 'datetime', type= 'n')
lines(data$Timestamp, data$Voltage, type='l')

# Plot 3
plot(data$Timestamp, data$Sub_metering_1, main='', 
     ylab= 'Energy sub metering', xlab= '', type= 'n')
lines(data$Timestamp, data$Sub_metering_1, type='l')
lines(data$Timestamp, data$Sub_metering_2, type='l', col='red')
lines(data$Timestamp, data$Sub_metering_3, type='l', col='blue')

legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lwd= c(2.5, 2.5, 2.5), col= c('black', 'red', 'blue'), bty='n')

# Plot 4
plot(data$Timestamp, data$Global_reactive_power, main='', 
     ylab='Gobal_reactive_power', xlab= 'datetime', type= 'n',
     ylim= c(0, 0.5))
lines(data$Timestamp, data$Global_reactive_power, type='l')

dev.off()