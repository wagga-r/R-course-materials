# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

#----- Looping, and conditionals -----

# Note: R objects are indexed from 1 (not zero as in some other programming languages)

# 'For' loops (actually, they are rarely required in R)
?Control

cc <- c(2,4,6,12,14,16,22,24,26,32)

for(i in 1:10) {print(cc[i])}

for(i in 1:10) {cc[i]^2}
for(i in 1:10) {print(cc[i]^2)}

# Vectorised version is much simpler!
cc^2

#----- Saving output from for() loop -----

for(i in 1:10) {print(cc[i]^2); return(cc[i]^2)}
cc_out

rm(ff)
for(i in 1:10) {ff[i] <- cc[i]^2}

# With a simple 'for' loop the output has to be predefined
ff <- vector()
for(i in 1:10) {ff[i] <- cc[i]^2}
ff

# Length mismatch can cause unexpected errors
for(i in 1:12) {ff[i] <- cc[i]^3}
ff

for(i in 1:10) {
  ff <- vector(length=10)  # Defined inside the loop each iteration
  ff[i] <- cc[i]^2
  print(ff)
  }

for(i in 1:length(cc)) {
  ff[i] <- cc[i]^3
}
ff

# This is best practice
for(i in seq_along(cc)) {
  ff[i] <- cc[i]*2
}
ff

#----- Subsetting is a form of conditional -----
data(iris)
iris$Sepal.Length[iris$Sepal.Width<2.5] # Less than

iris[iris$Species=="setosa",]           # Equal to; notice double '=='

keep <- c("setosa","virginica")
iris[iris$Species %in% keep, c(2,3)]    # 'present in'

iris[iris$Species!="setosa",]           # Not equal to '!='

# Boolean operators
iris[iris$Species=="setosa" & iris$Sepal.Width>4,]    # AND
iris[iris$Species=="setosa" | iris$Sepal.Width==3.3,] # OR

# Same in dplyr
iris %>% filter(Species=="setosa" & Sepal.Width>4)

#----- Conditionals: if, if...else, ifelse -----

mytime <- function(){as.numeric(format(Sys.time(), "%H.%M"))}
mytime()
current <- mytime()

if (current>9.00) {print("Keep working!")}
if (current>17.00) {print("Beer O'clock")}

current <- 12.30 # Set the time manually
if (current>12.00 & current<13.00) {print("Lunch time")}
if (current>12.00 & current<13.00) {cat("Lunch time")}
if (current>12.00 & current<13.00) {cat("\n\tLunch time\n\n")}  # More controlled printing

current <- 10.45
if (current>10.30 & current<11.00) {print("Coffee time")}
if (current>17.00) {print("Beer O'clock")}

if (current>17.00) {print("Home time")} else {print("Keep working!")}

current <- 17.25
if (current>12.00 & current<13.00) {print("Lunch time")} else
  if (current>10.30 & current<11.00) {print("Coffee time")} else
    if (current>17.00) {print("Beer O'clock")} else
    {print("Keep Working!")}

current <- 18.00
ifelse(current>17.00, "Beer O'clock", "Keep working!")

current <- 13.50
ifelse(current>12.00 & current<13.00, "Lunch time",
       ifelse(current>15.00, "Stop", "error"))

#----- ifelse is vectorised -----
cc
ifelse(cc>15, "yes", "no")
ifelse(cc>15, TRUE, FALSE)


#----- while() loops -----

x <- 3
while(x < 10) {x <- x+1; print(x)}


#----- dplyr case_when() -----
# Create some dummy data
set.seed(42)
ht.df <- data.frame(index=1:10,
                    height=rnorm(n=10, mean=170, sd=15))
ht.df

ht.df %>%
  mutate(category = case_when(
    height < 170 ~ "short",
    height > 170 & height < 180 ~ "medium",
    height > 180 ~ "tall")) -> ht.df


ht.df


#----- Task -----
# TASK: Set-up some conditional subsetting using your own data.
# Subset on rows, columns, and both together. You can do this using
# base functions or dplyr (your choice).
# Save the subset into a new object.

#----- Extension task -----
# Using the iris dataset, calculate the approximate area of sepals and petals.
# Calculate the quintiles of these new vectors.
# Use dplyr case_when to classify those new vectors into these categories:
# "very_small", "small", "medium", "large", "very_large".
# Make these new vectors ordered factors so that the levels print in a sensible
# order in a table (hint: not alaphabetical). Draw boxplots based on the new levels.


# Ends.
