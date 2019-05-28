# Soybean
# Multi-Year
# Marketing Year Loading

# COMPATABLE WITH CORN AND SOYBEAN

multiyearTrigger = function(cropYear, featuresObject) {
  multiYearTriggers = data.frame()
  
  jan1 = paste("01-01", toString(year(mdy(cropYear$`Start Date`))), sep="-")
  dec31 = paste("12-31", toString(year(mdy(cropYear$`Start Date`))), sep="-")
  firstYearInterval = interval(mdy(jan1), mdy(dec31))
  
  marketingYearMY = cropYear[['Marketing Year MY']]
  
  # Multi Year trigger loading
  for(row in 2:nrow(marketingYearMY)) {
    if(mdy(marketingYearMY$Date[row]) %within% firstYearInterval){
      if (isTenDayHigh(mdy(marketingYearMY$Date[row]), marketingYearMY$`NC Price`[row], marketingYearMY$Percentile[row], 
                       cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                       featuresObject$`95% of Ten Day High`, MY = TRUE)) {
        multiYearTriggers = rbind(multiYearTriggers, data.frame("Date" = marketingYearMY$Date[row],
                                                                "Previous Percentile" = marketingYearMY$Percentile[row - 1],
                                                                "Percentile" = marketingYearMY$Percentile[row],
                                                                "Type" = "Ten Day High"))
      }
      
      else if (isAllTimeHigh(mdy(marketingYearMY$Date[row]), marketingYearMY$`NC Price`[row], marketingYearMY$Percentile[row],
                             cropYear$`Pre/Post Interval`$intervalPre, cropYear$`Pre/Post Interval`$intervalPost, 
                             featuresObject$`95% of Ten Day High`, featuresObject$`All Time High`, MY = TRUE)) {
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

if(type == "corn"){
  for(i in 1:length(Corn_CropYearObjects)) {
    Corn_CropYearObjects[[i]] = multiyearTrigger(Corn_CropYearObjects[[i]], Corn_FeaturesObject)
    Corn_CropYearObjects[[i]]$`MultiYear Triggers`$Date = mdy(Corn_CropYearObjects[[i]]$`MultiYear Triggers`$Date)
  }
}

if(type == "soybean"){
  for(i in 1:length(Soybean_CropYearObjects)) {
    Soybean_CropYearObjects[[i]] = multiyearTrigger(Soybean_CropYearObjects[[i]], Soybean_FeaturesObject)
    Soybean_CropYearObjects[[i]]$`MultiYear Triggers`$Date = mdy(Soybean_CropYearObjects[[i]]$`MultiYear Triggers`$Date)
  }
}