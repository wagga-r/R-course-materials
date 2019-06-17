# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703
# Amended by Thomas Williams.

# Easter (Sunday) - when is it?

# "First Sunday after first full moon after
# equinox (Spring in Northern Hemisphere, and Autumn in southern hemisphere)"
# Therefore, between 21 March and 24 April.

#install.packages("timeDate")
library(timeDate)

Easter(2019)

Easter(2019:2027)
as.Date.timeDate(Easter(2019:2020))   # Output needs to be converted to simple date

doy <- data.frame(dd=dayOfYear(Easter(1500:2019)))

# Plot using numerical date
hist(doy$dd, breaks=c(75:120))

# lattice version
library(lattice)
histogram(doy$dd, breaks=c(75:120))

# ggplot version
ggplot(doy, aes(x=dd)) + geom_histogram(binwidth=1, colour ="white", fill = "black") + theme_bw()

# Plot using actual date
lst <- as.Date.timeDate(Easter(1500:2019))
str(lst)

# Need just day-month (not year!)
lst2 <- format(lst, "%m-%d")
head(lst2)

lst3 <- paste0("1999-",lst2)   # Pretend all are in same non-leap year
lst4 <- as.Date(lst3)

head(lst4)

hist(lst4, breaks="days", freq=TRUE)


#---- Rotate the tick labels -----
lab <- format(lst4, format="%d-%B")
head(lab)

hist(lst4, xaxt="n", xlab="", breaks="days", freq=TRUE,
     main="Frequency of date of Easter Sunday\n1500 - 2019")

axis(1, at=lst4, labels=FALSE, tick=FALSE)
axis(2, cex=0.8, labels=TRUE)
text(x=lst4, y=-2, labels=lab, srt=90, pos=1, cex=0.7, xpd=TRUE)


#----- Task -----
# Find the dates of Christmas day for the next 5 years.
# Save those dates in a dataframe, and write the dataframe to
# a .csv file on disk (with and without row numbers).


# Ends.
