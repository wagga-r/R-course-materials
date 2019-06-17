# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

#----- Use of quotes in R -----

a <- "David Luckett"
b <- 'Betty Davis'
c = "Nelson Mandela"  # = is not recommended for assignment!
d='short'

a;b;c;d   # semi-colon allows multiple commands on a line

help(Quotes)

#----- Single quotes can be used to enclose double quotes (and visa versa) -----

dd <- '"It\'s alive!", he screamed.'
dd
cat(dd)

help(cat)

ee <- c("   \"It's alive!\", he screamed.   \n\n")
ee
cat(ee)   # The escaped quotes and line-feeds are interpreted in the output.


#----- Control characters can be useful for graph titles -----

ff <- "My Figure 1 Title\nsplit onto two lines"
cat(ff)
plot(1:10, rnorm(10), main=ff)

set.seed(1984)
xx <- c(1:10); yy <- rnorm(10)
ggplot(data=NULL, aes(xx, yy)) + geom_point(size=2) +
  ggtitle(ff) +
  labs(caption="Reference: D.J. Luckett (2018)") +
  theme_bw()
  #theme_base(base_size=12)

# Note: If you have a common or favourite graph format, save it as a customised theme for
# easy use in the future.
# See: https://chrischizinski.github.io/rstats/favorite-themes/


# Ends.
