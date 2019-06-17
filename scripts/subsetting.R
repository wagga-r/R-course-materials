# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

#----- Subsetting data -----

# Types of data in R to subset:
# vector      elements
# list        elements (may be nested)

# data.frame  rows or columns, or both
# matrix      rows or columns, or both
# array       rows or columns, or both

# Check help on "Extract or Replace Parts of an Object"
?Extract

#----- Vector subsetting -----
a <- seq(2, 20, by=2)
a
length(a)

a[1:6]
b <- a[1:6]
b

c <- a[c(1:2,5,8:10)]
c

# DROP elements
d <- a[c(-5,-7)]
d

e <- a[-c(5,7)]
e

# make a value missing
a[6] <- NA
a

# subset on condition
f <- a[a>15]
f

f.1 <- a[a>15 & !is.na(a)]
f.1

g <- a[a==4]
g

# Character strings are quoted
h <- c("red", "red", "red", "blue", "green", "green", "pink")
h
h[h=="red"]

my.colours <- c("blue", "green")
h[h==my.colours]
h[h %in% my.colours]
which(h %in% my.colours)

# Lookup-and-replace e.g. replace one text string with another
gender <- c("m", "f", NA, "f", "f", "m", "m")
gender

longnames <- c("m" = "Male", "f" = "Female")
longnames[gender]

which(gender=="m")
which(longnames[gender]=="Female")

# Indirect subsetting
mean(a)
a
mean(a, na.rm=TRUE)

#----- Dataframe subsetting ------

data(iris)
names(iris)[1:4] <- abbreviate(names(iris)[1:4])
head(iris)
dim(iris)

iris$Species  # The '$' character subsets to only one column of a dataframe

# dataframe default subset is COLUMNS
iris[2:3]
iris["Sp.L"]  # Using specific column names is more conservative programming

# order for 2D is [ROWS, COLUMNS]
# Beware the danger of the stray comma
dc <- iris[iris$Species=="setosa"]
dc <- iris[iris$Species=="setosa",]
dim(dc)

dd <- iris[iris$Sp.W<3,]
head(dd)
dim(dd)

# Can use indexes for both directions
iris[123:127,]
iris[c(142, 148, 152),]

iris[c(130:133), c(2,5)]

#---- dplyr subsetting ------
# dplyr handles index subsetting with filter() and select()
iris %>% filter(c(20:25)) %>% select(c(2:3))   # Error

iris %>% filter(row_number() %in% c(20:25)) %>% select(c(2:3))
# In this process we 'lost' the original row number
# To avoid this, first save row number to an actual dataframe column

iris %>%
  mutate(index = row_number()) %>%
  select(6,5,1,2,3,4) %>%           # Put columns in different order
  filter(index %in% c(20:25)) %>%
  select(c(1:3))


#----- List subsetting -----
# Lots of R output is contained in "lists"
# e.g. ANOVA, asreml, regression, PCA, etc.

oats <- read.table(file="Dummy_data.prn", header=TRUE)

oats
dim(oats)
str(oats)

my.aov <- aov(Length ~ Colour, data=oats)

my.aov
summary(my.aov)
str(my.aov)

# Contents of the list
names(my.aov)

my.aov$fitted.values
my.aov$residuals
my.aov$df.residual

plot(my.aov$residuals, my.aov$fitted.values)
plot(residuals(my.aov), fitted(my.aov))

plot(my.aov)

#----- Access elements of list directly -----
# Double square brackets [[...]] simplifies the output class, whereas [...] does not.

# Can access elements by index (position in list) or name
my.aov[[1]]
my.aov[["coefficients"]]

my.aov[1]
my.aov["coefficients"]

# this object is a nested list
my.aov[[1]][[1]]
my.aov[["coefficients"]][["(Intercept)"]]

# compare the output class
str(my.aov[1])      # Subset is still a list (only smaller)
str(my.aov[[1]])    # Subset has been reduced to a numerical vector (named)

# Your use will depend on what you want to do with the output

#----- The broom package -----
# Tidyverse package 'broom' gives a consistent summary output from list objects
# produced by modelling. Output is converted to a dataframe.
library(broom)
help(broom)

tidy(my.aov)
glance(my.aov)  # Very useful when you are running many models and want to compare them.

my.lm <- lm(Height ~ Length, data=oats)
tidy(my.lm)
glance(my.lm)

#----- Task -----
# TASK:
# Conduct an aov() or lm() on either your data or the iris dataset, save the output,
# look at it with broom::tidy and broom::glance, and plot the diagostic graphs.
# Don't worry at this stage whether or not such an analysis is sensible or
# necessary - its just an exercise.


#----- Extension task -----
# Download, install, and load the 'lme4' package for mixed effects models.
# Run one of examples (e.g. using glmer()), save the output, and look at that
# output with broom.



#----- Random sample subsetting
# Take a random sample subset from an object
#
a <- seq(from=1, to=20, by=2)
a
sample(a, 5)
sample(a, 5, replace=TRUE)


#----- Using logicals to do subsetting -----
# Logical operations to access a subset

# Make some elements of the 'iris' dataframe = NA

iris[c(12,20,30), c(2,3,4)] <- NA

is.na(iris)
!is.na(iris)

is.numeric(iris)
is.numeric(iris$Species)
is.numeric(iris$Sp.L)

# Use 'is.finite()' to test for any of: NA, NaN, Inf, -Inf

#----- Task -----
# TASK: Subset your own dataframe by a random number of rows and columns, & assign to a new name.
# Look at your neighbour's code. Can you describe in words what they have done?


# Ends.
