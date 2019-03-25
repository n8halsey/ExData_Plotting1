# plot 3:
        # main title: no main title
        # x axis: Day of Week values with no axis label
        # y axis: 'Energy sub metering' label
        # colors: each sub metering type is different color
        # sub 1: black
        # sub 2: red
        # sub 3: blue
        # legend: 'Sub_metering_1', 'Sub_metering_2', and 'Sub_metering_3' included in legend along with their respective colors

# download data set
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
sub_meter1 <- as.numeric(pow_cons_sub$Sub_metering_1)
sub_meter2 <- as.numeric(pow_cons_sub$Sub_metering_2)
sub_meter3 <- as.numeric(pow_cons_sub$Sub_metering_3)

# create plot graphic
plot(day_time,sub_meter1,type="l",xlab="",ylab="Energy Submetering")
lines(day_time,sub_meter2,type="l",col="red")
lines(day_time,sub_meter3,type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=2,lty=1)
dev.copy(png,file='plot3.png',width=480,height=480)  # copy from screen device to file device formatted png
dev.off()  # deliver the file device to local directory and close file device