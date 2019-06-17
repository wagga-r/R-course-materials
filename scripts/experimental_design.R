# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Designing experiments.

# Read this CRAN task view: https://CRAN.R-project.org/view=ExperimentalDesign

# Think carefully about what sort of data your experiment will produce and
# how you will collect and analyse it. Consult a statistician or biometrician
# when your have firm ideas but BEFORE you start the experiment.

# If you are really serious about design you might dive into using 'DiGGer'
# http://nswdpibiom.org/austatgen/software/

# If you are an 'asreml' user (not free), check out the 'od' package (optimal design).


#----- Simple experiment -----
# At a simple level you can use R to set-up your factors for an experiment
help(gl)   # Generate levels

gl(n=10, k=3)
(Patient <- gl(n=10, k=3))

# Or, create a dataframe from all combinations of factor variables
expand.grid(my_fac_1 = seq(60, 80, 5),
            my_fac_2 = seq(100, 300, 50),
            sex = c("Male","Female"))

#----- Designing simple field experiments -----
library(agricolae)

# try library(dae)

# Randomised complete block
# 5 treatments and 6 blocks (replicates)
my_trts <- c("A","B","C","D","E")

des1 <- design.rcbd(trt=my_trts, r=6, serie=3, seed=986)

str(des1)
des1$sketch  # but not well-balanced for rows and columns

des1$book # field book

# Save design to disk
write.table(des1$book, "design1.txt", row.names=FALSE, sep="\t")
file.show("design1.txt")

# Let's say the plots in field are sown and labelled in ZIGZAG (serpentine) format.
fieldbook1 <- zigzag(des1)
print(matrix(fieldbook1[,1], byrow=TRUE, ncol=5))

# There are several ways to number the plots.
# Simple and continuous numbering of plots
des2 <- design.rcbd(my_trts, 6, serie=0, seed=986, continue=TRUE)
des2$sketch
des2$book
print(matrix(des2$book[,1], byrow=TRUE, ncol=5))


#----- Alpha design (resolvable block design) -----

# In an alpha design the number of treatments must be multiple of k (block size).

# 12 treatments, 3 blocks, 3 reps
trt <- LETTERS[1:12]

t <- length(trt)
k <- 3
r <- 3
s <- t/k

des3 <- design.alpha(trt, k, r, serie=3, seed=986)
des3$sketch
des3$book


#----- Package 'desplot' helps visualise field trial design and layout -----
library(desplot)

# Add row and column specification to our design1
des1$book$row <- rep(1:6, each=5)
des1$book$col <- rep(1:5, times=6)

str(des1$book)
head(des1$book)

# What colours to use to show the treatments?
help(colours)
colours()
new_colours <- c("yellow","red1","lightblue","tan","grey90")

# Display the treatments as text in each plot
desplot(data=des1$book,
        form=my_trts~col*row,
        text=my_trts,
        shorten="no",
        col.regions=new_colours,
        main="Design 1", xlab="Columns", ylab="Rows", cex=0.9,
        out1=block,
        out2=my_trts,
        out2.gpar=list(col="black", lwd=1, lty=1))

# Display the plot number as text in each plot
desplot(data=des1$book,
        form=my_trts~col*row,
        text=plots,
        shorten="no",
        col.regions=new_colours,
        main="Design 1", xlab="Columns", ylab="Rows", cex=0.9,
        out1=block,
        out2=my_trts,
        out2.gpar=list(col="black", lwd=1, lty=1))

# Display the 'range,row' as text in each plot
# This assumes range = col, and row = row (depends on the standard in your work area)

des1$book$range_row <- with(des1$book, range_row <- paste0(col, ",", row))
head(des1$book)

desplot(data=des1$book,
        form=my_trts~col*row,
        text=range_row,
        shorten="no",
        col.regions=new_colours,
        main="Design 1", xlab="Columns", ylab="Rows", cex=0.9, #flip=TRUE,
        out1=block,
        out2=my_trts,
        out2.gpar=list(col="black", lwd=1, lty=1))


# Ends.
