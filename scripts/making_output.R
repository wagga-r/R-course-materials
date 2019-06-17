# R course at CSU, April 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Output data from R

# Make up some dummy data using common functions
aa <- rep(c(2,3,4), each=2, times=3)
aa

bb <- seq(from=5, to=90, by=5)
bb

cc <- LETTERS[1:18]
cc

my.df <- data.frame(aa,bb,cc)
my.df
str(my.df)

my.df$dd <- my.df$aa+my.df$bb
my.df

#----- ASCII files -----
# write to disk (ASCII files)
# Where are these files going to go?
# In your Rstudio project directory!
getwd()
#setwd("C:/Users/your_name/your_directory/sub_directory_1/sub_directory_2")
dir()

file.exists("my_out_1.csv")

# There is *NO* warning about over-writing an existing file
write.table(my.df, file="Output_ver1.txt")
write.table(my.df, file="Output_ver2.txt", row.names=FALSE)

write.csv(my.df, file="Output_ver3.csv", row.names=FALSE)  # This file is Excel-compatible

#-----
# Write Excel files in .XLSX format (including multiple sheets).

# BEST option:
install.packages("openxlsx")
library(openxlsx)
?openxlsx

# Older package.
install.packages("xlsx")
library(xlsx)
?xlsx

# Depends on your machine having Java installed correctly.
install.packages("XLConnect")
library(XLConnect)
?XLConnect

# Notice how several functions are masked when they are all loaded together.
# Explicity call any that are required.


#----- Binary files for output -----
# Write an object to disk in R binary format.
# This is VERY fast and should be used to save large intermediate data structures
# between analysis sessions (it uses much less disk space).

save(my.df, file="output_ver4.bin")

# If that object gets deleted, we can read it back in
rm(my.df)

# No need for assignment - object names are kept in the binary file.
load("output_ver4.bin")

my.df

#-----
# write entire R session to disk in R binary format.
save.image(file="R_course_CSU.RData")

# Load entire session back in.
load("R_course_CSU.RData")

#----- Task -----
# TASK: Save your imported dataframe into a binary R file. Delete your dataframe!
# Now, re-import your data from the binary file.
# Save your data to a new file in .CSV format.


#----- Extension task -----
# Using two in-built datasets, write both of the dataframes to an Excel file using
# one of the Excel-capable packages. Write each dataframe to a separate sheet.
# Choose sensible Excel sheet names.
# Why is this better than writing multiple .csv files?





#-----
# Another way to produce Word documents uses the 'ReporteRs' package.
# However, it has an annoying Java dependency but give it a try if this
# interests you.

# Export a Table from R to Microsoft Word
# Needs latest version of Java installed on your PC (64 bit, in my case).
# Visit: http://java.com

library(ReporteRs)
library(magrittr)

# Write the file
docx() %>% addFlexTable(my.df %>% FlexTable()) %>% writeDoc(file="Output_tab1_v1.docx")

# Alter the table appearance
docx() %>%
  addFlexTable(my.df %>%
      FlexTable(
        header.cell.props=cellProperties(background.color="#003366"),
        header.text.props=textBold(color = "white"),
        add.rownames = TRUE) %>%
      setZebraStyle(odd="#DDDDDD", even="#FFFFFF")) %>%
  writeDoc(file="Output_tab1_v2.docx")

# Now, check the Word document files.


# Ends.
