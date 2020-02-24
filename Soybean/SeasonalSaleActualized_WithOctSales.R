# Soybean
# Seasonal Sales
# Actualized


isActualizedPresent = function(cropYear) {
  if ("SS Actualized MY" %in% names(cropYear)) {
    return(cropYear[["SS Actualized MY"]])
  } else {
    seasonalSaleActualized = data.frame(matrix(ncol = 5, nrow = 0))
    colnames(seasonalSaleActualized) = c("Date", "Percentile", "Type", "PercentSold", "TotalSold")
    return(seasonalSaleActualized)
  }
}

getTotalSold = function(actualizedSales) {
  if (nrow(actualizedSales) == 0) {
    return(0)
  } else {
    return(last(actualizedSales$Total.Sold))
  }
}

getPercentSold = function(actualizedSales) {
  if (nrow(actualizedSales) == 0) {
    return(0)
  } else {
    return(last(actualizedSales$Percent.Sold))
  }
}

i=1
cropYear=Corn_CropYearObjects[[i]]
cropYear1 = Corn_CropYearObjects[[i + 1]]
cropYear2 = Corn_CropYearObjects[[i + 2]]
futuresMarket = Corn_FuturesMarket
MY = TRUE

isActualizedSS = function(cropYear, cropYear1, cropYear2, futuresMarket,MY) {
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
  
  jan1NC = paste("01-01", toString(year(mdy(cropYear$`Start Date`))), sep = "-")
  may31NC = paste("05-31", toString(year(mdy(cropYear$`Start Date`))), sep = "-")
  june1NC = paste("06-01", toString(year(mdy(cropYear$`Start Date`))), sep = "-")
  aug31NC = paste("08-31", toString(year(mdy(cropYear$`Start Date`))), sep = "-")
  sep1OC = paste("09-01", toString(year(mdy(cropYear$`Start Date`))), sep = "-")
  dec31OC = paste("12-31", toString(year(mdy(cropYear$`Start Date`))), sep = "-")
  jan1OC = paste("01-01", toString(year(mdy(cropYear$`Stop Date`))), sep = "-")
  aug31OC = paste("08-31", toString(year(mdy(cropYear$`Stop Date`))), sep = "-")
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
  
  if (type == "corn") {
    NC = futuresMarket$DecNC
    NC1yr = futuresMarket$DecNC1yr
    NC2yr = futuresMarket$DecNC2yr
  }
  
  if (type == "soybean") {
    NC = futuresMarket$NovNC
    NC1yr = futuresMarket$NovNC1yr
    NC2yr = futuresMarket$NovNC2yr
  }
  
  if (!is.null(cropYear1)) {
    if (totalSold > 0) {
      totalSoldMax = 60
    }
    else {
      totalSoldMax = 50
    }
  } else {
    totalSoldMax = 50
  }
  
  if (is.null(cropYear1) || !is.null(cropYear1)) {
    for (row in 1:nrow(marketingYear)) {
      if (!is.null(cropYear1)) {
        if (row <= nrow(marketingYear1)) {
          if (marketingYear$Date[row] %in% multiyearTriggers$Date) {
            mytRow = which(marketingYear$Date[row] == multiyearTriggers$Date)
            futuresMarketRow = which(futuresMarket$Date == marketingYear$Date[row])
            
            if (!(multiyearTriggers$Date[mytRow] %within% interval4)) {
              if (!(nrow(seasonalSaleActualized1year) == 0)) {
                if (abs(difftime(multiyearTriggers$Date[mytRow], seasonalSaleActualized1year$Date[nrow(seasonalSaleActualized1year)])) >= 7) {
                  if (multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High") {
                    if (totalSold1year < 60) {
                      totalSold1year = totalSold1year + 10
                      seasonalSaleActualized1year = rbind(seasonalSaleActualized1year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                                  "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                                  "Type" = "Multi-Year",
                                                                                                  "Percent Sold" = 10,
                                                                                                  "Total Sold" = totalSold1year,
                                                                                                  "Price" = NC1yr[futuresMarketRow]))
                      seasonalSaleActualized1year = arrange(seasonalSaleActualized1year, Date)
                      
                      if (multiyearTriggers$Date[mytRow] %within% interval1 || multiyearTriggers$Date[mytRow] %within% interval2) {
                        if (nrow(seasonalSaleActualized) == 0 || min(abs(difftime(multiyearTriggers$Date[mytRow], seasonalSaleActualized$Date))) >= 7) {
                          if (totalSold < 60) {  
                            tRow = which(marketingYear$Date[row] == triggers$Date)
                            totalSold = totalSold + 10
                            seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                              "Percentile" = triggers$Percentile[tRow],
                                                                                              "Type" = multiyearTriggers$Type[mytRow],
                                                                                              "Percent Sold" = 10,
                                                                                              "Total Sold" = totalSold,
                                                                                              "Price" = NC[futuresMarketRow]))
                            seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                          }
                        }
                      }
                    }
                  }
                }
              }
              
              else {            
                if (multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High") {
                  totalSold1year = totalSold1year + 10
                  seasonalSaleActualized1year = rbind(seasonalSaleActualized1year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                              "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                              "Type" = "Multi-Year",
                                                                                              "Percent Sold" = 10,
                                                                                              "Total Sold" = totalSold1year,
                                                                                              "Price" = NC1yr[futuresMarketRow]))
                  seasonalSaleActualized1year = arrange(seasonalSaleActualized1year, Date)
                  
                  if (multiyearTriggers$Date[mytRow] %within% interval1 || multiyearTriggers$Date[mytRow] %within% interval2) {
                    if (nrow(seasonalSaleActualized) == 0 || min(abs(difftime(multiyearTriggers$Date[mytRow], seasonalSaleActualized$Date))) >= 7) {
                      if (totalSold < 60) {  
                        tRow = which(marketingYear$Date[row] == triggers$Date)
                        totalSold = totalSold + 10
                        seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = triggers$Date[tRow], 
                                                                                          "Percentile" = triggers$Percentile[tRow],
                                                                                          "Type" = multiyearTriggers$Type[mytRow],
                                                                                          "Percent Sold" = 10,
                                                                                          "Total Sold" = totalSold,
                                                                                          "Price" = NC[futuresMarketRow]))
                        seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                      }
                    }
                  }
                }  
              }
            }
          }
        }
        
        #Keep going 
        if (row <= nrow(marketingYear2)) {
          if (marketingYear$Date[row] %in% multiyearTriggers$Date) {
            mytRow = which(marketingYear$Date[row] == multiyearTriggers$Date)
            futuresMarketRow = which(marketingYear$Date[row] == futuresMarket$Date)
            
            if (!(multiyearTriggers$Date[mytRow] %within% interval4)) {
              if (nrow(seasonalSaleActualized2year) != 0) {
                if (abs(difftime(multiyearTriggers$Date[mytRow], seasonalSaleActualized2year$Date[nrow(seasonalSaleActualized2year)])) >= 7) {
                  if (multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High") {
                    if (totalSold2year < 60) {
                      totalSold2year = totalSold2year + 10
                      seasonalSaleActualized2year = rbind(seasonalSaleActualized2year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                                  "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                                  "Type" = "Multi-Year",
                                                                                                  "Percent Sold" = 10,
                                                                                                  "Total Sold" = totalSold2year,
                                                                                                  "Price" = NC2yr[futuresMarketRow]))
                      seasonalSaleActualized2year = arrange(seasonalSaleActualized2year, Date)
                    }
                  }
                }
              }
              
              else {
                if (multiyearTriggers$Type[mytRow] == "Ten Day High" || multiyearTriggers$Type[mytRow] == "All Time High") {
                  totalSold2year = totalSold2year + 10
                  seasonalSaleActualized2year = rbind(seasonalSaleActualized2year, data.frame("Date" = multiyearTriggers$Date[mytRow], 
                                                                                              "Percentile" = multiyearTriggers$Percentile[mytRow],
                                                                                              "Type" = "Multi-Year",
                                                                                              "Percent Sold" = 10,
                                                                                              "Total Sold" = totalSold2year,
                                                                                              "Price" = NC2yr[futuresMarketRow]))
                  seasonalSaleActualized2year = arrange(seasonalSaleActualized2year, Date)
                }
              }
            }
          }
        }
      }
      #check if the day is a trigger date and if the sale was already actualized in the multiyear sales
      if (is.null(cropYear1) || !is.null(cropYear1)) {
        if (!(marketingYear$Date[row] %in% seasonalSaleActualized$Date)) {
          if (marketingYear$Date[row] %within% intervalPost) {
            if (nrow(seasonalSaleActualized) == 0 || abs(difftime(marketingYear$Date[row], seasonalSaleActualized$Date[nrow(seasonalSaleActualized)])) >= 7) {
              percentRemaining = 100 - totalSold
              if (percentRemaining > 0) {
                
                ################# STARTED OCT SALES MODIFICATIONS HERE ################### 
                
                if ((type == "corn" && month(marketingYear$Date[row]) == 10) || (type == "soybean" && month(marketingYear$Date[row]) == 10)) {
                  # if the day is within an Oct sale date
                  day = day(marketingYear$Date[row])
                  if (day == 4 || day == 5 || day == 6 || day == 7) { 
                    if (percentRemaining > 75) {
                      # Oct sales are 25%
                      percentSold = (percentRemaining / 4) #for MY sales at 25% each
                      totalSold = totalSold + percentSold
                      if (MY == TRUE && (is.null(tail(seasonalSaleActualized$Total.Sold, 1)) || totalSold > tail(seasonalSaleActualized$Total.Sold, 1))) {
                        totalSoldTemp = totalSold
                        if (length(tail(seasonalSaleActualized$Total.Sold, 1)) == 0) {
                          totalSold = percentSold
                        } else {
                          totalSold = tail(seasonalSaleActualized$Total.Sold, 1)
                        }
                        seasonalSaleActualized$Total.Sold[nrow(seasonalSaleActualized)] = totalSoldTemp
                        seasonalSaleActualized = rbind(seasonalSaleActualized, data.frame("Date" = marketingYear$Date[row],
                                                                                          "Percentile" = marketingYear$Percentile[row],
                                                                                          "Type" = "Seasonal",
                                                                                          "Percent Sold" = percentSold,
                                                                                          "Total Sold" = totalSold,
                                                                                          "Price" = marketingYear$`Price`[row]))
                        totalSold = totalSoldTemp
                        seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                        percentSold = 0
                        for (i in 1:nrow(seasonalSaleActualized)) {
                          seasonalSaleActualized$Total.Sold[i] = percentSold + seasonalSaleActualized$Percent.Sold[i]
                          percentSold = seasonalSaleActualized$Total.Sold[i]
                        }
                      }
                      else {
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
                  else if (day == 11 || day == 12 || day == 13 || day == 14) {
                    if (percentRemaining > 50) {
                      # Oct sales are 25% each
                      percentSold = (percentRemaining / 3)
                      totalSold = totalSold + percentSold
                      if (MY == TRUE && (is.null(tail(seasonalSaleActualized$Total.Sold, 1)) || totalSold > tail(seasonalSaleActualized$Total.Sold, 1))) {
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
                        seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                        percentSold = 0
                        for (i in 1:nrow(seasonalSaleActualized)) {
                          seasonalSaleActualized$Total.Sold[i] = percentSold + seasonalSaleActualized$Percent.Sold[i]
                          percentSold = seasonalSaleActualized$Total.Sold[i]
                        }
                      }
                      else {
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
                else if (day == 18 || day == 19 || day == 20 || day == 21) {
                  if (percentRemaining > 25) {
                    #Oct sales are 25% each
                    percentSold = (percentRemaining / 2)
                    totalSold = totalSold + percentSold
                    if (MY == TRUE && (is.null(tail(seasonalSaleActualized$Total.Sold, 1)) || totalSold > tail(seasonalSaleActualized$Total.Sold, 1))) {
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
                      seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                      percentSold = 0
                      for (i in 1:nrow(seasonalSaleActualized)) {
                        seasonalSaleActualized$Total.Sold[i] = percentSold + seasonalSaleActualized$Percent.Sold[i]
                        percentSold = seasonalSaleActualized$Total.Sold[i]
                      }
                    }
                    else {
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
                else if (day == 25 || day == 26 || day == 27 || day == 28) {
                  if (percentRemaining <= 25) {
                    #Oct sales are 25% each
                    percentSold = (percentRemaining / 1)
                    totalSold = totalSold + percentSold
                    if (MY == TRUE && (is.null(tail(seasonalSaleActualized$Total.Sold, 1)) || totalSold > tail(seasonalSaleActualized$Total.Sold, 1))) {
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
                      seasonalSaleActualized = arrange(seasonalSaleActualized, Date)
                      percentSold = 0
                      for (i in 1:nrow(seasonalSaleActualized)) {
                        seasonalSaleActualized$Total.Sold[i] = percentSold + seasonalSaleActualized$Percent.Sold[i]
                        percentSold = seasonalSaleActualized$Total.Sold[i]
                      }
                    }
                    else {
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
  }
  
  
  if (MY == TRUE) {
    cropYear[['SS Actualized MY']] = seasonalSaleActualized
    if (!is.null(cropYear1)) {
      cropYear1[['SS Actualized MY']] = seasonalSaleActualized1year
      cropYear2[['SS Actualized MY']] = seasonalSaleActualized2year
      actualizedList = list(cropYear, cropYear1, cropYear2)
    } else {
      actualizedList = cropYear
    }
  }
  
  if (MY == FALSE) {
    cropYear[['SS Actualized']] = seasonalSaleActualized
    actualizedList = cropYear
  }
  
  return(actualizedList)
}

if (type == "corn") {
  # Seasonal Sales loading
  for (i in 1:length(Corn_CropYearObjects)) {
    Corn_CropYearObjects[[i]] = isActualizedSS(Corn_CropYearObjects[[i]], NULL, NULL, Corn_FuturesMarket, MY = FALSE)
  }
  
  # Mutli-year loading
  if ("Marketing Year MY" %in% names(Corn_CropYearObjects[[1]])) {
    for (i in 1:(length(Corn_CropYearObjects) - 2)) {
      temp = list()
      temp[[1]] = isActualizedSS(Corn_CropYearObjects[[i]], Corn_CropYearObjects[[i + 1]], Corn_CropYearObjects[[i + 2]], Corn_FuturesMarket, MY = TRUE)
      Corn_CropYearObjects[[i]] = temp[[1]][[1]]
      Corn_CropYearObjects[[i + 1]] = temp[[1]][[2]]
      Corn_CropYearObjects[[i + 2]] = temp[[1]][[3]]
    }
    
    for (i in (length(Corn_CropYearObjects) - 1):length(Corn_CropYearObjects)) {
      Corn_CropYearObjects[[i]] = isActualizedSS(Corn_CropYearObjects[[i]], NULL, NULL, Corn_FuturesMarket, MY = TRUE)
    }
  }
}

if (type == "soybean") {
  # Seasonal Sales loading
  for (i in 1:length(Soybean_CropYearObjects)) {
    Soybean_CropYearObjects[[i]] = isActualizedSS(Soybean_CropYearObjects[[i]], NULL, NULL, Soybean_FuturesMarket, MY = FALSE)
  }
  
  # Mutli-year loading
  if ("Marketing Year MY" %in% names(Soybean_CropYearObjects[[1]])) {
    for (i in 1:(length(Soybean_CropYearObjects) - 2)) {
      temp = list()
      temp[[1]] = isActualizedSS(Soybean_CropYearObjects[[i]], Soybean_CropYearObjects[[i + 1]], Soybean_CropYearObjects[[i + 2]], Soybean_FuturesMarket, MY = TRUE)
      Soybean_CropYearObjects[[i]] = temp[[1]][[1]]
      Soybean_CropYearObjects[[i + 1]] = temp[[1]][[2]]
      Soybean_CropYearObjects[[i + 2]] = temp[[1]][[3]]
    }
    
    for (i in (length(Soybean_CropYearObjects) - 1):length(Soybean_CropYearObjects)) {
      Soybean_CropYearObjects[[i]] = isActualizedSS(Soybean_CropYearObjects[[i]], NULL, NULL, Soybean_FuturesMarket, MY = TRUE)
    }
  }
}
