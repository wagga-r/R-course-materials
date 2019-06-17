# Plotmath and special (named) symbols in R

library(cli)
cat(symbol$tick, " SUCCESS\n", symbol$cross, " FAILURE\n", sep = "")

# All symbols (note: on Windows some have a fallback to less fancy symbols)
# *** These only work on the command-line, NOT when plotting.
cat(paste(format(names(symbol), width = 20),
          unlist(symbol)), sep = "\n")

#-----
help(plotmath)  # See examples at the bottom
demo(plotmath)

# my previous example
tempdegC <- c(expression(paste( "Temperature ("^{o},"C)" )))

plot.new()
rect(0,0,1,1)
text(x=0.4, y=0.10, tempdegC)

# new version using symbol name (output looks nicer)
t1 <- c(expression(paste("Temperature (", degree,"C)" )))
text(x=0.4, y=0.20, t1)

# symbol$xxxxx things only work on command line.
t2 <- c(expression(paste("Temperature", degree, symbol$tick, symbol$square )))
text(x=0.4, y=0.30, t2)


#----
# What about including unicode symbols or hex/octal specification?

## some other useful symbols
plot.new(); plot.window(c(0,4), c(15,1))
text(1, 1, "universal", adj = 0); text(2.5, 1,  "\\042")
text(3, 1, expression(symbol("\042")))
text(1, 2, "existential", adj = 0); text(2.5, 2,  "\\044")
text(3, 2, expression(symbol("\044")))
text(1, 3, "suchthat", adj = 0); text(2.5, 3,  "\\047")
text(3, 3, expression(symbol("\047")))
text(1, 4, "therefore", adj = 0); text(2.5, 4,  "\\134")
text(3, 4, expression(symbol("\134")))
text(1, 5, "perpendicular", adj = 0); text(2.5, 5,  "\\136")
text(3, 5, expression(symbol("\136")))
text(1, 6, "circlemultiply", adj = 0); text(2.5, 6,  "\\304")
text(3, 6, expression(symbol("\304")))
text(1, 7, "circleplus", adj = 0); text(2.5, 7,  "\\305")
text(3, 7, expression(symbol("\305")))
text(1, 8, "emptyset", adj = 0); text(2.5, 8,  "\\306")
text(3, 8, expression(symbol("\306")))
text(1, 9, "angle", adj = 0); text(2.5, 9,  "\\320")
text(3, 9, expression(symbol("\320")))
text(1, 10, "leftangle", adj = 0); text(2.5, 10,  "\\341")
text(3, 10, expression(symbol("\341")))
text(1, 11, "rightangle", adj = 0); text(2.5, 11,  "\\361")
text(3, 11, expression(symbol("\361")))

# Ends.