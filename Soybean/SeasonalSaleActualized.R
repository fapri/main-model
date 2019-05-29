# Soybean
# Seasonal Sales
# Multi-Year
# Actualized


isActualizedPresent = function(cropYear){
  if ("SS Actualized MY" %in% names(cropYear)){
    return(cropYear[["SS Actualized MY"]])
  }
  
  else{
    seasonalSaleActualized = data.frame(matrix(ncol = 5, nrow = 0))
    colnames(seasonalSaleActualized) = c("Date", "Percentile", "Type", "PercentSold", "TotalSold")
    return(seasonalSaleActualized)
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

isActualizedSSMY = function(cropYear, cropYear1, cropYear2, futuresMarket,MY){
  seasonalSaleActualized = isActualizedPresent(cropYear)
  seasonalSaleActualized1year = isActualizedPresent(cropYear1)
  seasonalSaleActualized2year = isActualizedPresent(cropYear2)
  
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
  
  totalSold = getTotalSold(seasonalSaleActualized)
  totalSold1year = getTotalSold(seasonalSaleActualized1year)
  totalSold2year = getTotalSold(seasonalSaleActualized2year)
  
  percentSold = getPercentSold(seasonalSaleActualized)
  percentSold1year = getPercentSold(seasonalSaleActualized1year)
  percentSold2year = getPercentSold(seasonalSaleActualized2year)
  
  futuresMarket$Date = mdy(futuresMarket$Date)
  
  if(type == "corn"){
    NC = futuresMarket$DecNC
    NC1yr = futuresMarket$DecNC1yr
    NC2yr = futuresMarket$DecNC2yr
  }
  
  if(type == "soybean"){
    NC = futuresMarket$NovNC
    NC1yr = futuresMarket$NovNC1yr
    NC2yr = futuresMarket$NovNC2yr
  }
  
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
        futuresMarketRow = which(futuresMarket$Date == marketingYear$Date[row])
        
        if(!(multiyearTriggers$Date[mytRow] %within% interval4)){
          if(!(nrow(seasonalSaleActualized1year) == 0)){
            if(abs(difftime(multiyearTriggers$Date[mytRow], seasonalSaleActualized1year$Date[nrow(seasonalSaleActualized1year)])) >= 7) {
              if(multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High"){
                if(totalSold1year < 60){
                  totalSold1year = totalSold1year + 10
                  seasonalSaleActualized1year = rbind(seasonalSaleActualized1year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                              "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                              "Type" = "Multi-Year",
                                                                                              "Percent Sold" = 10,
                                                                                              "Total Sold" = totalSold1year,
                                                                                              "Price" = futuresMarket$DecNC1yr[futuresMarketRow]))
                  
                  if(multiyearTriggers$Date[mytRow] %within% interval1 || multiyearTriggers$Date[mytRow] %within% interval2){
                    tRow = which(marketingYear$Date[row] == triggers$Date)
                    totalSold = totalSold + 10
                    seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                      "Percentile" = triggers$Percentile[tRow],
                                                                                      "Type" = triggers$Type[tRow],
                                                                                      "Percent Sold" = 10,
                                                                                      "Total Sold" = totalSold,
                                                                                      "Price" = futuresMarket$DecNC[futuresMarketRow]))
                  }
                }
              }
            }
          }
          else{            
            if(multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High"){
              totalSold1year = totalSold1year + 10
              seasonalSaleActualized1year = rbind(seasonalSaleActualized1year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                          "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                          "Type" = "Multi-Year",
                                                                                          "Percent Sold" = 10,
                                                                                          "Total Sold" = totalSold1year,
                                                                                          "Price" = futuresMarket$DecNC1yr[futuresMarketRow]))
              
              if(multiyearTriggers$Date[mytRow] %within% interval1 || multiyearTriggers$Date[mytRow] %within% interval2){
                tRow = which(marketingYear$Date[row] == triggers$Date)
                totalSold = totalSold + 10
                seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                  "Percentile" = triggers$Percentile[tRow],
                                                                                  "Type" = triggers$Type[tRow],
                                                                                  "Percent Sold" = 10,
                                                                                  "Total Sold" = totalSold,
                                                                                  "Price" = futuresMarket$DecNC[futuresMarketRow]))
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
        futuresMarketRow = which(marketingYear$Date[row] == futuresMarket$Date)
        
        if(!(multiyearTriggers$Date[mytRow] %within% interval4)){
          if(nrow(seasonalSaleActualized2year) != 0){
            if(abs(difftime(multiyearTriggers$Date[mytRow], seasonalSaleActualized2year$Date[nrow(seasonalSaleActualized2year)])) >= 7) {
              if(multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High"){
                if(totalSold2year < 60){
                  totalSold2year = totalSold2year + 10
                  seasonalSaleActualized2year = rbind(seasonalSaleActualized2year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                              "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                              "Type" = "Multi-Year",
                                                                                              "Percent Sold" = 10,
                                                                                              "Total Sold" = totalSold2year,
                                                                                              "Price" = futuresMarket$DecNC2yr[futuresMarketRow]))
                }
              }
            }
          }
          else{
            if(multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High"){
              totalSold2year = totalSold2year + 10
              seasonalSaleActualized2year = rbind(seasonalSaleActualized2year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                          "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                          "Type" = "Multi-Year",
                                                                                          "Percent Sold" = 10,
                                                                                          "Total Sold" = totalSold2year,
                                                                                          "Price" = futuresMarket$DecNC2yr[futuresMarketRow]))
            }
          }
        }
      }
    }
  }
  
  if(is.null(cropYear1) || !is.null(cropYear1)){
    if(totalSold == 0){
      for(row in 1:nrow(marketingYear)) {
        if(nrow(seasonalSaleActualized) == 0 || abs(difftime(marketingYear$Date[row], seasonalSaleActualized$Date[nrow(seasonalSaleActualized)])) >= 7) {
          if((type == "corn" && month(marketingYear$Date[row]) == 3) || (type == "soybean" && month(marketingYear$Date[row]) == 5))  {
            # if the day is within a seasonal sale date
            day = day(marketingYear$Date[row])
            if(day == 10 || day == 11 || day == 12 || day == 13){ 
              if (totalSold <= 60) {
                # seasonal sales must be at least 10%
                percentSold = 12.5
                totalSold = totalSold + percentSold
                seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                  "Percentile" = marketingYear$Percentile[row],
                                                                                  "Type" = "Seasonal",
                                                                                  "Percent Sold" = percentSold,
                                                                                  "Total Sold" = totalSold,
                                                                                  "Price" = marketingYear$`Price`[row]))
              }
            }
            else if(day == 20 || day == 21 || day == 22 || day == 23) {
              if (totalSold <= 70) {
                # seasonal sales must be at least 10%
                percentSold = 12.5
                totalSold = totalSold + percentSold
                seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                  "Percentile" = marketingYear$Percentile[row],
                                                                                  "Type" = "Seasonal",
                                                                                  "Percent Sold" = percentSold,
                                                                                  "Total Sold" = totalSold,
                                                                                  "Price" = marketingYear$`Price`[row]))
              }
            }
          }
          else if((type == "corn" && month(marketingYear$Date[row]) == 6) || (type == "soybean" && month(marketingYear$Date[row]) == 7)) {
            # if the day is within a seasonal sale date
            day = day(marketingYear$Date[row])
            if(day == 10 || day == 11 || day == 12 || day == 13) {
              if (totalSold <= 80) {
                #seasonal sales must be at least 10%
                percentSold = 12.5
                totalSold = totalSold + percentSold
                seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                  "Percentile" = marketingYear$Percentile[row],
                                                                                  "Type" = "Seasonal",
                                                                                  "Percent Sold" = percentSold,
                                                                                  "Total Sold" = totalSold,
                                                                                  "Price" = marketingYear$`Price`[row]))
              }
            }
            else if(day == 20 || day == 21 || day == 22 || day == 23) {
              if(totalSold <= 90) {
                #seasonal sales must be at least 10%
                percentSold = 12.5
                totalSold = totalSold + percentSold
                seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                  "Percentile" = marketingYear$Percentile[row],
                                                                                  "Type" = "Seasonal",
                                                                                  "Percent Sold" = percentSold,
                                                                                  "Total Sold" = totalSold,
                                                                                  "Price" = marketingYear$`Price`[row]))
              }
            }
          }
        }
      }
    }
    
    else{
      for(row in 1:nrow(marketingYear)) {
        if(marketingYear$Date[row] %within% intervalPre){
          if(nrow(seasonalSaleActualized) == 0 || abs(difftime(marketingYear$Date[row], seasonalSaleActualized$Date[nrow(seasonalSaleActualized)])) >= 7) {
            preHarvestPercentRemaining = 60 - totalSold
            if(preHarvestPercentRemaining > 0){              
              if((type == "corn" && month(marketingYear$Date[row]) == 3) || (type == "soybean" && month(marketingYear$Date[row]) == 5)) {
                # if the day is within a seasonal sale date
                day = day(marketingYear$Date[row])
                if(day == 10 || day == 11 || day == 12 || day == 13){ 
                  if (preHarvestPercentRemaining >= 40) {
                    # seasonal sales must be at least 10%
                    percentSold = (preHarvestPercentRemaining / 4)
                    totalSold = totalSold + percentSold
                    if (MY == TRUE && totalSold > tail(seasonalSaleActualized$Total.Sold, 1)){
                      totalSoldTemp = totalSold
                      totalSold = tail(seasonalSaleActualized$Total.Sold, 1)
                      seasonalSaleActualized$Total.Sold[nrow(seasonalSaleActualized)] = totalSoldTemp
                      seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                      totalSold = totalSoldTemp
                    }
                    else{
                      seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                    }
                    seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                  }
                }
                else if(day == 20 || day == 21 || day == 22 || day == 23) {
                  if (preHarvestPercentRemaining >= 30) {
                    # seasonal sales must be at least 10%
                    percentSold = (preHarvestPercentRemaining / 3)
                    totalSold = totalSold + percentSold
                    if (MY == TRUE && totalSold > tail(seasonalSaleActualized$Total.Sold, 1)){
                      totalSoldTemp = totalSold
                      totalSold = tail(seasonalSaleActualized$Total.Sold, 1)
                      seasonalSaleActualized$Total.Sold[nrow(seasonalSaleActualized)] = totalSoldTemp
                      seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                      totalSold = totalSoldTemp
                    }
                    else{
                      seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                    }
                    seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                  }
                }
              }
              else if((type == "corn" && month(marketingYear$Date[row]) == 6) || (type == "soybean" && month(marketingYear$Date[row]) == 7)) {
                # if the day is within a seasonal sale date
                day = day(marketingYear$Date[row])
                if(day == 10 || day == 11 || day == 12 || day == 13) {
                  if (preHarvestPercentRemaining >= 20) {
                    #seasonal sales must be at least 10%
                    percentSold = (preHarvestPercentRemaining / 2)
                    totalSold = totalSold + percentSold
                    if (MY == TRUE && totalSold > tail(seasonalSaleActualized$Total.Sold, 1)){
                      totalSoldTemp = totalSold
                      totalSold = tail(seasonalSaleActualized$Total.Sold, 1)
                      seasonalSaleActualized$Total.Sold[nrow(seasonalSaleActualized)] = totalSoldTemp
                      seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                      totalSold = totalSoldTemp
                    }
                    else{
                      seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                    }
                    seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                  }
                }
                else if(day == 20 || day == 21 || day == 22 || day == 23) {
                  if(preHarvestPercentRemaining >= 10) {
                    #seasonal sales must be at least 10%
                    percentSold = (preHarvestPercentRemaining / 1)
                    totalSold = totalSold + percentSold
                    if (MY == TRUE && totalSold > tail(seasonalSaleActualized$Total.Sold, 1)){
                      totalSoldTemp = totalSold
                      totalSold = tail(seasonalSaleActualized$Total.Sold, 1)
                      seasonalSaleActualized$Total.Sold[nrow(seasonalSaleActualized)] = totalSoldTemp
                      seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                      totalSold = totalSoldTemp
                    }
                    else{
                      seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                        "Percentile" = marketingYear$Percentile[row],
                                                                                        "Type" = "Seasonal",
                                                                                        "Percent Sold" = percentSold,
                                                                                        "Total Sold" = totalSold,
                                                                                        "Price" = marketingYear$`Price`[row]))
                    }
                    seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                  }
                }
              }
            }
          }
        }
        
        
        if(marketingYear$Date[row] %within% intervalPost){
          if(nrow(seasonalSaleActualized) == 0 || abs(difftime(marketingYear$Date[row], seasonalSaleActualized$Date[nrow(seasonalSaleActualized)])) >= 7) {
            postHarvestPercentRemaining = 100 - totalSold
            if(postHarvestPercentRemaining > 0){
              if((type == "corn" && month(marketingYear$Date[row]) == 3 && year(marketingYear$Date[row]) == year(mdy(cropYear$`Stop Date`))) || 
                 (type == "soybean" && month(marketingYear$Date[row]) == 5 && year(marketingYear$Date[row]) == year(mdy(cropYear$`Stop Date`)))) {
                # if the day is within a seasonal sale date
                day = day(marketingYear$Date[row])
                if(day == 10 || day == 11 || day == 12 || day == 13){ 
                  if (postHarvestPercentRemaining >= 40) {
                    # seasonal sales must be at least 10%
                    percentSold = ((100 - totalSold) / 4)
                    totalSold = totalSold + percentSold
                    seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                      "Percentile" = marketingYear$Percentile[row],
                                                                                      "Type" = "Seasonal",
                                                                                      "Percent Sold" = percentSold,
                                                                                      "Total Sold" = totalSold,
                                                                                      "Price" = marketingYear$`Price`[row]))
                    seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                  }
                }
                else if(day == 20 || day == 21 || day == 22 || day == 23) {
                  if (postHarvestPercentRemaining >= 30) {
                    # seasonal sales must be at least 10%
                    percentSold = ((100 - totalSold) / 3)
                    totalSold = totalSold + percentSold
                    seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                      "Percentile" = marketingYear$Percentile[row],
                                                                                      "Type" = "Seasonal",
                                                                                      "Percent Sold" = percentSold,
                                                                                      "Total Sold" = totalSold,
                                                                                      "Price" = marketingYear$`Price`[row]))
                    seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                  }
                }
              }
              else if((type == "corn" && month(marketingYear$Date[row]) == 6 && year(marketingYear$Date[row]) == year(mdy(cropYear$`Stop Date`))) || 
                      (type == "soybean" && month(marketingYear$Date[row]) == 7 && year(marketingYear$Date[row]) == year(mdy(cropYear$`Stop Date`)))) {
                # if the day is within a seasonal sale date
                day = day(marketingYear$Date[row])
                if(day == 10 || day == 11 || day == 12 || day == 13) {
                  if (postHarvestPercentRemaining >= 20) {
                    #seasonal sales must be at least 10%
                    percentSold = ((100 - totalSold) / 2)
                    totalSold = totalSold + percentSold
                    seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                      "Percentile" = marketingYear$Percentile[row],
                                                                                      "Type" = "Seasonal",
                                                                                      "Percent Sold" = percentSold,
                                                                                      "Total Sold" = totalSold,
                                                                                      "Price" = marketingYear$`Price`[row]))
                    seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                  }
                }
                else if(day == 20 || day == 21 || day == 22 || day == 23) {
                  if(postHarvestPercentRemaining >= 10) {
                    #seasonal sales must be at least 10%
                    percentSold = ((100 - totalSold) / 1)
                    totalSold = totalSold + percentSold
                    seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                      "Percentile" = marketingYear$Percentile[row],
                                                                                      "Type" = "Seasonal",
                                                                                      "Percent Sold" = percentSold,
                                                                                      "Total Sold" = totalSold,
                                                                                      "Price" = marketingYear$`Price`[row]))
                    seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  
  if(MY == TRUE) {
    cropYear[['SS Actualized MY']] = seasonalSaleActualized
    if(!is.null(cropYear1)){
      cropYear1[['SS Actualized MY']] = seasonalSaleActualized1year
      cropYear2[['SS Actualized MY']] = seasonalSaleActualized2year
      actualizedList = list(cropYear, cropYear1, cropYear2)
    }
    
    else{
      actualizedList = cropYear
    }
  }
  
  if(MY == FALSE) {
    cropYear[['SS Actualized']] = seasonalSaleActualized
    actualizedList = cropYear
  }
  
  return(actualizedList)
}
  
if (type == "corn"){
  # Seasonal Sales loading
  for(i in 1:length(Corn_CropYearObjects)){
    Corn_CropYearObjects[[i]] = isActualizedSSMY(Corn_CropYearObjects[[i]], NULL, NULL, Corn_FuturesMarket, MY = FALSE)
  }
  
  # Mutli-year loading
  if("Marketing Year MY" %in% names(Corn_CropYearObjects[[1]])){
    for(i in 1:(length(Corn_CropYearObjects) - 2)) {
      temp = list()
      temp[[1]] = isActualizedSSMY(Corn_CropYearObjects[[i]], Corn_CropYearObjects[[i + 1]], Corn_CropYearObjects[[i + 2]], Corn_FuturesMarket, MY = TRUE)
      Corn_CropYearObjects[[i]] = temp[[1]][[1]]
      Corn_CropYearObjects[[i + 1]] = temp[[1]][[2]]
      Corn_CropYearObjects[[i + 2]] = temp[[1]][[3]]
    }
    
    for(i in (length(Corn_CropYearObjects) - 1):length(Corn_CropYearObjects)){
      Corn_CropYearObjects[[i]] = isActualizedSSMY(Corn_CropYearObjects[[i]], NULL, NULL, Corn_FuturesMarket, MY = TRUE)
    }
  }
}

if (type == "soybean"){
  # Seasonal Sales loading
  for(i in 1:length(Soybean_CropYearObjects)){
    Soybean_CropYearObjects[[i]] = isActualizedSSMY(Soybean_CropYearObjects[[i]], NULL, NULL, Soybean_FuturesMarket, MY = FALSE)
  }
  
  # PAUSED FOR TRACK 'N TRADE DATA
  
  # # Mutli-year loading
  # if("Marketing Year MY" %in% names(Soybean_CropYearObjects[[1]])){
  #   for(i in 1:(length(Soybean_CropYearObjects) - 2)) {
  #     temp = list()
  #     temp[[1]] = isActualizedSSMY(Soybean_CropYearObjects[[i]], Soybean_CropYearObjects[[i + 1]], Soybean_CropYearObjects[[i + 2]], Soybean_FuturesMarket, MY = TRUE)
  #     Soybean_CropYearObjects[[i]] = temp[[1]][[1]]
  #     Soybean_CropYearObjects[[i + 1]] = temp[[1]][[2]]
  #     Soybean_CropYearObjects[[i + 2]] = temp[[1]][[3]]
  #   }
  #   
  #   for(i in (length(Soybean_CropYearObjects) - 1):length(Soybean_CropYearObjects)){
  #     Soybean_CropYearObjects[[i]] = isActualizedSSMY(Soybean_CropYearObjects[[i]], NULL, NULL, Soybean_FuturesMarket, MY = TRUE)
  #   }
  # }
}
