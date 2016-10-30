workdir <- "C:/Users/mardin/Desktop/Coursera" ; setwd(workdir)

datadir <- "C:/Users/mardin/Desktop/Coursera/Data"

inputfile = paste (datadir, "/", "household_power_consumption.txt", sep="")

# Read the power file removing factors
power_df <- read.csv(inputfile, sep=";", header=TRUE, stringsAsFactors=FALSE)

# Convert Date to a Date and filter out records with dates "2007-02-01" and "2007-02-02"

power_df$Date <- as.Date(power_df$Date, "%d/%m/%Y")
power_df <- power_df[(power_df$Date >= "2007-02-01" & power_df$Date <= "2007-02-02"), ]

# Remove rows with value of ? in Global_active_power

power_df <- power_df[!(power_df$Global_active_power=="?"),]

# Convert Global_active power to a numeric value

power_df$Global_active_power <- as.numeric(power_df$Global_active_power)

# Cleardown any existing mfrow settings

par(mfrow= c(1,1))

png(filename = "plot1.png", width = 480, height = 480, units ="px")

hist (power_df$Global_active_power, col = "red", 
      xlab = "Global Active Power (kilowatts)", main="Global Active Power")

dev.off()