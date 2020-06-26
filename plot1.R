#Plot 1
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
#Edits the classes of the variables
hpc[,Date:=lubridate::dmy(Date)][,Time:=lubridate::hms(Time)][,
         Global_intensity:=as.numeric(Global_intensity)][,
         Global_reactive_power:=as.numeric(Global_reactive_power)][,
         Voltage:= as.numeric(Voltage)][,Sub_metering_1 := as.numeric(Sub_metering_1)][,
         Global_active_power := as.numeric(Global_active_power)][,
         Sub_metering_2:= as.numeric(Sub_metering_2)]

#Subsets the data
hpc= hpc[Date == ymd("2007/02/01") | Date == ymd("2007/02/02")]

#Creates the plot
png(file='./figure/plot1.png', width = 480, height = 480)
with(hpc, hist(Global_active_power, breaks = 12, col='red', main = 'Global Active Power'
               , xlab = 'Global Active Power (kilowats)' ), ylim=1200)
dev.off()
