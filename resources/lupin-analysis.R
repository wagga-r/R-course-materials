# Read my own data

library(readxl)

lupin.df <- read_excel("Lupin-expt-2011.xlsx", sheet="Data",
                na="NA", skip=7, col_names=TRUE)

lupin.df
summary(lupin.df)
