# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703
# Amended by Thomas Williams

# The importance of data exploration and visualisation BEFORE analysis to understand what is going on.

# Anscombe's quartet (1973 paper)

# See: https://en.wikipedia.org/wiki/Anscombe's_quartet

aq.df <- data.frame(read.table(text="
x1	y1	x2	y2	x3	y3	x4	y4
10.0	8.04	10.0	9.14	10.0	7.46	8.0	6.58
8.0	6.95	8.0	8.14	8.0	6.77	8.0	5.76
13.0	7.58	13.0	8.74	13.0	12.74	8.0	7.71
9.0	8.81	9.0	8.77	9.0	7.11	8.0	8.84
11.0	8.33	11.0	9.26	11.0	7.81	8.0	8.47
14.0	9.96	14.0	8.10	14.0	8.84	8.0	7.04
6.0	7.24	6.0	6.13	6.0	6.08	8.0	5.25
4.0	4.26	4.0	3.10	4.0	5.39	19.0	12.50
12.0	10.84	12.0	9.13	12.0	8.15	8.0	5.56
7.0	4.82	7.0	7.26	7.0	6.42	8.0	7.91
5.0	5.68	5.0	4.74	5.0	5.73	8.0	6.89", header=TRUE))

aq.df

#---- Set1 ----
p1 <- ggplot(data=aq.df, aes(x=x1, y=y1)) + geom_smooth(method="lm", se=FALSE)
p1
p1 + geom_point(colour="red", cex=2) + labs(title="Set 1")


#----- Set 2 -----
p2 <- ggplot(data=aq.df, aes(x=x2, y=y2)) + geom_smooth(method="lm", se=FALSE)
p2
p2 + geom_point(colour="red", cex=2) + labs(title="Set 2")


#----- Set 3 -----
p3 <- ggplot(data=aq.df, aes(x3, y3)) + geom_smooth(method="lm", se=FALSE)
p3
p3 + geom_point(colour="red", cex=2) + labs(title="Set 3")


#----- Set 4 -----
p4 <- ggplot(aq.df, aes(x4, y4)) + geom_smooth(method="lm")
p4
p4 + geom_point(colour="red", cex=2) + labs(title="Set 3")


# Using base package to plot a dataframe - its gives a pairs plot.
plot(aq.df)


#----- Statistics summary -----
# Using base::summary() function
summary(aq.df)

# Using skimr package
install.packages("skimr")
library(skimr)
help(skimr)

skim(aq.df)
describe(aq.df)

# Using dplyr package
aq.df %>% select(y1,y2,y3,y4) %>% summarise_all(list(m=mean))

aq.df %>%
  select(y1,y2,y3,y4) %>%
  summarise_all(list(m=mean,
                sdev=sd,
                med=median))

# alternate output
aq.df %>%
  select(y1,y2,y3,y4) %>%
  gather("variable", "value", 1:4) %>%
  group_by(variable) %>%
  summarise(m=mean(value),
            sdev=sd(value),
            med=median(value))

# There are several other packages/options for summarizing data and putting
# the output into nice tables.



# Ends.
