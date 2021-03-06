# Corn 
# Price Objective
# Multi Year
# Actualized

isActualizedPresent = function(cropYear){
  if ("PO Actualized MY" %in% names(cropYear)){
    return(cropYear[["PO Actualized MY"]])
  }
  
  else{
    priceObjectiveActualized = data.frame(matrix(ncol = 5, nrow = 0))
    colnames(priceObjectiveActualized) = c("Date", "Percentile", "Type", "PercentSold", "TotalSold")
    return(priceObjectiveActualized)
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

# Finds actualized Price Objective sales
isActualizedPO = function(cropYear, cropYear1, cropYear2, MY){
  priceObjectiveActualized = isActualizedPresent(cropYear)
  priceObjectiveActualized1year = isActualizedPresent(cropYear1)
  priceObjectiveActualized2year = isActualizedPresent(cropYear2)
  
  marketingYear = cropYear[['Marketing Year']]
  marketingYear1 = cropYear1[['Marketing Year MY']]
  marketingYear2 = cropYear2[['Marketing Year MY']]
  
  marketingYear$Date = mdy(marketingYear$Date)
  triggers = cropYear[['PO Triggers']]
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
  
  totalSold = getTotalSold(priceObjectiveActualized)
  totalSold1year = getTotalSold(priceObjectiveActualized1year)
  totalSold2year = getTotalSold(priceObjectiveActualized2year)
  
  percentSold = getPercentSold(priceObjectiveActualized)
  percentSold1year = getPercentSold(priceObjectiveActualized1year)
  percentSold2year = getPercentSold(priceObjectiveActualized2year)
  
  Corn_FuturesMarket$Date = mdy(Corn_FuturesMarket$Date)
  
  if (!is.null(cropYear1)){
    if(totalSold > 0){
      totalSoldMax = 60
    }
    else{
      totalSoldMax = 50
    }
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
          if(!(nrow(priceObjectiveActualized1year) == 0)){
            if(difftime(multiyearTriggers$Date[mytRow], priceObjectiveActualized1year$Date[nrow(priceObjectiveActualized1year)]) >= 7) {
              if(multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High"){
                if(totalSold1year < 60){
                  totalSold1year = totalSold1year + 10
                  priceObjectiveActualized1year = rbind(priceObjectiveActualized1year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                                  "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                                  "Type" = "Multi-Year",
                                                                                                  "Percent Sold" = 10,
                                                                                                  "Total Sold" = totalSold1year,
                                                                                                  "Price" = Corn_FuturesMarket$DecNC1yr[futuresMarketRow]))
                  
                  if(multiyearTriggers$Date[mytRow] %within% interval1 || multiyearTriggers$Date[mytRow] %within% interval2){
                    tRow = which(marketingYear$Date[row] == triggers$Date)
                    totalSold = totalSold + 10
                    priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
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
              priceObjectiveActualized1year = rbind(priceObjectiveActualized1year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                              "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                              "Type" = "Multi-Year",
                                                                                              "Percent Sold" = 10,
                                                                                              "Total Sold" = totalSold1year,
                                                                                              "Price" = Corn_FuturesMarket$DecNC1yr[futuresMarketRow]))
              
              if(multiyearTriggers$Date[mytRow] %within% interval1 || multiyearTriggers$Date[mytRow] %within% interval2){
                tRow = which(marketingYear$Date[row] == triggers$Date)
                totalSold = totalSold + 10
                priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
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
          if(nrow(priceObjectiveActualized2year) != 0){
            if(difftime(multiyearTriggers$Date[mytRow], priceObjectiveActualized2year$Date[nrow(priceObjectiveActualized2year)]) >= 7) {
              if(multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High"){
                if(totalSold2year < 60){
                  totalSold2year = totalSold2year + 10
                  priceObjectiveActualized2year = rbind(priceObjectiveActualized2year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
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
              priceObjectiveActualized2year = rbind(priceObjectiveActualized2year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
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
          if(nrow(priceObjectiveActualized) == 0 || abs(difftime(triggers$Date[tRow], priceObjectiveActualized$Date[nrow(priceObjectiveActualized)])) >= 7) {
            #if < 50% sold preharvest
            if(totalSold < totalSoldMax) {
              #check if this was the first sale. If so, then there wont be any old percentlies to check
              if(dim(priceObjectiveActualized)[1] != 0) {
                #check if trigger date is in a restricted interval. Also check Ten Day high because they are unrestricted.
                if(triggers$Date[tRow] %within% interval1 && triggers$Type[tRow] != "Ten Day High" && triggers$Type[tRow] != "All Time High" && triggers$Type[tRow] != "Seasonal") {
                  tempRows = NA
                  #create a list to get the actualized sales rows within an interval. This will be used to ensure 1 sale per percentile
                  tempRows = which(priceObjectiveActualized$Date %within% interval1 & priceObjectiveActualized$Type == "Price Objective")
                  #check if a sale was made in that percentile
                  if(!(triggers$Percentile[tRow] %in% priceObjectiveActualized$Percentile[tempRows])) {
                    #PO, ATH, TDH at 10% increments
                    totalSold = totalSold + 10
                    if (MY == TRUE && totalSold > tail(priceObjectiveActualized$Total.Sold, 1)){
                      totalSoldTemp = totalSold
                      totalSold = tail(priceObjectiveActualized$Total.Sold, 1)
                      priceObjectiveActualized$Total.Sold[nrow(priceObjectiveActualized)] = totalSoldTemp
                      priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                            "Percentile" = triggers$Percentile[tRow],
                                                                                            "Type" = triggers$Type[tRow],
                                                                                            "Percent Sold" = 10,
                                                                                            "Total Sold" = totalSold,
                                                                                            "Price" = marketingYear$`Price`[row]))
                      totalSold = totalSoldTemp
                    }
                    else{
                      priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                            "Percentile" = triggers$Percentile[tRow],
                                                                                            "Type" = triggers$Type[tRow],
                                                                                            "Percent Sold" = 10,
                                                                                            "Total Sold" = totalSold,
                                                                                            "Price" = marketingYear$`Price`[row]))
                    }
                    priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                  }
                }
                #if trigger date is in an unrestricted interval or ATH/TDH we can just make the sale
                else {
                  #PO, ATH, TDH at 10% increments
                  totalSold = totalSold + 10
                  if (MY == TRUE && totalSold > tail(priceObjectiveActualized$Total.Sold, 1)){
                    totalSoldTemp = totalSold
                    totalSold = tail(priceObjectiveActualized$Total.Sold, 1)
                    priceObjectiveActualized$Total.Sold[nrow(priceObjectiveActualized)] = totalSoldTemp
                    priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                          "Percentile" = triggers$Percentile[tRow],
                                                                                          "Type" = triggers$Type[tRow],
                                                                                          "Percent Sold" = 10,
                                                                                          "Total Sold" = totalSold,
                                                                                          "Price" = marketingYear$`Price`[row]))
                    totalSold = totalSoldTemp
                  }
                  else{
                    priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                          "Percentile" = triggers$Percentile[tRow],
                                                                                          "Type" = triggers$Type[tRow],
                                                                                          "Percent Sold" = 10,
                                                                                          "Total Sold" = totalSold,
                                                                                          "Price" = marketingYear$`Price`[row]))
                  }
                  priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                }
              }
              #if trigger is the first one we can just make the sale
              else {
                #PO, ATH, TDH at 10% increments
                totalSold = totalSold + 10
                priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                      "Percentile" = triggers$Percentile[tRow],
                                                                                      "Type" = triggers$Type[tRow],
                                                                                      "Percent Sold" = 10,
                                                                                      "Total Sold" = totalSold,
                                                                                      "Price" = marketingYear$`Price`[row]))
                priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
              }
            }
          }
        }
        
        #check if postharvest
        else if(triggers$Date[tRow] %within% intervalPost) {
          #if > 0% of crop remains
          if(totalSold < 100) {
            #Check if any sales have been made yet
            if(nrow(priceObjectiveActualized) != 0) {
              #if day not within 7 days of last sale
              if(abs(difftime(triggers$Date[tRow], priceObjectiveActualized$Date[nrow(priceObjectiveActualized)])) >= 7){
                #if >=10% of crop remains
                if(totalSold <= 90) {
                  #check if this percentile has had a sale yet. Also Check Ten Day high because they are unrestricted
                  if(triggers$Date[tRow] %within% interval3 && triggers$Type[tRow] != "Ten Day High" && triggers$Type[tRow] != "All Time High" && triggers$Type[tRow] != "Seasonal" && triggers$Type[tRow] != "End of Year Trailing Stop") {
                    tempRows = NA
                    #create a list to get the actualized sales rows within an interval. This will be used to ensure 1 sale per percentile
                    tempRows = which(priceObjectiveActualized$Date %within% interval3 & priceObjectiveActualized$Type == "Price Objective")
                    #check if a sale was made in that percentile. 
                    if(!(triggers$Percentile[tRow] %in% priceObjectiveActualized$Percentile[tempRows])) {
                      #PO, ATH, TDH at 10% increments
                      totalSold = totalSold + 10
                      priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                            "Percentile" = triggers$Percentile[tRow],
                                                                                            "Type" = triggers$Type[tRow],
                                                                                            "Percent Sold" = 10,
                                                                                            "Total Sold" = totalSold,
                                                                                            "Price" = marketingYear$`Price`[row]))
                      priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                    }
                  }
                  #if trigger date is in an unrestricted interval or ATH/TDH we can just make the sale
                  else if(triggers$Type[tRow] != "End of Year Trailing Stop") {
                    #PO, ATH, TDH at 10% increments
                    totalSold = totalSold + 10
                    priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                          "Percentile" = triggers$Percentile[tRow],
                                                                                          "Type" = triggers$Type[tRow],
                                                                                          "Percent Sold" = 10,
                                                                                          "Total Sold" = totalSold,
                                                                                          "Price" = marketingYear$`Price`[row]))
                    priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                  }
                }
              }
              
              else if (month(marketingYear$Date[row]) == 6){
                if (triggers$Type[tRow] == "End of Year Trailing Stop"){
                  if (triggers$Percentile[tRow] >= 60){
                    if (triggers$Percentile[tRow] == 90 && triggers$Percentile[tRow - 1] == 95){
                      percentSold = (100 - totalSold) / 4
                      totalSold = totalSold + percentSold
                      priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                            "Percentile" = triggers$Percentile[tRow],
                                                                                            "Type" = triggers$Type[tRow],
                                                                                            "Percent Sold" = percentSold,
                                                                                            "Total Sold" = totalSold,
                                                                                            "Price" = marketingYear$`Price`[row]))
                      priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                    }
                    
                    else if (triggers$Percentile[tRow] == 80 && triggers$Percentile[tRow - 1] == 90){
                      percentSold = (100 - totalSold) / 3
                      totalSold = totalSold + percentSold
                      priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                            "Percentile" = triggers$Percentile[tRow],
                                                                                            "Type" = triggers$Type[tRow],
                                                                                            "Percent Sold" = percentSold,
                                                                                            "Total Sold" = totalSold,
                                                                                            "Price" = marketingYear$`Price`[row]))
                      priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                    }
                    
                    else if (triggers$Percentile[tRow] == 70 && triggers$Percentile[tRow - 1] == 80){
                      percentSold = (100 - totalSold) / 2
                      totalSold = totalSold + percentSold
                      priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                            "Percentile" = triggers$Percentile[tRow],
                                                                                            "Type" = triggers$Type[tRow],
                                                                                            "Percent Sold" = percentSold,
                                                                                            "Total Sold" = totalSold,
                                                                                            "Price" = marketingYear$`Price`[row]))
                      priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                    }
                    
                    else if (triggers$Percentile[tRow] == 60 && triggers$Percentile[tRow - 1] == 70){
                      percentSold = (100 - totalSold) / 1
                      totalSold = totalSold + percentSold
                      priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                            "Percentile" = triggers$Percentile[tRow],
                                                                                            "Type" = triggers$Type[tRow],
                                                                                            "Percent Sold" = percentSold,
                                                                                            "Total Sold" = totalSold,
                                                                                            "Price" = marketingYear$`Price`[row]))
                      priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                    }
                  }
                }
              }
            }
            
            #if trigger is the first one we can just make the sale
            else {
              #PO, ATH, TDH at 10% increments
              totalSold = totalSold + 10
              priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                    "Percentile" = triggers$Percentile[tRow],
                                                                                    "Type" = triggers$Type[tRow],
                                                                                    "Percent Sold" = 10,
                                                                                    "Total Sold" = totalSold,
                                                                                    "Price" = marketingYear$`Price`[row]))
              priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
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
          if(difftime(marketingYear$Date[row], priceObjectiveActualized$Date[nrow(priceObjectiveActualized)]) >= 7) {
            # if month is march seasonal sale month
            if(month(marketingYear$Date[row]) == 3 && year(marketingYear$Date[row]) == year(mdy(cropYear$`Stop Date`))) {
              # if the day is within a seasonal sale date
              day = day(marketingYear$Date[row])
              if(day == 10 || day == 11 || day == 12 || day == 13){ 
                if (totalSold <= 60) {
                  # seasonal sales must be at least 10%
                  percentSold = ((100 - totalSold) / 4)
                  totalSold = totalSold + percentSold
                  priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                  priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                }
              }
              else if(day == 20 || day == 21 || day == 22 || day == 23) {
                if (totalSold <= 70) {
                  # seasonal sales must be at least 10%
                  percentSold = ((100 - totalSold) / 3)
                  totalSold = totalSold + percentSold
                  priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                  priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
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
                  priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                  priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                }
              }
              else if(day == 20 || day == 21 || day == 22 || day == 23) {
                if(totalSold <= 90) {
                  #seasonal sales must be at least 10%
                  percentSold = ((100 - totalSold) / 1)
                  totalSold = totalSold + percentSold
                  priceObjectiveActualized = rbind(priceObjectiveActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                  priceObjectiveActualized = arrange(priceObjectiveActualized, Date)
                }
              }
            }
          }
        }
      }
    }
  }
  
  if(MY == TRUE) {
    cropYear[['PO Actualized MY']] = priceObjectiveActualized
    if(!is.null(cropYear1)){
      cropYear1[['PO Actualized MY']] = priceObjectiveActualized1year
      cropYear2[['PO Actualized MY']] = priceObjectiveActualized2year
      actualizedList = list(cropYear, cropYear1, cropYear2)
    }
    else{
      actualizedList = cropYear
    }
  }
  
  if(MY == FALSE) {
    cropYear[['PO Actualized']] = priceObjectiveActualized
    actualizedList = cropYear
  }
  
  return(actualizedList)
}


# Price Objective loading
for(i in 1:length(Corn_CropYearObjects)){
  Corn_CropYearObjects[[i]] = isActualizedPO(Corn_CropYearObjects[[i]], NULL, NULL, MY = FALSE)
}

if("Marketing Year MY" %in% names(Corn_CropYearObjects[[1]])){
  # Multi-year loading
  for(i in 1:(length(Corn_CropYearObjects) - 2)) {
    temp = list()
    temp[[1]] = isActualizedPO(Corn_CropYearObjects[[i]], Corn_CropYearObjects[[i + 1]], Corn_CropYearObjects[[i + 2]], MY = TRUE)
    Corn_CropYearObjects[[i]] = temp[[1]][[1]]
    Corn_CropYearObjects[[i + 1]] = temp[[1]][[2]]
    Corn_CropYearObjects[[i + 2]] = temp[[1]][[3]]
  }
  
  for(i in (length(Corn_CropYearObjects) - 1):length(Corn_CropYearObjects)){
    Corn_CropYearObjects[[i]] = isActualizedPO(Corn_CropYearObjects[[i]], NULL, NULL, MY = TRUE)
}
  }