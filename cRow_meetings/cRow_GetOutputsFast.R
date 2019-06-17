# cRow meeting given by Thomas Williams
#----- Fri Jun 14 15:54:42 2019 -----

# exp <- c("DataExplorer","skimr", "table1", "dplyr", "nycflights13")
# install.packages(exp)

library(tidyverse)
library(DataExplorer)
library(skimr)
library(table1)
library(nycflights13)

#----- Visualising Data Fast -----

??`Introduction to DataExplorer`

# There are five data sets in this package. Let's turn into a list and visualise.

data_list <- list(airlines, airports, flights, planes, weather)
plot_str(data_list)

# Now let's merge all the tables together for a more robust dataset for DataExplorer

merge_airlines <- merge(flights, airlines, by = "carrier", all.x = TRUE)
merge_planes <- merge(merge_airlines, planes, by = "tailnum", all.x = TRUE, suffixes = c("_flights", "_planes"))
merge_airports_origin <- merge(merge_planes, airports, by.x = "origin", by.y = "faa", all.x = TRUE, suffixes = c("_carrier", "_origin"))
final_data <- merge(merge_airports_origin, airports, by.x = "dest", by.y = "faa", all.x = TRUE, suffixes = c("_origin", "_dest"))

dim(final_data)

# And now to explore.

glimpse(final_data) # similar to str(). very boring. using brains is overrated.

#----- On to the easy stuff -----

introduce(final_data)

plot_intro(final_data) #low complete obs, relatively high missing obs, concern?
plot_missing(final_data) #Speed is missing in most cases
profile_missing(final_data) # Want a table of missing values?

#----- But we don't reeeeally care about the missing values, what does our data look like? ------

plot_bar(final_data) # Note the warning message

#----- Value of Discrete variables with one unique value? -----
# Upon closer inspection of manufacturer variable, it is not hard to identify the following duplications:
#
#     AIRBUS and AIRBUS INDUSTRIE
#     CANADAIR and CANADAIR LTD
#     MCDONNELL DOUGLAS, MCDONNELL DOUGLAS AIRCRAFT CO and MCDONNELL DOUGLAS CORPORATION

#----- Fix columns ------
final_data[which(final_data$manufacturer == "AIRBUS INDUSTRIE"),]$manufacturer <- "AIRBUS"
final_data[which(final_data$manufacturer == "CANADAIR LTD"),]$manufacturer <- "CANADAIR"
final_data[which(final_data$manufacturer %in% c("MCDONNELL DOUGLAS AIRCRAFT CO", "MCDONNELL DOUGLAS CORPORATION")),]$manufacturer <- "MCDONNELL DOUGLAS"
final_data <- drop_columns(final_data, c("dst_origin", "tzone_origin"))

#----- Inspect by just specifying one column -----

plot_bar(final_data$manufacturer)

#----- Bivariate frequency distribution -----
plot_bar(final_data)
hist(final_data$arr_delay)
plot_bar(final_data, with = "arr_delay")

#----- Histograms! -----

plot_histogram(final_data)
#Immediately, you could observe that there are datetime features to be further treated,
#e.g., concatenating year, month and day to form date, and/or adding hour and minute to form datetime.

# We can also see flight is class numeric (should be categorical)
final_data <- update_columns(final_data, "flight", as.factor)

# only one value in some columns.
final_data <- drop_columns(final_data, c("year_flights", "tz_origin"))

#----- Moving further down the exlporation road -----

# QQ PLots

qq_data <- final_data[, c("arr_delay", "air_time", "distance", "seats")] # grab some variabes to explore

plot_qq(qq_data, sampled_rows = 1000L) #selecting 1000L speeds up the process. Stops from bricking my PC

# Correlation Plots

plot_correlation(na.omit(final_data), maxcat = 5L)
plot_correlation(na.omit(final_data), type = "c")
plot_correlation(na.omit(final_data), maxcat = 5L, type = "d")

# Box Plots

# Reduce data size for demo purpose
arr_delay_df <- final_data[, c("arr_delay", "month", "day", "hour", "minute", "dep_delay", "distance", "year_planes", "seats")]

# Call boxplot function
plot_boxplot(arr_delay_df, by = "arr_delay")

# Scatter plots

arr_delay_df2 <- final_data[, c("arr_delay", "dep_time", "dep_delay", "arr_time", "air_time", "distance", "year_planes", "seats")]

plot_scatterplot(arr_delay_df2, by = "arr_delay", sampled_rows = 1000L)


#----- Do I have to do all this everytime? -----
# NO!

# lets make the dataframe smaller simply for speed
subset_data <- final_data[sample(nrow(final_data), 1000), ]

create_report(subset_data) # Breaks on this data set. It big and Principal component analysis breaks


#----- Create a template for regular exploration -----
config <- configure_report(
  add_plot_qq = FALSE,
  add_plot_prcomp = FALSE, # Drop principal components analysis
  add_plot_boxplot = TRUE,
  add_plot_scatterplot = TRUE,
  add_plot_correlation = FALSE,
  global_ggtheme = quote(theme_classic(base_size = 14))
)
create_report(subset_data, config = config)

# remember {janitor} package is very useful to clean-up data
library(janitor)
??janitor

#----- Producing Summary Tables Fast -----
# The {table1} package

dat <- expand.grid(id=1:10, sex=c("Male", "Female"), treat=c("Treated", "Placebo"))
dat$age <- runif(nrow(dat), 10, 50)
dat$age[3] <- NA  # Add a missing value
dat$wt <- exp(rnorm(nrow(dat), log(70), 0.2))


label(dat$sex) <- "Sex"
label(dat$age) <- "Age"
label(dat$treat) <- "Treatment Group"
label(dat$wt) <- "Weight"

units(dat$age) <- "years"
units(dat$wt) <- "kg"

dat$dose <- sample(c("5 mg", "10 mg"), nrow(dat), replace=TRUE)
dat$dose <- factor(dat$dose, levels=c("Placebo", "5 mg", "10 mg"))

create_report(dat)

# One level of stratification
table1(~ sex + age + wt | treat, data=dat)

# Two levels of stratification (nesting)
table1(~ age + wt | treat*sex, data=dat)

# Switch the order or nesting
table1(~ age + wt | sex*treat, data=dat)

# No stratification
table1(~ treat + sex + age + wt, data=dat)

# Ends.
