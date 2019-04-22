# Corn 
# Seasonal Sales
# Storage

source("Corn/SeasonalSaleActualized.R")

# Extract Price data into the PO Actualized Data Frame
for (i in 1:length(Corn_CropYearObjects)){
  for(j in 1:nrow(Corn_CropYearObjects[[i]]$`SS Actualized`)){
    Corn_CropYearObjects[[i]]$`SS Actualized`$Price[j] = Corn_CropYearObjects[[i]]$`Marketing Year`$Price[which(mdy(Corn_CropYearObjects[[i]]$`Marketing Year`$Date) == Corn_CropYearObjects[[i]]$`SS Actualized`$Date[j])]
  }
}

# Interest Rate
interestRate = 0.055
# Monthly Commercial Storage Cost
monthlyCommCost = 0.05
# Three Month Minimum Storage Charge
TMMStorageCharge = 0.15
# Total cost of bin storage, 1st month
binStorage1 = 0.2469625
# Total cost of bin storage(exlcuding interest), 2nd month forward
binStorageAfter = 0.0032009009009009


getStorageCost = function(actualizedSales, marketingYear, intervalPost) {
  # Initialize variables
  storageInterval = interval(mdy(paste("11-01", toString(year(int_start(intervalPost))), sep="-")), int_end(intervalPost))
  salePrice = actualizedSales$Price
  actualizedSales$monthsSinceOct = NA
  commercialStorage = rep(0, nrow(actualizedSales))
  onFarmStorage = rep(0, nrow(actualizedSales))
  commercialPrice = rep(0, nrow(actualizedSales))
  onFarmPrice = rep(0, nrow(actualizedSales))
  
  # Calculate months since October for post harvest dates only
  for(i in 1:nrow(actualizedSales)) {
    # Check if date is in storage interval
    if(actualizedSales$Date[i] %within% storageInterval) {
      if(month(actualizedSales$Date[i]) == 9) {
        # Special case for September
        actualizedSales$monthsSinceOct[i] = 0
      }
      else {
        # Create interval from the date to post harvest October
        tempInt = interval(actualizedSales$Date[i], mdy(paste("10-01", toString(year(int_start(intervalPost))), sep="-")))
        # Calculate months since October
        actualizedSales$monthsSinceOct[i] = abs(tempInt %/% months(1))
      }
    }
  }
  
  monthsSinceOct = actualizedSales$monthsSinceOct
  
  # On farm storage formula
  for (i in 1:nrow(actualizedSales)){
    # Check that date is in post harvest
    if (actualizedSales$Date[i] %within% storageInterval){
      # Formula for on farm storage
      A = salePrice[i] * ((1 + (interestRate/12)) ^ (monthsSinceOct[i])) + binStorage1 + (binStorageAfter*(monthsSinceOct[i] - 1))
      # Comute on farm storage cost
      onFarmStorage[i] = A - salePrice[i]
      
    }
  }
  
  # Get new prices that factor storage
  for (i in 1:nrow(actualizedSales)){
    commercialPrice[i] = salePrice[i] - commercialStorage[i]
    onFarmPrice[i] = salePrice[i] - onFarmStorage[i]
  }
  
  # Create object to return
  storage = cbind(commercialStorage, onFarmStorage, commercialPrice, onFarmPrice)
  
  return(storage)
}



# Fills storage values into the Corn Crop Year object under Price Actualized
for (i in 1:length(Corn_CropYearObjects)){
  # Initialize Variables
  Corn_CropYearObjects[[i]]$`SS Actualized`$CommercialStorage = 0
  Corn_CropYearObjects[[i]]$`SS Actualized`$onFarmStorage = 0
  # Call storage function. This will return the base cost of storage
  temp = getStorageCost(Corn_CropYearObjects[[i]][["SS Actualized"]],
                        Corn_CropYearObjects[[i]][["Marketing Year"]],
                        Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  
  # Write values into Corn_CropYearObjects
  Corn_CropYearObjects[[i]]$`SS Actualized`$CommercialStorage = temp[,1]
  Corn_CropYearObjects[[i]]$`SS Actualized`$onFarmStorage = temp[,2]
  Corn_CropYearObjects[[i]]$`SS Actualized`$commercialPrice = temp[,3]
  Corn_CropYearObjects[[i]]$`SS Actualized`$onFarmPrice = temp[,4]
}


getStorageActualized = function(actualizedSales, intervalPre, intervalPost) {
  # Initialize variables
  preRows = rep(0, 9)
  postRows = rep(0, 9)
  commercialRows = NA
  onfarmRows = NA
  
  # Creates storage interval
  storageInterval = interval(mdy(paste("11-01", toString(year(int_start(intervalPost))), sep="-")), int_end(intervalPost))
  # Finds rows corresponding to pre (or post) harvest. This will be used to caluclate the respective storages
  preRows = which(actualizedSales$Date %within% intervalPre)
  postRows = which(actualizedSales$Date %within% intervalPost)
  
  # Finds the row for the first date that storage is utilized
  # This will be used to find how much crop needs to be stored
  for (i in 1:nrow(actualizedSales)){
    # Check that date is in post harvest
    if (actualizedSales$Date[i] %within% storageInterval){
      # Store the first date which storage needs to be utilized
      firstDateRow = i
      break
    }
  }
  
  # IF THE FIRST POST HARVEST DATE HAS >=50% "TOTAL.SOLD"
  if(actualizedSales$Total.Sold[firstDateRow - 1] >= 50){
    # AVERAGE SALES BEFORE STORAGE + STRICTLY ON FARM STORAGE
    storageAdjAvg = weighted.mean(actualizedSales$onFarmPrice, actualizedSales$Percent.Sold)
    # Average storage-adjusted sales in the post harvest
    # No need for pre harvest since storage begins in the post harvest
    storagePostharvestAvg = weighted.mean(actualizedSales$onFarmPrice[postRows], actualizedSales$Percent.Sold[postRows])
    commercialRows = NA
    onfarmRows = 1:nrow(actualizedSales)
  }
  
  # Creates object to return
  storageAdjustments = cbind(storageAdjAvg, storagePostharvestAvg)
  
  listReturn = list(storageAdjustments, actualizedSales, commercialRows, onfarmRows)
  
  return(listReturn)
}

# Initialize variables
storageAdjAvg = rep(0, 9)
noStorageAvg = rep(0, 9)
preharvestAverage = rep(0, 9)
postharvestAverage = rep(0, 9)
preharvestAverageStorage = rep(0, 9)
postharvestAverageStorage = rep(0, 9)
for (i in 1:length(Corn_CropYearObjects)){
  # Initialize variables
  preRows = rep(0, 9)
  postRows = rep(0, 9)
  
  # Calculates total average price, accounting for storage
  storageAdjAvg[i] = getStorageActualized(Corn_CropYearObjects[[i]][["SS Actualized"]],
                                          Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPre"]],
                                          Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])[[1]][1]
  
  # Calculates total average price, without storage
  noStorageAvg[i] = weighted.mean(Corn_CropYearObjects[[i]][["SS Actualized"]][["Price"]], 
                                  Corn_CropYearObjects[[i]][["SS Actualized"]][["Percent.Sold"]])
  
  # Finds pre harvest and post harvest rows
  preRows = which(Corn_CropYearObjects[[i]][["SS Actualized"]][["Date"]] %within% Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPre"]])
  postRows = which(Corn_CropYearObjects[[i]][["SS Actualized"]][["Date"]] %within% Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  
  # Calculates pre harvest average without storage
  preharvestAverage[i] = weighted.mean(Corn_CropYearObjects[[i]][["SS Actualized"]][["Price"]][preRows], 
                                       Corn_CropYearObjects[[i]][["SS Actualized"]][["Percent.Sold"]][preRows])
  
  # Calculates post harvest average without storage
  postharvestAverage[i] = weighted.mean(Corn_CropYearObjects[[i]][["SS Actualized"]][["Price"]][postRows], 
                                        Corn_CropYearObjects[[i]][["SS Actualized"]][["Percent.Sold"]][postRows])
  
  # Calculates post harvest average with storage
  postharvestAverageStorage[i] = getStorageActualized(Corn_CropYearObjects[[i]][["SS Actualized"]],
                                                      Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPre"]],
                                                      Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])[[1]][2]
  
  Corn_CropYearObjects[[i]][["SS Actualized"]] = getStorageActualized(Corn_CropYearObjects[[i]][["SS Actualized"]],
                                                                      Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPre"]],
                                                                      Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])[[2]]
  
  commercialRows = getStorageActualized(Corn_CropYearObjects[[i]][["SS Actualized"]],
                                        Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPre"]],
                                        Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])[[3]]
  
  onfarmRows = getStorageActualized(Corn_CropYearObjects[[i]][["SS Actualized"]],
                                    Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPre"]],
                                    Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])[[4]]
  
  if (is.na(commercialRows[1])){
    Corn_CropYearObjects[[i]][["SS Actualized"]]$finalPrice = Corn_CropYearObjects[[i]][["SS Actualized"]]$onFarmPrice
  }
  
  else{
    for (k in 1:tail(commercialRows, n=1)){
      Corn_CropYearObjects[[i]][["SS Actualized"]]$finalPrice[k] = Corn_CropYearObjects[[i]][["SS Actualized"]]$commercialPrice[k]
    }
    
    Corn_CropYearObjects[[i]][["SS Actualized"]]$finalPrice[onfarmRows] = Corn_CropYearObjects[[i]][["SS Actualized"]]$onFarmPrice[onfarmRows]
  }
  
  dates = Corn_CropYearObjects[[i]]$`SS Actualized`$Date
  dates = format(dates, "%b-%d-%y")
  dates = make.unique(dates, sep = "Split")
  
  
  Corn_CropYearObjects[[i]]$`SS Sales Summary` = data.frame(matrix(nrow = 6, ncol = length(dates)))
  
  colnames(Corn_CropYearObjects[[i]]$`SS Sales Summary`) = dates
  
  Corn_CropYearObjects[[i]]$`SS Sales Summary` = cbind("Date" = NA, Corn_CropYearObjects[[i]]$`SS Sales Summary`)
  
  Corn_CropYearObjects[[i]]$`SS Sales Summary`$`Date` =  c("Price", "Percentage", "Trigger", "On Farm", "Commercial", "Price - Storage")
  
  Corn_CropYearObjects[[i]]$`SS Sales Summary`[1,2:(length(dates) + 1)] = formatC(round(Corn_CropYearObjects[[i]]$`SS Actualized`$Price, digits = 2), format = 'f', digits = 2)
  Corn_CropYearObjects[[i]]$`SS Sales Summary`[2,2:(length(dates) + 1)] = Corn_CropYearObjects[[i]]$`SS Actualized`$Percent.Sold
  Corn_CropYearObjects[[i]]$`SS Sales Summary`[3,2:(length(dates) + 1)] = Corn_CropYearObjects[[i]]$`SS Actualized`$Type
  
  
  if (is.na(commercialRows[1])){
    Corn_CropYearObjects[[i]]$`SS Sales Summary`[4,2:(length(dates) + 1)] = formatC(round(Corn_CropYearObjects[[i]]$`SS Actualized`$onFarmStorage, digits = 2), format = 'f', digits = 2)
    Corn_CropYearObjects[[i]]$`SS Sales Summary`[5,2:(length(dates) + 1)] = 0.00
  }
  
  else{
    for (k in 1:tail(commercialRows, n=1)){
      Corn_CropYearObjects[[i]]$`SS Sales Summary`[4,(k + 1)] = 0.00
      Corn_CropYearObjects[[i]]$`SS Sales Summary`[5,(k + 1)] = formatC(round(Corn_CropYearObjects[[i]]$`SS Actualized`$CommercialStorage[k], digits = 2), format = 'f', digits = 2)
    }
    
    Corn_CropYearObjects[[i]]$`SS Sales Summary`[4,(onfarmRows + 1)] = formatC(round(Corn_CropYearObjects[[i]]$`SS Actualized`$onFarmStorage[onfarmRows], digits = 2), format = 'f', digits = 2)
    Corn_CropYearObjects[[i]]$`SS Sales Summary`[5,(onfarmRows + 1)] = 0.00
    
  }
  
  Corn_CropYearObjects[[i]]$`SS Sales Summary`[6,2:(length(dates) + 1)] = formatC(round(Corn_CropYearObjects[[i]]$`SS Actualized`$finalPrice, digits = 2), format = 'f', digits = 2)
}

# Aggregates all adjusted prices by crop year
finalizedPrices = data.frame("CropYear" = Corn_CropYears$CropYear, noStorageAvg, storageAdjAvg, preharvestAverage,
                             postharvestAverage, postharvestAverageStorage)


# Loads all prices into corn crop year object in a format ready for tables
for (i in 1:length(Corn_CropYearObjects)){
  Corn_CropYearObjects[[i]][["SS Storage"]] = data.frame(matrix(nrow = 3, ncol = 3))
  
  colnames(Corn_CropYearObjects[[i]][["SS Storage"]]) = c(" ", "No Storage", "Storage")
  
  Corn_CropYearObjects[[i]][["SS Storage"]]$` ` =  c("Total Avg Price", "Pre-Harvest Avg Price", "Post-Harvest Avg Price")
  Corn_CropYearObjects[[i]][["SS Storage"]]$`No Storage`[1] = finalizedPrices$noStorageAvg[i]
  Corn_CropYearObjects[[i]][["SS Storage"]]$`No Storage`[2] = finalizedPrices$preharvestAverage[i]
  Corn_CropYearObjects[[i]][["SS Storage"]]$`No Storage`[3] = finalizedPrices$postharvestAverage[i]
  Corn_CropYearObjects[[i]][["SS Storage"]]$`Storage`[1] = finalizedPrices$storageAdjAvg[i]
  Corn_CropYearObjects[[i]][["SS Storage"]]$`Storage`[2] = finalizedPrices$preharvestAverage[i]
  Corn_CropYearObjects[[i]][["SS Storage"]]$`Storage`[3] = finalizedPrices$postharvestAverageStorage[i]
  
}



