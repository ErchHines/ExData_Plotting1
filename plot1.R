url       <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "power.zip")
unzip("power.zip")

power <- read.table(
    "household_power_consumption.txt", header = TRUE, sep = ";"
)

power[power == "?"] <- NA

power$Date <- as.character(power$Date)
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

power <- subset(
    power, 
    power$Date >= as.Date("2007-02-01") & 
    power$Date <= as.Date("2007-02-02")
)

power$Global_active_power <-  as.numeric(
    as.character(power$Global_active_power)
)

png(file = "plot1.png", width = 480, height = 480, units = "px")
    hist(power$Global_active_power,
        col = "red",
        main = "Global Active Power",
        xlab = "Global Active Power (kilowatts)"
    )
dev.off()
