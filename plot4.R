library(dplyr)
library(lubridate)
##setting path
fileUrl <- "data/household_power_consumption.txt"
if(!file.exists(file = "data/household_power_consumption.txt")){
    download.file(fileUrl, destfile = "Data.zip")
    unzip("Data.zip")
}

##loading Data
Data <- read.csv(fileUrl, sep = ";", na.strings = "?",
                 colClasses = c("factor", "factor", "numeric", "numeric", "numeric",
                                "numeric","numeric","numeric","numeric"))

##formatting Date variable to date
Data <- Data %>% mutate(Date = dmy(Date))

##loading required Data
requiredData <- Data[Data$Date == "2007-02-01" | Data$Date == "2007-02-02",]

par(mfrow = c(2,2))

##plot Time against Global Active Power
with(requiredData, plot(Time, Global_active_power, ylab = "Global Active Power"))

##plot Time against Voltage
with(requiredData, plot(Time, Voltage, xlab = "Datetime", ylab = "Voltage", pch ="|"))

##plot Time against sub_metering_1, sub_metering_2, sub_metering_3, sub_metering_4
with(requiredData, plot(Time, Sub_metering_1, col ="red"))
with(requiredData, points(Time, Sub_metering_2, col = "red" , pch = "|"))
with(requiredData, points(Time, Sub_metering_3, col = "blue" , pch = "|"))

#add legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       cex =0.2,
       bty = "n"              
)

title(ylab = "Energy Sub metering")

##plot Time aginst Global Reactive Power
with(requiredData, plot(Time, Global_reactive_power, xlab = "Datetime"))

dev.copy(png, file = "plot4.png")
dev.off()
