
install.packages("dplyr")
library(dplyr)
install.packages("downloader")
library(downloader)
library(datasets)


if(!file.exists("./Data")){dir.create("./Data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileUrl,destfile = "./Data/power_consumption.zip", mode="wb")
unzip("./Data/power_consumption.zip", exdir = "./Data")
file.remove("./Data/power_consumption.zip")


# 1 Load the data
# read file into R
file <- read.table("./Data/household_power_consumption.txt", 
                     header = TRUE, sep = ";", na.strings = c("?",""))


# convert Date column class from factor to date
file$Date <- as.Date(file$Date, format = "%d/%m/%Y")

# convert Time column class from factor to POSIXlt class (date and time)
# which we can do by pasting the date and time fields together and then
# using strptime():
file$timeTemp <- paste(file$Date, file$Time)
file$Time <- strptime(file$timeTemp, format = "%Y-%m-%d %H:%M:%S")
file <- file[,1:9]
        
# 2 Subset out only the rows with dates 2007-02-01 and 2007-02-02
file.sub <- subset(file, Date >= "2007-02-01" & Date <= "2007-02-02")

# 3 Make plot and save to .png file
png("plot3.png", 480, 480, units = "px")
plot(file.sub$Time,file.sub$Sub_metering_1, xlab = "", ylab = "Energy sub metering", ylim = range(file.sub[c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]), type = "l", col = 1)
lines(file.sub$Time, file.sub$Sub_metering_2, col = 2) 
lines(file.sub$Time, file.sub$Sub_metering_3, col = 4) 
legend("topright", lty = 1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()



