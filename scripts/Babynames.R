# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Baby names
# USA data from 1880 to 2017
# Only includes names used >= 5 times in that period

#----- Install & load packages -----
install.packages("tidyverse")

# Bring into memory
library(tidyverse)

install.packages("babynames")
library(babynames)

#----- Examine the data -----
help(babynames)
head(babynames)
tail(babynames)

# 1.9 million rows in the dataframe
dim(babynames)

# 97,000 different names are present
length(unique(babynames$name))

# 348 million births are recorded (under-estimate of all births - why?)
sum(babynames$n)

#----- Draw some graphs -----
yourname <- "Alex"

babynames %>%
  dplyr::filter(name==yourname) %>%
  ggplot(aes(x=year, y=n, color=sex)) +
  geom_line(size=1) +
  ggtitle(yourname)


babynames %>%
  dplyr::filter(name==yourname) %>%
  ggplot(aes(x=year, y=prop, color=sex)) +
  geom_line(size=1) +
  ggtitle(yourname)

# Try some celebrity names:
# Kylie
# Clint
# Nicole

# Try some unisex names:
# Lesley
# Jordan
# Jackie
# Hilary or Hillary
# Sasha



#----------------------------------------------------------
# TASK: with your neighbour discuss the following: how could you use this
# dataset to find out what was the most likely name of your best friend
# in school (assuming you went to school in the USA)?


#----------------------------------------------------------
# R is a simple calculator (BUT a powerful one)

# Use the '+' symbol to add numbers together
5 + 2
2345 + 0.1134
5 + 2 + 10

# Use the '-' symbol to subtract numbers
12-3
456-17.8645

# Use the '*' symbol to multiply numbers
13*3
867.72*145.99

# Use the '^' symbol to raise a number to a power
2^2
3.45^3.78

# R knows about mathematics and trignometry
log10(100)
log(100)
exp(1)

sin(1)   # In radians, not degrees
cos(1)
tan(1)

asin(sin(1))

# R knows about pi
pi
pi*3^2
2*pi*3

# R also has some other built-in constants
letters
LETTERS
LETTERS[1:5]

month.name
month.abb

# We will be learning much more about dates and times later.

#----- Solution -----

yourbirthyear <- 1957

babynames %>%
  dplyr::filter(year==yourbirthyear & sex=="M") %>%
  arrange(desc(n)) %>%
  head(., n=5)

babynames %>%
  dplyr::filter(year==yourbirthyear & sex=="F") %>%
  arrange(desc(n)) %>%
  head(., n=5)

#----- Sex ratio at birth -----

babynames %>%
  group_by(year, sex) %>%
  summarise(g_acc_n = sum(n),
            g_acc_prop = sum(prop)) %>%
  mutate(g_tot =
           g_acc_n / g_acc_prop) %>%
  ungroup() %>%
  ggplot(aes(x = year, y = g_tot, color = sex)) +
  geom_line(size = 1) +
  geom_vline(xintercept=1937)

# Seems that that many people born before 1937 never applied for a Social Security
# card, so their names are not included in the data. More women signed up for
# Social Security when it was opt in rather than compulsory.

# Ends.
