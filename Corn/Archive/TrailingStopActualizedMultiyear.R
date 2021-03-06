# Corn 
# Trailing Stop
# Multi Year
# Actualized

library(data.table)
library(lubridate)
library(dplyr)

isActualizedPresent = function(cropYear){
  if ("TS Actualized MY" %in% names(cropYear)){
    return(cropYear[["TS Actualized MY"]])
  }
  
  else{
    trailingStopActualized = data.frame(matrix(ncol = 7, nrow = 0))
    colnames(trailingStopActualized) = c("Date", "Previous Percentile", "Percentile", "Type", "PercentSold", "TotalSold", "Price")
    return(trailingStopActualized)
  }
}

getTotalSold = function(actualizedSales){
  if(nrow(actualizedSales) == 0){
    return(0)
  }
  
  else{
    return(last(actualizedSales$Total.Sold))
  }
}

getPercentSold = function(actualizedSales){
  if(nrow(actualizedSales) == 0){
    return(0)
  }
  
  else{
    return(last(actualizedSales$Percent.Sold))
  }
}

# Finds actualized Trailing Stop sales
isActualizedTS = function(cropYear, cropYear1, cropYear2, MY){
  trailingStopActualized = isActualizedPresent(cropYear)
  trailingStopActualized1year = isActualizedPresent(cropYear1)
  trailingStopActualized2year = isActualizedPresent(cropYear2)
  
  marketingYear = cropYear[['Marketing Year']]
  marketingYear1 = cropYear1[['Marketing Year MY']]
  marketingYear2 = cropYear2[['Marketing Year MY']]
  
  marketingYear$Date = mdy(marketingYear$Date)
  triggers = cropYear[['TS Triggers']]
  multiyearTriggers = cropYear[['MultiYear Triggers']]
  intervalPre = cropYear$`Pre/Post Interval`$intervalPre
  intervalPost = cropYear$`Pre/Post Interval`$intervalPost
  
  jan1NC = paste("01-01", toString(year(mdy(cropYear$`Start Date`))), sep="-")
  may31NC = paste("05-31", toString(year(mdy(cropYear$`Start Date`))), sep="-")
  june1NC = paste("06-01", toString(year(mdy(cropYear$`Start Date`))), sep="-")
  aug31NC = paste("08-31", toString(year(mdy(cropYear$`Start Date`))), sep="-")
  sep1OC = paste("09-01", toString(year(mdy(cropYear$`Start Date`))), sep="-")
  dec31OC = paste("12-31", toString(year(mdy(cropYear$`Start Date`))), sep="-")
  jan1OC = paste("01-01", toString(year(mdy(cropYear$`Stop Date`))), sep="-")
  aug31OC = paste("08-31", toString(year(mdy(cropYear$`Stop Date`))), sep="-")
  interval1 = interval(mdy(jan1NC), mdy(may31NC))
  interval2 = interval(mdy(june1NC), mdy(aug31NC))
  interval3 = interval(mdy(sep1OC), mdy(dec31OC))
  interval4 = interval(mdy(jan1OC), mdy(aug31OC))
  
  totalSold = getTotalSold(trailingStopActualized)
  totalSold1year = getTotalSold(trailingStopActualized1year)
  totalSold2year = getTotalSold(trailingStopActualized2year)
  
  percentSold = getPercentSold(trailingStopActualized)
  percentSold1year = getPercentSold(trailingStopActualized1year)
  percentSold2year = getPercentSold(trailingStopActualized2year)
  
  Corn_FuturesMarket$Date = mdy(Corn_FuturesMarket$Date)
  
  if(totalSold > 0){
    totalSoldMax = 60
  }
  else{
    totalSoldMax = 50
  }
  
  if(!is.null(cropYear1)){
    #Multi-Year Sales
    for(row in 1:nrow(marketingYear1)) {
      if(marketingYear$Date[row] %in% multiyearTriggers$Date) {
        mytRow = which(marketingYear$Date[row] == multiyearTriggers$Date)
        futuresMarketRow = which(Corn_FuturesMarket$Date == marketingYear$Date[row])
        
        if(!(multiyearTriggers$Date[mytRow] %within% interval4)){
          if(!(nrow(trailingStopActualized1year) == 0)){
            if(abs(difftime(multiyearTriggers$Date[mytRow], trailingStopActualized1year$Date[nrow(trailingStopActualized1year)])) >= 7) {
              if(multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High"){
                if(totalSold1year < 60){
                  totalSold1year = totalSold1year + 10
                  trailingStopActualized1year = rbind(trailingStopActualized1year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                              "Previous Percentile" = multiyearTriggers$Previous.Percentile[mytRow],
                                                                                              "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                              "Type" = "Multi-Year",
                                                                                              "Percent Sold" = 10,
                                                                                              "Total Sold" = totalSold1year,
                                                                                              "Price" = Corn_FuturesMarket$DecNC1yr[futuresMarketRow]))
                  
                  if(multiyearTriggers$Date[mytRow] %within% interval1 || multiyearTriggers$Date[mytRow] %within% interval2){
                    tRow = which(marketingYear$Date[row] == triggers$Date)
                    totalSold = totalSold + 10
                    trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                      "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                      "Percentile" = triggers$Percentile[tRow],
                                                                                      "Type" = triggers$Type[tRow],
                                                                                      "Percent Sold" = 10,
                                                                                      "Total Sold" = totalSold,
                                                                                      "Price" = Corn_FuturesMarket$DecNC[futuresMarketRow]))
                  }
                }
              }
            }
          }
          else{            
            if(multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High"){
              totalSold1year = totalSold1year + 10
              trailingStopActualized1year = rbind(trailingStopActualized1year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                          "Previous Percentile" = multiyearTriggers$Previous.Percentile[mytRow],
                                                                                          "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                          "Type" = "Multi-Year",
                                                                                          "Percent Sold" = 10,
                                                                                          "Total Sold" = totalSold1year,
                                                                                          "Price" = Corn_FuturesMarket$DecNC1yr[futuresMarketRow]))
              
              if(multiyearTriggers$Date[mytRow] %within% interval1 || multiyearTriggers$Date[mytRow] %within% interval2){
                tRow = which(marketingYear$Date[row] == triggers$Date)
                totalSold = totalSold + 10
                trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                  "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                  "Percentile" = triggers$Percentile[tRow],
                                                                                  "Type" = triggers$Type[tRow],
                                                                                  "Percent Sold" = 10,
                                                                                  "Total Sold" = totalSold,
                                                                                  "Price" = Corn_FuturesMarket$DecNC[futuresMarketRow]))
              }
            }  
          }
        }
      }
    }
    
    #Multi - Year Sales
    for(row in 1:nrow(marketingYear2)) {
      if(marketingYear$Date[row] %in% multiyearTriggers$Date) {
        mytRow = which(marketingYear$Date[row] == multiyearTriggers$Date)
        futuresMarketRow = which(marketingYear$Date[row] == Corn_FuturesMarket$Date)
        
        if(!(multiyearTriggers$Date[mytRow] %within% interval4)){
          if(nrow(trailingStopActualized2year) != 0){
            if(abs(difftime(multiyearTriggers$Date[mytRow], trailingStopActualized2year$Date[nrow(trailingStopActualized2year)])) >= 7) {
              if(multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High"){
                if(totalSold2year < 60){
                  totalSold2year = totalSold2year + 10
                  trailingStopActualized2year = rbind(trailingStopActualized2year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                              "Previous Percentile" = multiyearTriggers$Previous.Percentile[mytRow],
                                                                                              "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                              "Type" = "Multi-Year",
                                                                                              "Percent Sold" = 10,
                                                                                              "Total Sold" = totalSold2year,
                                                                                              "Price" = Corn_FuturesMarket$DecNC2yr[futuresMarketRow]))
                }
              }
            }
          }
          else{
            if(multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High"){
              totalSold2year = totalSold2year + 10
              trailingStopActualized2year = rbind(trailingStopActualized2year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                          "Previous Percentile" = multiyearTriggers$Previous.Percentile[mytRow],
                                                                                          "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                          "Type" = "Multi-Year",
                                                                                          "Percent Sold" = 10,
                                                                                          "Total Sold" = totalSold2year,
                                                                                          "Price" = Corn_FuturesMarket$DecNC2yr[futuresMarketRow]))
            }
          }
        }
      }
    }
  }
  
  
  if(is.null(cropYear1) || !is.null(cropYear1)){
    for(row in 1:nrow(marketingYear)) {
      #check if the day is a trigger date
      if(marketingYear$Date[row] %in% triggers$Date) {
        #find trigger row
        tRow = which(marketingYear$Date[row] == triggers$Date)
        
        #check if preharvest
        if(triggers$Date[tRow] %within% intervalPre) {
          #check if sale was made in last 7 days
          if(nrow(trailingStopActualized) == 0 || abs(difftime(triggers$Date[tRow], trailingStopActualized$Date[nrow(trailingStopActualized)])) >= 7) {
            #if < 50% sold preharvest
            if(totalSold < totalSoldMax) {
              #check if this was the first sale. If so, then there wont be any old percentlies to check
              if(dim(trailingStopActualized)[1] != 0) {
                #check if trigger date is in a restricted interval. Also check Ten Day high because they are unrestricted.
                if(triggers$Date[tRow] %within% interval1 && triggers$Type[tRow] != "Ten Day High" && triggers$Type[tRow] != "All Time High" && triggers$Type[tRow] != "Seasonal") {
                  tempRows = NA
                  #create a list to get the actualized sales rows within an interval. This will be used to ensure 1 sale per percentile
                  tempRows = which(trailingStopActualized$Date %within% interval1 & trailingStopActualized$Type == "Trailing Stop")
                  #check if a sale was made in that percentile
                  if(!(triggers$Previous.Percentile[tRow] %in% trailingStopActualized$Previous.Percentile[tempRows])) {
                    #TS, ATH, TDH at 10% increments
                    totalSold = totalSold + 10
                    if (MY == TRUE && totalSold > tail(trailingStopActualized$Total.Sold, 1)){
                      totalSoldTemp = totalSold
                      totalSold = tail(trailingStopActualized$Total.Sold, 1)
                      trailingStopActualized$Total.Sold[nrow(trailingStopActualized)] = totalSoldTemp
                      trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                        "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                        "Percentile" = triggers$Percentile[tRow],
                                                                                        "Type" = triggers$Type[tRow],
                                                                                        "Percent Sold" = 10,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                      totalSold = totalSoldTemp
                    }
                    else{
                      trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                        "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                        "Percentile" = triggers$Percentile[tRow],
                                                                                        "Type" = triggers$Type[tRow],
                                                                                        "Percent Sold" = 10,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                    }
                    trailingStopActualized = arrange(trailingStopActualized, Date)
                  }
                }
                #if trigger date is in an unrestricted interval or ATH/TDH we can just make the sale
                else {
                  #TS, ATH, TDH at 10% increments
                  totalSold = totalSold + 10
                  if (MY == TRUE && totalSold > tail(trailingStopActualized$Total.Sold, 1)){
                    totalSoldTemp = totalSold
                    totalSold = tail(trailingStopActualized$Total.Sold, 1)
                    trailingStopActualized$Total.Sold[nrow(trailingStopActualized)] = totalSoldTemp
                    trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                      "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                      "Percentile" = triggers$Percentile[tRow],
                                                                                      "Type" = triggers$Type[tRow],
                                                                                      "Percent Sold" = 10,
                                                                                      "Total Sold" = totalSold,
                                                                                      "Price" = marketingYear$`Price`[row]))
                    totalSold = totalSoldTemp
                  }
                  else{
                    trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                      "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                      "Percentile" = triggers$Percentile[tRow],
                                                                                      "Type" = triggers$Type[tRow],
                                                                                      "Percent Sold" = 10,
                                                                                      "Total Sold" = totalSold,
                                                                                      "Price" = marketingYear$`Price`[row]))
                  }                  
                  trailingStopActualized = arrange(trailingStopActualized, Date)
                }
              }
              #if trigger is the first one we can just make the sale
              else {
                #TS, ATH, TDH at 10% increments
                totalSold = totalSold + 10
                trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                  "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                  "Percentile" = triggers$Percentile[tRow],
                                                                                  "Type" = triggers$Type[tRow],
                                                                                  "Percent Sold" = 10,
                                                                                  "Total Sold" = totalSold,
                                                                                  "Price" = marketingYear$`Price`[row]))
                trailingStopActualized = arrange(trailingStopActualized, Date)
              }
            }
          }
        }
        
        #check if postharvest
        else if(triggers$Date[tRow] %within% intervalPost) {
          #if > 0% of crop remains
          if(totalSold < 100) {
            #Check if any sales have been made yet
            if(nrow(trailingStopActualized) != 0) {
              #if day not within 7 days of last sale
              if(abs(difftime(triggers$Date[tRow], trailingStopActualized$Date[nrow(trailingStopActualized)])) >= 7){
                #if >=10% of crop remains
                if(totalSold <= 90) {
                  #check if this percentile has had a sale yet. Also Check Ten Day high because they are unrestricted
                  if(triggers$Date[tRow] %within% interval3 && triggers$Type[tRow] != "Ten Day High" && triggers$Type[tRow] != "All Time High" && triggers$Type[tRow] != "Seasonal" && triggers$Type[tRow] != "End of Year Trailing Stop") {
                    
                    tempRows = NA
                    #create a list to get the actualized sales rows within an interval. This will be used to ensure 1 sale per percentile
                    tempRows = which(trailingStopActualized$Date %within% interval3 & trailingStopActualized$Type == "Trailing Stop")
                    #check if a sale was made in that percentile. 
                    if(!(triggers$Previous.Percentile[tRow] %in% trailingStopActualized$Previous.Percentile[tempRows])) {
                      #TS, ATH, TDH at 10% increments
                      totalSold = totalSold + 10
                      trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                        "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                        "Percentile" = triggers$Percentile[tRow],
                                                                                        "Type" = triggers$Type[tRow],
                                                                                        "Percent Sold" = 10,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                      trailingStopActualized = arrange(trailingStopActualized, Date)
                    }
                  }
                  #if trigger date is in an unrestricted interval or ATH/TDH we can just make the sale
                  else {
                    #TS, ATH, TDH at 10% increments
                    totalSold = totalSold + 10
                    trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow],
                                                                                      "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                      "Percentile" = triggers$Percentile[tRow],
                                                                                      "Type" = triggers$Type[tRow],
                                                                                      "Percent Sold" = 10,
                                                                                      "Total Sold" = totalSold,
                                                                                      "Price" = marketingYear$`Price`[row]))
                    trailingStopActualized = arrange(trailingStopActualized, Date)
                  }
                }
              }
              
              else if (month(marketingYear$Date[row]) == 6){
                if (triggers$Type[tRow] == "End of Year Trailing Stop"){
                  if (triggers$Percentile[tRow] >= 60){
                    if (marketingYear$Percentile[row] == 90 && marketingYear$Percentile[row - 1] == 95){
                      percentSold = (100 - totalSold) / 4
                      totalSold = totalSold + percentSold
                      trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow],
                                                                                        "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                        "Percentile" = triggers$Percentile[tRow],
                                                                                        "Type" = triggers$Type[tRow],
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                      trailingStopActualized = arrange(trailingStopActualized, Date)
                    }
                    
                    else if (marketingYear$Percentile[row] == 80 && marketingYear$Percentile[row - 1] == 90){
                      percentSold = (100 - totalSold) / 3
                      totalSold = totalSold + percentSold
                      trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow],
                                                                                        "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                        "Percentile" = triggers$Percentile[tRow],
                                                                                        "Type" = triggers$Type[tRow],
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                      trailingStopActualized = arrange(trailingStopActualized, Date)
                    }
                    
                    else if (marketingYear$Percentile[row] == 70 && marketingYear$Percentile[row - 1] == 80){
                      percentSold = (100 - totalSold) / 2
                      totalSold = totalSold + percentSold
                      trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                        "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                        "Percentile" = triggers$Percentile[tRow],
                                                                                        "Type" = triggers$Type[tRow],
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                      trailingStopActualized = arrange(trailingStopActualized, Date)
                    }
                    
                    else if (marketingYear$Percentile[row] == 60 && marketingYear$Percentile[row - 1] == 70){
                      percentSold = (100 - totalSold) / 1
                      totalSold = totalSold + percentSold
                      trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow],
                                                                                        "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                        "Percentile" = triggers$Percentile[tRow],
                                                                                        "Type" = triggers$Type[tRow],
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                      trailingStopActualized = arrange(trailingStopActualized, Date)
                    }
                  }
                }
              }
            }
            #if trigger is the first one we can just make the sale
            else {
              #TS, ATH, TDH at 10% increments
              totalSold = totalSold + 10
              trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                "Percentile" = triggers$Percentile[tRow],
                                                                                "Type" = triggers$Type[tRow],
                                                                                "Percent Sold" = 10,
                                                                                "Total Sold" = totalSold,
                                                                                "Price" = marketingYear$`Price`[row]))
              trailingStopActualized = arrange(trailingStopActualized, Date)
            }
          }
        }
      }
      # SEASONAL SALES
      # else if we sold 60% of crop or less
      else if(totalSold > 0) {
        # if price < 70 percentile
        if(marketingYear$Percentile[row] < 70) {
          # if day not within 7 days of last sale
          if(abs(difftime(marketingYear$Date[row], trailingStopActualized$Date[nrow(trailingStopActualized)])) >= 7) {
            # if month is march seasonal sale month
            if(month(marketingYear$Date[row]) == 3 && year(marketingYear$Date[row]) == year(mdy(cropYear$`Stop Date`))) {
              # if the day is within a seasonal sale date
              day = day(marketingYear$Date[row])
              if(day == 10 || day == 11 || day == 12 || day == 13){ 
                if (totalSold <= 60) {
                  # seasonal sales must be at least 10%
                  percentSold = ((100 - totalSold) / 4)
                  totalSold = totalSold + percentSold
                  trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                    "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                    "Percentile" = marketingYear$Percentile[row],
                                                                                    "Type" = "Seasonal",
                                                                                    "Percent Sold" = percentSold,
                                                                                    "Total Sold" = totalSold,
                                                                                    "Price" = marketingYear$`Price`[row]))
                  trailingStopActualized = arrange(trailingStopActualized, Date)
                }
              }
              else if(day == 20 || day == 21 || day == 22 || day == 23) {
                if (totalSold <= 70) {
                  # seasonal sales must be at least 10%
                  percentSold = ((100 - totalSold) / 3)
                  totalSold = totalSold + percentSold
                  trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                    "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                    "Percentile" = marketingYear$Percentile[row],
                                                                                    "Type" = "Seasonal",
                                                                                    "Percent Sold" = percentSold,
                                                                                    "Total Sold" = totalSold,
                                                                                    "Price" = marketingYear$`Price`[row]))
                  trailingStopActualized = arrange(trailingStopActualized, Date)
                }
              }
            }
            else if(month(marketingYear$Date[row]) == 6 && year(marketingYear$Date[row]) == year(mdy(cropYear$`Stop Date`))) {
              # if the day is within a seasonal sale date
              day = day(marketingYear$Date[row])
              if(day == 10 || day == 11 || day == 12 || day == 13) {
                if (totalSold <= 80) {
                  #seasonal sales must be at least 10%
                  percentSold = ((100 - totalSold) / 2)
                  totalSold = totalSold + percentSold
                  trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                    "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                    "Percentile" = marketingYear$Percentile[row],
                                                                                    "Type" = "Seasonal",
                                                                                    "Percent Sold" = percentSold,
                                                                                    "Total Sold" = totalSold,
                                                                                    "Price" = marketingYear$`Price`[row]))
                  trailingStopActualized = arrange(trailingStopActualized, Date)
                }
              }
              else if(day == 20 || day == 21 || day == 22 || day == 23) {
                if(totalSold <= 90) {
                  #seasonal sales must be at least 10%
                  percentSold = ((100 - totalSold) / 1)
                  totalSold = totalSold + percentSold
                  trailingStopActualized = rbind(trailingStopActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                    "Previous Percentile" = triggers$Previous.Percentile[tRow],
                                                                                    "Percentile" = marketingYear$Percentile[row],
                                                                                    "Type" = "Seasonal",
                                                                                    "Percent Sold" = percentSold,
                                                                                    "Total Sold" = totalSold,
                                                                                    "Price" = marketingYear$`Price`[row]))
                  trailingStopActualized = arrange(trailingStopActualized, Date)
                }
              }
            }
          }
        }
      }
    }
  }
  
  if(MY == TRUE) {
    cropYear[['TS Actualized MY']] = trailingStopActualized
    if(!is.null(cropYear1)){
      cropYear1[['TS Actualized MY']] = trailingStopActualized1year
      cropYear2[['TS Actualized MY']] = trailingStopActualized2year
      actualizedList = list(cropYear, cropYear1, cropYear2)
    }
    else{
      actualizedList = cropYear
    }
  }
  
  if(MY == FALSE) {
    cropYear[['TS Actualized']] = trailingStopActualized
    actualizedList = cropYear
  }
  
  return(actualizedList)
}

# Trailing Stop loading
for(i in 1:length(Corn_CropYearObjects)){
  Corn_CropYearObjects[[i]] = isActualizedTS(Corn_CropYearObjects[[i]], NULL, NULL, MY = FALSE)
}

# Multi-year loading
if("Marketing Year MY" %in% names(Corn_CropYearObjects[[1]])){
  for(i in 1:(length(Corn_CropYearObjects) - 2)) {
    temp = list()
    temp[[1]] = isActualizedTS(Corn_CropYearObjects[[i]], Corn_CropYearObjects[[i + 1]], Corn_CropYearObjects[[i + 2]], MY = TRUE)
    Corn_CropYearObjects[[i]] = temp[[1]][[1]]
    Corn_CropYearObjects[[i + 1]] = temp[[1]][[2]]
    Corn_CropYearObjects[[i + 2]] = temp[[1]][[3]]
  }
  
  for(i in (length(Corn_CropYearObjects) - 1):length(Corn_CropYearObjects)){
    Corn_CropYearObjects[[i]] = isActualizedTS(Corn_CropYearObjects[[i]], NULL, NULL, MY = TRUE)
  }
}