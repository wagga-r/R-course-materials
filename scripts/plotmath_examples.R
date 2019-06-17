# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Fancy text and symbols for plotting

#----- plotmath examples -----

help(plotmath)

# Common ones used in titles or axis labels of graphs
# Superscripts and subscripts can appear crowded when rendered
# unless extra space is inserted

tempdegC <- c(expression(paste( "Temperature ("^{o},"C)" )))
kgperha <-  c(expression(paste( "kg.ha"^{-1 })))
mgperkg <-  c(expression(paste( "mg.kg"^{-1 })))
eminusyx <- c(expression(paste( "e"^{-yx} )))
dmgr <-     c(expression(paste( "DM"[{gr}] )))
c14 <-      c(expression(paste( ""^{14},"C" )))  # Dummy leading empty character string
chu5 <-     c(expression(paste( "CHU"[{5}] )))
fvfm <-     c(expression(paste( "F"[v],"/F"[m])))
fvfmtick <- c(expression(paste( "F"[v],'\'',"/F"[m],'\'')))
my.y.lab <- c(expression(paste( "Ryegrass density (plants.m"^{-2 },")" )))
pirsq <-    c(expression(paste( pi,"r"^{2})))
rsqeq <-    c(expression(italic(paste( "R"^{2}," = 0.78"))))


# Single quote mark, in ASCII=39, in hex=27
# In Windows use: Start>Programs>Accessories>SystemTools>CharacterMap to find
# unicode for a character.

# ?Quotes: Single quotes need to be escaped by backslash in single-quoted strings,
# and double quotes in double-quoted strings.
tick <-     c(expression(paste("tick ",'\'')))
nickname <- c(expression(paste("Billy ","\"","Bulldog","\""," Smith")))

bnn <-      c(expression(bold(paste("Billy ","\"","Bulldog","\""," Smith"))))
inn <-      c(expression(italic(paste("Billy ","\"","Bulldog","\""," Smith"))))

plot.new()
rect(0,0,1,1)
text(x=0.4, y=0.10, tempdegC)
text(x=0.4, y=0.15, kgperha)
text(x=0.4, y=0.20, mgperkg)
text(x=0.4, y=0.25, eminusyx)
text(x=0.4, y=0.30, dmgr)
text(x=0.4, y=0.35, c14)
text(x=0.4, y=0.40, chu5)
text(x=0.4, y=0.45, fvfm)
text(x=0.4, y=0.50, tick)
text(x=0.4, y=0.55, fvfmtick)
text(x=0.4, y=0.60, my.y.lab)
text(x=0.4, y=0.65, pirsq)
text(x=0.4, y=0.70, nickname)
text(x=0.4, y=0.75, bnn)
text(x=0.4, y=0.80, inn)
text(x=0.4, y=0.90, rsqeq)

# How to substitute a calculated value as an object into a plotmath string
myval <- 0.7654
myval2 <- 0.6878
new1 <- bquote(italic(R^2 == .(myval)))
new2 <- bquote(Adjusted~italic(R^2) == .(myval2))

plot.new()
rect(0,0,1,1)
text(x=0.4, y=0.20, new1)
text(x=0.4, y=0.40, new2)

#------------------------------------------------------------
# Do fancy text strings work as axis labels in all plotting packages?
# YES!

# Make-up some dummy data
xx <- c(1:10)
yy <- c(11:20)

(new.df <- data.frame(xx,yy))

plot(xx, yy, xlab=tempdegC)   # base graphics

ggplot(data=new.df, aes(xx, yy)) +  # ggplot2 graphics
       geom_point() +
       scale_x_continuous(tempdegC)

library(lattice)
xyplot(yy~xx, xlab=tempdegC)  # lattice graphics

#----- Task -----
# TASK: Create a plotmath string showing "tonnes per metre squared" using correct
# scientific journal format.
# Use that string to label an axis in a graph.


#----- Extension task -----
# Create a plotmath string that shows the volume of a sphere.
# Output that string as the title in a ggplot graph.


# Ends.

