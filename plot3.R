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


power$DateTime <- as.POSIXct(
    paste(power$Date, power$Time),
    format="%Y-%m-%d %H:%M:%S"
)


power$Sub_metering_1 <-  as.numeric(
    as.character(power$Sub_metering_1)
)

power$Sub_metering_2 <-  as.numeric(
    as.character(power$Sub_metering_2)
)

power$Sub_metering_3 <-  as.numeric(
    as.character(power$Sub_metering_3)
)


png(file = "plot3.png", width = 480, height = 480, units = "px")
    plot(power$DateTime, power$Sub_metering_1,
        yaxt = "n",
        ylab = "Energy sub meeting",
        xlab = "",
        type = "l"
    )
    
    axis(2, at = seq(10, 40, by = 10), las=2)
    
    lines(power$DateTime, power$Sub_metering_2,
        col = "red"      
    )
    
    lines(power$DateTime, power$Sub_metering_3,
        col = "blue"      
    )
    
    legend("topright", 
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        col    = c("black", "red", "blue"),
        lty=1
    )
dev.off()
