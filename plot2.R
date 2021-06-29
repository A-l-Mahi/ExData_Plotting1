library(dplyr)
library(lubridate)

fileUrl <- "data/household_power_consumption.txt"
Data <- read.csv(fileUrl, sep = ";", na.strings = "?",
                 colClasses = c("factor", "factor", "numeric", "numeric", "numeric",
                                "numeric","numeric","numeric","numeric"))

Data <- Data %>% mutate(Date = dmy(Date))
requiredData <- Data[Data$Date == "2007-02-01" | Data$Date == "2007-02-02",]

with(requiredData, plot(Time, Global_active_power))

dev.copy(png, "plot2.png")
dev.off()
