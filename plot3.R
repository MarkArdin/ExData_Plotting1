workdir <- "C:/Users/mardin/Desktop/Coursera" ; setwd(workdir)

datadir <- "C:/Users/mardin/Desktop/Coursera/Data"

inputfile = paste (datadir, "/", "household_power_consumption.txt", sep="")

# Read the power file removing factors
power_df <- read.csv(inputfile, sep=";", header=TRUE, stringsAsFactors=FALSE)

# Convert Date to a Date and filter out records with dates "2007-02-01" and "2007-02-02"

power_df$Date <- as.Date(power_df$Date, "%d/%m/%Y")
power_df <- power_df[(power_df$Date >= "2007-02-01" & power_df$Date <= "2007-02-02"), ]

# Remove rows with value of ? in Sub_metering_n

power_df <- power_df[!(power_df$Sub_metering_1=="?"),]
power_df <- power_df[!(power_df$Sub_metering_2=="?"),]
power_df <- power_df[!(power_df$Sub_metering_3=="?"),]

# Convert Sub_metering_n power to numeric values

power_df$Sub_metering_1 <- as.numeric(power_df$Sub_metering_1)
power_df$Sub_metering_2 <- as.numeric(power_df$Sub_metering_2)
power_df$Sub_metering_3 <- as.numeric(power_df$Sub_metering_3)

# Set up a new date time column to support identification of days of the week
datetime <- paste(power_df$Date, power_df$Time)
power_df$Datetime <- as.POSIXct(datetime)

# Cleardown any existing mfrow settings

par(mfrow= c(1,1))

# Set up the plot3.png file

png(filename = "plot3.png", width = 480, height = 480, units ="px")

plot(power_df$Sub_metering_1~power_df$Datetime,ylab="Engery sub metering",xlab="",type ="n")
lines(power_df$Sub_metering_1~power_df$Datetime)
lines(power_df$Sub_metering_2~power_df$Datetime,col="Red")
lines(power_df$Sub_metering_3~power_df$Datetime,col="Blue")

legend("topright", col=c("Black", "Red", "Blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()