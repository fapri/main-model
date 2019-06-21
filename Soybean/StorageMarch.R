# Storage
# Corn and Soybean

if(type == "corn"){
  cropYearObjects = Corn_CropYearObjects
  cropYearsList = Corn_CropYears
}

if(type == "soybean"){
  cropYearObjects = Soybean_CropYearObjects
  cropYearsList = Soybean_CropYears
}

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

# Function to fill storage values into the Crop Year object
fillStorage = function(actualizedSales, marketingYear, intervalPost){
  
  originalActualizedSaleDates = actualizedSales$Date
  marchSaleRows = which(grepl("March", actualizedSales$Type))
  actualizedSales$Date[marchSaleRows] = mdy(paste("03-01", toString(year(int_end(intervalPost))), sep="-"))
  actualizedSales = arrange(actualizedSales, Date)
  
  # Call storage function. This will return the base cost of storage
  temp = getStorageCost(actualizedSales,
                        marketingYear,
                        intervalPost)
  
  actualizedSales = cbind(actualizedSales, temp)
  
  actualizedSales = arrange(actualizedSales, Total.Sold)
  actualizedSales$Date = originalActualizedSaleDates
  
  
  return(actualizedSales)
}


for(i in 1:length(cropYearObjects)){
  # Price Objective
  cropYearObjects[[i]]$`PO Actualized` = fillStorage(cropYearObjects[[i]][["PO Actualized"]],
                                                     cropYearObjects[[i]][["Marketing Year"]],
                                                     cropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  # Price Objective Multi Year
  cropYearObjects[[i]]$`PO Actualized MY` = fillStorage(cropYearObjects[[i]][["PO Actualized MY"]],
                                                        cropYearObjects[[i]][["Marketing Year"]],
                                                        cropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  # Trailing Stop
  cropYearObjects[[i]]$`TS Actualized` = fillStorage(cropYearObjects[[i]][["TS Actualized"]],
                                                     cropYearObjects[[i]][["Marketing Year"]],
                                                     cropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  # Trailing Stop Multi Year
  cropYearObjects[[i]]$`TS Actualized MY` = fillStorage(cropYearObjects[[i]][["TS Actualized MY"]],
                                                        cropYearObjects[[i]][["Marketing Year"]],
                                                        cropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  # Seasonal Sales
  cropYearObjects[[i]]$`SS Actualized` = fillStorage(cropYearObjects[[i]][["SS Actualized"]],
                                                     cropYearObjects[[i]][["Marketing Year"]],
                                                     cropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  # Seasonal Sales Multi Year
  cropYearObjects[[i]]$`SS Actualized MY` = fillStorage(cropYearObjects[[i]][["SS Actualized MY"]],
                                                        cropYearObjects[[i]][["Marketing Year"]],
                                                        cropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
}










# i = 1
# actualizedSales = cropYearObjects[[i]]$`PO Actualized`
# marketingYear = cropYearObjects[[i]][["Marketing Year"]]
# intervalPre = cropYearObjects[[i]]$`Pre/Post Interval`$intervalPre
# intervalPost = cropYearObjects[[i]]$`Pre/Post Interval`$intervalPost
















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
  preRows = which(actualizedSales$originalDate %within% intervalPre)
  postRows = which(actualizedSales$originalDate %within% intervalPost)
  
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
  
  # When no storage is needed
  if(is.null(firstDateRow)){
    storageAdjAvg = weighted.mean(actualizedSales$onFarmPrice, actualizedSales$Percent.Sold)
    storagePostharvestAvg = weighted.mean(actualizedSales$onFarmPrice[postRows], actualizedSales$Percent.Sold[postRows])
    commercialRows = NA
    onfarmRows = NA
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
    preRowsNew = which(actualizedSales$originalDate %within% intervalPre)
    # Removes NA value
    commercialRows = commercialRows[!is.na(commercialRows)]
    # Finds rows in which onfarm storage was utilized
    storageRows = which(actualizedSales$commercialStorage != 0)
    onfarmRows = storageRows[-which(commercialRows %in% storageRows)]
    
    
    # Average prearvest sales
    storagePreharvestAvg = weighted.mean(actualizedSales$onFarmPrice[preRowsNew], actualizedSales$Percent.Sold[preRowsNew])
    
    if(length(which(commercialRows %in% postRows)) > 0){
      # Average storage-adjusted sales in the post harvest
      # No need for pre harvest since storage begins in the post harvest
      commercialPostHarvestRows = commercialRows[which(commercialRows %in% postRows)]
      commercialPostharvestAvg = weighted.mean(actualizedSales$commercialPrice[commercialPostHarvestRows], actualizedSales$Percent.Sold[commercialPostHarvestRows])
      onfarmPostharvestAvg = weighted.mean(actualizedSales$onFarmPrice[onfarmRows], actualizedSales$Percent.Sold[onfarmRows])
      
      # Finds percent sold in commercial and onfarm storage cases
      commercialPercent = sum(actualizedSales$Percent.Sold[commercialPostHarvestRows]) * 0.01
      onfarmPercent = sum(actualizedSales$Percent.Sold[onfarmRows]) * 0.01
    } else{
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
  
  
  actualizedSales$Order = as.numeric(row.names(actualizedSales))
  actualizedSales$originalDate = actualizedSales$Date
  
  originalActualizedSaleDates = actualizedSales$Date
  marchSaleRows = which(grepl("March", actualizedSales$Type))
  actualizedSales$Date[marchSaleRows] = mdy(paste("03-01", toString(year(int_end(intervalPost))), sep="-"))
  actualizedSales = arrange(actualizedSales, Date)
  
  for(k in 1:nrow(actualizedSales)){
    actualizedSales$Total.Sold[k] = sum(actualizedSales$Percent.Sold[1:k])
  }
  
  
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
  preRows = which(actualizedSales$originalDate %within% intervalPre)
  postRows = which(actualizedSales$originalDate %within% intervalPost)
  
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
  
  # Creates single column for final price recieved
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
  
  actualizedSales$Date = actualizedSales$originalDate
  actualizedSales = actualizedSales[,-which(names(actualizedSales) %in% c("Order","originalDate"))]
  
  
  ########################################################
  # Potentially order by date here??????????????????
  ########################################################
  
  
  listReturn = list(actualizedSales, salesSummary, finalizedPrices)
  
  return(listReturn)
  
}




















# Price Objective
POfinalizedPrices = data.frame(matrix(nrow = length(cropYearObjects), ncol = 8))
colnames(POfinalizedPrices) = c("Crop Year", "noStorageAvg", "storageAdjAvg", "preharvestAverage",
                                "postharvestAverage", "postharvestAverageStorage", "preharvestPercent", 
                                "postharvestPercent")

# Price Objective Multi Year
POfinalizedPricesMY = data.frame(matrix(nrow = length(cropYearObjects), ncol = 8))
colnames(POfinalizedPricesMY) = colnames(POfinalizedPrices)

# Trailing Stop
TSfinalizedPrices = data.frame(matrix(nrow = length(cropYearObjects), ncol = 8))
colnames(TSfinalizedPrices) = colnames(POfinalizedPrices)

# Trailing Stop Multi Year
TSfinalizedPricesMY = data.frame(matrix(nrow = length(cropYearObjects), ncol = 8))
colnames(TSfinalizedPricesMY) = colnames(POfinalizedPrices)

#Seasonal Sales
SSfinalizedPrices = data.frame(matrix(nrow = length(cropYearObjects), ncol = 8))
colnames(SSfinalizedPrices) =colnames(POfinalizedPrices)

# Seasonal Sales Multi Year
SSfinalizedPricesMY = data.frame(matrix(nrow = length(cropYearObjects), ncol = 8))
colnames(SSfinalizedPricesMY) = colnames(POfinalizedPrices)



















for (i in 1:length(cropYearObjects)){
  # Price Objective
  POtemp = finalizeStorage(cropYearObjects[[i]]$`PO Actualized`,
                           cropYearsList$CropYear[i],
                           cropYearObjects[[i]]$`Pre/Post Interval`$intervalPre,
                           cropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  cropYearObjects[[i]]$`PO Actualized` = POtemp[[1]]
  cropYearObjects[[i]]$`Sales Summary` = POtemp[[2]]
  POfinalizedPrices[i,] = POtemp[[3]]
  
  # Price Objective Multi Year
  jan1 = paste("01-01", toString(year(mdy(cropYearObjects[[i]]$`Start Date`)) - 2), sep="-")
  POintervalPreMY = interval(mdy(jan1), int_end(cropYearObjects[[i]]$`Pre/Post Interval`$intervalPre))
  POtempMY = finalizeStorage(cropYearObjects[[i]]$`PO Actualized MY`,
                             cropYearsList$CropYear[i],
                             POintervalPreMY,
                             cropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  cropYearObjects[[i]]$`PO Actualized MY` = POtempMY[[1]]
  cropYearObjects[[i]]$`PO Sales Summary MY` = POtempMY[[2]]
  POfinalizedPricesMY[i,] = POtempMY[[3]]
  
  # Trailing Stop
  TStemp = finalizeStorage(cropYearObjects[[i]]$`TS Actualized`,
                           cropYearsList$CropYear[i],
                           cropYearObjects[[i]]$`Pre/Post Interval`$intervalPre,
                           cropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  cropYearObjects[[i]]$`TS Actualized` = TStemp[[1]]
  cropYearObjects[[i]]$`TS Sales Summary` = TStemp[[2]]
  TSfinalizedPrices[i,] = TStemp[[3]]
  
  # Trailing Stop Multi Year
  jan1 = paste("01-01", toString(year(mdy(cropYearObjects[[i]]$`Start Date`)) - 2), sep="-")
  TSintervalPreMY = interval(mdy(jan1), int_end(cropYearObjects[[i]]$`Pre/Post Interval`$intervalPre))
  TStempMY = finalizeStorage(cropYearObjects[[i]]$`TS Actualized MY`,
                             cropYearsList$CropYear[i],
                             TSintervalPreMY,
                             cropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  cropYearObjects[[i]]$`TS Actualized MY` = TStempMY[[1]]
  cropYearObjects[[i]]$`TS Sales Summary MY` = TStempMY[[2]]
  TSfinalizedPricesMY[i,] = TStempMY[[3]]
  
  #Seasonal Sales
  SStemp = finalizeStorage(cropYearObjects[[i]]$`SS Actualized`,
                           cropYearsList$CropYear[i],
                           cropYearObjects[[i]]$`Pre/Post Interval`$intervalPre,
                           cropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  cropYearObjects[[i]]$`SS Actualized` = SStemp[[1]]
  cropYearObjects[[i]]$`SS Sales Summary` = SStemp[[2]]
  SSfinalizedPrices[i,] = SStemp[[3]]
  
  # Seasonal Sales Multi Year
  jan1 = paste("01-01", toString(year(mdy(cropYearObjects[[i]]$`Start Date`)) - 2), sep="-")
  SSintervalPreMY = interval(mdy(jan1), int_end(cropYearObjects[[i]]$`Pre/Post Interval`$intervalPre))
  SStempMY = finalizeStorage(cropYearObjects[[i]]$`SS Actualized MY`,
                             cropYearsList$CropYear[i],
                             SSintervalPreMY,
                             cropYearObjects[[i]]$`Pre/Post Interval`$intervalPost)
  
  cropYearObjects[[i]]$`SS Actualized MY` = SStempMY[[1]]
  cropYearObjects[[i]]$`SS Sales Summary MY` = SStempMY[[2]]
  SSfinalizedPricesMY[i,] = SStempMY[[3]]
}

POfinalizedPrices$`Crop Year` = cropYearsList$CropYear
POfinalizedPricesMY$`Crop Year` = cropYearsList$CropYear
TSfinalizedPrices$`Crop Year` = cropYearsList$CropYear
TSfinalizedPricesMY$`Crop Year` = cropYearsList$CropYear
SSfinalizedPrices$`Crop Year` = cropYearsList$CropYear
SSfinalizedPricesMY$`Crop Year` = cropYearsList$CropYear

finalizedPriceObject = list("POfinalizedPrices" = POfinalizedPrices,
                            "POfinalizedPricesMY" = POfinalizedPricesMY,
                            "TSfinalizedPrices" = TSfinalizedPrices, 
                            "TSfinalizedPricesMY" = TSfinalizedPricesMY,
                            "SSfinalizedPrices" = SSfinalizedPrices,
                            "SSfinalizedPricesMY" = SSfinalizedPricesMY
)

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

for (i in 1:length(cropYearObjects)){
  cropYearObjects[[i]]$`PO Storage` = makeStorageTable(POfinalizedPrices)
  cropYearObjects[[i]]$`PO Storage MY` = makeStorageTable(POfinalizedPricesMY)
  cropYearObjects[[i]]$`TS Storage` = makeStorageTable(TSfinalizedPrices)
  cropYearObjects[[i]]$`TS Storage MY` = makeStorageTable(TSfinalizedPricesMY)
  cropYearObjects[[i]]$`SS Storage` = makeStorageTable(SSfinalizedPrices)
  cropYearObjects[[i]]$`SS Storage MY` = makeStorageTable(SSfinalizedPricesMY)
}

makeResultsTable = function(finalizedPrices){
  resultsTable = data.frame(matrix(nrow = 4, ncol = 3))
  colnames(resultsTable) = c(" ", "No Storage", "Storage")
  
  resultsTable$` ` =  c("Total Avg Price", "Pre-Harvest Avg Price", "Post-Harvest Avg Price", "USDA Average (Basis Adjusted)")
  resultsTable$`No Storage`[2] = weighted.mean(finalizedPrices$preharvestAverage, finalizedPrices$preharvestPercent)
  resultsTable$`No Storage`[3] = weighted.mean(finalizedPrices$postharvestAverage, finalizedPrices$postharvestPercent)
  resultsTable$`Storage`[2] = weighted.mean(finalizedPrices$preharvestAverage, finalizedPrices$preharvestPercent)
  resultsTable$`Storage`[3] = weighted.mean(finalizedPrices$postharvestAverageStorage, finalizedPrices$postharvestPercent)
  
  preharvestSum = sum(finalizedPrices$preharvestPercent)
  postharvestSum = sum(finalizedPrices$postharvestPercent)
  
  resultsTable$`No Storage`[1] = ((resultsTable$`No Storage`[2] * (preharvestSum * 0.01)) + (resultsTable$`No Storage`[3] * (postharvestSum * 0.01)))/ ((preharvestSum + postharvestSum) * 0.01)
  resultsTable$`Storage`[1] = ((resultsTable$`Storage`[2] * (preharvestSum * 0.01)) + (resultsTable$`Storage`[3] * (postharvestSum * 0.01)))/ ((preharvestSum + postharvestSum) * 0.01)
  
  # USDA Average price inputs
  if(type == "corn"){
    resultsTable$`No Storage`[4] = 4.75
  }
  else if(type == "soybean"){
    resultsTable$`No Storage`[4] = 11.41
  }
  
  resultsTable$`Storage`[4] = NA
  
  return(resultsTable)
}

finalizedPriceObject[["POResultsTable"]] = makeResultsTable(finalizedPriceObject[[1]])
finalizedPriceObject[["POResultsTableMY"]] = makeResultsTable(finalizedPriceObject[[2]])
finalizedPriceObject[["TSResultsTable"]] = makeResultsTable(finalizedPriceObject[[3]])
finalizedPriceObject[["TSResultsTableMY"]] = makeResultsTable(finalizedPriceObject[[4]])
finalizedPriceObject[["SSResultsTable"]] = makeResultsTable(finalizedPriceObject[[5]])
finalizedPriceObject[["SSResultsTableMY"]] = makeResultsTable(finalizedPriceObject[[6]])

finalizedPriceObject[["AllResultsTable"]] = cbind(finalizedPriceObject[["POResultsTable"]][1:3, 1:3], 
                                                  finalizedPriceObject[["POResultsTableMY"]][1:3, 2:3],
                                                  finalizedPriceObject[["TSResultsTable"]][1:3, 2:3], 
                                                  finalizedPriceObject[["TSResultsTableMY"]][1:3, 2:3],
                                                  finalizedPriceObject[["SSResultsTable"]][1:3, 2:3], 
                                                  finalizedPriceObject[["SSResultsTableMY"]][1:3, 2:3])

if(type == "corn"){
  Corn_CropYearObjects = cropYearObjects
  Corn_CropYears = cropYearsList
}

if(type == "soybean"){
  Soybean_CropYearObjects = cropYearObjects
  Soybean_CropYears = cropYearsList
}
