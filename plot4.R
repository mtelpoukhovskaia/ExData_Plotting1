##This script reads Household Power Consuption Data, subsets Jul 1 and Jul 2 
##of 2007, and plots 4 plots in one Figure

##Reading the data from the file and changing date and time classes
full_dataset <- read.table("household_power_consumption.txt", 
                           header = TRUE, sep = ";")
full_dataset$Date <- as.Date(full_dataset$Date , "%d/%m/%Y")
full_dataset$Time <- as.POSIXlt(full_dataset$Time , "%H:%M:%S")

#Subsetting the file for chosen dates
DATE1 <- as.Date("2007-02-01")
DATE2 <- as.Date("2007-02-02")
data_subset <- full_dataset[full_dataset$Date %in% DATE1:DATE2, ]

#Combining date + time into one column using M3 package
library(M3)
data_subset$DateTime <- combine.date.and.time(data_subset$Date, data_subset$Time)

#Converting from factor to numeric
data_subset$Global_active_power <- 
     as.numeric(paste(data_subset$Global_active_power))
data_subset$Global_reactive_power <- 
     as.numeric(paste(data_subset$Global_reactive_power))
data_subset$Voltage <- 
     as.numeric(paste(data_subset$Voltage))
data_subset$Sub_metering_1 <- as.numeric(paste(data_subset$Sub_metering_1))
data_subset$Sub_metering_2 <- as.numeric(paste(data_subset$Sub_metering_2))
data_subset$Sub_metering_3 <- as.numeric(paste(data_subset$Sub_metering_3))

#Graphing the plot and making a png file

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

     plot(data_subset$DateTime, data_subset$Global_active_power, 
          xlab = "",
          ylab = "Global Active Power", 
          type = "l")
    
      plot(data_subset$DateTime, data_subset$Voltage,
          xlab = "datetime",
          ylab = "Voltage", 
          type = "l")
     
      with(data_subset, plot(DateTime,Sub_metering_1, 
                            main = "", 
                            type = "n", 
                            xlab = "", 
                            ylab = "Energy sub metering"))
     with(data_subset, lines(DateTime, Sub_metering_1, col = "black"))
     with(data_subset, lines(DateTime, Sub_metering_2, col = "red"))
     with(data_subset, lines(DateTime, Sub_metering_3, col = "blue"))
     legend("topright", 
            pch = "-", 
            col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     
     plot(data_subset$DateTime, data_subset$Global_reactive_power, 
          xlab = "datetime",
          ylab = "Global_reactive_power", 
          type = "l")

dev.off()