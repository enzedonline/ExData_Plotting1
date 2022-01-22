## Plot 2 - Global Active Power vs Date/Time

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
png('plot2.png', width = 480, height = 480)

## Create required plot
## B&W line graph of time vs global active power, y label set, no x label or title
with(df, 
     plot(
       lubridate::as_datetime(paste(Date, Time)), 
       Global_active_power, 
       type='l',
       ylab="Global Active Power (kilowatts)",
       xlab=NA,
       )
)

# close device and write png
dev.off()
