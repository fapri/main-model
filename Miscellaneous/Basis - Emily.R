library(sf)
library(ggplot2)
library(rnaturalearth)
library(tools)
library(maps)
library(stringi)
library(readxl)
library(readr)
library(tm)

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

# Clean text and get cities from K State data frame
test$City = gsub("MO", "", test$City, fixed = TRUE)
test$City = trimws(test$City, "r")
test$City = gsub(".", "", test$City, fixed = TRUE)
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

# Gets average basis for each county for every year
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

# Gets average basis by county by week
weeklyAverages = data.frame()
weeklyAverages = setNames(aggregate(x = test[, 8:13],
                                    by = list(test$Week, test$County),
                                    FUN = mean,
                                    na.rm = TRUE),
                          c("Week", "County", "weeklyBasis2019", "weeklyBasis2018", "weeklyBasis2017", 
                            "weeklyBasis2016", "weeklyBasis2015", "weeklyBasis2014"))

# Merge average basis to geographic coordinates for plotting
yearlyMerge = merge(x = averageBasisCounty, y = counties, by = "County", all = TRUE)

split_tibble <- function(tibble, col = 'col') tibble %>% split(., .[,col])
weeklyAverageList = split_tibble(weeklyAverages, 'Week')
weeklyAverageList = lapply(names(weeklyAverageList), function(x) merge(x = weeklyAverageList[[x]], y = counties, by = "County", all = TRUE))

# Plot basis 2019
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = yearlyMerge, aes(fill = avgBasis2019, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(yearlyMerge$avgBasis2019, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2019, na.rm = TRUE))) - 0.05,
                                  max(abs(min(yearlyMerge$avgBasis2019, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2019, na.rm = TRUE))) + 0.05), direction = "reverse") + 
  ggtitle("Missouri - Corn Basis 2019") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30))

# Plot basis 2018
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = yearlyMerge, aes(fill = avgBasis2018, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(yearlyMerge$avgBasis2018, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2018, na.rm = TRUE))) - 0.05,
                                  max(abs(min(yearlyMerge$avgBasis2018, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2018, na.rm = TRUE))) + 0.05), direction = "reverse") + 
  ggtitle("Missouri - Corn Basis 2018") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30))

# Plot basis 2017
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = yearlyMerge, aes(fill = avgBasis2017, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(yearlyMerge$avgBasis2017, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2017, na.rm = TRUE))) - 0.05,
                                  max(abs(min(yearlyMerge$avgBasis2017, na.rm = TRUE)), abs(max(yearlyMerge$avgBasis2017, na.rm = TRUE))) + 0.05), direction = "reverse") + 
  ggtitle("Missouri - Corn Basis 2017") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30))

# Plot first week of 2019
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = weeklyAverageList[[1]], aes(fill = weeklyBasis2019, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                       limits = c(-max(abs(min(weeklyAverageList[[1]]$weeklyBasis2019, na.rm = TRUE)), abs(max(weeklyAverageList[[1]]$weeklyBasis2019, na.rm = TRUE))) - 0.05,
                                  max(abs(min(weeklyAverageList[[1]]$weeklyBasis2019, na.rm = TRUE)), abs(max(weeklyAverageList[[1]]$weeklyBasis2019, na.rm = TRUE))) + 0.05), direction = "reverse") + 
  ggtitle("Missouri - Weekly Corn Basis 2019") +
  labs(fill = "Basis (cents)") + 
  theme(plot.title = element_text(hjust = 0.5, size = 30))

# Save all weekly plots for 2019
for (week in 1:length(weeklyAverageList)) {
  plots[[week]] = ggplot(data = world) +
    geom_sf() +
    geom_sf(data = weeklyAverageList[[week]], aes(fill = weeklyBasis2019, geometry = geometry)) +
    coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) + 
    scale_fill_distiller(palette = "RdYlGn", na.value = "White", 
                         limits = c(-max(abs(min(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE)), abs(max(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE))) - 0.05,
                                    max(abs(min(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE)), abs(max(weeklyAverageList[[week]]$weeklyBasis2019, na.rm = TRUE))) + 0.05), direction = "reverse") + 
    ggtitle("Missouri - Weekly Corn Basis 2019") +
    labs(fill = "Basis (cents)") + 
    theme(plot.title = element_text(hjust = 0.5, size = 30))
}









