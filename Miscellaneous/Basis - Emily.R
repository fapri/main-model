library(sf)
library(ggplot2)
library(rnaturalearth)
library(tools)
library(maps)
library(stringi)
library(readxl)
library(readr)

# Load files
test = read_csv("Miscellaneous/test.csv")
citiesCounties = read_excel("Miscellaneous/Cities and Counties.xlsx")

# mo = map('county', region = 'Missouri')

# Gets world geographic data
world = ne_countries(scale = "medium", returnclass = "sf")

# Plot point in a particular location
sites = data.frame(longitude = c(-95.76416, -89.08348), latitude = c(35.99894, 40.61698))

# Gets coordinates for all states
states = st_as_sf(map("state", plot = FALSE, fill = TRUE))
states = cbind(states, st_coordinates(st_centroid(states)))
states$ID = toTitleCase(states$ID)

# Plot Missouri with points
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = states, fill = NA) + 
  geom_point(data = sites, aes(x = longitude, y = latitude), size = 4, 
             shape = 23, fill = "darkred") +
  geom_text(data = states, aes(X, Y, label = ID), size = 5) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE)

# Get cities from K State data frame
test$City = stri_extract_first(test$City, regex = "\\w+")
test$City = tolower(test$City)

# initialize column
test$County = NA

# Standardize data
citiesCounties$CITY = tolower(citiesCounties$CITY)
citiesCounties$COUNTY = tolower(citiesCounties$COUNTY)

# Matches counties to K State data
for (i in 1:nrow(citiesCounties)) {
  tempRows = which(test$City == citiesCounties$CITY[i])
  test$County[tempRows] = as.character(citiesCounties$COUNTY[i])
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

# Gets average basis for each county fo revery year
for (year in requiredYears) {
  years = which(grepl(year, colnames(test)))
  listOfYears[[year]] = test[,c(c(1, 14, 15, 16), c(years))]
  
  if (nrow(averageBasisCounty) == 0) {
    averageBasisCounty = setNames(aggregate(listOfYears[[year]][, 6], list(listOfYears[[year]]$County), mean, na.rm = TRUE), 
                                  c("County", paste("avgBasis", year, sep = "")))
  } else {
    
    temp = setNames(aggregate(listOfYears[[year]][, 6], list(listOfYears[[year]]$County), mean, na.rm = TRUE), 
                    c("County", paste("avgBasis", year, sep = "")))
    averageBasisCounty = merge(x = averageBasisCounty, y = temp, by = "County", all = TRUE)
  }
}

# Merge average basis to geographic coordinates for plotting
dfMerge = merge(x = averageBasisCounty, y = counties, by = "County", all = TRUE)

# Plot baisis
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = dfMerge, aes(fill = avgBasis2019, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(dfMerge$avgBasis2019, na.rm = TRUE)), abs(max(dfMerge$avgBasis2019, na.rm = TRUE))) - 0.05,
                       max(abs(min(dfMerge$avgBasis2019, na.rm = TRUE)), abs(max(dfMerge$avgBasis2019, na.rm = TRUE))) + 0.05)) + 
  ggtitle("Missouri - Corn Basis") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30))







