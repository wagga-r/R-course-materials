# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# matrix() and array()

# Matrices and arrays are two other data structures in R (as in other programming languages).
# They have specific uses.
# Matrices are 2D; arrays can be 1D, 2D, 3D, or multi-dimensional.
# Recycling and/or subsetting occurs if the sizes of input/output don't match.

# Unlike dataframes and lists, arrays and matrices can only store one type of data (numeric,
# character, date-time, logical).

#----- Define a matrix -----
matrix(c(1:24), nrow=6, ncol=4)

matrix(c(1:24), nrow=6, ncol=4, byrow=TRUE)

mat1 <- matrix(c(1:24), nrow=6, ncol=4, byrow=TRUE)
class(mat1)

matrix(c(1:12), nrow=6, ncol=4, byrow=TRUE)
matrix(c(1:5), nrow=6, ncol=4, byrow=TRUE)

#----- Matrix calculations -----
t(mat1)   # t() = Transpose a matrix

install.packages("matlib")
library(matlib)
inv(mat1)
mat1 <- matrix(1:4, 2, 2)
mat1i <- inv(matrix(1:4, 2, 2))


library(matmult)
mat1 %*% mat1i

mat1*2    # Matrices are vectorised

mat2 <- matrix(seq(from=5, to=120, by=5), nrow=6, ncol=4, byrow=TRUE)
mat2

# Matrix operations = element by element
mat1*mat2

#----- Diagonal matrices -----

(yd <- diag(1:5))
(yu <- upper.tri(mat1))
(yl <- lower.tri(mat1, diag=TRUE))


#----- Subset a matrix: [rows, columns] -----
mat1
mat1[1:2, 3:4]

mat1[3,]
mat1[,2]

mat1[,5]

#----- Logicals in a matrix -----
(mat3 <- matrix("FALSE", nrow=3, ncol=4))
(mat3 <- matrix(FALSE, nrow=3, ncol=4))
(mat3 <- matrix(c(rep(FALSE, 6), rep(TRUE, 6)), nrow=3, ncol=4))

#----- Can convert between matrices and dataframes - can be very useful -----
data.frame(mat1)
as.matrix(data.frame(mat1))

# A matrix can have 'named' rows and columns

#----- Task -----
# TASK: Create a 8 x 6 matrix, holding the numbers 1:12 in sequence by-row, repeated 4 times.
# Create a similar matrix with the numbers in sequence 1,1,1,1,2,2,2,2,3,3,3,3, etc.

matrix(rep(c(1:12), each=4), nrow=8, ncol=6, byrow = TRUE)

#----- Arrays in R -----
# In truth, I have never used arrays in R for a real-world problem!

as.array(letters)     # 1D
dim(as.array(letters))

my.ar <- array(LETTERS, c(4,5))   # 2D
my.ar
dim(my.ar)

my2.ar <- array(LETTERS, c(2,3,4))  # 3D
my2.ar
dim(my2.ar)

array(1:3, c(2,4)) # recycle '1:3' 2.6667 times

#----- Task -----
# TASK: Create a 4D array with dimensions 2,2,2,3 and fill it with 24
# random numbers between 1 and 48.
# Create a similar array with the random numbers in sorted order.

#----- Extension task -----
# Create a 2D array size 2x3 filled with common people's names.
# Convert the array to a matrix, and then to a dataframe.
# Give the dataframe columns some more-informative names.


# Ends

