# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# How R handles missing values

# VERY IMPORTANT:
# Missing values are "unknown" data. They are not zeros, and they are not NULLs.

# By default readxl converts blank cells to missing data but this
# is not best-practice in Excel nor in any other spreadsheet.

# The missing value indicator in R is NA, not the string "NA" or 'NA'.

# Some other software uses other missing-value indicators: -99, -999, *, etc.
# They can be converted automatically at import time, or converted later.

library(readxl)

miss.df <- read_excel(path="Dummy_data.xlsx",
                      sheet="Missing_values", skip=2, col_names=TRUE)

miss.df

# In this 'messy' file there are THREE different missing-value strings
miss2.df <- read_excel(path="Dummy_data.xlsx",
                      sheet="Missing_values", skip=2, col_names=TRUE,
                      na=c("NA", "missing", "*"))

miss2.df
summary(miss2.df)


#----- Missing values in calculations -----
# How do missing values affect calculations?

mean(miss2.df$length)
mean(miss2.df$length, na.rm=TRUE)  # You will need this a lot!

sd(miss2.df$length, na.rm=TRUE)
var(miss2.df$length, na.rm=TRUE)
min(miss2.df$length, na.rm=TRUE)
max(miss2.df$length, na.rm=TRUE)
median(miss2.df$length, na.rm=TRUE)
range(miss2.df$length, na.rm=TRUE)

# If your results seem strange, always ask "Are there any missing values?"


#---- Task -----
# TASK: Does your personal data have any missing values?
# How were they coded in the original file?
# Do any special codes need to be converted to NA to work correctly in R?
# If necessary, re-read your data and perform any conversion.


#----- Extension task -----
# Examine the lupin data in the Excel file "Lupin-expt-2011.xlsx".
# In the yield column (kgplot) the value of 0.001 was used to represent missing values.
# Re-read the data to take this into account.


# Ends.
