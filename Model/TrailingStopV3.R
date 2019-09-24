# Corn and Soybean
# Trailing Stop

# Creates new marketing year where baselines are lowered by 1%
adjustMarketingYear = function(cropObject){
  baselineCol = which(names(cropObject[["Marketing Year"]]) == "Baseline")
  ninetyFifthCol = which(names(cropObject[["Marketing Year"]]) == "95th")
  
  cropObject[["Marketing Year"]][baselineCol:ninetyFifthCol] = 
    (cropObject[["Marketing Year"]][baselineCol:ninetyFifthCol] * 0.99)
  
  marketingYearAdj = cropObject[["Marketing Year"]]
  
  for (row in 1:nrow(marketingYearAdj)) {
    if (marketingYearAdj$Price[row] > marketingYearAdj$`95th`[row])
      marketingYearAdj[row, "Percentile"] = 95
    else if (marketingYearAdj$Price[row] >= marketingYearAdj$`90th`[row])
      marketingYearAdj[row, "Percentile"] = 90
    else if (marketingYearAdj$Price[row] >= marketingYearAdj$`80th`[row])
      marketingYearAdj[row, "Percentile"] = 80
    else if (marketingYearAdj$Price[row] >= marketingYearAdj$`70th`[row])
      marketingYearAdj[row, "Percentile"] = 70
    else if (marketingYearAdj$Price[row] >= marketingYearAdj$`60th`[row])
      marketingYearAdj[row, "Percentile"] = 60
    else if (marketingYearAdj$Price[row] >= marketingYearAdj$Baseline[row])
      marketingYearAdj[row, "Percentile"] = 50
    else
      marketingYearAdj[row, "Percentile"] = 0
  }  
  
  return(marketingYearAdj) 
}

if (type == "corn") {
  for (i in 1:length(Corn_CropYearObjects)) {
    Corn_CropYearObjects[[i]][["Marketing Year Adjusted"]] = adjustMarketingYear(Corn_CropYearObjects[[i]])
  }
} else if (type == "soybean") {
  for (i in 1:length(Soybean_CropYearObjects)) {
    Soybean_CropYearObjects[[i]][["Marketing Year Adjusted"]] = adjustMarketingYear(Soybean_CropYearObjects[[i]])
  }
}

# Checks if currentDayPercentile is a trailing stop trigger
isTrailingStop = function(previousDayPercentile, currentDayPercentile) {
  if (previousDayPercentile >= 70 && previousDayPercentile > currentDayPercentile)
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
  marketingYearAdj = cropYear[['Marketing Year Adjusted']]
  june = which(month(mdy(marketingYear$Date)) == 6)
  juneOC = which(year(mdy(marketingYear$Date[june])) == year(mdy(marketingYear$Date[nrow(marketingYear)])))
  
  EYTSInterval = interval(head(mdy(marketingYear$Date[june[juneOC]]), 1), mdy(marketingYear$Date[nrow(marketingYear)]))
  
  for (row in 2:nrow(marketingYear)) {
    
    # All time high
    # Functions on normal marketing year
    if (isAllTimeHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row],
                           cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                           featuresObject$`95% of Ten Day High`, featuresObject$`All Time High`, MY = FALSE)) {
      trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                    "Previous Percentile" = marketingYear$Percentile[row - 1],
                                                                    "Percentile" = marketingYear$Percentile[row],
                                                                    "Type" = "All Time High"))
    }
    
    # Special case for Feb -> March
    # Functions on adjusted marketing year
    else if (month(mdy(marketingYearAdj$Date[row])) == 3 && month(mdy(marketingYearAdj$Date[row - 1])) == 2) {
      if (marketingYearAdj$Percentile[row - 1] != 95 && marketingYearAdj$Percentile[row - 1] >= 70) {
        
        if (marketingYearAdj$Percentile[row - 1] == 70) previousPercentileBelow = "60th"
        if (marketingYearAdj$Percentile[row - 1] == 80) previousPercentileBelow = "70th"
        if (marketingYearAdj$Percentile[row - 1] == 90) previousPercentileBelow = "80th"
        if (marketingYearAdj$Percentile[row - 1] == 95) previousPercentileBelow = "90th"
        
        pricePreviousPercentileBelow = marketingYearAdj[row, previousPercentileBelow]
        
        if (previousPercentileBelow == "60th") previousPercentileBelow = 60
        if (previousPercentileBelow == "70th") previousPercentileBelow = 70
        if (previousPercentileBelow == "80th") previousPercentileBelow = 80
        if (previousPercentileBelow == "90th") previousPercentileBelow = 90
        
        # Takes in price for percentile above prevous day, percentile above previous day, current day price
        if (isTrailingStopSpecial(pricePreviousPercentileBelow, marketingYearAdj$Price[row])) {
          trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYearAdj$Date[row], 
                                                                        "Previous Percentile" = marketingYearAdj$Percentile[row - 1],
                                                                        "Percentile" = previousPercentileBelow,
                                                                        "Type" = "Trailing Stop Special"))
        }
      }
    }

    # Special case for Aug -> Sept
    # Functions on adjusted marketing year
    else if (month(mdy(marketingYearAdj$Date[row])) == 9 && month(mdy(marketingYearAdj$Date[row - 1])) == 8) {
      next
    }
    
    # Functions on adjusted marketing year
    else if (isTrailingStop(marketingYearAdj$Percentile[row - 1], marketingYearAdj$Percentile[row]) && !(mdy(marketingYearAdj$Date[row]) %within% EYTSInterval)) {
      if (nrow(trailingStopTriggers) == 0 || difftime((mdy(marketingYearAdj$Date[row])), mdy(trailingStopTriggers$Date[nrow(trailingStopTriggers)])) >= 7) { 
        trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYearAdj$Date[row], 
                                                                      "Previous Percentile" = marketingYearAdj$Percentile[row - 1],
                                                                      "Percentile" = marketingYearAdj$Percentile[row],
                                                                      "Type" = "Trailing Stop"))
      }
    }
    
    # Functions on normal marketing year
    else if (isTrailingStop(marketingYear$Percentile[row - 1], marketingYear$Percentile[row]) && (mdy(marketingYear$Date[row]) %within% EYTSInterval)) {
      if (!nrow(trailingStopTriggers) == 0 || difftime((mdy(marketingYear$Date[row])), mdy(trailingStopTriggers$Date[nrow(trailingStopTriggers)])) >= 7) {
        trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                      "Previous Percentile" = marketingYear$Percentile[row - 1],
                                                                      "Percentile" = marketingYear$Percentile[row],
                                                                      "Type" = "End of Year Trailing Stop"))
      }
    }
    
    # Functions on normal marketing year
    else if (isTenDayHigh(mdy(marketingYear$Date[row]), marketingYear$Price[row], marketingYear$Percentile[row], 
                          cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                          featuresObject$`95% of Ten Day High`, MY = FALSE)) {
      trailingStopTriggers = rbind(trailingStopTriggers, data.frame("Date" = marketingYear$Date[row], 
                                                                    "Previous Percentile" = marketingYear$Percentile[row - 1],
                                                                    "Percentile" = marketingYear$Percentile[row],
                                                                    "Type" = "Ten Day High"))
    }
    
  }
  
  cropYear[['TS Triggers']] = trailingStopTriggers
  
  return(cropYear)
}

if (type == "corn") {
  # Gets the price objective triggers for earch crop year
  # Gets the trailing stop triggers for earch crop year
  for (i in 1:length(Corn_CropYearObjects)) {
    Corn_CropYearObjects[[i]] = trailingStopTrigger(Corn_CropYearObjects[[i]], Corn_FeaturesObject)
    Corn_CropYearObjects[[i]]$`TS Triggers`$Date = mdy(Corn_CropYearObjects[[i]]$`TS Triggers`$Date)
  }
}

if (type == "soybean") {
  # Gets the price objective triggers for earch crop year
  for (i in 1:length(Soybean_CropYearObjects)) {
    Soybean_CropYearObjects[[i]] = trailingStopTrigger(Soybean_CropYearObjects[[i]], Soybean_FeaturesObject)
    Soybean_CropYearObjects[[i]]$`TS Triggers`$Date = mdy(Soybean_CropYearObjects[[i]]$`TS Triggers`$Date)
  }
}