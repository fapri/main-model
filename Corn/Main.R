# Corn

library(lubridate)
library(dplyr)
library(ggplot2)

Corn_CropYears <- read.csv("Data/Corn_CropYears.csv", stringsAsFactors = FALSE)
Corn_FuturesMarket <- read.csv("Data/Corn_FuturesMarket.csv", stringsAsFactors = FALSE)
Corn_Basis <- read.csv("Data/Corn_Basis.csv", stringsAsFactors = FALSE)
Corn_Baseline <- read.csv("Data/Corn_Baseline.csv", stringsAsFactors = FALSE)

lockBinding("Corn_CropYears", globalenv())
lockBinding("Corn_FuturesMarket", globalenv())
lockBinding("Corn_Basis", globalenv())
lockBinding("Corn_Baseline", globalenv())


#HOLDS ALL TIME HIGH, 10 DAY HIGH, AND 95% OF TEN DAY HIGH FEATURES
createFeatures = function(date, OC, NC, rowMax) {

  #ALL TIME HIGH FEATURE
  ATH_OC = NA
  ATH_OC[1] = OC[1]
  for (row in 2:rowMax) {
    if (OC[row] > ATH_OC[row-1])
      ATH_OC[row] = OC[row]
    else 
      ATH_OC[row] = ATH_OC[row-1]
  }
  ATH_NC = NA
  ATH_NC[1] = OC[1]
  for (row in 2:rowMax) {
    if (NC[row] > ATH_NC[row-1])
      ATH_NC[row] = NC[row]
    else 
      ATH_NC[row] = ATH_NC[row-1]
  }
  ATH = data.frame("Date" = mdy(date), "OC" = ATH_OC, "NC" = ATH_NC)
  
  #TEN DAY HIGH FEATURE
  TDH_OC = NA
  for (row in 1:(rowMax-10)) {
    tempCount = row+9
    TDH_OC[tempCount+1] = max(OC[row:tempCount])
  }
  TDH_NC = NA
  for (row in 1:(rowMax-10)) {
    tempCount = row+9
    TDH_NC[tempCount+1] = max(NC[row:tempCount])
  }
  
  TDH = data.frame("Date" = mdy(date),"OC" = TDH_OC, "NC" = TDH_NC)
  
  #95% OF TEN DAY HIGH FEATURE
  TDH_OC_95 = NA
  TDH_NC_95 = NA
  for (row in 11:(rowMax)) {
    TDH_OC_95[row] = TDH_OC[row] * 0.95
    TDH_NC_95[row] = TDH_NC[row] * 0.95
  }
  
  TDH_95 = data.frame("Date" = mdy(date), "OC" = TDH_OC_95 , "NC" = TDH_NC_95)
  
  featuresObj = list("All Time High" = ATH, "Ten Day High" = TDH, "95% of Ten Day High" = TDH_95)
  
  return(featuresObj)
  
}

featuresObjects = createFeatures(Corn_FuturesMarket$Date, Corn_FuturesMarket$NearbyOC, Corn_FuturesMarket$DecNC, nrow(Corn_FuturesMarket))


# Creates a crop year based on the input parameters
createCropYear <- function(cropYear, startDate, stopDate) {
  harvest = paste("09-01", toString(year(mdy(startDate))), sep="-")
  marchUpdate1 = paste("03-01", toString(year(mdy(startDate))), sep="-")
  marchUpdate2 = paste("03-01", toString(year(mdy(stopDate))), sep="-")
  
  intervalPre = interval(mdy(startDate), mdy(harvest) - days(1))
  intervalPost = interval(mdy(harvest), mdy(stopDate))
  
  marketingYearPre <- Corn_FuturesMarket[which(mdy(Corn_FuturesMarket$Date) %within% intervalPre), c(1, 3)]
  marketingYearPre <- setNames(marketingYearPre, c("Date","Price"))
  marketingYearPost <- Corn_FuturesMarket[which(mdy(Corn_FuturesMarket$Date) %within% intervalPost), c(1, 2)]
  marketingYearPost <- setNames(marketingYearPost, c("Date","Price"))
  marketingYear <- rbind(marketingYearPre, marketingYearPost)
  
  marketingYear[,c("Baseline", "60th", "70th", "80th", "90th", "95th", "Basis", "Percentile")] <- NA
  
  interval1 = interval(mdy(startDate) - months(5), mdy(marchUpdate1) - days(1))
  interval2 = interval(mdy(marchUpdate1), mdy(harvest) - days(1))
  interval3 = interval(mdy(harvest), mdy(marchUpdate2) - days(1))
  interval4 = interval(mdy(marchUpdate2), mdy(stopDate))

  for(row in 1:nrow(marketingYear)) {
    if(mdy(marketingYear$Date[row]) %within% interval1) {
      basis = marketingYear[row, "Basis"] = Corn_Basis[which(Corn_Basis$CropYearStart == year(interval1$start)), 3]
      marketingYear[row, "Baseline"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval1), 8] - basis
      marketingYear[row, "60th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval1), 9] - basis
      marketingYear[row, "70th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval1), 10] - basis
      marketingYear[row, "80th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval1), 11] - basis
      marketingYear[row, "90th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval1), 12] - basis
      marketingYear[row, "95th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval1), 13] - basis
    }
    else if(mdy(marketingYear$Date[row]) %within% interval2) {
      basis = marketingYear[row, "Basis"] = Corn_Basis[which(Corn_Basis$CropYearEnd == year(interval2$start)), 3]
      marketingYear[row, "Baseline"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval2), 8] - basis
      marketingYear[row, "60th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval2), 9] - basis
      marketingYear[row, "70th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval2), 10] - basis
      marketingYear[row, "80th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval2), 11] - basis
      marketingYear[row, "90th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval2), 12] - basis
      marketingYear[row, "95th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval2), 13] - basis
    }
    else if(mdy(marketingYear$Date[row]) %within% interval3) {
      basis = marketingYear[row, "Basis"] = Corn_Basis[which(Corn_Basis$CropYearStart == year(interval3$start)), 3]
      marketingYear[row, "Baseline"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval3), 2] - basis
      marketingYear[row, "60th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval3), 3] - basis
      marketingYear[row, "70th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval3), 4] - basis
      marketingYear[row, "80th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval3), 5] - basis
      marketingYear[row, "90th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval3), 6] - basis
      marketingYear[row, "95th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval3), 7] - basis
    }
    else if(mdy(marketingYear$Date[row]) %within% interval4) {
      basis = marketingYear[row, "Basis"] = Corn_Basis[which(Corn_Basis$CropYearEnd == year(interval4$start)), 3]
      marketingYear[row, "Baseline"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval4), 2] - basis
      marketingYear[row, "60th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval4), 3] - basis
      marketingYear[row, "70th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval4), 4] - basis
      marketingYear[row, "80th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval4), 5] - basis
      marketingYear[row, "90th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval4), 6] - basis
      marketingYear[row, "95th"] = Corn_Baseline[which(mdy(Corn_Baseline$Date) %within% interval4), 7] - basis
    }
  }

  
  #Finds Percentiles
  for (row in 1:nrow(marketingYear)) {
    if (marketingYear$Price[row] > marketingYear$`95th`[row])
      marketingYear[row, "Percentile"] = 95
    else if (marketingYear$Price[row] >= marketingYear$`90th`[row])
      marketingYear[row, "Percentile"] = 90
    else if (marketingYear$Price[row] >= marketingYear$`80th`[row])
      marketingYear[row, "Percentile"] = 80
    else if (marketingYear$Price[row] >= marketingYear$`70th`[row])
      marketingYear[row, "Percentile"] = 70
    else if (marketingYear$Price[row] >= marketingYear$`60th`[row])
      marketingYear[row, "Percentile"] = 60
    else if (marketingYear$Price[row] >= marketingYear$Baseline[row])
      marketingYear[row, "Percentile"] = 50
    else
      marketingYear[row, "Percentile"] = 0
  }
  
  cropYearObj = list("Crop Year" = cropYear, "Start Date" = startDate, "Stop Date" = stopDate, 
                     "Interval" = interval, "Marketing Year" = marketingYear)
  
  return(cropYearObj)
}

Corn_CropYearObjects = list()
for(i in 1:nrow(Corn_CropYears)) {
  Corn_CropYearObjects[[i]] = createCropYear(Corn_CropYears[i,1], Corn_CropYears[i,2], Corn_CropYears[i,3])
}



#Started Plotting Function
plotMarketingYear = function (marketingYear){

  Plot = ggplot(marketingYear, aes(x = mdy(Date), y = Price, group = 1)) + geom_line() + xlab("Day") + ylab("Price")
  
  return(Plot)
}

for(i in 1:length(Corn_CropYearObjects)) {
  plot(plotMarketingYear(Corn_CropYearObjects[[i]]$`Marketing Year`))
}





# cropYear = Corn_CropYears[1,1]
# startDate = Corn_CropYears[1,2]
# stopDate = Corn_CropYears[1,3]


