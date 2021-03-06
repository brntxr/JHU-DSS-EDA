# Get data
library(lubridate)
library(dplyr)

zipFile <- 'household_power_consumption.zip'
zipFilePath <- file.path(getwd(),zipFile)

if (!file.exists(zipFilePath)){
    zipURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    download.file(zipURL, destfile = zipFilePath, method = 'curl')
}


dataFile<- 'household_power_consumption.txt'
if (!file.exists(dataFile)){
    unzip(zipfile = zipFile)
}

# setClass('DDMMYYYY')
# setClass('HHMMSS')
# setAs("character","DDMMYYYY", function(from) dmy(from) )
# setAs("character", "HHMMSS", function(from) hms(from))


power<-read.csv2(dataFile, sep = ";", na.strings = "?", dec=".",
                 colClasses = 
                     c(
                         # 'DDMMYYYY','HHMMSS',
                         rep('character',2),
                         rep("numeric", 7)
                     ),
                 stringsAsFactors = FALSE)



power$Date_Time <- with(power, paste(Date, Time))
power$Date <- with(power, as.POSIXct(Date, format = "%d/%m/%Y"))
power$Date_Time  <- with(power,  as.POSIXct(Date_Time, format = "%d/%m/%Y %H:%M:%S"))


#Plot 1
png("./Plot1.png")
with(power_sample, hist(Global_active_power, 
                        col='red',
                        main='Global Active Power',
                        xlab="Global Active Power (kilowatts)"
                        )
     )

dev.off()


