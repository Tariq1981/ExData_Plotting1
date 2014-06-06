data<-read.csv("household_power_consumption.txt",sep=";",stringsAsFactors=F)
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
subData<-data[data$Date>=as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]
rm(data)
subData$Global_active_power<-as.numeric(subData$Global_active_power)
subData$Voltage<-as.numeric(subData$Voltage)
subData$Sub_metering_1<-as.numeric(subData$Sub_metering_1)
subData$Sub_metering_2<-as.numeric(subData$Sub_metering_2)
subData$Sub_metering_3<-as.numeric(subData$Sub_metering_3)
subData$Global_reactive_power<-as.numeric(subData$Global_reactive_power)
indexs=tapply(seq(1:nrow(subData)),weekdays(subData$Date,abbreviate=T),min)
lab=sapply(indexs,function(x)weekdays(subData[x,1],abbreviate=T))
indexs=c(indexs,nrow(subData)+1)
lab=c(lab,weekdays(subData[nrow(subData),1]+1,abbreviate=T))

png("plot4.png",width=480,height=480)
par(mfrow = c(2, 2))

plot(subData$Global_active_power,col="black",type="l",xaxt="n",ylab="Global Active Power",xlab="")
axis(1,indexs,labels=lab)

plot(subData$Voltage,col="black",type="l",xaxt="n",ylab="Voltage",xlab="datetime")
axis(1,indexs,labels=lab)

with(subData,plot(subData$Sub_metering_1,type="l",lwd=1,xaxt="n",ylab="Energy sub metering",xlab="",col="black"))
with(subData,lines(subData$Sub_metering_2,col="red"))
with(subData,lines(subData$Sub_metering_3,col="blue"))
legend("topright",bty="n",cex=0.8,lty=c(1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
axis(1,indexs,labels=lab)

plot(subData$Global_reactive_power,col="black",type="l",xaxt="n",ylab="Global_reactive_power",xlab="datetime")
axis(1,indexs,labels=lab)
dev.off()
