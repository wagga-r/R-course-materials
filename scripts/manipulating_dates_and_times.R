# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Dates and times in R

date()

# ISO 8601 defines how dates/times should be unambiguously represented.
# Makes life so much easier if you record all dates in this way in Excel, etc.
# See: https://xkcd.com/1179/

# Also, its essential to pad any dates with leading zeros, and give the full year

# 2018-2-4   ----> 2018-02-04
# 2018-10-9  ----> 2018-10-09
# 17-6-28    ----> 2017-06-28

Sys.Date()
Sys.time()
Sys.timezone()
Sys.timezone(location=FALSE)

OlsonNames()  # The timezone names known to R

# Australian time zone names
full_tz <- OlsonNames()
full_tz[grepl("Australia", full_tz)]

# Produce a date/time output string to your liking
format(Sys.time(), "%A-%d-%B-%Y")


## Format codes are:
## %a   Day of week as abbreviated text name (e.g. Sat)
## %A   Day of week in full
## %d   Day of month as number
## %b   Month as abbreviated text name (e.g. Feb)
## %B   Month name in full
## %m   Month of year as 2-digit number (** Do not confuse with minutes)
## %y   Year as abbreviated 2-digit number (e.g. 11)
## %Y   Year as 4-digit number

## %H   Hour of day in 24hr clock format
## %M   Minute of hour (** Do not confuse with months)
## %S   Second of minute

## See help(strptime) for more info

# Some non-standard strings of dates (e.g. from Excel file)
# Absence of leading zeros can be dealt with, but be careful.
txt <- c("1-Nov","2-Oct","23-Jun","30-Apr","03-Mar")
str(txt)

# Converts OK but assumes current year
as.Date(txt, format="%d-%b")

# Append required year, say, 2008
txt2 <- paste(txt, "2008", sep="-")
txt2
as.Date(txt2)

# Needs different format string to parse correctly
date3 <- as.Date(txt2, format=c("%d-%b-%Y"))
date3
str(date3)

#----- What is time? -----
# Instance
# Duration


#----- Reading dates & times -----
# Reading dates/times directly from files can be problammatic - so many formats.

# With 'readxl' or 'readr' dates are often read correctly - but not always!
# Suggest you read them as 'text', then convert.
# e.g. TinyTag datalogger; data saved in Excel-compatible format (csv).

# ,Time,1
# S/N,,359558
# Type,,TGP-4017
# Description,,FROST-2-0
# Property,,Temperature
# 1,2010-07-02 13:30:09,19.463
# 2,2010-07-02 13:31:09,20.004
# 3,2010-07-02 13:32:09,19.909
# 4,2010-07-02 13:33:09,19.827
# 5,2010-07-02 13:34:09,19.754
# 6,2010-07-02 13:35:09,19.741
# 7,2010-07-02 13:36:09,19.862
# 8,2010-07-02 13:37:09,19.768
# 9,2010-07-02 13:38:09,19.706
# 10,2010-07-02 13:39:09,19.659
# 11,2010-07-02 13:40:09,19.626
# 12,2010-07-02 13:41:09,19.602
# 13,2010-07-02 13:42:09,19.583
# 14,2010-07-02 13:43:09,19.567


temps.df <- read_csv(file="temperatures.csv", skip=5, col_names=FALSE)
temps.df
str(temps.df)

#POSIXct == "continuous time" (most convenient for use in files, dataframes, etc.)

# If that same file is read using base::read.csv, a bit more work is required.
temps.df <- read.csv(file="temperatures.csv", skip=5, header=FALSE, stringsAsFactors=FALSE)
temps.df

str(temps.df)

# strptime() - convert between character strings and dates/times
# convert date/time column as text to a date (to the nearest minute)
temps.df$date1 <- strptime(temps.df$V2, format=c("%Y-%m-%d %H:%M"), tz="Australia/Perth")
str(temps.df)

temps.df$date1[1]

plot(x=temps.df$date1, y=temps.df$V3, type="b")
ggplot(data=temps.df, aes(x=date1, y=V3)) + geom_point() + geom_line()

ggplot(data=temps.df, aes(x=as.POSIXct(date1), y=V3)) + geom_point() + geom_line()

# Internally date-time is stored in R as cumulative seconds since 1-Jan-1970
print(as.numeric(temps.df$date1), digits=15)

# 40 years * 365 days * 24 hours * 60 mins * 60 secs
40*365*24*60*60


#----- Calculations with time ------
# Getting time since a certain origin (e.g. days-from-sowing)
# Time intervals
org <- as.Date("2008-01-23")
str(org)

# Can then do date calculations (e.g. DFS = days-from-sowing)
DFS <- date3 - org
DFS

# time intervals - works with other units
origin2 <- c("2010-07-02 00:00")
difftime(temps.df$date1, origin2) # Difference in hours

origin3 <- c("2010-07-01 00:00") # From one day earlier
difftime(temps.df$date1, origin3) # Difference now in days

difftime(temps.df$date1, origin3, units="hours") # Force back to hours

options(digits=10)  # Increase default digits (I usually only use 4).
difftime(temps.df$date1, origin3) # Difference now in days

#----- The powerful 'lubriate' package -----
install.packages("lubridate")
library(lubridate)

help(lubridate)

txt3 <- origin3
is.Date(txt3)

now()
today()

yday(today())
yday(txt3)   # String is automatically converted to date to do calculation
week(txt3)
wday(txt3)

# What day of the week were you born on?
wday("1957-09-13", label=TRUE)
wday("1957-09-13", label=TRUE, abbr=FALSE)



#----- Task -----
# TASK: Work out what day-of-the-week your birthday falls on next year.
# What week-of-the-year does your birthday fall in?

wday("2020-09-13", label=TRUE)
week("2020-09-13")
#----- Extension task -----
# Find out how to get the date of Easter Sunday for next year (2020).
# How many days are there between your birthday and Easter Sunday?


#----- Finer details of dates/times -----
# R knows about leap-years, and changes due to daylight saving.

leap_year(2018)
leap_year(2000)
leap_year(1900)   # Old versions of Excel thought that 1900 was a leap year!

make_datetime(year=2018, month=c(4), day=c(1), hour=c(01:04), tz="Australia/Sydney")

#----
# Generate a regular sequence of dates or times
start_date <- c("2018-03-31")
stop_date <- c("2018-04-19")
seq(from=as.Date(start_date), to=as.Date(stop_date), by=1)

start_time <- c("2012-01-01 10:45")
stop_time <- c("2012-01-01 20:45")

seq(from=as.POSIXlt(start_time),
    to=as.POSIXlt(stop_time),
    by="hour")


# Beware of daylight-saving transition periods!
# This year (2019) daylight-saving time ended at 2:00 AM on April 7.
start2 <- c("2019-04-06 22:00")
stop2 <- c("2019-04-07 12:00")

seq(from=as.POSIXlt(start2),
    to=as.POSIXlt(stop2),
    by="hour")



#-----
# Time series are particular classes of data.
# They are not the same as a relatively small number of 'dates' or 'times' used in designed experiments.
??"time series"
# https://CRAN.R-project.org/view=TimeSeries

#-----
# More detail on R date & time data classes
help("POSIXct")

#-----
# Dates and times can be used as graph axes, and R knows what to do with them.
# We will see eaxmples later.

# Ends.
