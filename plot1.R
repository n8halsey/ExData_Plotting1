# plot 1: histogram with following
        # main title: 'Global Active Power'
        # x axis: 'Global Active Power (kilowatts)' axis label
        # y axis: base plot default 'Frequency' axis label
        # color: red
        # DATA TYPE NOTE: convert variable pow_cons_sub$Global_active_power from character to numeric

# download data set
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/household_power_consumption.zip",method="curl")

# unzip data set
unzip(zipfile="./data/household_power_consumption.zip",exdir="./data")

# read in household_power_consumption data
pow_cons <- read.table("./data/household_power_consumption.txt",sep=";",skip=1)  # read in data set without variable names
names(pow_cons) <- c("Date","Time","Global_active_power"
                     ,"Global_reactive_power","Voltage","Global_intensity"
                     ,"Sub_metering_1","Sub_metering_2","Sub_metering_3")  # assign new variable names
head(pow_cons)  # review data set
summary(pow_cons)  # review data set
# 2,075,260 records

# create subset of data for graphical analysis that is made up of the two dates that are in scope... 2/1/2007 and 2/2/2007
pow_cons_sub <- subset(pow_cons,pow_cons$Date=="2/1/2007"|pow_cons$Date=="2/2/2007")
head(pow_cons)  # review data set
summary(pow_cons)  # review data set
# 1,440 records for 2/1/2007 and 1,440 records for 2/2/2007

# create plot graphic
hist(as.numeric(as.character(pow_cons_sub$Global_active_power)),xlab="Global Active Power (kilowatts)",col="red",main="Global Active Power")
dev.copy(png,file='plot1.png',width=480,height=480)  # copy from screen device to file device formatted png
dev.off()  # deliver the file device to local directory and close file device