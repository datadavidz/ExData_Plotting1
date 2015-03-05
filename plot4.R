library(dplyr)

setwd("c:/Users/David/Documents/GitHub/ExData_Plotting1")

#Location of raw data
filename <- "c:/Users/David/Documents/R/household_power_consumption.txt"

# Specify colClasses for read.table
colclasses = c(rep("character",2), rep("numeric",7))

# Load the power consumption datafile
all_power <- read.table(filename, sep=";", colClasses = colclasses, header=TRUE, na.strings="?")

#Convert dates to Date format
all_power$Date <- as.Date(all_power$Date, "%d/%m/%Y")

#Filter to only Feb 1 2007 through Feb 2 2007
feb_power <- filter(all_power, Date >= "2007-02-01" & Date <= "2007-02-02")

#Convert times to POSIXlt format
feb_power <- mutate(feb_power, DateTime = paste(Date, Time, sep = " "))
feb_power$DateTime <- strptime(feb_power$DateTime, "%Y-%m-%d %H:%M:%S")

# Open png device
png(filename = "plot4.png", width = 480, height=480, pointsize=11)

# Set device to capture 4 plots
par(mfcol=c(2,2), mar= c(4,4,2,2))

# Plot top left Global Active Power vs. Day/Time
with(feb_power, plot(DateTime, Global_active_power, type = "l", xlab = "", 
                     ylab = "Global Active Power"))

# Plot bottom left submetering stations vs. Day/Time
# Plot lines for each submetering station
with(feb_power, plot(DateTime, Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
with(feb_power, lines(DateTime, Sub_metering_2, col="red"))
with(feb_power, lines(DateTime, Sub_metering_3, col="blue"))

# Add a legend
legend("topright", lty=c(1,1,1), bty = "n", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Plot top right Voltage vs. Day/Time
with(feb_power, plot(DateTime, Voltage, type = "l", xlab = "datetime", 
                     ylab = "Voltage"))

#Plot bottom right Global Reactive Power vs. Day/Time
with(feb_power, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))
#with(feb_power, lines(DateTime, Global_reactive_power))

# Close the png file
dev.off()

# Remove the large dataset from memory
rm("all_power")