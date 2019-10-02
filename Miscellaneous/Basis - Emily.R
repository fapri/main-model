library(sf)
library(raster)
library(dplyr)
library(spData)
library(spDataLarge)
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(mapview) # for interactive maps
library(ggplot2) # tidyverse data visualization package
library(shiny)   # for web applications
library(maps)
library(cowplot)
library(googleway)
library(ggspatial)
library(libwgeom)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggrepel)
library(tools)
library(maps)
library(stringi)



mo = map('county', region = 'Missouri')

world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

(sites <- data.frame(longitude = c(-95.76416, -89.08348), latitude = c(35.99894, 40.61698)))

states <- st_as_sf(map("state", plot = FALSE, fill = TRUE))
head(states)
states <- cbind(states, st_coordinates(st_centroid(states)))
states$ID <- toTitleCase(states$ID)
head(states)
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = states, fill = NA) + 
  geom_point(data = sites, aes(x = longitude, y = latitude), size = 4, 
             shape = 23, fill = "darkred") +
  geom_text(data = states, aes(X, Y, label = ID), size = 5) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE)

test <- read_csv("Miscellaneous/test.csv")
test = test[,c(1, 7, 8, 14, 15)]
 
basisCities = stri_extract_first(test$City, regex = "\\w+")
test$City = basisCities

myCityNames <- tolower(test$City)

test$City <- tolower(test$City)

test$County = NA

citiesCounties <- read_excel("Miscellaneous/Cities and Counties.xlsx")

citiesCounties$CITY <- tolower(citiesCounties$CITY)
citiesCounties$COUNTY <- tolower(citiesCounties$COUNTY)

for (i in 1:nrow(citiesCounties)) {
  tempRows = which(test$City == citiesCounties$CITY[i])
  test$County[tempRows] = as.character(citiesCounties$COUNTY[i])
}

counties <- st_as_sf(map("county", plot = FALSE, fill = TRUE))
counties <- subset(counties, grepl("missouri", counties$ID))

splitCountyState = unlist(strsplit(counties$ID, ","))
splitCountyState = splitCountyState[!splitCountyState %in% "missouri"]

counties$County = splitCountyState

averageBasisCounty = aggregate(test[, 3], list(test$County), mean, na.rm = TRUE)
colnames(averageBasisCounty) = c("County", "Basis")

dfMerge <- merge(x = averageBasisCounty, y = counties, by = "County", all = TRUE)

dfMerge$Basis[which(is.na(dfMerge$Basis))] = 0

ggplot(data = world) +
  geom_sf() +
  geom_sf(data = dfMerge, aes(fill = Basis, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE)












