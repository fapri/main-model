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

# i = 17
# date = mdy(Corn_CropYearObjects[[1]]$`Marketing Year`$Date[i])
# percentile = Corn_CropYearObjects[[1]]$`Marketing Year`$Percentile[i]
# price = Corn_CropYearObjects[[1]]$`Marketing Year`$Price[i]
# preInterval = Corn_CropYearObjects[[1]]$`Pre/Post Interval`$intervalPre
# postInterval = Corn_CropYearObjects[[1]]$`Pre/Post Interval`$intervalPost



# Checks 5% Drop from Ten Day High
isTenDayHigh = function(date, price, percentile, preInterval, postInterval) {
    
    # Checks if date is NC
    if (date %within% preInterval){
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for NC
      if (is.na(Corn_FeaturesObject$`95% of Ten Day High`[which(Corn_FeaturesObject$`95% of Ten Day High`$Date == date),]$NC)){
        return(F)
      }
      else if (percentile == 95 && price < Corn_FeaturesObject$`95% of Ten Day High`[which(Corn_FeaturesObject$`95% of Ten Day High`$Date == date),]$NC){
        return(T)
      }
      else return(F)
    }
    
    # Checks if date is OC
    if (date %within% postInterval){
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for OC
      if (percentile == 95 && price < Corn_FeaturesObject$`95% of Ten Day High`[which(Corn_FeaturesObject$`95% of Ten Day High`$Date == date),]$OC){
        return(T)
      }
      else return(F)
    }
}







######################################################################################
### BEGINNING OF THE GIANT MESS    
######################################################################################

# Checks...
isAllTimeHigh = function(cropYear) {
  return(FALSE)
}


######################################################################################
### END OF THE GIANT MESS
######################################################################################










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

    else if (isTenDayHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row], cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost)){
      priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                        "Type" = "Ten Day High"))
    }
      
    # else if ath...
  }

  cropYear[['PO Triggers']] = priceObjectiveTriggers
  
  return(cropYear)
}

# Gets the price objective triggers for earch crop year
for(i in 1:length(Corn_CropYearObjects)) {
  Corn_CropYearObjects[[i]] = priceObjectiveTrigger(Corn_CropYearObjects[[i]])
  Corn_CropYearObjects[[i]]$`PO Triggers`$Date = mdy(Corn_CropYearObjects[[i]]$`PO Triggers`$Date)
}





  


