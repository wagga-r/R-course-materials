# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Manipulating text strings in R

# There are many functions to work with strings, including "regular expressions" (regex)

# However, we will use the stringr package (not to be confused with 'stringi')

#install.packages("stringr")
library(stringr)
help(stringr)

#----- Read in some dummy data -----

xx <- "
Person,       Age,        Address
Jane Smith,    32,        21 Murray Street
David Brown,   45,        14 High Street
Mary Peters,   62,        98 Baylis Street
Rory Jones,    30,        66 Winston Avenue
Dan Sultan,    77,        19 West Parade"

# This prevents text being converted to factors--------------------|
xx.df <- read.delim(textConnection(xx), sep=",", header=TRUE, stringsAsFactors=FALSE)

xx.df
str(xx.df)
names(xx.df)

#----- Convert the CASE of the string -----
str_to_upper(xx.df$Person)

#----- Search & Replace in strings -----
str_replace(xx.df$Address, "Street", "Road")

(xx.df$Address <- str_replace(xx.df$Address, "Street", "Road"))
# Enclose whole line with (.......) = evaluate & print
xx.df


#----- Concatenate strings -----
str_c(xx.df$Person, xx.df$Age, sep="--")  # In base R this is done with paste() and paste0().

xx.df$New <- str_c(xx.df$Person, xx.df$Age, sep="--")
xx.df

#----- How long is each string? -----
str_length(xx.df$Address)

# This looks wrong. So, trim any whitespace around the string before getting length
str_length(str_trim(xx.df$Address))

#----- Split a string into components -----
# This mimics the "text-to-columns" function in Excel
# Extract the first-name and second-name of each person

str_split_fixed(xx.df$Person, " ", n=2)

(xx.df$FirstName <- str_split_fixed(xx.df$Person, " ", n=2)[,1])  # Take first column of result
(xx.df$SecondName <- str_split_fixed(xx.df$Person, " ", n=2)[,2]) # Second column

xx.df

#----- Locate the position of a string (in a string) -----
# e.g. What position is the letter 's'?
str_locate(xx.df$Address, "s")
str_locate(xx.df$Person, "S")

str_locate_all(xx.df$SecondName, "e")

#----- Task -----
# TASK: In your data, make a new column by concatenating together two other columns.
# You may need to turn some columns into type 'character' before you can achieve this.


#----- Extension task -----
# Using the stringr::sentences inbuilt dataset, take the first five strings, extract
# each word separately, make each word uppercase, paste a unique index number to the end
# of each word, and then replace every occurrence of the letter 'E' with 'x'.


# Ends.
