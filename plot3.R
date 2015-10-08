plot3 <- function() {
  # check if file already loaded, if not downloand and unzip
  if (!file.exists("household_power_consumption.txt")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL,"data.zip")
    unzip("data.zip")    
  }
  # read in data
  hpc <- read.csv("household_power_consumption.txt",sep=";",header = TRUE,na.strings = "?", stringsAsFactors = FALSE)
  # select dates requested
  target <- hpc[hpc$Date == "1/2/2007"|hpc$Date == "2/2/2007",]
  #next lines merge date and time columns to form strpdate formated date & time
  target$Date <- as.Date(target$Date, "%d/%m/%Y")
  target$DT <- paste(target$Date,target$Time)
  target$DT <- strptime(target$DT,format = "%Y-%m-%d %H:%M:%S") 
  #open png graphics device
  png(file = "Plot3.png")
  # build required plot
  plot(target$DT,target$Sub_metering_1,pch = NA, lty = 1, ylab = "Energy sub metering", xlab = "")
  lines(target$DT,target$Sub_metering_1)
  lines(target$DT,target$Sub_metering_2, col = "red")
  lines(target$DT,target$Sub_metering_3, col = "blue")
  legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
  #close graphics device
  dev.off()
}