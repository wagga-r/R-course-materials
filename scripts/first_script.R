# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# This is an R script file - save it and copy/edit as required.

# R contains lots of supplied datasets
data()
data(iris)

#----- What are data frames? -----
# A dataframe is the most common R data structure: a collection of
# columns all the same length.
# Each column can contain data of different 'types' (e.g. character or numeric).
# Look at the data in the 'dataframe'
iris
head(iris)
tail(iris)
View(iris)

# Look at one column of the dataframe only
# There is wrap-around, plus item numbers to guide you
iris$Sepal.Length

# Check the structure of the dataframe
str(iris)
names(iris)
levels(iris$Species)
glimpse(iris)

# A quick summary of a dataframe
summary(iris)

#----- Closing R and Rstudio -----
# Close R session - don't forget to save script file first
q()
quit()

#----- Getting help -----
help(head)
?print
help.search("barchart")
# or, in RStudio code window, highlight any command and hit F1 to get HTML help
# or, in RStudio package list, click on name to get more info.

# fuzzy searching
??printing

# The 'sos' package can help to find new functions in all possible packages
install.packages("sos")
library(sos)
findFn("left_join")

???left_join
????left_join

# Other forms of in-built help
vignette()
vignette("dplyr")

example(date)
example(aov)

# some demonstrations
demo()
demo(graphics)

# functions have arguments which provide additional options
head(iris, n=10)
tail(iris, n=3)

# What is the current working directory?
# Change directory (not often needed if you stick with RStudio projects)
getwd()
help(setwd)

# Get list of files
dir()

#----- Common errors -----
# spelling mistakes
prit(iris)
Print(iris)

# Using an incorrect argument (but they don't always give an error)
length(iris, rows=15)

# Outout can be a bit cryptic
length(iris)
dim(iris)


# Failing to balance () {} [] [[]] "" ''
# RStudio helps by inserting them in pairs.
#
#help(iris")
# when console gets stuck in continuation mode, highlight window and hit ESC

# RStudio editor also auto-indents code to make it more readable.

#----- Everything in R is case-sensitive -----
# foo, Foo, FOO, bar, Bar, BAR  are six different objects

# Easy to mix up certain characters, especially in certain fonts: 1lL|o0O

# R uses " (double quotes) or ' (single quotes) to enclose strings, object names,
# and function arguments. Beware of so-called smart-quotes that are used in Word
# processing files - they are unicode not plain ASCII characters and will cause errors.
# Also, the ` (back-tick) character has specific uses.
help(Quotes)

#----- Object names -----
# Object names are, generally, your choice (unless its a reserved word).
# Its good to have your own system and stick to it.
# Make names short (rather than long) - you will be typing them many times!

# Don't call your dataframe 'data' or your matrix 'matrix'; you wouldn't call your dog 'dog'!

# plot.yield
# plant_height   # 'Snake case'
# bodyWeight     # 'Camel case'
# body-weight    # 'kebab' case   (won't work here)
#
# my.df
# my.data
# my_data
# myreg
# myReg
# myAnova
# my.df
# my.aov
# my.glm
#
## Better still, make your names mean something:
# yield.df
# yield.aov
# yield.lm
#
# height_out
# height_means
# height_females


# No dashes (hyphens) in object names (but OK in character strings)
my-data <- c(1,2,3)    # Basically, gets confused with a minus sign
my.data <- "First-bit-of-text"
my.data

# Underscores are often advocated
string_two <- "Second bit of text"
string_two

#----- Expanding R -----
#
# Download and install an extra package

# I recommend 'readr' for reading text files, and 'readxl' for reading Excel files.
# 'readr' is already bundled & loaded with 'tidyverse'

# Load-up an extra package
# This has to be done for each R session (may be done automatically by a start-up script)
# library(readr)
library(readxl)

# How to cite R in a publication (please do this)
citation()

# How to cite a package you use
citation("dplyr")
citation(package="ggplot2")

#----- Creating data objects -----

# Read data from files or create it on-the-fly

# Create a simple vector of ten numbers
# 'c' stands for 'combine' or 'concatenate'
# Commas separate the elements of the vector
out1 <- c(7,9,12,4,7,2,8,7,8,5)
out1
str(out1)
length(out1)


a <- 2.56789
a

b <- (3,7)
b <- C(3,7)
b <- c(3,7)
b

c <- c(1:120)
c

d <- rep(1:3, each=2, times=4)
d

(e <- seq(from=2, to=40, by=2))   # Print the result immediately

#----- R is vectorised & recycles -----
# Great strength of R over other languages is that it is vectorised.
# In addition, values to operate on are recycled as required.

out1 + 3.5

out1 + c(2,100) # There is no warning if the recycling 'lines-up' correctly

out1 + c(2, 100, 300) # A warning that objects don't line-up neatly.

out1 * c(1:10) # Both objects are the same length, so the calculation is element by element.


#----- Missing Values -----
# Missing values in R are given by the characters 'NA' (with no quotes)
out2 <- c(7.1,9.5,NA,4.2,7.3,2.2,NA,7.9,8.4,5.3,3.6,7.0)
out2
str(out2)
summary(out2)


# The existance of NAs in the data can have major impact.
# Good advice: "Get to know your NAs".
mean(out1)
mean(out2)
mean(out2, na.rm=TRUE)

# More on missing values later.

#----- Functions can be nested -----
# Nesting can make code more compact but sometimes harder to read.
head(out1, n=3)
mean(head(out1, n=3))

# Multiple functions can also be on the same line (but I avoid this).
# Semicolon separates the functions.
out1; out2
out1; head(out2)


#----- Task -----
# TASK: Create a numeric vector of 20 elements. Square each element.
# Multiply each of those elements by pi.
# Get the natural logarithm of each element of your pi.r^2 values.
# Combine those four steps into one line.

log(pi*((1:20)^2))

#----- Extension task -----
# Find out how to calculate the variance of a set of numbers in R (hint: use Google).
# Create a new variable including several missing values.
# Calculate the variance of your new variable.
# Calculate the standard deviation of your new variable.
# Calculate the median of your variable.

varvar(c(1:20, NA, NA, NA), na.rm=TRUE)
sd(c(1:20, NA, NA, NA), na.rm=TRUE)
median(c(1:20, NA, NA, NA), na.rm=TRUE)

# Ends.
