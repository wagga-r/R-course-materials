# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

#----- More on R Lists and how to access them -----

# For a description of lists in R see:
# http://adv-r.had.co.nz/Data-structures.html

# A list can contain mixed types of atomic vectors with different lengths
x.lst <- list(First=1:3,
              Second="a",
              Third=c(TRUE, FALSE, TRUE),
              Fourth=c(2.3, 5.9))
str(x.lst)
print(x.lst)   # A 'named list'

class(x)

# A list can be nested (recursive)
y.lst <- list(1:3, list(5:8, c(4.4, 6.1)))
str(y.lst)
print(y.lst)   # An 'unnamed list'; elements are only referred to by their indices.

# Check and unlist
is.list(x.lst)
unlist(x.lst)
unlist(y.lst)

# Copy into a list
(bb <- c("Red","Green","Blue"))
(cc <- as.list(bb))

#----- Access elements of a list = subsetting -----

x.lst[1]       # Preserving subset, keep the name, can be >1 element
x.lst[[1]]     # Simplifying subset, drops the name, only 1 element

y.lst[1]
y.lst[[1]]
y.lst[2]
y.lst[[2]]
y.lst[[2]][[1]]

x.lst[c(1,2)]
x.lst[[c(1,2)]]

#----- Task -----
# TASK: Create a list containg some ficticious details: first-name, age, and hair-colour.
# Print the whole list. Print only the second element of the list.
# Output that list to a flattened vector.


#----- Extension task -----
# Create a named list containing three different vectors of the same length and type.
# Convert that list into a sensible dataframe in one step.



#---- R output is often a complex list -------
# Many R functions produce complex lists as output (e.g. regression analysis).
# You will need to access sections of this output.

data(mtcars)
head(mtcars)

plot(hp~disp, data=mtcars)
abline(lm(hp~disp, data=mtcars))

lm(hp~disp, data=mtcars)

car.lm <- lm(hp~disp, data=mtcars)
class(car.lm)
typeof(car.lm)

# Elements of lists can also have "attributes" (e.g. names, descriptions, etc.)
str(car.lm)
summary(car.lm)
# Extract a component of the output list e.g. fitted values
# Can also use the $ extractor in this circumstance but only when using the name
names(car.lm)

car.lm$fitted.values
car.lm[5]
car.lm[[5]]
car.lm[["fitted.values"]]

car.lm$5    # Doesn't work
car.lm$'5'  # No error, but NULL result.

fitvals <- car.lm$fitted.values
resvals <- car.lm$residuals
plot(y=resvals, x=fitvals)
plot(car.lm)

# get the R-squared value for a regression (via the summary function)
summary(car.lm)$r.squared
summary(car.lm)$adj.r.squared

# add R-squared equation to graph
r2val <- round(summary(car.lm)$r.squared, digits=2)

# Two ways to create the plotmath text
rsqtxt <- substitute(expression(italic(paste( "R"^{2}," =",r2val))))
rsqtxt <- bquote(italic("R"^2 == .(r2val)))

plot(hp~disp, data=mtcars, las=1)
abline(car.lm, col="red") # regression line

text(x=200, y=250, rsqtxt)

# add probability to graph
summary(car.lm)$coefficients
my.p <- round(summary(car.lm)$coefficients[2,4], digits=3)

# If P is very small change string to show <0.001
if(my.p < 0.001) {my.p <- c("< 0.001")}
ptxt <- bquote(italic("P" == .(my.p)))
text(x=200, y=200, ptxt)

#----- Task -----
# TASK: Run a simple linear regression of mtcars miles-per-gallon
# against weight. Plot the raw data using a non-default symbol and
# colour and with increased size, and plot the regression line in blue.


#----- Extension task -----
# Identify the three car models with the greatest deviation
# from the regression calculated above.


# Ends.

