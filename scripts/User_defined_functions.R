# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# User-defined functions (UDFs)

# All 'commands' in R are basically functions.
# You can write your own functions to avoid repetition, and increase accuracy.
# Allows you to automate routine operations.

#----- General syntax for a new function -----
function_name <- function( arguments ) { some_code_to_do_stuff }


function_name <- function( arguments ) {
  some_code_to_do_stuff
  a_second_line_to_do_things
  third_line
}

# For your function name, choose wisely.
# Relatively short, unique, and not a name already in use.

#----- Function to square a number -----

my_square <- function(x){ x^2 }

my_square(2)

my_square()     # my_square() has no 'default'
my_square(x=3)
my_square(xx=3)

args(my_square)

#----- Set argument defaults -----
# Let's give my_square a default for its argument
my_square <- function(x=5) {x^2}

my_square()
my_square(x=3)
my_square(xx=3)

# You can see the code for a function by entering just its name
my_square


#----- A function definition containing an error -----
my_cube <- function(cc) {
  print(cc^3)
  dd^3
}

my_cube()
my_cube(3)


#----- A function with >1 argument -----
my_add <- function(aa,bb) {
  aa+bb
}

my_add(7,5)

my_add()
my_add(4)
my_add("2",3)

#----- Function to manipulate strings (character vectors) -----
say_hello <- function(input_name="anonymous"){
  paste("Hello", input_name)
}

say_hello()
say_hello("David")

say_hello(David)

#----- Pass an already existing object to a function -----
first_name <- "Peter"

say_hello(first_name)

#----- Typically a function will do several things at once -----

my_powers <- function(xx) {
  xx^2
  xx^3
  xx^4
}

my_powers(2) # Only the last result inside the function gets reported

# Can use explicit print() to see other results (not recommended)
my_powers <- function(xx) {
  print(xx^2)
  print(xx^3)
  xx^4
}

my_powers(3)

# Better option is to assign the results internally and then return
# the results.
# return() can only return one thing - so make it a list!
my_powers <- function(xx) {
  a2 <- xx^2
  a3 <- xx^3
  a4 <- xx^4
  return(list(a2,a3,a4))
}

my_powers(3)
unlist(my_powers(3))


#----- Saving the result from a function -----
# 'Environments' and 'lexical scoping' in R are important.

environment()

my_save <- function(qq) {
  print(environment())
  paste("Here is some text:", qq)
}

my_save(qq="Learning R is fun!")

# Create a new object inside the function, and print it out in different ways
my_save <- function(qq) {
  combined_text <- paste("\n\nHere is some text:", qq, "\n\n")
  print(combined_text)
  cat(combined_text)
}

my_save(qq="second piece")


# The object we made (combined_text) is NOT available outside the function
ls()

# But we can export the result.
# A function can only export ONE object but that object can be a LIST so we can,
# effectively, export many objects. This is why many R outputs are list
# structures e.g. aov(), lm(), glm(), etc.

my_save <- function(qq) {
  combined_text <- paste("Here is some text:", qq)
  return(combined_text)
}

my_save(qq="third test")

# But the object 'combined_text' was printed as the function finished but not saved
# in the current environment.
# We have to do an 'assignment' from the function

saved_text <- my_save(qq="third test")
saved_text

#----- A useful user-defined function -----
# Ok, now lets make something potentially useful

# Calculate a CV% (coefficient of variation).
# Here the 'x' argument is passed to two parts of the function code
CVpc <- function(x) {
  (sd(x, na.rm=TRUE)/mean(x, na.rm=TRUE))*100
}

CVpc
CVpc()
CVpc(25)

# Get the CVpc of a set of numbers
CVpc(c(14,17,23,25,11,19,22))

a <- c(1:20)
CVpc(a)

data(iris)
head(iris)
CVpc(iris$Sepal.Length)
CVpc(iris[,3])            # Dataframes are subsetted as: '[row, column]'

# Works OK in dplyr like this:
iris %>% group_by(Species) %>% summarise_at(., 1:4, CVpc)


#----- Common use for a UDF is with lapply() -----
?lapply

str(iris)
typeof(iris)

lapply(iris, CVpc)
lapply(iris[,1:4], CVpc)
lapply(iris[,c(4,2,1,3)], CVpc)

saved_lst <- lapply(iris[,1:4], CVpc)
saved_lst

unlist(saved_lst)

# This is the same as what 'sapply' does
sapply(iris[1:4], CVpc)

#----- Often use lapply() and a UDF to import several datafiles at once -----

# Make some dummy files and save them in the project directory:
full.df <- data.frame(aa=c("gg","gg","hh","hh","kk","kk"), bb=1:6, cc=abs(rnorm(6)))
full.df

for (ii in c(1:3)) {
  this_level <- levels(full.df$aa)[ii]
  temp.df <- full.df[full.df$aa==this_level,]
  outname <- paste0("my_out_", ii, ".csv")
  write.csv(temp.df, outname, row.names=FALSE)
}

# Now get a list of those files
infiles <- dir(pattern="my_out")
infiles

# A new function to read a .csv file and calculate the sum() of column 'cc'.
# The print() functions included here are just to show progress, but will not
# always be appropriate.
my_tots <- function(ff) {
  temp.df <- read.csv(ff, header=TRUE)
  print(temp.df)
  tot_cc <- sum(temp.df$cc)
  print(tot_cc)
}

my_tots("my_out_1.csv")

# Use lapply to read each of the files in the list
lapply(infiles, my_tots)

# Save the result as well as see the progress
tots_lst <- lapply(infiles, my_tots)
tots_lst

tots_lst <- sapply(infiles, my_tots)
tots_lst

#----- Re-using a function -----
# How do you re-use a function from project-to-project without cut-and-paste
# into each script file you create?

#----- OPTION 1 -----
# 'source' a script file into your current session (clumsy)

help(source)

source("my_UDFs.R")

#----- OPTION 2 ------
# Open the .Rprofile file in your 'home' directory.
# Where is your HOME directory? Its stored in an OS system variable:
Sys.getenv("HOME")

# Cut-and-paste the CVpc function above into that file and save.
# Then restart R and the new function will be available.

#----- OPTION 3 -----
# Create your own personal R package which you can load at will.


#----- Task -----
# TASK: Search online to find some examples of people's .Rprofile files.
# Find a potentially useful function, copy it to your current R session
# and try it out.

#----- Extension task -----
# Think fo something that you do regularly in R.
# Start to write a function to streamline that process.



#----- Notes -----
# The 'environment' when using a loop is different to a function:

for (ii in 1:5) {
  print(environment())
  print(ii^2)
}

ii <- 1:5
my_fun <- function(zz) {
  print(environment())
  print(ii^2)
}

my_fun(ii)


# Ends.
