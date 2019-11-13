# Distance and Price optimization
library(readr)
library(readxl)
library(lubridate)
library(tidyverse)
library(rnaturalearth)

# Load files
Corn_FuturesMarket <- read_csv("Data/Corn_FuturesMarket.csv")
Montgomery_Distances_DF = readRDS("Miscellaneous/Montgomery_Distances_DF.rds")
cornBasis = read_csv("Miscellaneous/corn.csv")
citiesCounties = read_excel("Miscellaneous/Cities and Counties.xlsx")
kLocBasisMergeCorn = readRDS("Miscellaneous/KLocBasisMergeCorn.rds")

# Clean and merge
Montgomery_Distances_DF$County = tolower(Montgomery_Distances_DF$County)
Montgomery_Distances_DF = rbind(Montgomery_Distances_DF, c("montgomery", 0))
Montgomery_Distances_DF$Distance = as.numeric(Montgomery_Distances_DF$Distance)
Montgomery_Merge = merge(x = kLocBasisMergeCorn, y = Montgomery_Distances_DF, by = "County", all = TRUE)

# Makes list that separates each year into its own dataframe
years = c("threeYearAvg", "fiveYearAvg")
commonCols = select(Montgomery_Merge, "County", "Distance", "geometry", "Latitude", "Longitude")
Montgomery_List = list()
for (Year in years) {
  cols_For_Year = which(grepl(Year, colnames(Montgomery_Merge)))
  Montgomery_List[[Year]] = data.frame(commonCols,
                                       Montgomery_Merge[, c(cols_For_Year)])
  names(Montgomery_List[[Year]]) = c("County", "Distance", "geometry", "Latitude", "Longitude", "avgBasis")
}

# Calculate differences between montgomery county and all other counties
# Other_County - Montgomery_County
# Positive means better than Montgomery
get_Differences = function(Data_One_Year) {
  Data_One_Year$Difference = NA
  Montgomery_County = Data_One_Year[which(Data_One_Year$County == "montgomery"), ]
  Data_One_Year$Difference = Data_One_Year$avgBasis - Montgomery_County$avgBasis
  return(Data_One_Year)
}

Montgomery_List = lapply(Montgomery_List, get_Differences)

# Define constants
Number_Bushels = 10000
Number_Truck_Loads = ceiling(Number_Bushels / 900)
Cost_Per_Mile = 2.74

# Gets total cost of trucking per bushel
# Montgomery county .15 cent local hauling charge
get_Trucking_Total = function(Data_One_Year) {
  Data_One_Year$Distance = as.numeric(Data_One_Year$Distance)
  Data_One_Year$truckingTotal = NA
  Data_One_Year$truckingTotal = -((Data_One_Year$Distance * Cost_Per_Mile * Number_Truck_Loads) / Number_Bushels) + .15
  Data_One_Year$truckingTotal[which(Data_One_Year$County == "montgomery")] = 0
  return(Data_One_Year)
}

Montgomery_List = lapply(Montgomery_List, get_Trucking_Total)

# Calculates net gain/loss
# Basis gain/loss over montgomery + cost to truck (per bushel)
get_Net = function(Data_One_Year) {
  Data_One_Year$net = NA
  Data_One_Year$net = Data_One_Year$Difference + Data_One_Year$truckingTotal
  return(Data_One_Year)
}

Montgomery_List = lapply(Montgomery_List, get_Net)

# Gets world geographic data
world = ne_countries(scale = "medium", returnclass = "sf")

# Plot first week of 2019
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = Montgomery_List[["threeYearAvg"]], aes(fill = net, geometry = geometry)) +
  geom_sf(data = Montgomery_List[["threeYearAvg"]]$geometry[which(Montgomery_List[["threeYearAvg"]]$County == "montgomery")], fill = "blue") +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) +
  scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                       limits = c(-max(abs(min(Montgomery_List[["threeYearAvg"]]$net, na.rm = TRUE)), abs(max(Montgomery_List[["threeYearAvg"]]$net, na.rm = TRUE))) - 0.05,
                                  max(abs(min(Montgomery_List[["threeYearAvg"]]$net, na.rm = TRUE)), abs(max(Montgomery_List[["threeYearAvg"]]$net, na.rm = TRUE))) + 0.05), direction = "reverse") +
  ggtitle("Missouri") +
  labs(fill = "Net Gain/Loss (dollars)") +
  theme(plot.title = element_text(hjust = 0.5, size = 30))

