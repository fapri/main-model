# Corn
# Trailing Stop

# Create the corn objects necessary to run the Trailing Stop strategy
source('Corn/Main.R')

# TODO EVENTUALLY WE CAN MOVE THESE TRIGGER FUNCTIONS TO ANOTHER FILE/FOLDER.
# THEY ARE NOT DEPENDENT TO CORN

# Checks if currentDayPercentile is a trailing stop trigger
isTrailingStop = function(previousDayPercentile, currentDayPercentile) {
  if(previousDayPercentile >= 70 && previousDayPercentile > currentDayPercentile)
    return(T)
  return(F)
}

# Checks 5% Drop from Ten Day High
isTenDayHigh = function(date, price, percentile, preInterval, postInterval, TDH) {
  # Checks if date is NC
  if (date %within% preInterval) {
    # Checks if the price is in 95 percentile.
    # Checks if the price is > 95%TDH for NC
    if (is.na(TDH[which(TDH$Date == date),]$NC)) {
      return(F)
    } else if (percentile == 95 && price < TDH[which(TDH$Date == date),]$NC) {
      return(T)
    } else 
      return(F)
  }
  
  # Checks if date is OC
  else if (date %within% postInterval) {
    # Checks if the price is in 95 percentile.
    # Checks if the price is > 95%TDH for OC
    if (percentile == 95 && price < TDH[which(TDH$Date == date),]$OC) {
      return(T)
    } else 
      return(F)
  }
}

# Checks All Time High
isAllTimeHigh = function(date, price, percentile, preInterval, postInterval, TDH, ATH) {
  #Checks if date is NC
  if (date %within% preInterval){
    # Checks if the price is in 95 percentile.
    # Checks if the price is > 95%TDH for NC
    if (is.na(TDH[which(TDH$Date == date),]$NC)) {
      return(F)
    } else if (((price - ATH[which(ATH$Date == date),]$NC) > (-1)) && price < TDH[which(TDH$Date == date),]$NC) {
      return(T)
    } else 
      return(F)
  }
  
  # Checks if date is OC
  else if (date %within% postInterval) {
    # Checks if the price is in 95 percentile.
    # Checks if the price is > 95%TDH for OC
    if (((price - ATH[which(ATH$Date == date),]$OC) > (-1)) && price < TDH[which(TDH$Date == date),]$OC) {
      return(T)
    } else 
      return(F)
  }
}

# Checks End of the Year Trailing Stop
isEndYearTrailingStop = function(date, previousPercentile, currentPercentile, postInterval) {
  # checks if date is in June
  if (month(date) >= 6 && year(date) == year(int_end(postInterval))) {
    # Checks if Market passes down a percentile
    if (currentPercentile < previousPercentile && currentPercentile >= 70) {
      return(T)
    } else 
      return(F)
  } else 
    return(F)
}

# Checks cases where the baseline updates
isTrailingStopSpecial = function(pricePreviousPercentileBelow, currentPrice) {
  if (currentPrice <= pricePreviousPercentileBelow) {
    return(T)
  } else 
    return(F)
}

# Finds all of the trailing stop triggers for a given crop year
trailingStopTrigger = function(cropYear) {
  trailingStopTriggers = data.frame()
  
  marketingYear = cropYear[['Marketing Year']]
  june = which(month(mdy(marketingYear$Date)) == 6)
  juneOC = which(year(mdy(marketingYear$Date[june])) == year(mdy(marketingYear$Date[nrow(marketingYear)])))
  
  EYTSInterval = interval(head(mdy(marketingYear$Date[june[juneOC]]), 1), mdy(marketingYear$Date[nrow(marketingYear)]))
  
  for(row in 2:nrow(marketingYear)) {
    # Special case for Feb -> March
    if (month(mdy(marketingYear$Date[row])) == 3 && month(mdy(marketingYear$Date[row - 1])) == 2){
      if(marketingYear$Percentile[row - 1] != 95 && marketingYear$Percentile[row - 1] >= 70) {
        
        if(marketingYear$Percentile[row - 1] == 70) previousPercentileBelow = "60th"
        if(marketingYear$Percentile[row - 1] == 80) previousPercentileBelow = "70th"
        if(marketingYear$Percentile[row - 1] == 90) previousPercentileBelow = "80th"
        if(marketingYear$Percentile[row - 1] == 95) previousPercentileBelow = "90th"
        
        pricePreviousPercentileBelow = marketingYear[row, previousPercentileBelow]
        
        if(previousPercentileBelow == "60th") previousPercentileBelow = 60
        if(previousPercentileBelow == "70th") previousPercentileBelow = 70
        if(previousPercentileBelow == "80th") previousPercentileBelow = 80
        if(previousPercentileBelow == "90th") previousPercentileBelow = 90
        
        # Takes in price for percentile above prevous day, percentile above previous day, current day price
        if(isTrailingStopSpecial(pricePreviousPercentileBelow, marketingYear$Price[row])) {
          trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Percentile" = previousPercentileBelow,
                                                                        "Type" = "Trailing Stop Special"))
        }
      }
    }
    
    #Special case for Aug -> Sept
    else if (month(mdy(marketingYear$Date[row])) == 9 && month(mdy(marketingYear$Date[row - 1])) == 8){
      next
    }
    
    else if(isTrailingStop(marketingYear$Percentile[row - 1], marketingYear$Percentile[row])) {
      if(nrow(trailingStopTriggers) == 0 || difftime((mdy(marketingYear$Date[row])), mdy(trailingStopTriggers$Date[nrow(trailingStopTriggers)])) >= 7){ 
        trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                      "Percentile" = marketingYear$Percentile[row],
                                                                      "Type" = "Trailing Stop"))
      }
      
      else if ((mdy(marketingYear$Date[row]) %within% EYTSInterval)){ 
        trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                      "Percentile" = marketingYear$Percentile[row],
                                                                      "Type" = "End of Year Trailing Stop"))
      }
    }
    
    else if (isTenDayHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row], 
                          cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                          Corn_FeaturesObject$`95% of Ten Day High`)) {
      trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                    "Percentile" = marketingYear$Percentile[row],
                                                                    "Type" = "Ten Day High"))
    }
    
    else if (isAllTimeHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row],
                           cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                           Corn_FeaturesObject$`95% of Ten Day High`, Corn_FeaturesObject$`All Time High`)) {
      trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                    "Percentile" = marketingYear$Percentile[row],
                                                                    "Type" = "All Time High"))
    }
  }
  
  cropYear[['TS Triggers']] = trailingStopTriggers
  
  return(cropYear)
}

# Gets the trailing stop triggers for earch crop year
for(i in 1:length(Corn_CropYearObjects)) {
  Corn_CropYearObjects[[i]] = trailingStopTrigger(Corn_CropYearObjects[[i]])
  Corn_CropYearObjects[[i]]$`TS Triggers`$Date = mdy(Corn_CropYearObjects[[i]]$`TS Triggers`$Date)
}
