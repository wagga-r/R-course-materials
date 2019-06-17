# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Data is in "serial" read format (as can be used by some other packages, e.g. Genstat)


#----- Read serial format data -----
readLines(con="serial_format_data.txt")   # Check what's in the file?

scan(file="Serial_format_data.txt", skip=3, nlines=4) # Check we can read only the bits we want?
scan(file="Serial_format_data.txt", skip=3, nlines=4, what=character())


# The CR/LF characters are ignored
indat <- scan(file="Serial_format_data.txt", skip=3, nlines=4, what=character())
indat

# Split up the single vector into three smaller ones.
hh <- as.numeric(indat[1:6])
ww <- as.numeric(indat[7:12])
gg <- as.numeric(indat[13:18])
pp <- indat[19:24]

# Make a nice neat dataframe.
mydata <- data.frame(Height=hh, Width=ww, Weight=gg, Colour=pp)
mydata

str(mydata)

# Ends.
