##This script reads Household Power Consuption Data, subsets Jul 1 and Jul 2 
##of 2007, and plots the day/time use vs global active power

##Reading the data from the file and changing date and time classes
full_dataset <- read.table("household_power_consumption.txt", 
                           header = TRUE, sep = ";")
full_dataset$Date <- as.Date(full_dataset$Date , "%d/%m/%Y")
full_dataset$Time <- as.POSIXlt(full_dataset$Time , "%H:%M:%S")

#Subsetting the file for chosen dates
DATE1 <- as.Date("2007-02-01")
DATE2 <- as.Date("2007-02-02")
data_subset <- full_dataset[full_dataset$Date %in% DATE1:DATE2, ]

#Combining date + time into one column using M3 package and converting GPA to numeric
library(M3)
data_subset$DateTime <- combine.date.and.time(data_subset$Date, data_subset$Time)
data_subset$Global_active_power <- 
     as.numeric(paste(data_subset$Global_active_power))

#Graphing the plot and making a png file
plot(data_subset$DateTime, data_subset$Global_active_power, 
     xlab = "",
     ylab = "Global Active Power (kilowatts)", 
     type = "l")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()