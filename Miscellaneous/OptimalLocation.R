# Distance and Price optimization
library(readr)
library(readxl)
library(lubridate)
library(sf)
library(tidyverse)
library(rnaturalearth)
library(svDialogs)
library(ggrepel)
library(tools)
library(scales)

# Load files
Corn_FuturesMarket <- read_csv("Data/Corn_FuturesMarket.csv")
cornBasis = read_csv("Miscellaneous/corn.csv")
citiesCounties = read_excel("Miscellaneous/Cities and Counties.xlsx")
kLocBasisMergeCorn = readRDS("Miscellaneous/KLocBasisMergeCorn.rds")

# Load data saved from the other basis script
Load_Data = function() {
  filePath = choose.files(default = "", caption = "Select RDS Distance File:",
                          multi = FALSE, filters = Filters,
                          index = nrow(Filters))
  
  extenstion = file_ext(filePath)
  
  while (all(extenstion == "rds") == FALSE) {
    if (dlg_message(message = "File is not RDS! Quit?", type = "yesno")[["res"]] == "yes") {
      stop("Program Ending Now.")
    }
    filePath = NA
    extenstion = NA
    filePath = choose.files(default = "", caption = "Select RDS Distance File:",
                            multi = FALSE, filters = Filters,
                            index = nrow(Filters))
    extenstion = file_ext(filePath)
  }
  
  return(filePath)
}

if (dlg_message(message = "Load County Distance Data?", type = "yesno")[["res"]] == "yes") {
  filePath = Load_Data()
  county_Name = file_path_sans_ext(basename(filePath))
  county_Distances = read_rds(filePath)
}

# Clean and merge
county_Distances$County = tolower(county_Distances$County)
county_Distances = rbind(county_Distances, c(tolower(county_Name), 0))
county_Distances$Distance = as.numeric(county_Distances$Distance)
county_Merge = merge(x = kLocBasisMergeCorn, y = county_Distances, by = "County", all = TRUE)

# Makes list that separates each year into its own dataframe
years = c("threeYearAvg", "fiveYearAvg")
commonCols = select(county_Merge, "County", "Distance", "geometry", "Latitude", "Longitude")
County_List = list()
for (Year in years) {
  cols_For_Year = which(grepl(Year, colnames(county_Merge)))
  County_List[[Year]] = data.frame(commonCols,
                                   county_Merge[, c(cols_For_Year)])
  names(County_List[[Year]]) = c("County", "Distance", "geometry", "Latitude", "Longitude", "avgBasis")
}

# Calculate differences between montgomery county and all other counties
# Other_County - Montgomery_County
# Positive means better than Montgomery
get_Differences = function(Data_One_Year) {
  Data_One_Year$Difference = NA
  Data_One_County = Data_One_Year[which(Data_One_Year$County == tolower(county_Name)), ]
  Data_One_Year$Difference = Data_One_Year$avgBasis - Data_One_County$avgBasis
  return(Data_One_Year)
}
County_List = lapply(County_List, get_Differences)

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
  # Data_One_Year$truckingTotal[which(Data_One_Year$County == "montgomery")] = 0
  Data_One_Year$truckingTotal[which(Data_One_Year$County == "carroll")] = 0
  return(Data_One_Year)
}
County_List = lapply(County_List, get_Trucking_Total)

# Calculates net gain/loss
# Basis gain/loss over montgomery + cost to truck (per bushel)
get_Net = function(Data_One_Year) {
  Data_One_Year$net = NA
  Data_One_Year$net = Data_One_Year$Difference + Data_One_Year$truckingTotal
  return(Data_One_Year)
}
County_List = lapply(County_List, get_Net)

# Gets world geographic data
world = ne_countries(scale = "medium", returnclass = "sf")

# Find the best county
best_County = st_as_sf(County_List[["threeYearAvg"]][which(County_List[["threeYearAvg"]]$net == max(County_List[["threeYearAvg"]]$net, na.rm = TRUE)), ], 
                       coords = c("Latitude", "Longitude"), remove = FALSE, crs = 4326, agr = "constant")
best_County$Label = paste(toTitleCase(best_County$County), ": $", round(best_County$net, digits = 2), sep = "")

# Plot first week of 2019
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = County_List[["threeYearAvg"]], aes(fill = net, geometry = geometry)) +
  geom_sf(data = County_List[["threeYearAvg"]]$geometry[which(County_List[["threeYearAvg"]]$County == tolower(county_Name))], fill = "blue") +
  geom_sf(fill = "transparent", color = "#009933", size = 2, data = County_List[["threeYearAvg"]]$geometry[which(County_List[["threeYearAvg"]]$net == max(County_List[["threeYearAvg"]]$net, na.rm = TRUE))]) +
  geom_text_repel(data = best_County, aes(x = Longitude, y = Latitude, label = Label), 
                  fontface = "bold", nudge_x = -1, nudge_y = -0.5, size = 5) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) +
  scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                       limits = c(-max(abs(min(County_List[["threeYearAvg"]]$net, na.rm = TRUE)), abs(max(County_List[["threeYearAvg"]]$net, na.rm = TRUE))) - 0.05,
                                  max(abs(min(County_List[["threeYearAvg"]]$net, na.rm = TRUE)), abs(max(County_List[["threeYearAvg"]]$net, na.rm = TRUE))) + 0.05), 
                       direction = "reverse", breaks = pretty_breaks(10)) +
  ggtitle("Missouri Basis and Trucking Optimization") +
  labs(fill = "Net Gain/Loss (dollars)") +
  theme(plot.title = element_text(hjust = 0.5, size = 30), legend.key.size = unit(2, "cm"))

# Plot
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = County_List[["threeYearAvg"]], aes(fill = net, geometry = geometry)) +
  geom_sf(data = County_List[["threeYearAvg"]]$geometry[which(County_List[["threeYearAvg"]]$County == tolower(county_Name))], fill = "blue") +
  geom_sf(fill = "transparent", color = "yellow", size = 2, data = County_List[["threeYearAvg"]]$geometry[which(County_List[["threeYearAvg"]]$net == max(County_List[["threeYearAvg"]]$net, na.rm = TRUE))]) +
  geom_text_repel(data = best_County, aes(x = Longitude, y = Latitude, label = Label), 
                  fontface = "bold", nudge_x = -1, nudge_y = -0.5, size = 5) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) +
  scale_fill_distiller(palette = "RdYlGn", na.value = "White", limits = c(-1, 0.3),
                       direction = "reverse", breaks = pretty_breaks(10)) +
  ggtitle(paste(county_Name, " County Basis\n and Trucking Optimization", sep = "")) +
  labs(fill = "Net Gain/Loss \n(dollars)") +
  theme(plot.title = element_text(hjust = 0.5, size = 30), legend.key.size = unit(2, "cm"))
