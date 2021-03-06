workdir <- "C:/Users/mardin/Desktop/Coursera" ; setwd(workdir)

datadir <- "C:/Users/mardin/Desktop/Coursera/Data"

inputfile = paste (datadir, "/", "household_power_consumption.txt", sep="")

# Read the power file removing factors
power_df <- read.csv(inputfile, sep=";", header=TRUE, stringsAsFactors=FALSE)

# Convert Date to a Date and filter out records with dates "2007-02-01" and "2007-02-02"

power_df$Date <- as.Date(power_df$Date, "%d/%m/%Y")
power_df <- power_df[(power_df$Date >= "2007-02-01" & power_df$Date <= "2007-02-02"), ]

# Set up a new date time column to support identification of days of the week
datetime <- paste(power_df$Date, power_df$Time)
power_df$Datetime <- as.POSIXct(datetime)

# Remove rows with value of ? in Global_active_power

power_df <- power_df[!(power_df$Global_active_power=="?"),]

# Convert Global_active power to a numeric value

power_df$Global_active_power <- as.numeric(power_df$Global_active_power)

# Cleardown any existing mfrow settings

par(mfrow= c(1,1))

# Set up the plot2.png file

png(filename = "plot2.png", width = 480, height = 480, units ="px")

plot(power_df$Global_active_power~power_df$Datetime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")

dev.off()
