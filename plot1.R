## Plot 1 - Global Active Power Histogram

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
png('plot1.png', width = 480, height = 480)

## Create required plot
## Histogram: colour red, x label and main title set
with(df, 
     hist(
       Global_active_power, 
       col="red", 
       xlab="Global Active Power (kilowatts)",
       main="Global Active Power"
       )
     )

# close device and write png
dev.off()

