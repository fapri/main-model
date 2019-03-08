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





######################################################################################
### BEGINNING OF THE GIANT MESS    
######################################################################################



TDHTriggers = NA

# Checks 5% Drop from Ten Day High
isTenDayHigh = function(marketingYear, preInterval, postInterval, TDH) {
  

    # Checks if date is NC
    if (mdy(marketingYear$Date[i]) %within% preInterval){
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for NC
      if (is.na(TDH$NC[i])){
        next
      }
      else if (marketingYear$Percentile[i] == 95 && marketingYear$Price[i] < TDH$NC[i]){
        TDHTriggers[i] = marketingYear$Date[i]
      }
      else next
    }
    
    # Checks if date is OC
    if (mdy(marketingYear$Date[i]) %within% postInterval){
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for OC
      if (marketingYear$Percentile[i] == 95 && marketingYear$Price[i] < TDH$NC[i]){
        TDHTriggers[i] = marketingYear$Date[i]
      }
      else next
    }
  }

  # TDHTriggers = list()
  
  return(TDHTriggers)
}


for(row in 2:nrow(marketingYear)) {


for(i in 1){
  TDHTriggers_out = isTenDayHigh(Corn_CropYearObjects[[i]]$`Marketing Year`, Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPre,
                                Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPost, Corn_FeaturesObject$`95% of Ten Day High`)
  
}




#############
# marketingYear = Corn_CropYearObjects[[i]]$`Marketing Year`
# preInterval = Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPre
# postInterval = Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPost
# TDH = Corn_FeaturesObject$`95% of Ten Day High`






# Checks 5% Drop from Ten Day High
isTenDayHigh = function(marketingYear, preInterval, postInterval, TDH) {
  
  
  # Goes through number of rows in the marketing year
  for(i in 1:nrow(Corn_CropYearObjects[[1]]$`Marketing Year` = "marketingYear")){
    # Checks if date is NC
    if (Corn_CropYearObjects[[1]]$`Marketing Year`$Date[i] = "marketingYear$Date[i]" %within% Corn_CropYearObjects[[1]]$`Pre/Post Interval`$intervalPre = "preInterval"){
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for NC
      if (is.na(Corn_FeaturesObject$`95% of Ten Day High`$NC[i]) = "TDC$NC[i]"){
        return(FALSE)
      }
      else if (Corn_CropYearObjects[[1]]$`Marketing Year`$Percentile[i] = "marketingYear$Percentile[i]" == 95 && Corn_CropYearObjects[[1]]$`Marketing Year`$Price[i] = "marketingYear$Price[i]" < Corn_FeaturesObject$`95% of Ten Day High`$NC[i] = "TDH$NC[i]"){
        return(TRUE)
      }
      else return(FALSE)
    }

    # Checks if date is OC
    if (Corn_CropYearObjects[[1]]$`Marketing Year`$Date[i] = "marketingYear$Date[i]" %within% Corn_CropYearObjects[[1]]$`Pre/Post Interval`$intervalPost = "postInterval"){
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for OC
      if (Corn_CropYearObjects[[1]]$`Marketing Year`$Percentile[i] = "marketingYear$Percentile[i]" == 95 && Corn_CropYearObjects[[1]]$`Marketing Year`$Price[i] < Corn_FeaturesObject$`95% of Ten Day High`$OC[i] = "TDH$NC[i]"){
        return(TRUE)
      }
      else return(FALSE)
    }
  }
  
  return(FALSE)
}



######################################################################################
### END OF THE GIANT MESS
######################################################################################





# Checks...
isAllTimeHigh = function(cropYear) {
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
    # else if TDH
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






