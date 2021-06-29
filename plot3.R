library(dplyr)
library(lubridate)

fileUrl <- "data/household_power_consumption.txt"
Data <- read.csv(fileUrl, sep = ";", na.strings = "?",
                 colClasses = c("factor", "factor", "numeric", "numeric", "numeric",
                                "numeric","numeric","numeric","numeric"))

Data <- Data %>% mutate(Date = dmy(Date))
requiredData <- Data[Data$Date == "2007-02-01" | Data$Date == "2007-02-02",]

par(mfrow = c(2,2))

with(requiredData, plot(Time, Sub_metering_1, col ="red"))
with(requiredData, points(Time, Sub_metering_2, col = "red" , pch = "|"))
with(requiredData, points(Time, Sub_metering_3, col = "blue" , pch = "|"))

legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       cex = 0.5
)
title(ylab = "Energy Sub metering")

dev.copy(png, file = "plot3.png")
dev.off()
