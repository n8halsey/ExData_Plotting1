# plot 4:
        # top left plot: plot # 2
        # top right plot: line plot
                # main title: no main title
                # x axis: two days day of week values (Thursday through Friday) with label 'datetime'
                # y axis: 'Voltage' label
                # color: black
        # bottom left plot: plot 3
        # bottom right plot: line plot
                # main title: no main title
                # x axis: two days day of week values (Thursday through Friday) with label 'datetime'
                # y axis: 'Global_reactive_power' label
                # color: black

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/household_power_consumption.zip",method="curl")

# unzip data set
unzip(zipfile="./data/household_power_consumption.zip",exdir="./data")

# read in data set
pow_cons <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

# create subset of data for the two days that are in scope for graphically illustrating and analyzing
pow_cons_sub <- pow_cons[pow_cons$Date %in% c("1/2/2007","2/2/2007") ,]

# convert variables that will be included in graph to numeric class
day_time <- strptime(paste(pow_cons_sub$Date, pow_cons_sub$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
act_pow <- as.numeric(pow_cons_sub$Global_active_power)
react_pow <- as.numeric(pow_cons_sub$Global_reactive_power)
volt <- as.numeric(pow_cons_sub$Voltage)
sub_meter1 <- as.numeric(pow_cons_sub$Sub_metering_1)
sub_meter2 <- as.numeric(pow_cons_sub$Sub_metering_2)
sub_meter3 <- as.numeric(pow_cons_sub$Sub_metering_3)

# set plot area for 4 graphs positioned 2x2
par(mfrow=c(2,2))

# create top left plot
plot(day_time,act_pow,xlab="",ylab="Global Active Power",type="l")

# create top right plot
plot(day_time,volt,xlab="datetime",ylab="Voltage",type="l")

# create bottom left plot
plot(day_time,sub_meter1,xlab="",ylab="Energy sub metering",type="l")
lines(day_time,sub_meter2,col="red",type="l")
lines(day_time,sub_meter3,col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=2,lty=1)

# create bottom right plot
plot(day_time,react_pow,xlab="datetime",ylab="Global_reactive_power",type="l")

dev.copy(png,file='plot4.png',width=480,height=480)  # copy from screen device to file device formatted png
dev.off()  # deliver the file device to local directory and close file device