# Distance and Price optimization
library(readr)
library(readxl)
library(lubridate)
library(tidyverse)


Corn_FuturesMarket <- read_csv("Data/Corn_FuturesMarket.csv")
Montgomery_Distances_DF = readRDS("Miscellaneous/Montgomery_Distances_DF.rds")

# Load files
cornBasis = read_csv("Miscellaneous/test.csv")
citiesCounties = read_excel("Miscellaneous/Cities and Counties.xlsx")

# Clean text and get cities from K State data frame
cornBasis$City = gsub(" MO", "", cornBasis$City, fixed = TRUE)
cornBasis$City = trimws(cornBasis$City, "r")
cornBasis$City = gsub(".", "", cornBasis$City, fixed = TRUE)
cornBasis$City = tolower(cornBasis$City)

# initialize column
cornBasis$County = NA

# Standardize data
citiesCounties$CITY = tolower(citiesCounties$CITY)
citiesCounties$COUNTY = tolower(citiesCounties$COUNTY)
citiesCounties$CITY[which(citiesCounties$CITY == "e. prairie")] = "east prairie"

# Matches counties to K State data
for (i in seq_len(nrow(citiesCounties))) {
  tempRows = which(cornBasis$City == citiesCounties$CITY[i])
  cornBasis$County[tempRows] = as.character(citiesCounties$COUNTY[i])
}

# Clean and merge
Montgomery_Distances_DF$County = tolower(Montgomery_Distances_DF$County)
Montgomery_Merge = merge(x = cornBasis, y = Montgomery_Distances_DF, by = "County", all = TRUE)
Corn_FuturesMarket$Date = mdy(Corn_FuturesMarket$Date)

# Makes list that separates each year into its own dataframe
years = c("2014", "2015", "2016", "2017", "2018", "2019")
commonCols = select(Montgomery_Merge, "County", "Week", "City", "Company", "Distance")
Montgomery_List = list()
for (Year in years) {
  cols_For_Year = which(grepl(Year, colnames(Montgomery_Merge)))
  Montgomery_List[[Year]] = data.frame(commonCols, 
                                       Montgomery_Merge[, c(cols_For_Year)])
  names(Montgomery_List[[Year]]) = c("County", "Week", "City", "Company", "Distance", "Date", "Basis")
}

# Gets the average basis for each county for each week
get_County_Basis_Average = function(Data_One_Year) {
  
  Data_One_Year = Data_One_Year %>% 
    select(-c("City", "Company")) %>%
    group_by(County, Week, Date) %>%
    summarise_each(list(mean = ~mean(., na.rm = TRUE))) %>%
    mutate(Distance_mean = replace(Distance_mean, Distance_mean == "NaN", NA)) %>%
    mutate(Basis_mean = replace(Basis_mean, Basis_mean == "NaN", NA))
  
  colnames(Data_One_Year) = c("County", "Week", "Date", "Distance", "avgBasis")
  
  return(Data_One_Year)
}

Montgomery_List = lapply(Montgomery_List, get_County_Basis_Average)


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









# stLouis = Montgomery_List[["2014"]][which(Montgomery_List[["2014"]]$County == "st louis"),]
# 
# ggplot(data = stLouis) + 
#   geom_line(aes(x = Week, y = net, group = 1))





# match_Futures_Prices = function(basis_List_Element) {
#   initial_Merge = merge.data.frame(x = basis_List_Element, y = Corn_FuturesMarket, by = "Date", all.x = TRUE)
#   
#   # TODO Checking which dates need to be added which did not match
#   if (length(which(!is.na(initial_Merge$Date) & is.na(initial_Merge$NearbyOC))) > 0) {
#     dates_To_Find = unique(initial_Merge$Date[which(!is.na(initial_Merge$Date) & is.na(initial_Merge$NearbyOC))])
#     
#     replacement_Date = Corn_FuturesMarket$Date[which(abs(Corn_FuturesMarket$Date - dates_To_Find) == 
#                                                        min(abs(Corn_FuturesMarket$Date - dates_To_Find)))[1]]
#     
#     rows_To_Replace = which(!is.na(initial_Merge$Date) & is.na(initial_Merge$NearbyOC))
#     
#     row_To_Copy = Corn_FuturesMarket[which(Corn_FuturesMarket$Date == replacement_Date), c("NearbyOC", "DecNC", "DecNC1yr", "DecNC2yr", "MarNC")]
#     
#     rows_Replaced = row_To_Copy %>% slice(rep(1:n(), each = length(rows_To_Replace)))
#     
#     initial_Merge[rows_To_Replace, c("NearbyOC", "DecNC", "DecNC1yr", "DecNC2yr", "MarNC")] = rows_Replaced
#   }
#   
#   return(initial_Merge)
# }
# 
# Montgomery_List = lapply(Montgomery_List, match_Futures_Prices)















# 2.74 per loaded mile to truck grain one way

# Montgomery_Merge$costToTruck = 



