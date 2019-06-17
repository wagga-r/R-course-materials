# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# R has many basic functions for manipulating numbers, text, factors, logicals, etc.
# Most of these base functions are now replicated in the dplyr package (part of the "tidyverse").
# You can work in one 'ecosystem', or the other, or use them interchangeably, as I do.

# These data manipulations can also be performed in the data.table package (not covered in this course).

#----- base functions -----
(vec1 <- c(11:20,100:91))

(sort(vec1))
(sort(vec1, decreasing=TRUE))
(sort(vec1, dec=TRUE))
(sort(vec1, TRUE))

(rev(vec1))
(rank(vec1))

(log(vec1))
(log10(vec1))

exp(log(vec1))   # Antilogs

(cumsum(vec1))

#----- dplyr functions -----
# dplyr verbs to do similar things; but dplyr needs a tibble (data_frame) to operate on,
# and produces a tibble as output. This is not a problem as your data will usually be in
# a dataframe to start with

(my.tb <- tibble(vec1))

(arrange(tibble(vec1), vec1))
(arrange(my.tb, desc(vec1)))

my.tb %>% arrange(., vec1)  # Sort within a dplyr pipe
my.tb %>% arrange(vec1)


#----- Some more base functions -----

options(digits=7) # The default

rnorm(n=10)   # Random numbers from a normal distribution with mean=0, sd=1

(vec2 <- rnorm(n=5, mean=10, sd=3))
round(vec2)
round(vec2, digits=3)

ceiling(vec2)
floor(vec2)
signif(vec2, 5)

diff(vec1)

first(vec1)    # dplyr
last(vec1)     # dplyr

# Subsetting
# All R objects are indexed starting at 1 (not at 0 like many other languages).
vec1[1]

length(vec1)
vec1[length(vec1)]

cut(vec1, breaks=c(0,20,50,200))

#----- Scaler functions -----
# Functions that give scaler output (single values)
max(vec1)
min(vec1)

mean(vec2)
median(vec2)
sd(vec2)
var(vec2)

identical(sd(vec2), sqrt(var(vec2)))

range(vec2)


#----- R also does modulo arithmetic -----

5 %% 2  # This says: "is 5 modulo to 2?" or "is 5 an even number?"
# Answer 1 = No

6 %% 2 # 6 is an even, not an odd, number

# Integer arithmetric (gives the integer quotient from a division)
6 %/% 2
5 %/% 2

5.5 %/% 2
5.99999 %/% 2

# Remember that in all electronic systems, floating point arithmetic involves rounding errors
6/2
5.9/2
5.9999999/2


5.9*2
5.999999999*2

# If your data will only consist of integers you can specify them like this:
tt <- c(2L,10L,12L,3L)
tt
class(tt)

# Contrast with
ss <- c(2,10,12,3)
class(ss)


#----- Add new columns to a dataframe -----

# First make some dummy data
set.seed(42)
(df <- data.frame(aa=c(1:10), bb=(rnorm(10)+5), cc=rnorm(10)+120))

# Let's say we wanted to calculate the ratio of column cc/column bb
df$dd <- df$cc/df$bb
df

# Do same thing with dplyr
mutate(df, ee=cc/bb)
transmute(df, ee=cc/bb)
count(df)

# Get scaler answers using dplyr
summarise(df, m1=mean(cc))
df %>% summarise(., m2=mean(cc))

# Can set-out the last dplyr pipe (chain) as follows:
df %>%
  summarise(m2=mean(cc))

# This makes for easy reading. You can also use "right assigment" to save the result.
df %>%
  summarise(m2=mean(cc)) -> my_mean
my_mean


#----- Task -----
# TASK: Calculate a scaler function for any suitable column in
# your personal dataframe using both base R and dplyr.


#----- Extension task -----
# Using the mtcars dataset, calculate new columns which are the logs (in base 10)
# of two of the numeric columns; then calculate the variance of these two new columns.


# Ends.


