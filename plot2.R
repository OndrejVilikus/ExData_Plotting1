#Read and prepare the data (assumes the source file is unpacked in the working directory)
library(lubridate)
data<-read.table("household_power_consumption.txt",sep=";",dec = ".",na.strings="?",header=TRUE)
data$dateTime<- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date,"%d/%m/%Y")
data$Time<-strptime(data$Time,"%H:%M:%S")

#Subset data for the selected two days only
fdata<-subset(data,data$Date=="2007-02-01" | data$Date=="2007-02-02")

#Plot 2
png("plot2.png",width = 480, height = 480)
plot(x=fdata$dateTime,y=fdata$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",xaxt="n")
axis.POSIXct(1, at = seq(min(fdata$dateTime), min(fdata$dateTime)+days(2), by = "day"), format = "%a")
dev.off()
