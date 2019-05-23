# Corn
# Multi-Year
# Marketing Year Loading

multiyearTrigger = function(cropYear) {
  multiYearTriggers = data.frame()
  
  jan1 = paste("01-01", toString(year(mdy(cropYear$`Start Date`))), sep="-")
  dec31 = paste("12-31", toString(year(mdy(cropYear$`Start Date`))), sep="-")
  firstYearInterval = interval(mdy(jan1), mdy(dec31))
  
  marketingYearMY = cropYear[['Marketing Year MY']]
  
  # Multi Year trigger loading
  for(row in 2:nrow(marketingYearMY)) {
    if(mdy(marketingYearMY$Date[row]) %within% firstYearInterval){
      if (isTenDayHighMY(mdy(marketingYearMY$Date[row]), marketingYearMY$`NC Price`[row], marketingYearMY$Percentile[row], 
                         Corn_FeaturesObject$`95% of Ten Day High`)) {
        multiYearTriggers = rbind(multiYearTriggers, data.frame("Date" = marketingYearMY$Date[row],
                                                                "Previous Percentile" = marketingYearMY$Percentile[row - 1],
                                                                "Percentile" = marketingYearMY$Percentile[row],
                                                                "Type" = "Ten Day High"))
      }
      
      else if (isAllTimeHighMY(mdy(marketingYearMY$Date[row]), marketingYearMY$`NC Price`[row], marketingYearMY$Percentile[row],
                               Corn_FeaturesObject$`95% of Ten Day High`, Corn_FeaturesObject$`All Time High`)) {
        multiYearTriggers = rbind(multiYearTriggers, data.frame("Date" = marketingYearMY$Date[row], 
                                                                "Previous Percentile" = marketingYearMY$Percentile[row - 1],
                                                                "Percentile" = marketingYearMY$Percentile[row],
                                                                "Type" = "All Time High"))
      }
    }
  }
  
  cropYear[['MultiYear Triggers']] = multiYearTriggers
  
  return(cropYear)
}

for(i in 1:length(Corn_CropYearObjects)) {
  Corn_CropYearObjects[[i]] = multiyearTrigger(Corn_CropYearObjects[[i]])
  Corn_CropYearObjects[[i]]$`MultiYear Triggers`$Date = mdy(Corn_CropYearObjects[[i]]$`MultiYear Triggers`$Date)
}


