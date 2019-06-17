# Data munging, written by Shafi (Sahibzada Shafiullah), Graham Centre member and
# presented at a previous cRow monthly meeting.

# R course at CSU, April 2018
# David Luckett, djluckett@gmail.com, 0408 750 703

library(tidyr)
library(dplyr)
library(ggplot2)

# import mtcars (Motor Trend )
data("mtcars")
help(mtcars)

dim(mtcars)

# This dataset is a bit weird because the car models are in the row_names.
# Ideally, they should be in a factor.

mtcars["mpg"]	  # Miles/(US) gallon; the determinant of fuel efficiency.
mtcars["cyl"]	  # Number of cylinders; data includes 4,6,8 cylinder engines.
mtcars["disp"]	# Displacement (cu.in.); measures overall piston volume of the engine.
mtcars["h"]	    # Gross horsepower.
mtcars["drat" ]	# Rear axle ratio; a high ratio indicates more torque.
mtcars["wt"]	  # Weight (in 1000 lbs); he overall weight of the vehicle.
mtcars["qsec"]	# 1/4 mile time in second; acceleration rate from standstill.
mtcars["vs"]	  # Engine cylinder configuration: 0=V-shape, 1=straight line.
mtcars["am"]	  # Transmission type; 0 = automatic, 1 = manual.
mtcars["gear"]	# Number of forward gears.
mtcars["carb"]	# Number of carburetors; more = increased airflow for a larger engine.

# to see the structure of your data
mtcars %>% glimpse()

# change am and vs to factors
mtcars$am <- as.factor(mtcars$am)
mtcars$vs <- as.factor(mtcars$vs)

mtcars %>% glimpse()

mtcars %>% head()
mtcars %>% head(10)

mtcars %>% tail()

# sometimes the data is so long that can not be viewed easily. The utils::View function
# is very helpful to see the whole dataframe and to be able to move around in a spreadsheet 
# like way.
utils::View(mtcars)

# or in a dplyr pipe
mtcars %>% View()


#------------------------------------------------------------
# Use 'select' to choose a few or range of columns.
# select can also be used to arrange the columns in a specific order.
mtcars %>% select(am, gear ) 

mtcars %>% select(starts_with("c"))

# Leave out some columns
mtcars %>% select(-wt)
mtcars %>% select(-(wt:gear))


# reorder columns
mtcars %>% select(am, mpg:hp, carb, vs, everything(), -qsec)

# order columns alphabatically; e.g. keep the first one and reorder the rest
mtcars %>% select(cyl, order(colnames(.)))


#------------------------------------------------------------
# Use 'filter' to choose observations by rows

mtcars %>% filter(gear=="3")
mtcars %>% filter(gear %in% c("3", "4"))

# to exclude obsevations use 'negate'; the '!' character
mtcars %>% filter(!gear=="3")

# use logical
mtcars %>% filter(gear>3)


#------------------------------------------------------------
# 'slice' will do a similar thing to filter but you have to specify the row numbers
# But row_names are lost.
mtcars %>% slice(1)
mtcars %>% slice(c(1:4))

mtcars %>% slice(-c(1:20))

#------------------------------------------------------------
# finding 'distinct' (unique) values in a column
mtcars %>% select(cyl) %>% distinct()
mtcars %>% select(cyl, carb) %>% distinct()


#------------------------------------------------------------
# Use 'arrange' to order or rank variable values in accending or descending order
mtcars %>% arrange(mpg)       # ascending order
mtcars %>% arrange(desc(mpg)) # descending order

mtcars %>% arrange(mpg, am)

#------------------------------------------------------------
# Use 'mutate' to add a new column
mtcars %>% mutate(addition=mpg+cyl)

# to duplicate a column
mtcars %>% mutate(mpg2=mpg)

# to merge two or more columns as character vectors
mtcars %>% mutate(new_col = paste(vs, am, gear, sep = '__'))


#------------------------------------------------------------
# 'replace' values in a column and add as a new column 
mtcars %>% mutate(newcol=replace(gear, gear=="4", "four"))


#-----
# 'dot' notation is used by dplyr and pipes.
# The '.' is a placeholder for the data being passed down from upstream

# To replace using logical
mtcars %>% mutate_at(vars(gear,carb), funs(replace(., .<= 3, NA)))
mtcars %>% mutate_at(vars(gear), funs(replace(., .<= 4, "low gear")))


#------------------------------------------------------------
# summary statistics (summary/summarise)

# summary 
mtcars %>% summary()  # This s a base R function

# count
mtcars %>% count()
mtcars %>% count(am)

# summarise (or summarize)

# mean
mtcars %>% summarise(mean(mpg))

# median
mtcars %>% summarise(median(mpg))

# summarise multiple columns
mtcars %>% summarise_at(vars(mpg:hp), funs(sum(.)))


# multiple summary functions for a single column
mtcars %>% summarise_at(vars(mpg), funs(median(), mean(), sd()))
# These non-dplyr base functions do not work correctly without 'dot' notation

mtcars %>% summarise_at(vars(mpg), funs(median(.), mean(.), sd(.)))


# Combine both
mtcars %>% summarise_at(vars(mpg, disp, hp), 
                        funs(median(.), mean(.), sd(.), min(.), max(.), IQR(.)))


#------------------------------------------------------------
# group-by()

# Group the data first using one (or more) by categorical variables (factors)

mtcars %>% group_by(am) %>%
  summarise(n())

mtcars %>% group_by(am) %>%
  summarise(mean(mpg))

mtcars %>% group_by(am) %>%
  summarise(median(mpg))


# use a piping series for summary statistics
mtcars %>% 
  filter(cyl=='8') %>% 
  group_by(am) %>%
  summarise_at(vars(mpg),
               funs(n(), sum(.), median(.), mean(.), sd(.)))


#------------------------------------------------------------
# Tabulation

# table from a single dataframe column
mtcars %>% select(gear) %>% table()

# 2x2 table
mtcars %>% select(gear, am) %>% table     # Can leave out the parentheses after table

tbl_1 <- mtcars %>% select(gear, am) %>% table 
mtcars %>% select(gear, am) %>% table -> tbl_1

#-----
# row percent, column percent, and total percents for a table
library(RcmdrMisc)

# row percent
rowPercents(tbl_1)
prop.table(tbl_1, margin=1)

# column percent
colPercents(tbl_1)  
prop.table(tbl_1, margin=2)

# total percents
totPercents(tbl_1)
prop.table(tbl_1)

#-----
# reshape data from 'wide' to 'long' format
mtcars %>% gather(car_type, spec, vs, am)

mtcars %>% gather(car_type, spec, vs, am) -> mtcars2


# change data from long back to wide format 
mtcars2 %>% spread(car_type, spec)

# Ends.