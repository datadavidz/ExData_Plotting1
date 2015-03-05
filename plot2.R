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
png(filename = "plot2.png", width = 480, height=480)

# Plot histogram of Global Active Power
with(feb_power, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# Close png file
dev.off()

# Remove the large dataset from memory
rm("all_power")