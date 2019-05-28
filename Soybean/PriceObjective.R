# Soybean
# Price Objective

# COMBINES CORN AND SOYBEAN

# Checks if currentDayPercentile is a price objective trigger
isPriceObjective = function(previousDayPercentile, currentDayPercentile) {
  if(currentDayPercentile >= 70 && previousDayPercentile < currentDayPercentile)
    return(T)
  return(F)
}

# Checks cases where the baseline updates
isPriceObjectiveSpecial = function(pricePreviousPercentileAbove, currentPrice) {
  if (currentPrice >= pricePreviousPercentileAbove) {
    return(T)
  } else 
    return(F)
}

# Finds all of the price objective triggers for a given crop year
priceObjectiveTrigger = function(cropYear, featuresObject) {
  priceObjectiveTriggers = data.frame()
  marketingYear = cropYear[['Marketing Year']]
  
  for(row in 2:nrow(marketingYear)) {
    # Special case for Feb -> March
    if (month(mdy(marketingYear$Date[row])) == 3 && month(mdy(marketingYear$Date[row - 1])) == 2){
      if(marketingYear$Percentile[row - 1] != 95 && marketingYear$Percentile[row - 1] >= 60) {
        
        if(marketingYear$Percentile[row - 1] == 60) previousPercentileAbove = "70th"
        if(marketingYear$Percentile[row - 1] == 70) previousPercentileAbove = "80th"
        if(marketingYear$Percentile[row - 1] == 80) previousPercentileAbove = "90th"
        if(marketingYear$Percentile[row - 1] == 90) previousPercentileAbove = "95th"
        
        pricePreviousPercentileAbove = marketingYear[row, previousPercentileAbove]
        
        if(previousPercentileAbove == "70th") previousPercentileAbove = 70
        if(previousPercentileAbove == "70th") previousPercentileAbove = 80
        if(previousPercentileAbove == "70th") previousPercentileAbove = 90
        if(previousPercentileAbove == "70th") previousPercentileAbove = 95
        
        # Takes in price for percentile above prevous day, percentile above previous day, current day price
        if(isPriceObjectiveSpecial(pricePreviousPercentileAbove, marketingYear$Price[row])) {
          priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                            "Percentile" = previousPercentileAbove,
                                                                            "Type" = "Price Objective Special"))
        }
      }
    }
    
    #Special case for Aug -> Sept
    else if (month(mdy(marketingYear$Date[row])) == 9 && month(mdy(marketingYear$Date[row - 1])) == 8){
      next
    }
    
    else if(isPriceObjective(marketingYear$Percentile[row - 1], marketingYear$Percentile[row])) {
      priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                        "Type" = "Price Objective"))
    }
    
    else if (isTenDayHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row], 
                          cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                          featuresObject$`95% of Ten Day High`, MY = FALSE)) {
      priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                        "Type" = "Ten Day High"))
    }
    
    else if (isAllTimeHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row],
                           cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                           featuresObject$`95% of Ten Day High`, featuresObject$`All Time High`, MY = FALSE)) {
      priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                        "Type" = "All Time High"))
    }
    
    else if (isEndYearTrailingStop(mdy(marketingYear$Date[row]), marketingYear$Percentile[row - 1], marketingYear$Percentile[row],
                                   cropYear$`Pre/Post Interval`$intervalPost)) {
      priceObjectiveTriggers = rbind(priceObjectiveTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                        "Type" = "End of Year Trailing Stop"))
    }
  }
  
  cropYear[['PO Triggers']] = priceObjectiveTriggers
  
  return(cropYear)
}

if(type == "corn"){
  # Gets the price objective triggers for earch crop year
  for(i in 1:length(Corn_CropYearObjects)) {
    Corn_CropYearObjects[[i]] = priceObjectiveTrigger(Corn_CropYearObjects[[i]], Corn_FeaturesObject)
    Corn_CropYearObjects[[i]]$`PO Triggers`$Date = mdy(Corn_CropYearObjects[[i]]$`PO Triggers`$Date)
  }
}

if(type == "soybean"){
  # Gets the price objective triggers for earch crop year
  for(i in 1:length(Soybean_CropYearObjects)) {
    Soybean_CropYearObjects[[i]] = priceObjectiveTrigger(Soybean_CropYearObjects[[i]], Soybean_FeaturesObject)
    Soybean_CropYearObjects[[i]]$`PO Triggers`$Date = mdy(Soybean_CropYearObjects[[i]]$`PO Triggers`$Date)
  }
}