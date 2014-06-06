## plot3.R

## This file downloads the source data, subsets the data via
## read.csv.sql from sqldf, then creates plot 3 of the assignment.

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
png(file= 'plot3.png', width= 480, height= 480)

plot(data$Timestamp, data$Sub_metering_1, main='', 
     ylab= 'Energy sub metering', xlab= '', type= 'n')
lines(data$Timestamp, data$Sub_metering_1, type='l')
lines(data$Timestamp, data$Sub_metering_2, type='l', col='red')
lines(data$Timestamp, data$Sub_metering_3, type='l', col='blue')

legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lwd= c(2.5, 2.5, 2.5), col= c('black', 'red', 'blue'))

dev.off()
