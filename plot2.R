# plot 2: 
        # main title: no main title
        # x axis: two days day of week values (Thursday through Friday) with no axis label
        # y axis: 'Global Active Power (kilowatts)' axis label
        # color: black

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

# convert date variable and combine date and time into time variable and assign the two days of subset data to time variable
pow_cons_sub$Date <- as.Date(pow_cons_sub$Date, format="%d/%m/%Y")  # convert date variable values to class Date
pow_cons_sub$Time <- strptime(pow_cons_sub$Time, format="%H:%M:%S")  # convert time variable values to class Time
pow_cons_sub[1:1440,"Time"] <- format(pow_cons_sub[1:1440,"Time"],"2007-02-01 %H:%M:%S")  # subset all measured times for date 2007-02-01
pow_cons_sub[1441:2880,"Time"] <- format(pow_cons_sub[1441:2880,"Time"],"2007-02-02 %H:%M:%S")  # subset all measured times for date 2007-02-02
# head(pow_cons_sub)

# create plot graphic
plot(pow_cons_sub$Time,as.numeric(pow_cons_sub$Global_active_power),xlab="",ylab="Global Active Power (kilowatts)",type="l")  # create plot
dev.copy(png,file='plot2.png',width=480,height=480)  # copy from screen device to file device formatted png
dev.off()  # deliver the file device to local directory and close file device