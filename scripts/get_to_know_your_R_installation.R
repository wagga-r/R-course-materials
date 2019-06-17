# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Get to know your R installation. This aids trouble-shooting and debugging.

# Installation information, and list of loaded packages
sessionInfo()

# Re-define that long-winded function name
si() <- sessionInfo()
si()

R.Version()

# Location-specific and language-specific settings
readr::locale()

# What time does my computer think it is?
Sys.Date()
Sys.time()
Sys.timezone()

# What are the default directories?
R.home()   # 8.3 DOS filename format!

# Where are the other directories used by R?
Sys.getenv(c("R_HOME","R_USER","TEMP","TMP"))

# What do the startup files contain (if anything)?
help("Startup")
readLines("~/.Renviron")
readLines("~/.Rprofile")

#-----
# Where are my installed packages kept?
.libPaths()

installed.packages()  # Lots of info

my_pkgs <- data.frame(installed.packages())
str(my_pkgs)

my_pkgs %>%
  select(Package, Version, Built, LibPath, License) -> my_pkgs2

head(my_pkgs2, n=20)

#-----
# What options are set in R?
help(options)

options()
opts <- options()
length(opts)

names(opts)


# Change an option
pi
options(digits=6)
pi

options(dplyr.print_max=500, max.print=2000)

data(diamonds)
diamonds$carat

# Check one option
getOption("digits")

#-----
# Updating R and all its packages and other helper software can be tedious.
# The installr package can be very useful.

install.packages("installr")
library(installr)

help(installr)

check.for.updates.R()

#updateR()
#updateR(fast=TRUE)

# Ends.
