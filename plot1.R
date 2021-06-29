library(dplyr)
library(lubridate)

fileUrl <- "data/household_power_consumption.txt"
Data <- read.csv(fileUrl, sep = ";", na.strings = "?",
     colClasses = c("factor", "factor", "numeric", "numeric", "numeric",
     "numeric","numeric","numeric","numeric"))

Data <- Data %>% mutate(Date = dmy(Date))
requiredData <- Data[Data$Date == "2007-02-01" | Data$Date == "2007-02-02",]

hist(Data$Global_active_power,xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red")

dev.copy(png, file = "plot1.png")
dev.off()