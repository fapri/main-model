# Soybean

getCropType = function(){
  type = readline(prompt = "Enter crop type (soybean or corn. Anything else to quit): ")
  type = tolower(type)
  
  if(type != "soybean" && type != "corn"){
    type = "quit"
  }
  return(type)
}

type = getCropType()

if(type == "soybean"){
  Soybean_CropYears = read.csv("Data/Soybean_CropYears.csv", stringsAsFactors = FALSE)
  Soybean_FuturesMarket = read.csv("Data/Soybean_FuturesMarket.csv", stringsAsFactors = FALSE)
  Soybean_Basis = read.csv("Data/Soybean_Basis.csv", stringsAsFactors = FALSE)
  Soybean_Baseline = read.csv("Data/Soybean_Baseline.csv", stringsAsFactors = FALSE)
  
  lockBinding("Soybean_CropYears", globalenv())
  lockBinding("Soybean_FuturesMarket", globalenv())
  lockBinding("Soybean_Basis", globalenv())
  lockBinding("Soybean_Baseline", globalenv())
}

if(type == "corn"){
  Corn_CropYears = read.csv("Data/Corn_CropYears.csv", stringsAsFactors = FALSE)
  Corn_FuturesMarket = read.csv("Data/Corn_FuturesMarket.csv", stringsAsFactors = FALSE)
  Corn_Basis = read.csv("Data/Corn_Basis.csv", stringsAsFactors = FALSE)
  Corn_Baseline = read.csv("Data/Corn_Baseline.csv", stringsAsFactors = FALSE)
  
  lockBinding("Corn_CropYears", globalenv())
  lockBinding("Corn_FuturesMarket", globalenv())
  lockBinding("Corn_Basis", globalenv())
  lockBinding("Corn_Baseline", globalenv())
}


# Creates an object that holds different features
#   All Time High
#   10 Day High
#   95% of Ten Day High
createFeatures = function(date, OC, NC, rowMax) {
  # All Time High
  ATH_OC = NA
  ATH_OC[1] = OC[1]
  for (row in 2:rowMax) {
    if(OC[row] > ATH_OC[row - 1])
      ATH_OC[row] = OC[row]
    else 
      ATH_OC[row] = ATH_OC[row - 1]
  }
  
  ATH_NC = NA
  ATH_NC[1] = OC[1]
  for (row in 2:rowMax) {
    if(NC[row] > ATH_NC[row - 1])
      ATH_NC[row] = NC[row]
    else 
      ATH_NC[row] = ATH_NC[row - 1]
  }
  
  ATH = data.frame("Date" = mdy(date), "OC" = ATH_OC, "NC" = ATH_NC)
  
  # Ten Day High
  TDH_OC = NA
  for(row in 1:(rowMax - 10)) {
    tempCount = row+9
    TDH_OC[tempCount + 1] = max(OC[row:tempCount])
  }
  
  TDH_NC = NA
  for(row in 1:(rowMax - 10)) {
    tempCount = row + 9
    TDH_NC[tempCount + 1] = max(NC[row:tempCount])
  }
  
  TDH = data.frame("Date" = mdy(date),"OC" = TDH_OC, "NC" = TDH_NC)
  
  # 95% of Ten Day High
  TDH_OC_95 = NA
  TDH_NC_95 = NA
  for(row in 11:(rowMax)) {
    TDH_OC_95[row] = TDH_OC[row] * 0.95
    TDH_NC_95[row] = TDH_NC[row] * 0.95
  }
  
  TDH_95 = data.frame("Date" = mdy(date), "OC" = TDH_OC_95 , "NC" = TDH_NC_95)
  
  featuresObj = list("All Time High" = ATH, "Ten Day High" = TDH, "95% of Ten Day High" = TDH_95)
  
  return(featuresObj)
}

# Creates a crop year based on the input parameters
createCropYear = function(cropYear, startDate, stopDate, type) {
  harvest = paste("09-01", toString(year(mdy(startDate))), sep="-")
  marchUpdate1 = paste("03-01", toString(year(mdy(startDate))), sep="-")
  marchUpdate2 = paste("03-01", toString(year(mdy(stopDate))), sep="-")
  
  intervalPre = interval(mdy(startDate), mdy(harvest) - days(1))
  intervalPost = interval(mdy(harvest), mdy(stopDate))
  intervalPrePost = data.frame(intervalPre, intervalPost)
  
  if(type == "soybean"){
    futuresMarket = Soybean_FuturesMarket
    basisData = Soybean_Basis
    baseline = Soybean_Baseline
  }
  
  if(type == "corn"){
    futuresMarket = Corn_FuturesMarket
    basisData = Corn_Basis
    baseline = Corn_Baseline
  }
  
  marketingYearPre = futuresMarket[which(mdy(futuresMarket$Date) %within% intervalPre), c(1, 3)]
  marketingYearPre = setNames(marketingYearPre, c("Date","Price"))
  marketingYearPost = futuresMarket[which(mdy(futuresMarket$Date) %within% intervalPost), c(1, 2)]
  marketingYearPost = setNames(marketingYearPost, c("Date","Price"))
  marketingYear = rbind(marketingYearPre, marketingYearPost)
  
  marketingYearMY = futuresMarket[which(mdy(futuresMarket$Date) %within% intervalPrePost), c(1, 3)]
  marketingYearMY = setNames(marketingYearMY, c("Date","NC Price"))
  
  marketingYear[,c("Baseline", "60th", "70th", "80th", "90th", "95th", "Basis", "Percentile")] = NA
  marketingYearMY[,c("NC Baseline", "NC60th", "NC70th", "NC80th", "NC90th", "NC95th", "Basis", "Percentile")] = NA
  
  interval1 = interval(mdy(startDate) - months(5), mdy(marchUpdate1) - days(1))
  interval2 = interval(mdy(marchUpdate1), mdy(harvest) - days(1))
  interval3 = interval(mdy(harvest), mdy(marchUpdate2) - days(1))
  interval4 = interval(mdy(marchUpdate2), mdy(stopDate))
  
  for(row in 1:nrow(marketingYear)) {
    if(mdy(marketingYear$Date[row]) %within% interval1) {
      basis = marketingYear[row, "Basis"] = marketingYearMY[row, "Basis"] = basisData[which(basisData$CropYearStart == year(interval1$start)), 3]
      marketingYear[row, "Baseline"] = marketingYearMY[row, "NC Baseline"] = baseline[which(mdy(baseline$Date) %within% interval1), 8] - basis
      marketingYear[row, "60th"] = marketingYearMY[row, "NC60th"] = baseline[which(mdy(baseline$Date) %within% interval1), 9] - basis
      marketingYear[row, "70th"] = marketingYearMY[row, "NC70th"] = baseline[which(mdy(baseline$Date) %within% interval1), 10] - basis
      marketingYear[row, "80th"] = marketingYearMY[row, "NC80th"] = baseline[which(mdy(baseline$Date) %within% interval1), 11] - basis
      marketingYear[row, "90th"] = marketingYearMY[row, "NC90th"] = baseline[which(mdy(baseline$Date) %within% interval1), 12] - basis
      marketingYear[row, "95th"] = marketingYearMY[row, "NC95th"] = baseline[which(mdy(baseline$Date) %within% interval1), 13] - basis
    }
    else if(mdy(marketingYear$Date[row]) %within% interval2) {
      basis = marketingYear[row, "Basis"] = marketingYearMY[row, "Basis"] = basisData[which(basisData$CropYearEnd == year(interval2$start)), 3]
      marketingYear[row, "Baseline"] = marketingYearMY[row, "NC Baseline"] = baseline[which(mdy(baseline$Date) %within% interval2), 8] - basis
      marketingYear[row, "60th"] = marketingYearMY[row, "NC60th"] = baseline[which(mdy(baseline$Date) %within% interval2), 9] - basis
      marketingYear[row, "70th"] = marketingYearMY[row, "NC70th"] = baseline[which(mdy(baseline$Date) %within% interval2), 10] - basis
      marketingYear[row, "80th"] = marketingYearMY[row, "NC80th"] = baseline[which(mdy(baseline$Date) %within% interval2), 11] - basis
      marketingYear[row, "90th"] = marketingYearMY[row, "NC90th"] = baseline[which(mdy(baseline$Date) %within% interval2), 12] - basis
      marketingYear[row, "95th"] = marketingYearMY[row, "NC95th"] = baseline[which(mdy(baseline$Date) %within% interval2), 13] - basis
    }
    else if(mdy(marketingYear$Date[row]) %within% interval3) {
      basis = marketingYear[row, "Basis"] = marketingYearMY[row, "Basis"] = basisData[which(basisData$CropYearStart == year(interval3$start)), 3]
      marketingYear[row, "Baseline"] = baseline[which(mdy(baseline$Date) %within% interval3), 2] - basis
      marketingYear[row, "60th"] = baseline[which(mdy(baseline$Date) %within% interval3), 3] - basis
      marketingYear[row, "70th"] = baseline[which(mdy(baseline$Date) %within% interval3), 4] - basis
      marketingYear[row, "80th"] = baseline[which(mdy(baseline$Date) %within% interval3), 5] - basis
      marketingYear[row, "90th"] = baseline[which(mdy(baseline$Date) %within% interval3), 6] - basis
      marketingYear[row, "95th"] = baseline[which(mdy(baseline$Date) %within% interval3), 7] - basis
      
      #NC Baseline
      marketingYearMY[row, "NC Baseline"] = baseline[which(mdy(baseline$Date) %within% interval3), 8] - basis
      marketingYearMY[row, "NC60th"] = baseline[which(mdy(baseline$Date) %within% interval3), 9] - basis
      marketingYearMY[row, "NC70th"] = baseline[which(mdy(baseline$Date) %within% interval3), 10] - basis
      marketingYearMY[row, "NC80th"] = baseline[which(mdy(baseline$Date) %within% interval3), 11] - basis
      marketingYearMY[row, "NC90th"] = baseline[which(mdy(baseline$Date) %within% interval3), 12] - basis
      marketingYearMY[row, "NC95th"] = baseline[which(mdy(baseline$Date) %within% interval3), 13] - basis
    }
    else if(mdy(marketingYear$Date[row]) %within% interval4) {
      basis = marketingYear[row, "Basis"] = marketingYearMY[row, "Basis"] = basisData[which(basisData$CropYearEnd == year(interval4$start)), 3]
      marketingYear[row, "Baseline"] = baseline[which(mdy(baseline$Date) %within% interval4), 2] - basis
      marketingYear[row, "60th"] = baseline[which(mdy(baseline$Date) %within% interval4), 3] - basis
      marketingYear[row, "70th"] = baseline[which(mdy(baseline$Date) %within% interval4), 4] - basis
      marketingYear[row, "80th"] = baseline[which(mdy(baseline$Date) %within% interval4), 5] - basis
      marketingYear[row, "90th"] = baseline[which(mdy(baseline$Date) %within% interval4), 6] - basis
      marketingYear[row, "95th"] = baseline[which(mdy(baseline$Date) %within% interval4), 7] - basis
      
      #NC Baseline
      marketingYearMY[row, "NC Baseline"] = baseline[which(mdy(baseline$Date) %within% interval4), 8] - basis
      marketingYearMY[row, "NC60th"] = baseline[which(mdy(baseline$Date) %within% interval4), 9] - basis
      marketingYearMY[row, "NC70th"] = baseline[which(mdy(baseline$Date) %within% interval4), 10] - basis
      marketingYearMY[row, "NC80th"] = baseline[which(mdy(baseline$Date) %within% interval4), 11] - basis
      marketingYearMY[row, "NC90th"] = baseline[which(mdy(baseline$Date) %within% interval4), 12] - basis
      marketingYearMY[row, "NC95th"] = baseline[which(mdy(baseline$Date) %within% interval4), 13] - basis
    }
  }
  
  # Determines the percentile
  for(row in 1:nrow(marketingYear)) {
    if(marketingYear$Price[row] > marketingYear$`95th`[row])
      marketingYear[row, "Percentile"] = 95
    else if(marketingYear$Price[row] >= marketingYear$`90th`[row])
      marketingYear[row, "Percentile"] = 90
    else if(marketingYear$Price[row] >= marketingYear$`80th`[row])
      marketingYear[row, "Percentile"] = 80
    else if(marketingYear$Price[row] >= marketingYear$`70th`[row])
      marketingYear[row, "Percentile"] = 70
    else if(marketingYear$Price[row] >= marketingYear$`60th`[row])
      marketingYear[row, "Percentile"] = 60
    else if(marketingYear$Price[row] >= marketingYear$Baseline[row])
      marketingYear[row, "Percentile"] = 50
    else
      marketingYear[row, "Percentile"] = 0
  }
  
  for(row in 1:nrow(marketingYearMY)) {
    if(marketingYearMY$`NC Price`[row] > marketingYearMY$`NC95th`[row])
      marketingYearMY[row, "Percentile"] = 95
    else if(marketingYearMY$`NC Price`[row] >= marketingYearMY$`NC90th`[row])
      marketingYearMY[row, "Percentile"] = 90
    else if(marketingYearMY$`NC Price`[row] >= marketingYearMY$`NC80th`[row])
      marketingYearMY[row, "Percentile"] = 80
    else if(marketingYearMY$`NC Price`[row] >= marketingYearMY$`NC70th`[row])
      marketingYearMY[row, "Percentile"] = 70
    else if(marketingYearMY$`NC Price`[row] >= marketingYearMY$`NC60th`[row])
      marketingYearMY[row, "Percentile"] = 60
    else if(marketingYearMY$`NC Price`[row] >= marketingYearMY$`NC Baseline`[row])
      marketingYearMY[row, "Percentile"] = 50
    else
      marketingYearMY[row, "Percentile"] = 0
  }
  
  cropYearObj = list("Crop Year" = cropYear, "Start Date" = startDate, "Stop Date" = stopDate, "Interval" = interval, 
                     "Marketing Year" = marketingYear, "Pre/Post Interval" = intervalPrePost, "Marketing Year MY" = marketingYearMY)
  
  return(cropYearObj)
}

if (type == "soybean"){
  # Create the crop year objects
  Soybean_CropYearObjects = list()
  for(i in 1:nrow(Soybean_CropYears)) {
    Soybean_CropYearObjects[[i]] = createCropYear(Soybean_CropYears[i,1], Soybean_CropYears[i,2], Soybean_CropYears[i,3], type)
  }
  
  # Create the features object
  Soybean_FeaturesObject = createFeatures(Soybean_FuturesMarket$Date, Soybean_FuturesMarket$NearbyOC, 
                                          Soybean_FuturesMarket$NovNC, nrow(Soybean_FuturesMarket))
}

if(type == "corn"){
  # Create the crop year objects
  Corn_CropYearObjects = list()
  for(i in 1:nrow(Corn_CropYears)) {
    Corn_CropYearObjects[[i]] = createCropYear(Corn_CropYears[i,1], Corn_CropYears[i,2], Corn_CropYears[i,3], type)
  }
  
  # Create the features object
  Corn_FeaturesObject = createFeatures(Corn_FuturesMarket$Date, Corn_FuturesMarket$NearbyOC, Corn_FuturesMarket$DecNC, nrow(Corn_FuturesMarket))
} else if (type != "soybean" && type != "corn"){
  stop("Quitting program now")
}