#The goal of this assignment Verify you can use Microsoft Copilot / GitHub Copilot Chat alongside RStudio 
#to accelerate—but not replace—your coding.

# ------------------------------
# 1) Paths & file I/O
# ------------------------------

# 1.1 Set working directories -------------------------------------------------
# EDIT THESE for your environment
traindir <- "/Users/mariakasbaoui/Desktop/Data"
sourcedir <- "/Users/mariakasbaoui/Desktop/Source"

stopifnot(dir.exists(traindir))
setwd(traindir)
message("Working directory set to: ", getwd())

# 1.3 Safe CSV read helper ----------------------------------------------------
safe_read <- function(file) {
  # Matches read.csv defaults from class, but robust NA handling
  read.csv(file, na.strings = c("", "NA", "N/A"," NA", "NA "), stringsAsFactors = FALSE)
}

# 1.4 Read the accident CSV ------------------------------------------------
totacts <- safe_read("Railroad_Equipment_Accident_Incident_Source_Data__Form_54__20250907.csv")
# ------------------------------
#Prompts

#Filter the data to include only accidents that occured between the years 2021 and 2024 and name the new dataframe totacts2124
totacts2124 <- subset(totacts, YEAR >= 21 & YEAR <= 24)
#Initially didnt work as intended.
#The prompt worked correctly after the correction "2024 to 24" this is because the data was organized not by the full year but in 21,22,23,24. This was the wrong row name for IYR.
# ------------------------------
#Create a new column in the totacts2124 dataframe that sums TOTINJ + TOTKLD for each accident. Call the column CASINJ.
totacts2124$CASINJ <- totacts2124$TOTINJ + totacts2124$TOTKLD
#Worked correctly the first time.
#Code works to create a new column that adds the columns total injured and total killed to a collective column called casualties. This better helps identifies the crashes by severity.
# ------------------------------
#Convert the two-digit IYR year column to a four-digit year column. Call the new column year.
totacts2124$year <- ifelse(totacts2124$YEAR >= 50, 1900 + totacts2124$YEAR, 2000 + totacts2124$YEAR)
#worked correctly the first time.
#Created a column with the full year instead of the two digit year. This helps with clarity and understanding of the data.

