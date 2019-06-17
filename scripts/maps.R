# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Using on-line maps in R
# Example taken for R-bloggers website post

# May need to get the latest verson of ggmap 2.7 from GitHub
install.packages("devtools")
library(devtools)
devtools::install_github("dkahle/ggmap")


# In order to access the Google maps API, you need a registered key.
# When you register you need to give a credit card number but you get a large free allocation.
library(ggmap)

help(ggmap)
?register_google

# The first example specifies the longitude and latitude close to the
# London 2012 Olympic park from Google and selects the satellite map type.

mapImageData1 <- get_map(location = c(lon = -0.016179, lat = 51.538525),
                         color = "color",
                         source = "google",
                         maptype = "satellite",
                         zoom = 17)

ggmap(mapImageData1,
    extent = "device",
    ylab = "Latitude",
    xlab = "Longitude")


# The second example is a roadmap and is uncluttered and provides an overview
# of the surroundings.

mapImageData2 <- get_map(location = c(lon = -0.016179, lat = 51.538525),
    color = "color",
    source = "google",
    maptype = "roadmap",
    zoom = 16)

ggmap(mapImageData2,
    extent = "device",
    ylab = "Latitude",
    xlab = "Longitude")


# Other examples taken from help(get_map)

USA <- c(left = -125, bottom = 25.75, right = -67, top = 49)
map1 <- get_map(location=USA, zoom=5, maptype="toner-lite", source="stamen")
ggmap(map1)

map2 <- get_map(location=USA, zoom=4, maptype="terrain", source="google")
ggmap(map2)


#-----
# Try Wagga Wagga
# -35.0537, 147.3477

# Maps require a lot of data - do some clean_up first.
rm(mapImageData1, mapImageData2, map1, map2)
rm(waggamap1)
gc()

waggamap1 <- get_map(location= c(lon=147.3477, lat=-35.0537),
                     color="bw",
                     source="google",
                     maptype="roadmap",
                     zoom=12)

ggmap(waggamap1,
      extent="device",
      ylab="Latitude",
      xlab="Longitude")


# Let's add some points to our Wagga map.
# Make a data frame with the long/lat of three sites and their names
myplaces <- data.frame(name=c("One","Two","Three"),
                       longitude=c(147.30, 147.33, 147.40),
                       latitude=c(-35.00, -35.06, -35.04))
myplaces

# Draw the map as a layer
map1 <- ggmap(waggamap1,
              extent="device",
              ylab="Latitude",
              xlab="Longitude")

# Add the points to the map
map1 <- map1 + geom_point(data=myplaces,
                          aes(x=longitude, y=latitude), size=3, col="red")

# Add the labels for the points
map1 + geom_text(data=myplaces, aes(label=name, x=longitude+0.005, y=latitude),
                 hjust=0, size=4)

#----- OpenStreetMap package -----
# It has a Java dependency which can cause problems on some machines.

install.packages("OpenStreetMap")
library(OpenStreetMap)

map2 <- openmap(c(-34.5, 146), c(-35.5, 148), type="osm")
autoplot(map2)


#----- Australian outline maps -----
# Outline maps of Australia (coastline and state/territory boundaries)
# This is using base graphics.

install.packages("oz")
library(oz)
?oz
oz()                    # the lot
oz(states=FALSE)        # coastlines only
oz(sections=6)          # Tasmania
oz(sections=c(7,8,10,12,14,16))         # South Australia
oz(sections=c(3,11:13), visible=c(3,13))# Queensland with just coast and border with NSW.

# Outline of NSW
oz(sections=c(4,13,14,15))


# Read-in locations of some towns/cities (collected manually from Google maps):
towns.df <- read.table(header=TRUE, sep=" ",
colClasses=c("character","numeric","numeric"), text="
Name Lat Long
Culcairn -35.667278 147.037066
'Pleasant Hills' -35.466271 146.792148
Matong -34.767834 146.919248
Ardlethan -34.356791 146.899787
Temora -34.448038 147.534551
Junee -34.869157 147.583307
Cootamundra -34.640868 148.027017
Sydney -33.855676 151.213570
Canberra -35.281913 149.128799
")

towns.df
str(towns.df)

# Draw the NSW map with limits
oz(sections=c(5,4,13,14,15), xlim=c(145,151.5), ylim=c(-37.5,-33.5))

points(towns.df$Long, towns.df$Lat, col="black", pch=16, cex=1)

# Plot names
text(towns.df$Long, towns.df$Lat,
     cex=0.8, font=6,
     labels=c(towns.df$Name), pos=4, offset=0.4)

# Plot names USING specified positions
# pos=1 below point
# pos=2 left of point
# pos=3 above point
# pos=4 right of point

# Re-draw the other bits first.
text(towns.df$Long, towns.df$Lat,
     cex=0.8, font=6,
     labels=c(towns.df$Name),
     pos=c(4,4,2,3,4,4,4,2,4), offset=0.4)

towns.df

# Plot ocean name
text(y=-36, x=150.8, cex=1, font=6, labels=c("Tasman\nSea"))

# Scale
# 200 km = 108 nautical miles = 1.8 degrees of lat or long
ylin <- c(-37,-37)
xlin <- c(145,146.8)
lines(x=xlin, y=ylin, type="l", lwd=2)
text(x=145.9, y=-36.8, label="Scale: 200 km", cex=0.9, font=6)

# Add state names on boundry as angled text
text(y=-36.9, x=149.0, srt=-29, label="New South Wales", font=6, cex=0.8)
text(y=-37.15, x=149.0, srt=-29, label="Victoria", font=6, cex=0.8)

# Add a box around the plot
box()

# Add a North arrow
arrows(x0=c(145), x1=c(145), y0=c(-35.5), y1=c(-34.5),
       length=0.2, lwd=2)
text(x=145, y=-34.2, label="N", font=7, cex=1.5)

# You can also load and plot shape files (at any scale)


# Save a map at high-resolution in PNG format
png(file="fig1-png600.png", res=600, width=4800, height=4800, pointsize=10,
    type="windows", antialias="cleartype")
  #
  # Insert code here to draw the map (as above)
  #
dev.off()

# This png file can then be inserted into a Word or HTML document.
# If the map was produced in ggplot then use ggsave().


#----- Using shape files -----
# R can read *ANY* shape files or GIS files, then draw maps or diagrams.

library(rgdal)
# Read shapefile ('SHP') containing NSW local government boundaries.
# Downloaded as a ZIP file from:
# https://data.gov.au/dataset/nsw-local-government-areas

nswlg <- readOGR(dsn="C:/Users/David/Documents/NSW_local_govt_shape_files/NSW_LGA_POLYGON_shp.shp")

# Looks like 197 polygons (areas) with 10 descriptors
dim(nswlg)
summary(nswlg)

plot(nswlg)

nswlg$NSW_LGA__3   # What are the area names?

plot(nswlg[nswlg$NSW_LGA__3=="WAGGA WAGGA",])

# If you have coordinates you can make your own shape file e.g. the boundaries of a farm,
# paddock, national park, etc.

#----- Use shape files from the net -----
# Download a dataset on-the-fly from the internet.
# Victorian State Government "OVERSIZE AGRICULTURAL VEHICLES CLASS1 Zones"
# Why? Because you can, and its fun to learn how!

install.packages("devtools")
library(devtools)
install_github("ropensci/geojsonio")

library(geojsonio)

# Convert the data to a spatial object on download
vicvl <- geojson_read(x="https://opendata.arcgis.com/datasets/5d9b5ae32c2c4e50b39bf772018ce6de_31.geojson", method="local", parse=TRUE, what="sp")

class(vicvl)

plot(vicvl)

# R's default colours can be poor - get decent palettes with RColorBrewer.
# Essential to produce colour-blind-friendly graphics.

install.packages("RColorBrewer")
library(RColorBrewer)
my_palette <- brewer.pal(9, "YlGn")

plot(vicvl, col=my_palette)

#----- Task -----
# TASK: download a map of your home town, and plot that map on the screen.

#----- Extension task -----
# Draw a symbol on the map showing where your school was located.
# Label that point with some text.


# Ends.
