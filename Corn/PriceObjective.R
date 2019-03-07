# Corn
# Price Objective

# Create the corn objects necessary to run the Price Objective strategy
source('Corn/Main.R')

# TODO EVENTUALLY WE CAN MOVE THESE TRIGGER FUNCTIONS TO ANOTHER FILE/FOLDER.
# THEY ARE NOT DEPENDENT TO CORN

# Checks if currentDayPercentile is a price objective trigger
isPriceObjective = function(previousDayPercentile, currentDayPercentile) {
  # Check the first day of the crop year
  if(is.null(previousDayPercentile)) {
    if(currentDayPercentile >= 70) return(TRUE)
    else return(FALSE)
  } 
  # Check all subsequent days
  else if(previousDayPercentile >= 70 && previousDayPercentile < currentDayPercentile)
      return(TRUE)
  
  return(FALSE)
}

# Checks...
isAllTimeHigh = function(cropYear) {
  return(FALSE)
}

# Checks...
isTenDayHigh = function(cropYear) {
  return(FALSE)
}

# Finds all of the price objective triggers for a given crop year
priceObjectiveTrigger = function(cropYear) {
  priceObjectiveTriggers = data.frame()
  
  marketingYear = cropYear[['Marketing Year']]

  if(isPriceObjective(NULL, marketingYear$Percentile[1])) {
    priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[1], 
                                                                      "Percentile" = marketingYear$Percentile[1],
                                                                      "Type" = "Price Objective"))
  }
  
  for(row in 2:nrow(marketingYear)) {
    if(isPriceObjective(marketingYear$Percentile[row - 1], marketingYear$Percentile[row])) {
      priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                        "Type" = "Price Objective"))
    }
    # else if ath...
    # else if tdh...
  }

  cropYear[['PO Triggers']] = priceObjectiveTriggers
  
  return(cropYear)
}

# Gets the price objective triggers for earch crop year
for(i in 1:length(Corn_CropYearObjects)) {
  Corn_CropYearObjects[[i]] = priceObjectiveTrigger(Corn_CropYearObjects[[i]])
}
