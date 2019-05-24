# Corn 
# All Strategies
# Storage

# All prices are now being extracted in their actualization functions

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
  actualizedSales$monthsSinceOct = 0
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
  
  # Commercial Storage
  for(i in 1:nrow(actualizedSales)) {
    # Check that date is in storage interval
    if(actualizedSales$Date[i] %within% storageInterval) {
      # Calculate first part of storage function
      A = salePrice[i] * (1 + (interestRate/12)) ^ (monthsSinceOct[i])
      # Check if cost is less than three month minimum storage cost
      if((monthlyCommCost * monthsSinceOct[i]) < TMMStorageCharge) {
        B = TMMStorageCharge
      }
      else {
        B = monthlyCommCost * (monthsSinceOct[i])
      }
      
      # Compute commercial storage cost
      commercialStorage[i] = (A + B) - salePrice[i]
      
    }
  }
  
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

# Function to fill storage values into the Corn Crop Year object
fillStorage = function(actualizedSales, marketingYear, intervalPost){
  # Call storage function. This will return the base cost of storage
  temp = getStorageCost(actualizedSales,
                        marketingYear,
                        intervalPost)
  
  actualizedSales = cbind(actualizedSales, temp)
  
  return(actualizedSales)
}


for(i in 1:length(Corn_CropYearObjects)){
  # Price Objective
  Corn_CropYearObjects[[i]]$`PO Actualized` = fillStorage(Corn_CropYearObjects[[i]][["PO Actualized"]],
                                                          Corn_CropYearObjects[[i]][["Marketing Year"]],
                                                          Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  # Price Objective Multi Year
  Corn_CropYearObjects[[i]]$`PO Actualized MY` = fillStorage(Corn_CropYearObjects[[i]][["PO Actualized MY"]],
                                                             Corn_CropYearObjects[[i]][["Marketing Year"]],
                                                             Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  # Trailing Stop
  Corn_CropYearObjects[[i]]$`TS Actualized` = fillStorage(Corn_CropYearObjects[[i]][["TS Actualized"]],
                                                          Corn_CropYearObjects[[i]][["Marketing Year"]],
                                                          Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  # Trailing Stop Multi Year
  Corn_CropYearObjects[[i]]$`TS Actualized MY` = fillStorage(Corn_CropYearObjects[[i]][["TS Actualized MY"]],
                                                             Corn_CropYearObjects[[i]][["Marketing Year"]],
                                                             Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  # Seasonal Sales
  Corn_CropYearObjects[[i]]$`SS Actualized` = fillStorage(Corn_CropYearObjects[[i]][["SS Actualized"]],
                                                          Corn_CropYearObjects[[i]][["Marketing Year"]],
                                                          Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  # Seasonal Sales Multi Year
  Corn_CropYearObjects[[i]]$`SS Actualized MY` = fillStorage(Corn_CropYearObjects[[i]][["SS Actualized MY"]],
                                                             Corn_CropYearObjects[[i]][["Marketing Year"]],
                                                             Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
}

# Returns storage adjusted averages
# Contains logic that figures commercial/on-farm splits
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
  # AVERAGE SALES BEFORE STORAGE + 50% OF CROP IN ON-FARM STORAGE + REMAINING CROP IN COMMERCIAL STORAGE
  else{
    # Calculates remaining crop that needs storage
    remainingCrop = 100 - actualizedSales$Total.Sold[firstDateRow - 1]
    # Calculates the percent of crop that needs commercial storage
    commercialCrop = remainingCrop - 50
    
    for (j in firstDateRow:nrow(actualizedSales)){
      # Check if the sale can be made without splitting
      if(actualizedSales$Percent.Sold[j] <= commercialCrop && commercialCrop != 0){
        # Stores sales that are commercial
        commercialRows = c(commercialRows,j)
        # Calculates remaining crop that needs commercial storage
        commercialCrop = commercialCrop - actualizedSales$Percent.Sold[j]
      }
      
      else if (commercialCrop != 0){
        # Takes in column names. This will be used to reassign column names in new frame
        cols = match(c("Percent.Sold","Total.Sold"),names(actualizedSales))
        # Calculates the percent of a single sale that needs to be stored on farm
        # ex. (16-17 year) a 17.5% sale on 2017-03-20 had a 15% on farm split 
        onfarmSplit = actualizedSales$Percent.Sold[j] - commercialCrop
        # Calculates the percent of a single sale that needs to be stored on farm
        # ex. (16-17 year) a 17.5% sale on 2017-03-20 had a 2.5% commercial split
        commercialSplit = actualizedSales$Percent.Sold[j] - onfarmSplit
        # Calculates the new "Total.Sold" column since the sales were just split
        commercialSplitTotal = actualizedSales$Total.Sold[j - 1] + commercialSplit
        onfarmSplitTotal = onfarmSplit + commercialSplitTotal
        
        # Changes local actualizedSales to duplicate the row that needs to be split
        actualizedSales = data.frame(rbind(actualizedSales[1:j,], actualizedSales[j:nrow(actualizedSales),]))
        # Reassigns row names after spliiting
        row.names(actualizedSales) = 1:nrow(actualizedSales)
        # Loads in new values for Percent.Sold and Total.Sold
        actualizedSales[j, cols] = cbind(Percent.Sold = commercialSplit, Total.Sold = commercialSplitTotal)
        actualizedSales[j + 1, cols] = cbind(Percent.Sold = onfarmSplit, Total.Sold = onfarmSplitTotal)
        # Vector of rows that are commercial
        commercialRows = c(commercialRows, j)
        break
      }
      
      # Added to ensure proper functionality when commerical and on-farm 
      # storage is utilized but splitting a sale is not neccessary
      else if (commercialCrop == 0){
        break
      }
    }
    
    # Updates the rows in which preharvest sales were made
    preRowsNew = which(actualizedSales$Date %within% intervalPre)
    # Removes NA value
    commercialRows = commercialRows[!is.na(commercialRows)]
    # Finds rows in which onfarm storage was utilized
    onfarmRows = (last(commercialRows) + 1):nrow(actualizedSales)
    
    # Average prearvest sales
    storagePreharvestAvg = weighted.mean(actualizedSales$onFarmPrice[preRowsNew], actualizedSales$Percent.Sold[preRowsNew])
    
    if((last(preRowsNew) + 1) != commercialRows[1]){
      # Average storage-adjusted sales in the post harvest
      # No need for pre harvest since storage begins in the post harvest
      commercialPostharvestAvg = weighted.mean(actualizedSales$commercialPrice[(last(preRowsNew) + 1):commercialRows], actualizedSales$Percent.Sold[(last(preRowsNew) + 1):commercialRows])
      onfarmPostharvestAvg = weighted.mean(actualizedSales$onFarmPrice[onfarmRows], actualizedSales$Percent.Sold[onfarmRows])
      
      # Finds percent sold in commercial and onfarm storage cases
      commercialPercent = sum(actualizedSales$Percent.Sold[(last(preRowsNew) + 1):commercialRows]) * 0.01
      onfarmPercent = sum(actualizedSales$Percent.Sold[onfarmRows]) * 0.01
    }
    
    else{
      # Average storage-adjusted sales in the post harvest
      # No need for pre harvest since storage begins in the post harvest
      commercialPostharvestAvg = weighted.mean(actualizedSales$commercialPrice[commercialRows], actualizedSales$Percent.Sold[commercialRows])
      onfarmPostharvestAvg = weighted.mean(actualizedSales$onFarmPrice[onfarmRows], actualizedSales$Percent.Sold[onfarmRows])
      
      # Finds percent sold in commercial and onfarm storage cases
      commercialPercent = sum(actualizedSales$Percent.Sold[commercialRows]) * 0.01
      onfarmPercent = sum(actualizedSales$Percent.Sold[onfarmRows]) * 0.01
    }
    
    # Finds the weighted commercial and onfarm average price, weighted to the percent sold respectively
    storageCommercialPostharvestAvg = commercialPostharvestAvg * commercialPercent
    storageOnfarmPostharvestAvg = onfarmPostharvestAvg * onfarmPercent
    
    # Calculates percent sold in the preharvest and postharvest
    preharvestPercent = actualizedSales$Total.Sold[last(preRowsNew)] * 0.01
    postharvestPercent = 1 - preharvestPercent
    
    # Calculates postharvest average price, accounting for storage
    storagePostharvestAvg = (storageCommercialPostharvestAvg + storageOnfarmPostharvestAvg) / postharvestPercent
    
    # Finds the weighted preharvest and postharvest average price, weighted to the percent sold respectively
    storagePreharvestAvg2 = (storagePreharvestAvg * preharvestPercent)
    storagePostharvestAvg2 = (storagePostharvestAvg * postharvestPercent)
    
    # Finds the total average price
    storageAdjAvg = mean(storagePreharvestAvg2 + storagePostharvestAvg2)
    
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

finalizeStorage = function(actualizedSales, cropYear, intervalPre, intervalPost){
  # Initialize variables
  preRows = rep(0, 9)
  postRows = rep(0, 9)
  # Calculates total average price, accounting for storage
  storageAdjAvg = getStorageActualized(actualizedSales,
                                       intervalPre,
                                       intervalPost)[[1]][1]
  
  # Calculates total average price, without storage
  noStorageAvg = weighted.mean(actualizedSales$Price, 
                               actualizedSales$Percent.Sold)
  
  # Finds pre harvest and post harvest rows
  preRows = which(actualizedSales$Date %within% intervalPre)
  postRows = which(actualizedSales$Date %within% intervalPost)
  
  # Calculates pre harvest average without storage
  preharvestAverage = weighted.mean(actualizedSales$Price[preRows], 
                                    actualizedSales$Percent.Sold[preRows])
  
  # Calculates post harvest average without storage
  postharvestAverage = weighted.mean(actualizedSales$Price[postRows], 
                                     actualizedSales$Percent.Sold[postRows])
  
  # Calculates post harvest average with storage
  postharvestAverageStorage = getStorageActualized(actualizedSales,
                                                   intervalPre,
                                                   intervalPost)[[1]][2]
  
  actualizedSales = getStorageActualized(actualizedSales,
                                         intervalPre,
                                         intervalPost)[[2]]
  
  commercialRows = getStorageActualized(actualizedSales,
                                        intervalPre,
                                        intervalPost)[[3]]
  
  onfarmRows = getStorageActualized(actualizedSales,
                                    intervalPre,
                                    intervalPost)[[4]]
  
  if (is.na(commercialRows[1])){
    actualizedSales$finalPrice = actualizedSales$onFarmPrice
  }
  
  else{
    for (k in 1:tail(commercialRows, n=1)){
      actualizedSales$finalPrice[k] = actualizedSales$commercialPrice[k]
    }
    
    actualizedSales$finalPrice[onfarmRows] = actualizedSales$onFarmPrice[onfarmRows]
  }
  
  dates = actualizedSales$Date
  dates = format(dates, "%b-%d-%y")
  dates = make.unique(dates, sep = "Split")
  
  
  salesSummary = data.frame(matrix(nrow = 6, ncol = length(dates)))
  
  colnames(salesSummary) = dates
  
  salesSummary = cbind("Date" = NA, salesSummary)
  
  salesSummary$`Date` =  c("Price", "Percentage", "Trigger", "On Farm", "Commercial", "Price - Storage")
  
  salesSummary[1,2:(length(dates) + 1)] = formatC(round(actualizedSales$Price, digits = 2), format = 'f', digits = 2)
  salesSummary[2,2:(length(dates) + 1)] = actualizedSales$Percent.Sold
  salesSummary[3,2:(length(dates) + 1)] = actualizedSales$Type
  
  
  if (is.na(commercialRows[1])){
    salesSummary[4,2:(length(dates) + 1)] = formatC(round(actualizedSales$onFarmStorage, digits = 2), format = 'f', digits = 2)
    salesSummary[5,2:(length(dates) + 1)] = 0.00
  }
  
  else{
    for (k in 1:tail(commercialRows, n=1)){
      salesSummary[4,(k + 1)] = 0.00
      salesSummary[5,(k + 1)] = formatC(round(actualizedSales$commercialStorage[k], digits = 2), format = 'f', digits = 2)
    }
    
    salesSummary[4,(onfarmRows + 1)] = formatC(round(actualizedSales$onFarmStorage[onfarmRows], digits = 2), format = 'f', digits = 2)
    salesSummary[5,(onfarmRows + 1)] = 0.00
    
  }
  
  salesSummary[6,2:(length(dates) + 1)] = formatC(round(actualizedSales$finalPrice, digits = 2), format = 'f', digits = 2)
  
  preharvestPercent = sum(actualizedSales$Percent.Sold[preRows])
  postharvestPercent = sum(actualizedSales$Percent.Sold[postRows])
  
  finalizedPrices = data.frame("Crop Year" = cropYear, noStorageAvg, storageAdjAvg, preharvestAverage,
                               postharvestAverage, postharvestAverageStorage, preharvestPercent, postharvestPercent)
  
  listReturn = list(actualizedSales, salesSummary, finalizedPrices)
  
  return(listReturn)
  
}

# Price Objective
POfinalizedPrices = data.frame(matrix(nrow = length(Corn_CropYearObjects), ncol = 8))
colnames(POfinalizedPrices) = c("Crop Year", "noStorageAvg", "storageAdjAvg", "preharvestAverage",
                                "postharvestAverage", "postharvestAverageStorage", "preharvestPercent", 
                                "postharvestPercent")

# Price Objective Multi Year
POfinalizedPricesMY = data.frame(matrix(nrow = length(Corn_CropYearObjects), ncol = 8))
colnames(POfinalizedPricesMY) = colnames(POfinalizedPrices)

# Trailing Stop
TSfinalizedPrices = data.frame(matrix(nrow = length(Corn_CropYearObjects), ncol = 8))
colnames(TSfinalizedPrices) = colnames(POfinalizedPrices)

# Trailing Stop Multi Year
TSfinalizedPricesMY = data.frame(matrix(nrow = length(Corn_CropYearObjects), ncol = 8))
colnames(TSfinalizedPricesMY) = colnames(POfinalizedPrices)

#Seasonal Sales
SSfinalizedPrices = data.frame(matrix(nrow = length(Corn_CropYearObjects), ncol = 8))
colnames(SSfinalizedPrices) =colnames(POfinalizedPrices)

# Seasonal Sales Multi Year
SSfinalizedPricesMY = data.frame(matrix(nrow = length(Corn_CropYearObjects), ncol = 8))
colnames(SSfinalizedPricesMY) = colnames(POfinalizedPrices)

for (i in 1:length(Corn_CropYearObjects)){
  # Price Objective
  POtemp = finalizeStorage(Corn_CropYearObjects[[i]]$`PO Actualized`,
                           Corn_CropYears$CropYear[i],
                           Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPre,
                           Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  Corn_CropYearObjects[[i]]$`PO Actualized` = POtemp[[1]]
  Corn_CropYearObjects[[i]]$`Sales Summary` = POtemp[[2]]
  POfinalizedPrices[i,] = POtemp[[3]]
  
  # Price Objective Multi Year
  jan1 = paste("01-01", toString(year(mdy(Corn_CropYearObjects[[i]]$`Start Date`)) - 2), sep="-")
  POintervalPreMY = interval(mdy(jan1), int_end(Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPre))
  POtempMY = finalizeStorage(Corn_CropYearObjects[[i]]$`PO Actualized MY`,
                             Corn_CropYears$CropYear[i],
                             POintervalPreMY,
                             Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  Corn_CropYearObjects[[i]]$`PO Actualized MY` = POtempMY[[1]]
  Corn_CropYearObjects[[i]]$`PO Sales Summary MY` = POtempMY[[2]]
  POfinalizedPricesMY[i,] = POtempMY[[3]]
  
  # Trailing Stop
  TStemp = finalizeStorage(Corn_CropYearObjects[[i]]$`TS Actualized`,
                           Corn_CropYears$CropYear[i],
                           Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPre,
                           Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  Corn_CropYearObjects[[i]]$`TS Actualized` = TStemp[[1]]
  Corn_CropYearObjects[[i]]$`TS Sales Summary` = TStemp[[2]]
  TSfinalizedPrices[i,] = TStemp[[3]]
  
  # Trailing Stop Multi Year
  jan1 = paste("01-01", toString(year(mdy(Corn_CropYearObjects[[i]]$`Start Date`)) - 2), sep="-")
  TSintervalPreMY = interval(mdy(jan1), int_end(Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPre))
  TStempMY = finalizeStorage(Corn_CropYearObjects[[i]]$`TS Actualized MY`,
                             Corn_CropYears$CropYear[i],
                             TSintervalPreMY,
                             Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  Corn_CropYearObjects[[i]]$`TS Actualized MY` = TStempMY[[1]]
  Corn_CropYearObjects[[i]]$`TS Sales Summary MY` = TStempMY[[2]]
  TSfinalizedPricesMY[i,] = TStempMY[[3]]
  
  #Seasonal Sales
  SStemp = finalizeStorage(Corn_CropYearObjects[[i]]$`SS Actualized`,
                           Corn_CropYears$CropYear[i],
                           Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPre,
                           Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  Corn_CropYearObjects[[i]]$`SS Actualized` = SStemp[[1]]
  Corn_CropYearObjects[[i]]$`SS Sales Summary` = SStemp[[2]]
  SSfinalizedPrices[i,] = SStemp[[3]]
  
  # Seasonal Sales Multi Year
  jan1 = paste("01-01", toString(year(mdy(Corn_CropYearObjects[[i]]$`Start Date`)) - 2), sep="-")
  SSintervalPreMY = interval(mdy(jan1), int_end(Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPre))
  SStempMY = finalizeStorage(Corn_CropYearObjects[[i]]$`SS Actualized MY`,
                             Corn_CropYears$CropYear[i],
                             SSintervalPreMY,
                             Corn_CropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  Corn_CropYearObjects[[i]]$`SS Actualized MY` = SStempMY[[1]]
  Corn_CropYearObjects[[i]]$`SS Sales Summary MY` = SStempMY[[2]]
  SSfinalizedPricesMY[i,] = SStempMY[[3]]
}

POfinalizedPrices$`Crop Year` = Corn_CropYears$CropYear
POfinalizedPricesMY$`Crop Year` = Corn_CropYears$CropYear
TSfinalizedPrices$`Crop Year` = Corn_CropYears$CropYear
TSfinalizedPricesMY$`Crop Year` = Corn_CropYears$CropYear
SSfinalizedPrices$`Crop Year` = Corn_CropYears$CropYear
SSfinalizedPricesMY$`Crop Year` = Corn_CropYears$CropYear

finalizedPriceObject = list("POfinalizedPrices" = POfinalizedPrices,
                            "POfinalizedPricesMY" = POfinalizedPricesMY,
                            "TSfinalizedPrices" = TSfinalizedPrices, 
                            "TSfinalizedPricesMY" = TSfinalizedPricesMY,
                            "SSfinalizedPrices" = SSfinalizedPrices,
                            "SSfinalizedPricesMY" = SSfinalizedPricesMY)

makeStorageTable = function(finalizedPrices){
  storageTable = data.frame(matrix(nrow = 3, ncol = 3))
  colnames(storageTable) = c(" ", "No Storage", "Storage")
  
  storageTable$` ` =  c("Total Avg Price", "Pre-Harvest Avg Price", "Post-Harvest Avg Price")
  storageTable$`No Storage`[1] = finalizedPrices$noStorageAvg[i]
  storageTable$`No Storage`[2] = finalizedPrices$preharvestAverage[i]
  storageTable$`No Storage`[3] = finalizedPrices$postharvestAverage[i]
  storageTable$`Storage`[1] = finalizedPrices$storageAdjAvg[i]
  storageTable$`Storage`[2] = finalizedPrices$preharvestAverage[i]
  storageTable$`Storage`[3] = finalizedPrices$postharvestAverageStorage[i]
  
  return(storageTable)
}

for (i in 1:length(Corn_CropYearObjects)){
  Corn_CropYearObjects[[i]]$`PO Storage` = makeStorageTable(POfinalizedPrices)
  Corn_CropYearObjects[[i]]$`PO Storage MY` = makeStorageTable(POfinalizedPricesMY)
  Corn_CropYearObjects[[i]]$`TS Storage` = makeStorageTable(TSfinalizedPrices)
  Corn_CropYearObjects[[i]]$`TS Storage MY` = makeStorageTable(TSfinalizedPricesMY)
  Corn_CropYearObjects[[i]]$`SS Storage` = makeStorageTable(SSfinalizedPrices)
  Corn_CropYearObjects[[i]]$`SS Storage MY` = makeStorageTable(SSfinalizedPricesMY)
}

makeResultsTable = function(finalizedPrices){
  resultsTable = data.frame(matrix(nrow = 4, ncol = 3))
  colnames(resultsTable) = c(" ", "No Storage", "Storage")
  
  resultsTable$` ` =  c("Total Avg Price", "Pre-Harvest Avg Price", "Post-Harvest Avg Price", "USDA Avergage (Basis Adjusted)")
  resultsTable$`No Storage`[2] = weighted.mean(finalizedPrices$preharvestAverage, finalizedPrices$preharvestPercent)
  resultsTable$`No Storage`[3] = weighted.mean(finalizedPrices$postharvestAverage, finalizedPrices$postharvestPercent)
  resultsTable$`Storage`[2] = weighted.mean(finalizedPrices$preharvestAverage, finalizedPrices$preharvestPercent)
  resultsTable$`Storage`[3] = weighted.mean(finalizedPrices$postharvestAverageStorage, finalizedPrices$postharvestPercent)
  
  preharvestSum = sum(finalizedPrices$preharvestPercent)
  postharvestSum = sum(finalizedPrices$postharvestPercent)
  
  resultsTable$`No Storage`[1] = ((resultsTable$`No Storage`[2] * (preharvestSum * 0.01)) + (resultsTable$`No Storage`[3] * (postharvestSum * 0.01)))/ ((preharvestSum + postharvestSum) * 0.01)
  resultsTable$`Storage`[1] = ((resultsTable$`Storage`[2] * (preharvestSum * 0.01)) + (resultsTable$`Storage`[3] * (postharvestSum * 0.01)))/ ((preharvestSum + postharvestSum) * 0.01)
  
  resultsTable$`No Storage`[4] = 4.75
  resultsTable$`Storage`[4] = NA
  
  return(resultsTable)
}

finalizedPriceObject[["POResultsTable"]] = makeResultsTable(finalizedPriceObject[[1]])
finalizedPriceObject[["POResultsTableMY"]] = makeResultsTable(finalizedPriceObject[[2]])
finalizedPriceObject[["TSResultsTable"]] = makeResultsTable(finalizedPriceObject[[3]])
finalizedPriceObject[["TSResultsTableMY"]] = makeResultsTable(finalizedPriceObject[[4]])
finalizedPriceObject[["SSResultsTable"]] = makeResultsTable(finalizedPriceObject[[5]])
finalizedPriceObject[["SSResultsTableMY"]] = makeResultsTable(finalizedPriceObject[[6]])