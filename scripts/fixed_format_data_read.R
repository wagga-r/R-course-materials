# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703


#----- Reading fixed-format data -----
# Using some data on fish.

# can we read the file (and just dump output to console)?
read.fwf(file="fixed_format_data.txt", widths=c(3,1,2,5,2))

# Ignore the header rows
read.fwf(file="fixed_format_data.txt", widths=c(3,1,2,5,2), skip=8)

# Ignore the trailing row too
# When imported columns are "clean", the leading zeros in numbers are dropped
read.fwf(file="fixed_format_data.txt", widths=c(3,1,2,5,2), skip=8, n=10)

# Use saved argument values, and set desired column names
mywidths <- c(3,1,2,5,2)
mycols <- c("Length","Age","Scars","Weight","Species")
read.fwf(file="fixed_format_data.txt", widths=mywidths,
         skip=8, n=10, col.names=mycols)

# OK, its working - now read into a dataframe.
# This is using base::read.fwf ------> automatic factor creation.
fish.df <- read.fwf(file="fixed_format_data.txt", widths=mywidths,
                    skip=8, n=10, col.names=mycols)

# With readr::read_fwf (syntax and arguments are a bit different)
mytypes <- "iiinc"
fish2.df <- read_fwf(file="fixed_format_data.txt",
                     fwf_widths(mywidths, mycols),
                     col_types=mytypes,
                     skip=8, n_max=10)

# What is the data format?
str(fish.df)
str(fish2.df)

fish.df; fish2.df


# Ends.
