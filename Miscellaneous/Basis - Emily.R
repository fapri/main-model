# Load Libraries
library(tidyverse)
library(sf)
library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(rgeos)
library(tools)
library(maps)
library(stringi)
library(readxl)
library(readr)
library(tm)
library(Ckmeans.1d.dp)
library(grid)
library(gridExtra)
library(rhandsontable)
library(cowplot)
library(svDialogs)

# Load files
KStateFile = read.csv(choose.files(default = "", caption = "Select Crop File:",
             multi = FALSE, filters = Filters,
             index = nrow(Filters)))

citiesCounties = read_excel("Miscellaneous/Cities and Counties.xlsx")
countyCenters = read_excel("Miscellaneous/County Centers.xlsx")

# mo = map('county', region = 'Missouri')

# Gets world geographic data
world = ne_countries(scale = "medium", returnclass = "sf")

# Plot point in a particular location
sites = data.frame(longitude = c(-95.76416, -89.08348), latitude = c(35.99894, 40.61698))

# Gets coordinates for all states
states = st_as_sf(map("state", plot = FALSE, fill = TRUE))
states = cbind(states, st_coordinates(st_centroid(states)))
states$ID = toTitleCase(states$ID)

# # Plot Missouri with points
# ggplot(data = world) +
#   geom_sf() +
#   geom_sf(data = states, fill = NA) + 
#   geom_point(data = sites, aes(x = longitude, y = latitude), size = 4, 
#              shape = 23, fill = "darkred") +
#   geom_text(data = states, aes(X, Y, label = ID), size = 5) +
#   coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE)

# Clean text and get cities from K State data frame
KStateFile$City = gsub(" MO", "", KStateFile$City, fixed = TRUE)
KStateFile$City = trimws(KStateFile$City, "r")
KStateFile$City = gsub(".", "", KStateFile$City, fixed = TRUE)
KStateFile$City = tolower(KStateFile$City)

# initialize column
KStateFile$County = NA

# Standardize data
citiesCounties$CITY = tolower(citiesCounties$CITY)
citiesCounties$COUNTY = tolower(citiesCounties$COUNTY)
citiesCounties$CITY[which(citiesCounties$CITY == "e. prairie")] = "east prairie"

# Matches counties to K State data
for (i in seq_len(nrow(citiesCounties))) {
  tempRows = which(KStateFile$City == citiesCounties$CITY[i])
  KStateFile$County[tempRows] = as.character(citiesCounties$COUNTY[i])
}

# Gets coordinates for Missouri counties
counties = st_as_sf(map("county", plot = FALSE, fill = TRUE))
counties = subset(counties, grepl("missouri", counties$ID))

# Isolates county name
splitCountyState = unlist(strsplit(counties$ID, ","))
splitCountyState = splitCountyState[!splitCountyState %in% "missouri"]

# Atttach county to coordinate data
counties$County = splitCountyState

# initialize variables
listOfYears = list()
averageBasisCounty = data.frame()
requiredYears = c("2019", "2018", "2017", "2016", "2015", "2014")

# Gets average basis for each county for every year
for (year in requiredYears) {
  years = which(grepl(year, colnames(KStateFile)))
  listOfYears[[year]] = KStateFile[, c(c(1, 14, 15, 16), c(years))]
  
  if (nrow(averageBasisCounty) == 0) {
    averageBasisCounty = setNames(aggregate(listOfYears[[year]][, 6],
                                            list(listOfYears[[year]]$County), 
                                            mean, na.rm = TRUE), 
                                  c("County", paste("avgBasis", year, sep = "")))
    
  } else {
    
    temp = setNames(aggregate(listOfYears[[year]][, 6], list(listOfYears[[year]]$County), mean, na.rm = TRUE), 
                    c("County", paste("avgBasis", year, sep = "")))
    averageBasisCounty = merge(x = averageBasisCounty, y = temp, by = "County", all = TRUE)
  }
}

# Gets average basis by county by week
weeklyAverages = data.frame()
weeklyAverages = setNames(aggregate(x = KStateFile[, 8:13],
                                    by = list(KStateFile$Week, KStateFile$County),
                                    FUN = mean,
                                    na.rm = TRUE),
                          c("Week", "County", "weeklyBasis2019", "weeklyBasis2018", "weeklyBasis2017", 
                            "weeklyBasis2016", "weeklyBasis2015", "weeklyBasis2014"))

# Merge average basis to geographic coordinates for plotting
yearlyMerge = merge(x = averageBasisCounty, y = counties, by = "County", all = TRUE)

# Replace NaN values with NA
for (column in 2:ncol(averageBasisCounty)) {
  averageBasisCounty[which(is.nan(averageBasisCounty[, column])), column] = NA
}

# Get Weekly Averages
split_tibble = function(tibble, col = 'col') tibble %>% split(., .[,col])
weeklyAverageList = split_tibble(weeklyAverages, 'Week')
weeklyAverageList = lapply(names(weeklyAverageList), function(x) merge(x = weeklyAverageList[[x]], y = counties, by = "County", all = TRUE))

# Format data
countyCenters$County = tolower(countyCenters$County)

# Attach geographical information to basis
yearlyMerge = merge(x = yearlyMerge, y = countyCenters, by = "County", all = TRUE)

################################################################################
# Clustering - Latitude, Longitude, and Basis
################################################################################

kLocBasisMerge = yearlyMerge

# Get 3 and 5 year averages
kLocBasisMerge$threeYearAvg = rowMeans(kLocBasisMerge[, c("avgBasis2019", "avgBasis2018", "avgBasis2017")], na.rm = TRUE)
kLocBasisMerge$fiveYearAvg = rowMeans(kLocBasisMerge[, c("avgBasis2019", "avgBasis2018", "avgBasis2017", "avgBasis2016", "avgBasis2015")], na.rm = TRUE)

# Replace NaN values with NA
kLocBasisMerge$threeYearAvg[which(is.nan(kLocBasisMerge$threeYearAvg))] = NA
kLocBasisMerge$fiveYearAvg[which(is.nan(kLocBasisMerge$fiveYearAvg))] = NA

################################################################################
# Save final RDS for Later
################################################################################

# Export to RDS
if (dlg_message(message = "Export kLocBasisMerge to a RDS?", type = "yesno")[["res"]] == "yes") {
  filename1 = dlgInput("Enter the filename for kLocBasisMerge (without .rds):", Sys.info()["user"])$res
  saveRDS(kLocBasisMerge, paste("Miscellaneous/", filename1, ".rds", sep = ""))
}

if (dlg_message(message = "Export weeklyAverageList to a RDS?", type = "yesno")[["res"]] == "yes") {
  filename1 = dlgInput("Enter the filename for weeklyAverageList (without .rds):", Sys.info()["user"])$res
  saveRDS(weeklyAverageList, paste("Miscellaneous/", filename1, ".rds", sep = ""))
}

