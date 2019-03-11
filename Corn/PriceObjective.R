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
  else if(currentDayPercentile >= 70 && previousDayPercentile < currentDayPercentile)
      return(TRUE)
  
  return(FALSE)
}

# Checks 5% Drop from Ten Day High
isTenDayHigh = function(date, price, percentile, preInterval, postInterval, TDH) {
    
    # Checks if date is NC
    if (date %within% preInterval){
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for NC
      if (is.na(TDH[which(TDH$Date == date),]$NC)){
        return(F)
      }
      else if (percentile == 95 && price < TDH[which(TDH$Date == date),]$NC){
        return(T)
      }
      else return(F)
    }

    # Checks if date is OC
    else if (date %within% postInterval){
      # Checks if the price is in 95 percentile.
      # Checks if the price is > 95%TDH for OC
      if (percentile == 95 && price < TDH[which(TDH$Date == date),]$OC){
        return(T)
      }
      else return(F)
    }
}

# Checks All Time High
isAllTimeHigh = function(date, price, percentile, preInterval, postInterval, TDH, ATH) {
  
  #Checks if date is NC
  if (date %within% preInterval){
    # Checks if the price is in 95 percentile.
    # Checks if the price is > 95%TDH for NC
    if (is.na(TDH[which(TDH$Date == date),]$NC)){
      return(F)
    }
    else if (((price - ATH[which(ATH$Date == date),]$NC) > (-1)) && price < TDH[which(TDH$Date == date),]$NC){
      return(T)
    }
    else return(F)
  }
  
  # Checks if date is OC
  else if (date %within% postInterval){
    # Checks if the price is in 95 percentile.
    # Checks if the price is > 95%TDH for OC
    if (((price - ATH[which(ATH$Date == date),]$OC) > (-1)) && price < TDH[which(TDH$Date == date),]$OC){
      return(T)
    }
    else return(F)
  }
}

# Checks End of the Year Trailing Stop
isEndYearTrailingStop = function(date, previousPercentile, currentPercentile, postInterval){
  
  # checks if date is in June
  if (month(date) >=6 && year(date) == year(int_end(postInterval))){
    # Checks if Market passes down a percentile
    if (currentPercentile < previousPercentile && currentPercentile >= 60){
      return(T)
    }
    else return(F)
  }
  else return(F)
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

    else if (isTenDayHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row], 
                          cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                          Corn_FeaturesObject$`95% of Ten Day High`)){
      priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                        "Type" = "Ten Day High"))
    }
      
    else if (isAllTimeHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row],
                           cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                           Corn_FeaturesObject$`95% of Ten Day High`, Corn_FeaturesObject$`All Time High`)){
      priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                        "Type" = "All Time High"))
    }
    
    else if (isEndYearTrailingStop(mdy(marketingYear$Date[row]), marketingYear$Percentile[row - 1], marketingYear$Percentile[row], cropYear$`Pre/Post Interval`$intervalPost)){
      priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                        "Type" = "End of Year Trailing Stop"))
    }
  }

  cropYear[['PO Triggers']] = priceObjectiveTriggers
  
  return(cropYear)
  
}

# Gets the price objective triggers for earch crop year
for(i in 1:length(Corn_CropYearObjects)) {
  Corn_CropYearObjects[[i]] = priceObjectiveTrigger(Corn_CropYearObjects[[i]])
  Corn_CropYearObjects[[i]]$`PO Triggers`$Date = mdy(Corn_CropYearObjects[[i]]$`PO Triggers`$Date)
}





  


