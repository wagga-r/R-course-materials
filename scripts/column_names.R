# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# What happens to dataframe column names when imported from a file?

# The column headings may contain various layouts and/or include
# various special characters

# In text files, column names with spaces will need to be quoted, BUT this
# is not handled correctly by readr::read_table()

#----- From text files -----
my.df <- read.table(file="column_names.dat", header=TRUE)  # base
my.df
names(my.df)

library(readr)
my2.df <- read_table(file="column_names.dat", col_names=TRUE) # readr
my2.df
names(my2.df)


#----- From Excel files -----
# No quotes needed in the Excel cells - import results not quite the same

library(readxl)

my3.df <- read_excel(path="Dummy_data.xlsx",
                     sheet=c("Column_names"),
  									 col_names=TRUE)
my3.df

names(my3.df)

identical(names(my.df), names(my3.df))

# You need to check how the data has been imported before proceeding.

#----- Post-import clean-up -----
# Another way to make column names consistent is post-import:
install.packages("janitor")
library(janitor)

clean_names(my3.df)

# Also useful:
?remove_empty_cols
?remove_empty_rows
?get_dups
?excel_numeric_to_date  # There will be more on dates later

# ----- Take-home messages -----
# Have short, non-complicated column names.
# Have extra spreadsheet rows with longer description and/or units.
# Better still, capture this meta-data in a separate sheet called "Data_dictionary".
# Makes your data much more useable and available to others.

# VERY IMPORTANT:
# Excel formatting should never be used to hold actual data. Create a separate column to hold this info.

# Open the file "messy_fomatting.xlsx" and see what should be done to avoid this.

#----- Task -----
# TASK: Check the column names of your own imported data.
# Try 'cleaning' the column names using janitor. Does your dataframe contain any empty columns,
# empty rows, or any duplicated rows? If so, remove them.

#----- Extension task -----
# Look at the in-built 'mtcars' dataframe.
# Use Google to find a way to:
# copy the row_names into a new column called 'Model';
# make the row_names into a simple numerical vector (1:32).


# Ends.
