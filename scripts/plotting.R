# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Plotting data

data(iris)
help(iris)

str(iris)
summary(iris)
# Let's shorten those long names to save typing
names(iris) <- abbreviate(names(iris))
head(iris)

plot(iris)

plot(x=iris$Sp.L, y=iris$Sp.W)

plot(iris$Sp.L, iris$Sp.W)   # Default order for arguments: x=, y=

plot(iris$Sp.L ~ iris$Sp.W)  # So-called 'formula' interface: y ~ x
plot(Sp.W ~ Sp.L, data=iris)

boxplot(Sp.W ~ Spcs, data=iris)
hist(iris$Sp.W)

#----- Ways to make graphs in R -----
# R has four graphing systems

# 1: base system
# 2: grid system
# 3: lattice system
# 4: ggplot2 system

# Many object types (classes) have a default 'base' plotting method, e.g. ANOVA, regression, etc.
# You will often use base plotting to get a quick look at something.
methods(plot)

# I suggest you learn the ggplot2 system.
# It is the most modern, has recently become the most popular, and can produce
# publication-quality graphics with ease.

# BUT sometimes a simple base::plot() graph is the quickest and easiest.

#------------------------------------------------------------
# Credit: Dr Iain Hume (NSWDPI, Wagga Wagga)

library(ggplot2)
data(iris)

# Don't bother with the qplot() function, go straight to using ggplot()

# Graphs are built in layers (using the '+' symbol)
p1 <- ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width))
p1
p1 + geom_point()

# Can be on one line
ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()

# Can be on multiple lines.
# Note, the '+' cannot start a line
ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point()

p2 <- ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, colour=Species))
p2 + geom_point(aes(shape=Species), size=1)


# aes settings can go in either level depending how its needed
p3 <- ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width))
p3 + geom_point(aes(shape=Species, colour=Species), size=2)


# Using diamonds dataset
help(diamonds)

# its big, so get a random sample subset of it
set.seed(12345)    # This ensures that we all see the same subset
d2 <- diamonds[sample(1:dim(diamonds)[1], 1000),]
head(d2)

p3.1 <- ggplot(data=d2, aes(x=carat, y=price))
p3.1 + geom_point(aes(color=color))

p4 <- ggplot(data=d2, aes(x=carat, y=price/carat))
p4 + geom_point(aes(color=color))

p5 <- ggplot(data=d2, aes(x=color, y=price/carat))
p5 + geom_boxplot()

# With the entire dataset
p5.1 <- ggplot(data=diamonds, aes(x=color, y=price/carat))
p5.1 + geom_violin()


# Histograms
# "Old Faithful" dataset; a geyser in the Yellowstone National Park, USA
# See: https://en.wikipedia.org/wiki/Old_Faithful
help(faithful)
head(faithful)

p6 <- ggplot(data=faithful, aes(x=waiting))
p6 + geom_histogram()

p7 <- ggplot(data=faithful, aes(x=waiting))
p7 + geom_histogram(binwidth=4, fill="blue", colour="black")

p7.1 <- ggplot(data=faithful, aes(x=waiting, y=eruptions))
p7.1 + geom_point()

# Change titles and labels
p7.2 <- ggplot(data=faithful, aes(x=waiting, y=eruptions)) +
  labs(title="Old Faithful Geyser Eruptions",
       y="Length of previous eruption (mins)",
       x="Waiting time for next eruption (mins)") +
  geom_point()

p7.2   # Same as print(p7.2)


# Calculate the means of the broad groups
library(dplyr)

faithful %>%
  filter(eruptions<=3) %>%
  summarise(short=mean(waiting))

faithful %>%
  filter(eruptions>3) %>%
  summarise(short=mean(waiting))

# Conclusion:
# The time between eruptions has a bimodal distribution, with the mean interval
# being either 55 or 80 minutes, and is dependent on the length of the prior
# eruption. Within a margin of error of +/- 10 minutes, Old Faithful will erupt
# either 55 minutes after an eruption lasting less than <3 minutes, or 80
# minutes after an eruption lasting more than >3 minutes.

# There are always multiple ways to achieve the same end in R
mean(faithful$waiting[faithful$eruptions<=3], na.rm=TRUE)

with(faithful, mean(waiting[eruptions<=3], na.rm=TRUE))


#----- Line plots -----
climate <- read.csv("climate.csv", header=TRUE)
head(climate)
str(climate)
# Temperature anomalies for 1, 5 and 10 years, plus the uncertainty estimate of those values.


p8 <- ggplot(data=climate, aes(x=Year, y=Anomaly10y))
p8

p8 + geom_ribbon(aes(ymin=Anomaly10y - Unc10y,
                     ymax=Anomaly10y + Unc10y),
                 alpha=0.1) +
  geom_line(colour="steelblue") +
  geom_hline(yintercept=0)


p9 <- ggplot(data=climate, aes(x=Year, y=Anomaly10y))
p9 <- p9 + geom_line()
p9 <- p9 + geom_line(aes(y=Anomaly10y - Unc10y, x=Year),
                     colour="red", linetype=2)
p9 <- p9 + geom_line(aes(y=Anomaly10y + Unc10y, x=Year),
                     colour="red", linetype=2)
p9

# Different arrangement of commands to achieve the same result
p10 <- ggplot(data=climate, aes(x=Year, y=Anomaly10y)) +
  geom_line() +
  geom_line(aes(y=Anomaly10y - Unc10y, x=Year),
            colour="red", linetype=2) +
  geom_line(aes(y=Anomaly10y + Unc10y, x=Year),
            colour="red", linetype=2)
p10

#----- Faceting: making graphs based upon groups in the data (usually factors) -----
# trellis plots = faceting
p11 <- ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, colour=Species))
p11 + geom_point(size=2) + facet_grid(. ~ Species) # present Species by row

p11.1 <- ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, colour=Species))
p11.1 + geom_point(size=2) + facet_grid(Species ~ .) # present Species by column

# multi-dimensional faceting - use the diamonds subset again
P12 <- ggplot(data=d2, aes(x=carat, y=price/carat, color=clarity)) +
  geom_point(show.legend=FALSE) +
  facet_grid(cut~color)
P12

p13 <- ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, colour=Species))
p13 + geom_point(size=2) + facet_wrap(. ~ Species, nrow=2, ncol=2) # define the layout


#----- Graph themes -----
# Change the theme
ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point() +
  theme(axis.text.x = element_text(colour = "black",
                                   angle = 90, size = 20),
        axis.line = element_line(colour = "pink", size = 2),
        axis.title.x = element_text(vjust = 2, size = 12),
        panel.background = element_blank())+
  scale_y_continuous(limits = c(0,10))

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) +
  geom_point() +
  theme_bw()+


install.packages("ggthemes")
library(ggthemes)
p14 <- p9 + geom_rangeframe() + theme_tufte()
p14

#----- Save graph to file -----
# saving a graph at high quality
ggsave("Fig12.png", P12, dpi=600, width=20, height=15, units="cm")



#----- Task -----
# TASK: Import this last graph into your favourite Word processor and examine its resolution.


#----- Extension task -----
# TASK: Draw a suitable graph using the diamonds dataset to show whether, or not, the
# 'caret' value of a diamond is related to its physical volume. Save this graph to a file.
# Draw this graph for only one 'colour' class.

head(diamonds)


#----- Interactive graphs -----
# Render a ggplot2 graph in ggplotly to get cool interactivity
# Click on the legend to hide/show categories

library(plotly)

data(iris)

p15 <- ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, colour=Species)) +
  geom_point(size=4)

p15
# Now, the really cool stuff
ggplotly(p15)

#----- ggplot add-on packages -----
# There are many add-on packages for ggplot. They are usually named gg*****.
# For example:
?ggthemes

#-----
# ggplot2 can also handle maps and spatial data.
# You can also arrange multiple graphs on one page (see 'cowplot'),  or
# layer one whole graph over another (graph-in-graph), etc.

# Graphs can also be made animated; or rendered to an interactive web page with 'shiny'.


# Ends.
