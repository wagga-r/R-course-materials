# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# What happens to factor level labels when imported from a file?

# Remember: a factor is a vector with a limited number of possible levels (usually categories).
# The levels will be held internally as numbers by R but can have character labels.

# Character levels in alphabetical order
factor(c("aa","cc","dd","bb"))

# Stored internally as integers
str(factor(c("aa","bb","cc","dd")))

# Numeric levels in numeric order
factor(c(1,1,4,4,3,3,3,2,2,5,5,5))

# Over-ride the labels
factor(c("aa","aa","bb","cc","dd","dd"), labels=c("First","Second","Third","Last"))


#----- From Excel-----
library(readxl)

fl.df <- read_excel(path="Dummy_data.xlsx",
                     sheet=c("Factor_levels"),
  									 col_names=TRUE)
fl.df
str(fl.df)

# R usually imports "strings as factors"
# But readxl does not.
# In this case, you need to specify them as factors after import:

fl.df$Factor1 <- factor(fl.df$Factor1)
fl.df$Col2 <- factor(fl.df$Col2)
fl.df$replicate <- factor(fl.df$replicate)

str(fl.df)

# What is "wrong" with Factor1?
levels(fl.df$Factor1)

fl.df$Factor1

# Correct the typo in the Excel file and re-import (or do it here in R)
fl.df$Factor1[6] <- "tall"
f1.df$Factor1[f1.df$factor1=="Tall"] <- "tall"


`%nin%` <- Negate(`%in%`)

# This would also have worked
fl.df$Factor1[fl.df$Factor1 == "Tall"] <- "tall"
fl.df$Factor1[fl.df$Factor1 %nin% c("Tall", "tell")] <- "tall"

# Sort the levels sensibly - this is an ordinal vector
fl.df$Factor1 <- factor(fl.df$Factor1, order=TRUE, levels=c("short","medium","tall"))
str(fl.df)

#----- The forcats package -----
# The 'forcats' package has very useful functions for factor manipulation

install.packages("forcats")
library(forcats)
?forcats


#----- Task -----
# TASK: What is 'wrong' with Col2 in the fl.df dataframe? How would you fix it?
# Create any sensible factors in your imported data.
# What are the factor levels in your personal data? Do they need to be ordered?

#----- Extension task -----
# Several columns in the 'mtcars' dataset should be re-coded as factors; which ones?
# Hint: help(mtcars)
# Re-code them using base functions or forcats functions.

data(mtcars)
help(mtcars)
head(mtcars)

mtcars$gear <- factor(mtcars$gear)
mtcars$cyl <- factor(mtcars$cyl)

str(mtcars)


# Ends.
