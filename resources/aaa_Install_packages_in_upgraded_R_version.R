# R script to install existing suite of packages in an
# updated version of R.

#----- David Luckett, djluckett@gmail.com, 0408750703 -----

#-----
# In the OLD version of R, save a list of the installed packages to a text file.
# Warning: older versions of this text file will be destroyed.

setwd("~") # Set to R_HOME directory, or use line below
#setwd("C:/Users/david/Documents/")  # Change this line to suit
write.table(installed.packages()[,1],
            row.names=FALSE,
            col.names=FALSE,
            file="Rpackages.txt")

# -----
# Exit from OLD version of R.
# Start NEW version of R, and continue this script from here...

# Select a CRAN repository for Australia (e.g. one at Melbourne University)
# using list that appears on screen (or in console in RStudio); may be a short delay...
chooseCRANmirror()

# Read list of packages to be installed from the previously saved text file

setwd("~") # Set to R_HOME directory, or use line below
# setwd("C:/Users/david/Documents/") # Change this line to suit
packages <- scan("Rpackages.txt", "character")

# Install each of the packages in list (latest version) with all dependencies
# into USER library (not system library). This excludes any packages that are
# already installed.
# This process will take some time....
# Say "no" to installing source packages as this will save time.

# Check that there is a suitable user library path (linked to the version number of the new R)
.libPaths()

user_library <- .libPaths()[1]
install.packages(packages[!(packages %in% installed.packages())],
                 lib=user_library,
                 dependencies=TRUE)

# Ends.
