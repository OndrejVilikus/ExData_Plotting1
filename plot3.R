#Read and prepare the data (assumes the source file is unpacked in the working directory)
library(lubridate)
data<-read.table("household_power_consumption.txt",sep=";",dec = ".",na.strings="?",header=TRUE)
data$dateTime<- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date,"%d/%m/%Y")
data$Time<-strptime(data$Time,"%H:%M:%S")

#Subset data for the selected two days only
fdata<-subset(data,data$Date=="2007-02-01" | data$Date=="2007-02-02")

#Plot 3
png("plot3.png",width = 480, height = 480)
plot(x=fdata$dateTime,y=fdata$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",xaxt="n",col="black")
points(x=fdata$dateTime,y=fdata$Sub_metering_2,type="l",col="red")
points(x=fdata$dateTime,y=fdata$Sub_metering_3,type="l",col="blue")
axis.POSIXct(1, at = seq(min(fdata$dateTime), min(fdata$dateTime)+days(2), by = "day"), format = "%a")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = 1)
dev.off()

