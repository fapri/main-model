# Corn
# Seasonal Sales
# Actualized

isActualized = function(cropYear){
  seasonalSaleActualized = data.frame(matrix(ncol = 5, nrow = 0))
  colnames(seasonalSaleActualized) = c("Date", "Percentile", "Type", "PercentSold", "TotalSold")
  
  marketingYear = cropYear[['Marketing Year']]
  marketingYear$Date = mdy(marketingYear$Date)

  totalSold = 0
  percentSold = 0
  
  for(row in 1:nrow(marketingYear)) {
    if(nrow(seasonalSaleActualized) == 0 || difftime(marketingYear$Date[row], seasonalSaleActualized$Date[nrow(seasonalSaleActualized)]) >= 7) {
      if(month(marketingYear$Date[row]) == 3) {
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
                                                                              "Total Sold" = totalSold))
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
                                                                              "Total Sold" = totalSold))
          }
        }
      }
      else if(month(marketingYear$Date[row]) == 6) {
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
                                                                              "Total Sold" = totalSold))
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
                                                                              "Total Sold" = totalSold))
          }
        }
      }
    }
  }
  
  cropYear[['SS Actualized']] = seasonalSaleActualized
  
  return(cropYear)
}

for(i in 1:length(Corn_CropYearObjects)) {
  Corn_CropYearObjects[[i]] = isActualized(Corn_CropYearObjects[[i]])
}
