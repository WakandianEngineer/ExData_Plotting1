#Plot 4
#the labels may differ a little because my system is in spanish 
library(data.table)
library(lubridate)

##Downloads the data and unzips the data
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              destfile = './figure/data.zip')
unzip('./figure/data.zip', exdir = './figure')
#____________________________________________________________________________

#Reads the data
hpc=fread('./figure/household_power_consumption.txt')

#Make a new variable DateTime merging the variables Date and Time
hpc[, DateTime := dmy_hms(paste(hpc$Date,hpc$Time))]

#subsets the data
hpc[,Date:=lubridate::dmy(Date)][,Time:=lubridate::hms(Time)]
hpc= hpc[Date == ymd("2007/02/01") | Date == ymd("2007/02/02")]


#Edits the classes of the variables
hpc[,Global_intensity:=as.numeric(Global_intensity)][,
   Global_reactive_power:=as.numeric(Global_reactive_power)][,
           Voltage:= as.numeric(Voltage)][,Sub_metering_1 := as.numeric(Sub_metering_1)][,
           Global_active_power := as.numeric(Global_active_power)][,Sub_metering_2:= as.numeric(Sub_metering_2)]

#Creates the plot
png(file='./figure/plot4.png', width = 480, height = 480)
par(mfrow=c(2,2))
#1
with(hpc, plot(DateTime, Global_active_power, type = 'l', 
               ylab = 'Global Active Power', xlab = ''))
#2
with(hpc, plot(DateTime, Voltage, type = 'l', 
                xlab = 'datetime'))
#3
with(hpc, plot(DateTime, Sub_metering_1, type = 'l',
               ylab = 'Energy sub meltering', xlab = ''))
with(hpc, lines(DateTime, Sub_metering_2, col='red'))
with(hpc, lines(DateTime, Sub_metering_3, col='blue'))
legend('topright',lty = c(1, 1, 1),pch=c(NA,NA,NA), col=c('black', 'red', 'blue'), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3' ))
#4
with(hpc, plot(DateTime, Global_reactive_power, type = 'l', 
               xlab = 'datetime', ylab = 'Global_reactive_power'))
dev.off()