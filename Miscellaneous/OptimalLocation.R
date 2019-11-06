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

Montgomery_Distances_DF$County = tolower(Montgomery_Distances_DF$County)

Montgomery_Merge = merge(x = cornBasis, y = Montgomery_Distances_DF, by = "County", all = TRUE)


Corn_FuturesMarket$Date = mdy(Corn_FuturesMarket$Date)

years = c("2014", "2015", "2016", "2017", "2018", "2019")
commonCols = select(Montgomery_Merge, "County", "Week", "City", "Company", "Distance")
Montgomery_List = list()
for (Year in years) {
  cols_For_Year = which(grepl(Year, colnames(Montgomery_Merge)))
  Montgomery_List[[Year]] = data.frame(commonCols, 
                                       Montgomery_Merge[, c(cols_For_Year)])
  names(Montgomery_List[[Year]]) = c("County", "Week", "City", "Company", "Distance", "Date", "Basis")
}

match_Futures_Prices = function(basis_List_Element) {
  initial_Merge = merge.data.frame(x = basis_List_Element, y = Corn_FuturesMarket, by = "Date", all.x = TRUE)
  
  # TODO Checking which dates need to be added which did not match
  if (length(which(!is.na(initial_Merge$Date) & is.na(initial_Merge$NearbyOC))) > 0) {
    dates_To_Find = unique(initial_Merge$Date[which(!is.na(initial_Merge$Date) & is.na(initial_Merge$NearbyOC))])
    
    replacement_Date = Corn_FuturesMarket$Date[which(abs(Corn_FuturesMarket$Date - dates_To_Find) == 
                                                       min(abs(Corn_FuturesMarket$Date - dates_To_Find)))[1]]
    
    rows_To_Replace = which(!is.na(initial_Merge$Date) & is.na(initial_Merge$NearbyOC))
    
    row_To_Copy = Corn_FuturesMarket[which(Corn_FuturesMarket$Date == replacement_Date), c("NearbyOC", "DecNC", "DecNC1yr", "DecNC2yr", "MarNC")]
    
    rows_Replaced = row_To_Copy %>% slice(rep(1:n(), each = length(rows_To_Replace)))
    
    initial_Merge[rows_To_Replace, c("NearbyOC", "DecNC", "DecNC1yr", "DecNC2yr", "MarNC")] = rows_Replaced
  }
  
  return(initial_Merge)
}

Montgomery_List = lapply(Montgomery_List, match_Futures_Prices)


basis_List_Element = Montgomery_List[[1]]


# "2014"
# "2015"
# "2016"
# "2017"
"2018"
"2019"




# 2.74 per loaded mile to truck grain one way

# Montgomery_Merge$costToTruck = 



