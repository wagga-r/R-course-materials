# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703
# Amended by Thomas Williams.

# Reshaping and summarising data using the tidyr and dplyr packages.

# These packages, along with several others created by Hadley Wickham and
# co-workers at RStudio, are collectively called the "tidyverse". They are
# all about creating, manipulating, and visualising data in a "tidy" fashion.
# They aim to implement an R syntax that is more consistent than base R, and
# they alloy the "piping" of functions to make them more readable and without
# the need to keep saving intermediate objects.

install.packages("tidyverse")

library("tidyverse")

?tidyverse
?tidyr

#----- Wide-to-long -----
# Read some data in a "wide" layout
library(readxl)

wide.df <- read_excel(path="Dummy_data.xlsx",
            sheet=c("Wide_data"),
            skip=6,
            col_names=TRUE,
            na="NA")

head(wide.df)

# If I want to analyse the biomass subsamples, I need the data in "long" format
# Currently data has 36 rows. I want 3*36 at the end (from sub1, sub2 and sub3)

gather(data=wide.df, key=subsample, value=biomass, sub1, sub2, sub3)

long.df <- gather(data=wide.df, key=subsample, value=biomass, sub1, sub2, sub3)

# OK, now I can do ANOVA on biomass
long.aov <- aov(biomass ~ Entry*subsample, data=long.df)

summary(long.aov)
plot(long.aov)     # Default plotting for an aov output list object

ggplot(data=NULL, aes(x=fitted(long.aov), y=residuals(long.aov))) + geom_point()
ggplot(data=long.df, aes(y=biomass, x=subsample)) + geom_boxplot()

#or plot all at once
#install.packages("ggfortify")
library(ggfortify)
autoplot(long.aov,1:4,label.n = 0)

#---- Long-to-Wide -----
# If I have "long" data, how do I put it into "wide" format?
spread(long.df, key=subsample, value=biomass)


# Use glimpse() to have a quick look at a dataframe
glimpse(wide.df)

#------------------------------------------------------------
# Some history of options for reshaping data in R:

# base::reshape function
# reshape package
# reshape2 package (functions 'melt' and 'cast')
# tidyr package (functions 'gather' and 'spread')
# tidyr upcoming version will use 'pivot_wider' and 'pivot-longer'

# data.table package can do many data-munging tasks.
# New cdata package provides more options.

#----- Data munging -----
# dplyr is a large package with lots of functions (verbs).

# dplyr has verbs that affect ROWS of a dataframe, and has verbs that affect COLUMNS.

# dplyr can make use of pipes (%>%) to send data through a sequence of functions,
# also called 'chaining'.

# Insert '%>%' by typing the shortcut CTRL-SHIFT-M

# The 'tidyverse' procduces 'enhanced' daraframes called 'tibbles'.

#----- subset by row -----
mtcars %>% filter(mpg > 25)
mtcars %>% filter(mpg>20 & gear==4) %>% head(.)

#----- Subset by column -----
mtcars %>% select(mpg, cyl)
mtcars %>% select(-mpg, -cyl, -gear)

#----- Combinations of verbs -----
mtcars %>% filter(mpg<20 &  cyl==6) %>% select(mpg, cyl, gear)

mtcars %>%
  filter(mpg<20 &  cyl==6) %>%
  select(mpg, cyl, gear)

#----- Save the new dataframe -----

new.df <- mtcars %>%
  filter(mpg<20 &  cyl==6) %>%
  select(mpg, cyl, gear)

mtcars %>%
  filter(mpg<20 &  cyl==6) %>%
  select(mpg, cyl, gear) -> new.df


#----- Group by a factor and then calculate summary statistics -----

data(iris)
iris

iris %>% head()
iris %>% summary()

iris %>% group_by(Species) %>% summarise(msw=mean(Sepal.Width))
iris %>% group_by(Species) %>% summarise(msw=mean(Sepal.Width)) -> keep.df

iris %>% dplyr::filter(Species!="setosa") %>%
  group_by(Species) %>%
  summarise(sdsw=sd(Sepal.Width))

#----- Sorting a datframe -----
iris %>% arrange(Sepal.Width)  # Sort based on one variable
iris %>% arrange(desc(Sepal.Width))

#----- Create a new variable -----
iris %>% mutate(wlratio=Sepal.Width/Sepal.Length) # Create a new variable

#----- Base R options to achieve same -----
iris$wlratio <- iris$Sepal.Width/iris$Sepal.Length
with(iris, wlratio <- Sepal.Width/Sepal.Length)

#----- Rename an existing column -----
iris %>% dplyr::rename(sepwid=Sepal.Width) # Rename an existing variable
iris %>% dplyr::rename(sepwid=Sepal.Width) -> iris   # This makes it stick

names(iris)

#----- You can use some extra pipes from the magrittr package -----
install.packages("magrittr")
library(magrittr)
data(iris)
iris %<>% dplyr::rename(New_column_name=Sepal.Width)   # Bidirectional pipe
names(iris)

#----- Other nice dplyr goodies -----
iris %>% slice(10:13)

iris %>% glimpse()

iris %>% group_by(Species) %>% tally()

#----- A whole set of dplyr verbs that operate on multiple columns -----
iris %>% group_by(Species) %>% summarise_all(mean)


#----- Do a set of summary stats ------
iris %>% drop_na(Sepal.Length) %>%   # remove any NAs first
  group_by(Species) %>%
  summarise(med = median(Sepal.Length),
            mn = mean(Sepal.Length),
            mx = max(Sepal.Length),
            mi = min(Sepal.Length),
            q90 = quantile(Sepal.Length, 0.9),
            q10 = quantile(Sepal.Length, 0.1),
            stddev = sd(Sepal.Length),
            num=n())

#------ Can use right assignment (or left) to save output ------
iris %>% group_by(Species) %>% summarise_all(mean) -> mymeans.df
mymeans.df

#------------------------------------------------------------
# dplyr and readxl produce 'tibbles' which are enhanced dataframes.
# Bear this in mind if an unexpected error occurs when using a tibble.

# The datatable package also produces enhanced dataframes, has a large suite of functions,
# and is valued for its high speed. We won't have time to learn datatable here.
??datatable


#----- Merging dataframes -----
# dplyr can also merge (or join) dataframes (either row-wise or column-wise).
# Base R can also do joins with the merge() functions.
# A previous package to dplyr, called plyr, had join().

# First create some dummy data
one.df <- data.frame(Age=c(59,31,45,21,33),
                     Name=c("Jane","Peter","Susan","Helen","Mark"),
                     Sex=c("female","male","female","female","male"),
                     stringsAsFactors=FALSE)
one.df
str(one.df)

two.df <- data.frame(Name=c("Jane","Mark","Helen","Rhonda"),
                     Height=c(1.72, 1.83, 2.03, 1.94),
                     stringsAsFactors=FALSE)
two.df
str(two.df)

#----- Various joins ------
left_join(one.df, two.df, by="Name")

inner_join(one.df, two.df, by="Name")

right_join(one.df, two.df, by="Name")

full_join(one.df, two.df, by="Name")

anti_join(one.df, two.df, by="Name")  #Great for trouble shooting missing data

# Can match columns whose names are different
names(one.df) <- c("years","WhoIsIt","col3")

one.df

full_join(one.df, two.df, by=c("WhoIsIt" = "Name"))

#----- Making tables -----
# Check your data for balance and coding errors.
# Look closely at the frequencies of the factors in your data.
names(long.df)
table(long.df$Range, long.df$Row)
with(long.df, table(Range, Row))

long.df %>% group_by(Range, Row) %>% tally()

xtabs(~long.df$Range + long.df$Row)

table(long.df$Id, long.df$subsample)

tab1 <- table(long.df$Id, long.df$subsample)
addmargins(tab1)

# See how my coding of Id levels as geno** without leading zeros leads to sorting errors.

#----- Get to know your NAs -----
table(is.na(long.df$biomass))
long.df[is.na(long.df$biomass),]   # Watch for that tricky trailing comma!! Syntax: [row,column]

long.df %>% filter(is.na(biomass))

#----- Task -----
# TASK: With your own data: check the balance of factors, and check the occurrance of NAs.
# Produce a table of summary statistics and save this in a dataframe reday to be used in a
# thesis or publication.

#----- Extension task -----
# Find the number of unique or distinct vales in each column of the mtcars dataset.
# Make a table of frequencies from your data, and add margins showing percentages of the
# row and column totals.


# Ends.
