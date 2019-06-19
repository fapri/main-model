# Corn and Soybean
# Trailing Stop

# Checks if currentDayPercentile is a trailing stop trigger
isTrailingStop = function(previousDayPercentile, currentDayPercentile) {
  if(previousDayPercentile >= 70 && previousDayPercentile > currentDayPercentile)
    return(T)
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
trailingStopTrigger = function(cropYear, featuresObject) {
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
                                                                        "Previous Percentile" = marketingYear$Percentile[row - 1],
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
                                                                      "Previous Percentile" = marketingYear$Percentile[row - 1],
                                                                      "Percentile" = marketingYear$Percentile[row],
                                                                      "Type" = "Trailing Stop"))
      }
      
      else if ((mdy(marketingYear$Date[row]) %within% EYTSInterval)){ 
        trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                      "Previous Percentile" = marketingYear$Percentile[row - 1],
                                                                      "Percentile" = marketingYear$Percentile[row],
                                                                      "Type" = "End of Year Trailing Stop"))
      }
    }
    
    else if (isTenDayHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row], 
                          cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                          featuresObject$`95% of Ten Day High`, MY = FALSE)) {
      trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                    "Previous Percentile" = marketingYear$Percentile[row - 1],
                                                                    "Percentile" = marketingYear$Percentile[row],
                                                                    "Type" = "Ten Day High"))
    }
    
    else if (isAllTimeHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row],
                           cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                           featuresObject$`95% of Ten Day High`, featuresObject$`All Time High`, MY = FALSE)) {
      trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                    "Previous Percentile" = marketingYear$Percentile[row - 1],
                                                                    "Percentile" = marketingYear$Percentile[row],
                                                                    "Type" = "All Time High"))
    }
  }
  
  return(trailingStopTriggers)
}

# Finds all of the trailing stop triggers for a given crop year
trailingStopTriggerMarch = function(cropYear, featuresObject) {
  trailingStopTriggersMarch = data.frame()
  
  marketingYear = cropYear[['Marketing Year']]
  june = which(month(mdy(marketingYear$Date)) == 6)
  juneOC = which(year(mdy(marketingYear$Date[june])) == year(mdy(marketingYear$Date[nrow(marketingYear)])))
  
  EYTSInterval = interval(head(mdy(marketingYear$Date[june[juneOC]]), 1), mdy(marketingYear$Date[nrow(marketingYear)]))
  
  intervalPre = cropYear$`Pre/Post Interval`$intervalPre
  
  preRows = which(mdy(marketingYear$Date) %within% intervalPre)
  
  for(row in 2:last(preRows)) {
    # Special case for Feb -> March
    if (month(mdy(marketingYear$Date[row])) == 3 && month(mdy(marketingYear$Date[row - 1])) == 2){
      if(marketingYear$MarPercentile[row - 1] != 95 && marketingYear$MarPercentile[row - 1] >= 70) {
        
        if(marketingYear$MarPercentile[row - 1] == 70) previousPercentileBelow = "60th"
        if(marketingYear$MarPercentile[row - 1] == 80) previousPercentileBelow = "70th"
        if(marketingYear$MarPercentile[row - 1] == 90) previousPercentileBelow = "80th"
        if(marketingYear$MarPercentile[row - 1] == 95) previousPercentileBelow = "90th"
        
        pricePreviousPercentileBelow = marketingYear[row, previousPercentileBelow]
        
        if(previousPercentileBelow == "60th") previousPercentileBelow = 60
        if(previousPercentileBelow == "70th") previousPercentileBelow = 70
        if(previousPercentileBelow == "80th") previousPercentileBelow = 80
        if(previousPercentileBelow == "90th") previousPercentileBelow = 90
        
        # Takes in price for percentile above prevous day, percentile above previous day, current day price
        if(isTrailingStopSpecial(pricePreviousPercentileBelow, marketingYear$Price[row])) {
          trailingStopTriggersMarch = rbind(trailingStopTriggersMarch, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Previous Percentile" = marketingYear$MarPercentile[row - 1],
                                                                        "Percentile" = previousPercentileBelow,
                                                                        "Type" = "Trailing Stop Special March"))
        }
      }
    }
    
    #Special case for Aug -> Sept
    else if (month(mdy(marketingYear$Date[row])) == 9 && month(mdy(marketingYear$Date[row - 1])) == 8){
      next
    }
    
    else if(isTrailingStop(marketingYear$MarPercentile[row - 1], marketingYear$MarPercentile[row])) {
      if(nrow(trailingStopTriggersMarch) == 0 || difftime((mdy(marketingYear$Date[row])), mdy(trailingStopTriggersMarch$Date[nrow(trailingStopTriggersMarch)])) >= 7){ 
        trailingStopTriggersMarch = rbind(trailingStopTriggersMarch, data.frame("Date" = marketingYear$Date[row], 
                                                                      "Previous Percentile" = marketingYear$MarPercentile[row - 1],
                                                                      "Percentile" = marketingYear$MarPercentile[row],
                                                                      "Type" = "Trailing Stop March"))
      } 
    }
  }
  
  return(trailingStopTriggersMarch)

}

if(type == "corn"){
  # Gets the price objective triggers for earch crop year
  # Gets the trailing stop triggers for earch crop year
  for(i in 1:length(Corn_CropYearObjects)) {
    trailingStopTriggers = trailingStopTrigger(Corn_CropYearObjects[[i]], Corn_FeaturesObject)
    trailingStopTriggersMarch = trailingStopTriggerMarch(Corn_CropYearObjects[[i]], Corn_FeaturesObject)
    
    allTriggers = rbind(trailingStopTriggersMarch, trailingStopTriggers)
    allTriggers = allTriggers[order(allTriggers$Date), ]
    # allTriggers = allTriggers[!duplicated(allTriggers$Date), ]
    
    
    Corn_CropYearObjects[[i]]$`TS Triggers` = allTriggers
    Corn_CropYearObjects[[i]]$`TS Triggers`$Date = mdy(Corn_CropYearObjects[[i]]$`TS Triggers`$Date)
  }
}

if(type == "soybean"){
  # Gets the price objective triggers for earch crop year
  for(i in 1:length(Soybean_CropYearObjects)) {
    trailingStopTriggers = trailingStopTrigger(Soybean_CropYearObjects[[i]], Soybean_FeaturesObject)
    trailingStopTriggersMarch = trailingStopTriggerMarch(Soybean_CropYearObjects[[i]], Soybean_FeaturesObject)
    
    allTriggers = rbind(trailingStopTriggersMarch, trailingStopTriggers)
    allTriggers = allTriggers[order(allTriggers$Date), ]
    # allTriggers = allTriggers[!duplicated(allTriggers$Date), ]
    
    
    Soybean_CropYearObjects[[i]]$`TS Triggers` = allTriggers
    Soybean_CropYearObjects[[i]]$`TS Triggers`$Date = mdy(Soybean_CropYearObjects[[i]]$`TS Triggers`$Date)
  }
}



