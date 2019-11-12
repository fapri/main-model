# Distance and Price optimization
library(readr)
library(readxl)
library(lubridate)
library(tidyverse)


Corn_FuturesMarket <- read_csv("Data/Corn_FuturesMarket.csv")
Montgomery_Distances_DF = readRDS("Miscellaneous/Montgomery_Distances_DF.rds")

# Load files
cornBasis = read_csv("Miscellaneous/corn.csv")
citiesCounties = read_excel("Miscellaneous/Cities and Counties.xlsx")

kLocBasisMergeCorn = readRDS("Miscellaneous/KLocBasisMergeCorn.rds")

# # Clean text and get cities from K State data frame
# cornBasis$City = gsub(" MO", "", cornBasis$City, fixed = TRUE)
# cornBasis$City = trimws(cornBasis$City, "r")
# cornBasis$City = gsub(".", "", cornBasis$City, fixed = TRUE)
# cornBasis$City = tolower(cornBasis$City)
# 
# # initialize column
# cornBasis$County = NA
# 
# # Standardize data
# citiesCounties$CITY = tolower(citiesCounties$CITY)
# citiesCounties$COUNTY = tolower(citiesCounties$COUNTY)
# citiesCounties$CITY[which(citiesCounties$CITY == "e. prairie")] = "east prairie"
# 
# # Matches counties to K State data
# for (i in seq_len(nrow(citiesCounties))) {
#   tempRows = which(cornBasis$City == citiesCounties$CITY[i])
#   cornBasis$County[tempRows] = as.character(citiesCounties$COUNTY[i])
# }

# Clean and merge
Montgomery_Distances_DF$County = tolower(Montgomery_Distances_DF$County)
Montgomery_Merge = merge(x = kLocBasisMergeCorn, y = Montgomery_Distances_DF, by = "County", all = TRUE)


# # Makes list that separates each year into its own dataframe
# years = c("2014", "2015", "2016", "2017", "2018", "2019")
# commonCols = select(Montgomery_Merge, "County", "Week", "City", "Company", "Distance")
# Montgomery_List = list()
# for (Year in years) {
#   cols_For_Year = which(grepl(Year, colnames(Montgomery_Merge)))
#   Montgomery_List[[Year]] = data.frame(commonCols, 
#                                        Montgomery_Merge[, c(cols_For_Year)])
#   names(Montgomery_List[[Year]]) = c("County", "Week", "City", "Company", "Distance", "Date", "Basis")
# }

# # Gets the average basis for each county for each week
# get_County_Basis_Average = function(Data_One_Year) {
#   
#   Data_One_Year = Data_One_Year %>% 
#     select(-c("City", "Company")) %>%
#     group_by(County, Week, Date) %>%
#     summarise_each(list(mean = ~mean(., na.rm = TRUE))) %>%
#     mutate(Distance_mean = replace(Distance_mean, Distance_mean == "NaN", NA)) %>%
#     mutate(Basis_mean = replace(Basis_mean, Basis_mean == "NaN", NA))
#   
#   colnames(Data_One_Year) = c("County", "Week", "Date", "Distance", "avgBasis")
#   
#   return(Data_One_Year)
# }
# 
# Montgomery_List = lapply(Montgomery_List, get_County_Basis_Average)


# Calculate differences between montgomery county and all other counties
# Other_County - Montgomery_County
# Positive means better than Montgomery
get_Differences = function(Data_One_Year) {
  Data_One_Year$Difference = NA
  Montgomery_County = Data_One_Year[which(Data_One_Year$County == "montgomery"), ]
  
  for (i in 1:48) {
    County_Rows = which(Data_One_Year$Week == i)
    Week_Row = which(Montgomery_County$Week == i)
    Data_One_Year$Difference[County_Rows] = Data_One_Year$avgBasis[County_Rows] - Montgomery_County$avgBasis[Week_Row]
  }
  return(Data_One_Year)
}

Montgomery_List = lapply(Montgomery_List, get_Differences)

# Define constants
Number_Bushels = 10000
Number_Truck_Loads = ceiling(Number_Bushels / 900)
Cost_Per_Mile = 2.74

# Gets total cost of trucking per bushel
get_Trucking_Total = function(Data_One_Year) {
  Data_One_Year$truckingTotal = NA
  Data_One_Year$truckingTotal = -((Data_One_Year$Distance * Cost_Per_Mile * Number_Truck_Loads) / Number_Bushels)
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



# Montgomery county .10-.20 cent local hauling charge
# use .15



# Gets coordinates for Missouri counties
counties = st_as_sf(map("county", plot = FALSE, fill = TRUE))
counties = subset(counties, grepl("missouri", counties$ID))

# Isolates county name
splitCountyState = unlist(strsplit(counties$ID, ","))
splitCountyState = splitCountyState[!splitCountyState %in% "missouri"]

# Atttach county to coordinate data
counties$County = splitCountyState

# Aggregate weekly averages
weeklyAverageList = lapply(names(Montgomery_List), function(x) merge(x = Montgomery_List[[x]], y = counties, by = "County", all = TRUE))
split_tibble = function(tibble, col = 'col') tibble %>% split(., .[,col])
weeklyAverageList = lapply(seq_len(length(weeklyAverageList)), function(x) split_tibble(weeklyAverageList[[x]], 'Week'))









# Gets world geographic data
world = ne_countries(scale = "medium", returnclass = "sf")




# Plot first week of 2019
ggplot(data = world) +
  geom_sf() +
  geom_sf(data = weeklyAverageList[[1]][[1]], aes(fill = net, geometry = geometry)) +
  coord_sf(xlim = c(-96, -89), ylim = c(35.5, 41), expand = FALSE) +
  scale_fill_distiller(palette = "RdYlGn", na.value = "White",
                       limits = c(-max(abs(min(weeklyAverageList[[1]][[1]]$net, na.rm = TRUE)), abs(max(weeklyAverageList[[1]][[1]]$net, na.rm = TRUE))) - 0.05,
                                  max(abs(min(weeklyAverageList[[1]][[1]]$net, na.rm = TRUE)), abs(max(weeklyAverageList[[1]][[1]]$net, na.rm = TRUE))) + 0.05), direction = "reverse") +
  ggtitle("Missouri - Weekly Corn Basis 2019") +
  labs(fill = "Basis (cents)") +
  theme(plot.title = element_text(hjust = 0.5, size = 30))














# stLouis = Montgomery_List[["2019"]][which(Montgomery_List[["2019"]]$County == "st louis"),]
# 
# ggplot(data = stLouis) +
#   geom_line(aes(x = Week, y = net, group = 1))




