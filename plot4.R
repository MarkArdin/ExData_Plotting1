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

# Set up the plot4.png file

png(filename = "plot4.png", width = 480, height = 480, units ="px")

par(mfcol= c(2,2)) 

# ==== Add first plot

#      Remove rows with value of ? in Global_active_power

plot_df <- power_df[!(power_df$Global_active_power=="?"),]

#      Convert Global_active power to a numeric value

plot_df$Global_active_power <- as.numeric(plot_df$Global_active_power)

plot(plot_df$Global_active_power~plot_df$Datetime, type="l", 
     ylab="Global Active Power", xlab="")

# ==== Add second plot

#      Remove rows with value of ? in Sub_metering_n

plot_df <- power_df[!(power_df$Sub_metering_1=="?"),]
plot_df <-  plot_df[!(plot_df$Sub_metering_2=="?"),]
plot_df <-  plot_df[!(plot_df$Sub_metering_3=="?"),]

# Convert Sub_metering_n power to numeric values

plot_df$Sub_metering_1 <- as.numeric(plot_df$Sub_metering_1)
plot_df$Sub_metering_2 <- as.numeric(plot_df$Sub_metering_2)
plot_df$Sub_metering_3 <- as.numeric(plot_df$Sub_metering_3)

plot(plot_df$Sub_metering_1~plot_df$Datetime,ylab="Engery sub metering",xlab="",type ="n")
lines(plot_df$Sub_metering_1~plot_df$Datetime)
lines(plot_df$Sub_metering_2~plot_df$Datetime,col="Red")
lines(plot_df$Sub_metering_3~plot_df$Datetime,col="Blue")

legend("topright", col=c("Black", "Red", "Blue"), lty=1,  
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# ==== Add third plot

#      Remove rows with value of ? in Sub_metering_n

plot_df <- power_df[!(power_df$Voltage=="?"),]

#      Convert Voltage to numeric values

plot_df$Voltage <- as.numeric(plot_df$Voltage)

plot(plot_df$Voltage~plot_df$Datetime,ylab="Voltage",xlab="datetime",type="l")

# ==== Add fourth plot

#      Remove rows with value of ? in Global_active_power

plot_df <- power_df[!(power_df$Global_active_power=="?"),]

#      Convert Global_active power to a numeric value

plot_df$Global_active_power <- as.numeric(plot_df$Global_active_power)

plot(plot_df$Global_reactive_power~plot_df$Datetime,ylab="Voltage",xlab="datetime",type="l")

dev.off()