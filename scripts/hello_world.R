# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# This line is a comment

#----- The format of this line defines a 'block' in the code -----

print("Hello World") # This is an 'end-of-line' comment
print('Hello World')

hw <- "Hello World"

hw

print(hw)

str(hw)
help(str)

newnum <- 5
str(newnum)

#----- Second section -----
hi <- c("Hello", "World")
hi

str(hi)
hi[1]
hi[2]

paste(hi[1], hi[2])
help(paste)

paste(hi[1], hi[2], sep="----")  # Here there are 3 arguments

# More on subsetting later.

#----- Section 3 -----
# Some functions just give information
date()
sessionInfo()
R.Version()
getwd()
dir()
ls()

#----- Section 4 -----
# R syntax

# '<-' means left assignment (=create a new object)
# '->' right assignment also works but is less common
# '=' is used in arguments to allocate a value

# '=' can substitute for '<-' but this can cause confusion, so avoid using.
# '=' is still used in arguments (see above).

aa <- "Line 1"
bb = "Line 2"   # Avoid this
cc="Line 3"     # Avoid this

head(babynames)

print(c(aa, bb, cc))

# The 'c(.......)' construction means 'combine' or 'concatenate'.

#----- Task -----
# TASK: Get R to print out a message congratulating you on your commitment in
# attending this course! Save that message in an object.
# Print the object (to the console, not to a real paper printer!).

ww <- "Well done for attending the course"
ww
print(ww)
cat("\t\t\t", ww, "\n\n\n\n")

#----- Extension task -----
# Get R to paste together the names of the first 4 months of the year, using
# a suitable separator character. Read help(paste) on how to achieve this.
# Do the same thing but use tht first 6 abbreviated month names.

m2 <- paste(month.name[1], month.name[2], sep="--")
m2

# Ends.
