## Plot 4 - Grid of four graphs

## Read the delim file, set column types and '?'=NA
filename <- './data/raw/household_power_consumption.txt'
df <- readr::read_delim(
  filename, 
  delim = ";", 
  col_types = c('D', 't', rep('n', 7)), 
  locale = locale(date_format = "%d/%m/%Y"),
  na="?"
)

## subset to just the dates required
df <- subset(df, Date>=lubridate::ymd('2007-02-01') & Date<=lubridate::ymd('2007-02-02'))

## free up previously used memory
gc()

## set device to png with 480x480px
png('plot4.png', width = 480, height = 480)

with(df, 
     {
       ## Set graph grid to 2x2
       par(mfrow = c(2, 2), mar = c(4,4,2,2), oma = c(0, 0, 0, 0))
       
       ## Top left - Global Active Power vs Date/Time
       ## B&W line graph, y label only, set to "Global Active Power"
       plot(
         lubridate::as_datetime(paste(Date, Time)), 
         Global_active_power, 
         type='l',
         ylab="Global Active Power",
         xlab=NA,
       )

       ## Top right - Voltage vs Date/Time
       ## B&W line graph, y labelled with "Voltage", x labelled with "datetime"
       plot(
         lubridate::as_datetime(paste(Date, Time)), 
         Voltage, 
         type='l',
         ylab="Voltage",
         xlab="datetime",
       )
       
       ## Bottom left - Energy Sub Metering vs Date/Time
       ## Create required plot
       ## Line graph showing the 3 sub_metering values (1, 2, 3) as separate series
       ## Each plotted against their date/time values on the x-axis
       ## Coloured black, red, blue respectively
       ## Y axis labelled, no x label or title
       ## Legend top right showing coloured lines and column names, no border
       plot(
         lubridate::as_datetime(paste(Date, Time)), 
         Sub_metering_1, 
         type='l',
         ylab="Energy Sub Metering",
         xlab=NA,
       )
       lines(
         lubridate::as_datetime(paste(Date, Time)), 
         Sub_metering_2,
         col="red"
       )
       lines(
         lubridate::as_datetime(paste(Date, Time)), 
         Sub_metering_3,
         col="blue"
       )
       legend(
         "topright", 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col=c("black", "red", "blue"), 
         lty = 1,
         bty = "n"
       )
       
       ## Bottom right - Global Reactive Power vs Date/Time
       ## B&W line graph, y labelled with "Global_reactive_power", x labelled with "datetime"
       plot(
         lubridate::as_datetime(paste(Date, Time)), 
         Global_reactive_power, 
         type='l',
         ylab="Global_reactive_power",
         xlab="datetime",
       )
       
       
     }
)

# close device and write png
dev.off()

