data<-read.csv("household_power_consumption.txt",sep=";",stringsAsFactors=F)
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
subData<-data[data$Date>=as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]
rm(data)
subData$Global_active_power<-as.numeric(subData$Global_active_power)
png("plot1.png",width=480,height=480)
hist(subData$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
