plot2 <- function() {
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
  png(file = "Plot2.png")
  # create plot
  plot(target$DT,target$Global_active_power,pch = NA, lty = 1, ylab = "Global Active Power", xlab = "")
  lines(target$DT,target$Global_active_power)
  dev.off()  
}