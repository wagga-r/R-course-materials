# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Importing data from various file types.

# One of the primary intentions of R's creators was to: "interface with everything".

# R reads Excel spreadsheet files (.xlx, .xlsx) directly but also .csv files.

# If you want to import data from another stats package (e.g. SAS, SPSS, Stata) use
# the 'foreign' or 'haven' packages.
# If you want to import data from a database use the 'RODBC' package.
# R can also read 'Google sheets', Word documents, PDF files, and scrape data from
# web pages.
# R can read fixed-format files, and some binary formats.

# R can directly manipulate files on disk: move, delete, append, overwrite, etc.

#----- Data types in R -----

# vector (integer, numeric, character, factors).
# factors are powerful but usually cause the most hassle!
# dataframe (2D, rows and columns, mixed content).
# enhanced dataframes are either tibbles/data_frames or data.tables.
# lists (mixed content, can be nested lists).
# dates/times
# matrix
# array (multi-dimensional)
# special classes e.g. time series, ANOVA output (a list), regression output (a list)

# dataframes are the most common


#----- Reading your own data -----
#
# Where is the file to be found?
# Should be in your project directory.
# Or, use the 'here' package to define a data subdirectory under your project main directory.

#setwd("C:/Users/lucketd/Dropbox/R stats/cRow/R course CSU April 2019")
#setwd("C:/Users/David/Documents/")
getwd()
# If you have started in an RStudio project then this is done for you!

getwd()
dir()

# There are various options for simple, flat text files.
# There are base R functions plus matching ones from the 'readr' package.
# e.g. read.csv   <<<>>> readr::read_csv
# e.g. write.csv  <<<>>> readr::write_excel_csv
install.packages("readr")
library(readr)
help(readr)    # Need to click on RStudio package list to get help ----->

# COMMA delimited version
csv.df <- read_csv(file="Dummy_data.csv", col_names=TRUE)
csv.df

str(csv.df)
summary(csv.df)

# SPACE delimited version
prn.df <- read_table(file="Dummy_data.prn", col_names=TRUE)
prn.df
str(prn.df)

# TAB delimited version (or any other delimiter e.g. ';')
tab.df <- read_delim(file="Dummy_data.tab", col_names=TRUE, delim="\t")
tab.df


#----- Reading Excel files -----

# Install the readxl package from using RStudio menus, or
# install.packages("readxl")

# Then, load the package into memory ready ready for use
install.packages("readxl")
library(readxl)

# Old standard Excel file
xls.df <- read_excel(path="Dummy_data.xls", sheet=c("Data"), col_names=TRUE)

xls.df
str(xls.df)

# New standard Excel file.
# Skip two lines at the top of the sheet but alos read header row
xlsx.df <- read_excel(path="Dummy_data.xlsx", sheet=c("Dummy_data"), col_names=TRUE, skip=2)

xlsx.df
str(xlsx.df)

# Converting columns in a datafame into factors. Some functions used to read-in data do this
# conversion automatically but readr() and readxl() do not.
str(factor(xlsx.df$colour))
xlsx.df$colour <- factor(xlsx.df$colour)
xlsx.df$replicate <- factor(xls.df$Replicate)
str(xlsx.df)

#----- Path names to files -----
# Slashes in path names are reversed in R compared to Windows.
# R follows the Unix and MacOS convention.

# Path to the file can also be included in the function e.g.:
getwd()
read_csv(file="./raw_data/Dummy_data_ver2.csv", col_names=TRUE) # Uses '.' for ' current directory'


#----- Some simple analyses you may be familiar with! -----
aov(height ~ colour, data=xlsx.df)   # Simple ANOVA; formula interface
summary(aov(height ~ colour, data=xlsx.df))
plot(aov(height ~ colour, data=xlsx.df))

# Save the model output to an object, then examine it.
fit1 <- lm(height ~ length, data=xlsx.df)  # Simple linear regression; formula interface
summary(fit1)
plot(fit1)
plot(residuals(fit1) ~ fitted(fit1))   # Here we are using the 'formula interface': y ~ x
library(ggfortify)
autoplot(fit1,1:6)

lm(xlsx.df$height ~ xlsx.df$length)


#----- Task -----
# TASK: Start a new RStudio project in a separate directory.
# Read in your own data file.
# If you don't have your own data, use my file: "Lupin-expt-2011.xlsx".
# Check the column names, and the structure of the dataframe.
# Did it import correctly, or are there problems to fix?
# How many missing values do you have (if any)?


#----- Extension task -----
# Plot some graphs of the variables in your data.
# Do a suitable ANOVA or regression analysis.
# How are you going to check the statistical assumptions of your analysis?

# Ends.

