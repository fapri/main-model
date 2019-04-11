# Corn 
# Price Objective
# Storage

source("Corn/PriceObjectiveActualized.R")

# Extract Price data into the PO Actualized Data Frame
for (i in 1:length(Corn_CropYearObjects)){
  for(j in 1:nrow(Corn_CropYearObjects[[i]]$`PO Actualized`)){
    Corn_CropYearObjects[[i]]$`PO Actualized`$Price[j] = Corn_CropYearObjects[[i]]$`Marketing Year`$Price[which(mdy(Corn_CropYearObjects[[i]]$`Marketing Year`$Date) == Corn_CropYearObjects[[i]]$`PO Actualized`$Date[j])]
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
  storageInterval = interval(mdy(paste("11-01", toString(year(int_start(intervalPost))), sep="-")), int_end(intervalPost))
  salePrice = actualizedSales$Price
  actualizedSales$monthsSinceOct = NA
  
  # Calculate months since October for post harvest dates only
  for(i in 1:nrow(actualizedSales)) {
    commercialStorage = rep(0, nrow(actualizedSales))
    onFarmStorage = rep(0, nrow(actualizedSales))
    commercialPrice = rep(0, nrow(actualizedSales))
    onFarmPrice = rep(0, nrow(actualizedSales))
    #Check if date is in storage interval
    if(actualizedSales$Date[i] %within% storageInterval) {
      if(month(actualizedSales$Date[i]) == 9) {
        #Special case for September
        actualizedSales$monthsSinceOct[i] = 0
      }
      else {
        #Create interval from the date to post harvest October
        tempInt = interval(actualizedSales$Date[i], mdy(paste("10-01", toString(year(int_start(intervalPost))), sep="-")))
        #Calculate months since October
        actualizedSales$monthsSinceOct[i] = abs(tempInt %/% months(1))
      }
    }
  }
  
  monthsSinceOct = actualizedSales$monthsSinceOct
  
  # Commercial Storage
  for(i in 1:nrow(actualizedSales)) {
    # Check that date is in storage interval
    if(actualizedSales$Date[i] %within% storageInterval) {
      #Calculate first part of storage function
      A = salePrice[i] * (1 + (interestRate/12)) ^ (monthsSinceOct[i])
      #Check if cost is less than three month minimum storage cost
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
  
  #On farm storage formula
  for (i in 1:nrow(actualizedSales)){
    #Check that date is in post harvest
    if (actualizedSales$Date[i] %within% storageInterval){
      #Formula for on farm storage
      A = salePrice[i] * ((1 + (interestRate/12)) ^ (monthsSinceOct[i])) + binStorage1 + (binStorageAfter*(monthsSinceOct[i] - 1))
      #Comute on farm storage cost
      onFarmStorage[i] = A - salePrice[i]
      
    }
  }
  
  #Get new prices
  for (i in 1:nrow(actualizedSales)){
    commercialPrice[i] = salePrice[i] - commercialStorage[i]
    onFarmPrice[i] = salePrice[i] - onFarmStorage[i]
  }
  
  
  storage = cbind(commercialStorage, onFarmStorage, commercialPrice, onFarmPrice)
  
  return(storage)
}


#Fills storage values into the Corn Crop Year object under Price Actualized
for (i in 1:length(Corn_CropYearObjects)){
  # Initialize Variables
  Corn_CropYearObjects[[i]]$`PO Actualized`$CommercialStorage = 0
  Corn_CropYearObjects[[i]]$`PO Actualized`$onFarmStorage = 0
  # Call storage function. This will return the base cost of storage
  temp = getStorageCost(Corn_CropYearObjects[[i]][["PO Actualized"]],
                        Corn_CropYearObjects[[i]][["Marketing Year"]],
                        Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  
  Corn_CropYearObjects[[i]]$`PO Actualized`$CommercialStorage = temp[,1]
  Corn_CropYearObjects[[i]]$`PO Actualized`$onFarmStorage = temp[,2]
  Corn_CropYearObjects[[i]]$`PO Actualized`$commercialPrice = temp[,3]
  Corn_CropYearObjects[[i]]$`PO Actualized`$onFarmPrice = temp[,4]
  
}


#Returns storage adjusted averages
#Contains logic that figures commercial/on-farm splits
getStorageActualized = function(actualizedSales, intervalPre, intervalPost) {
  #Initialize variables
  preRows = rep(0, 9)
  postRows = rep(0, 9)
  commercialRows = NA
  
  #Creates storage interval
  storageInterval = interval(mdy(paste("11-01", toString(year(int_start(intervalPost))), sep="-")), int_end(intervalPost))
  #Finds rows corresponding to pre (or post) harvest. This will be used to caluclate the respective storages
  preRows = which(actualizedSales$Date %within% intervalPre)
  postRows = which(actualizedSales$Date %within% intervalPost)
  
  #Finds the row for the first date that storage is utilized
  #This will be used to find how much crop needs to be stored
  for (i in 1:nrow(actualizedSales)){
    #Check that date is in post harvest
    if (actualizedSales$Date[i] %within% storageInterval){
      firstDateRow = i
      break
    }
  }
  
  #IF THE FIRST POST HARVEST DATE HAS >=50% "TOTAL.SOLD"
  if(actualizedSales$Total.Sold[firstDateRow] >= 50){
    #AVERAGE SALES BEFORE STORAGE + STRICTLY ON FARM STORAGE
    storageAdjAvg = weighted.mean(actualizedSales$onFarmPrice, actualizedSales$Percent.Sold)
    #Average storage-adjusted sales in the post harvest
    #No need for pre harvest since storage begins in the post harvest
    storagePostharvestAvg = weighted.mean(actualizedSales$onFarmPrice[postRows], actualizedSales$Percent.Sold[postRows])
    
  }
  #ELSE
  #AVERAGE SALES BEFORE STORAGE + 50% OF CROP IN ON-FARM STORAGE + REMAINING CROP IN COMMERCIAL STORAGE
  else{
    #Calculates remaining crop that needs storage
    remainingCrop = 100 - actualizedSales$Total.Sold[firstDateRow - 1]
    #Calculates the percent of crop that needs commercial storage
    commercialCrop = remainingCrop - 50
    
    for (j in firstDateRow:nrow(actualizedSales)){
      #Check if the sale can be made without splitting
      if(actualizedSales$Percent.Sold[j] <= commercialCrop && commercialCrop != 0){
        #Stores sales that are commercial
        commercialRows = c(commercialRows,j)
        #Calculates remaining crop that needs commercial storage
        commercialCrop = commercialCrop - actualizedSales$Percent.Sold[j]
      }
      
      else if (commercialCrop != 0){
        cols = match(c("Percent.Sold","Total.Sold"),names(actualizedSales))
        onfarmSplit = actualizedSales$Percent.Sold[j] - commercialCrop
        commercialSplit = actualizedSales$Percent.Sold[j] - onfarmSplit
        commercialSplitTotal = actualizedSales$Total.Sold[j - 1] + commercialSplit
        onfarmSplitTotal = onfarmSplit + commercialSplitTotal
        
        actualizedSales = data.frame(rbind(actualizedSales[1:j,], actualizedSales[j:nrow(actualizedSales),]))
        row.names(actualizedSales) = 1:nrow(actualizedSales)
        actualizedSales[j, cols] = cbind(Percent.Sold = commercialSplit, Total.Sold = commercialSplitTotal)
        actualizedSales[j + 1, cols] = cbind(Percent.Sold = onfarmSplit, Total.Sold = onfarmSplitTotal)
        commercialRows = c(commercialRows, (last(commercialRows) + 1))
        break
      }
      
      else if (commercialCrop == 0){
        break
      }
    }
    
    preRowsNew = which(actualizedSales$Date %within% intervalPre)
    commercialRows = commercialRows[!is.na(commercialRows)]
    onfarmRows = (last(commercialRows) + 1):nrow(actualizedSales)
    
    #Average prearvest sales
    storagePreharvestAvg = weighted.mean(actualizedSales$onFarmPrice[preRowsNew], actualizedSales$Percent.Sold[preRowsNew])
    
    #Average storage-adjusted sales in the post harvest
    #No need for pre harvest since storage begins in the post harvest
    commercialPostharvestAvg = weighted.mean(actualizedSales$commercialPrice[commercialRows], actualizedSales$Percent.Sold[commercialRows])
    onfarmPostharvestAvg = weighted.mean(actualizedSales$onFarmPrice[onfarmRows], actualizedSales$Percent.Sold[onfarmRows])
    
    commercialPercent = sum(actualizedSales$Percent.Sold[commercialRows]) * 0.01
    onfarmPercent = sum(actualizedSales$Percent.Sold[onfarmRows]) * 0.01
    
    storageCommercialPostharvestAvg = commercialPostharvestAvg * commercialPercent
    storageOnfarmPostharvestAvg = onfarmPostharvestAvg * onfarmPercent
    
    preharvestPercent = actualizedSales$Total.Sold[firstDateRow - 1] * 0.01
    postharvestPercent = 1 - preharvestPercent
    
    storagePostharvestAvg = (storageCommercialPostharvestAvg + storageOnfarmPostharvestAvg) / postharvestPercent
    
    storagePreharvestAvg2 = (storagePreharvestAvg * preharvestPercent)
    storagePostharvestAvg2 = (storagePostharvestAvg * postharvestPercent)
    
    storageAdjAvg = mean(storagePreharvestAvg2 + storagePostharvestAvg2)
    
  }
  
  storageAdjustments = cbind(storageAdjAvg, storagePostharvestAvg)
  
  return(storageAdjustments)
}

storageAdjAvg = rep(0, 9)
noStorageAvg = rep(0, 9)
preharvestAverage = rep(0, 9)
postharvestAverage = rep(0, 9)
preharvestAverageStorage = rep(0, 9)
postharvestAverageStorage = rep(0, 9)
for (i in 1:length(Corn_CropYearObjects)){
  preRows = rep(0, 9)
  postRows = rep(0, 9)
  
  #Calculates total average price, accounting for storage
  storageAdjAvg[i] = getStorageActualized(Corn_CropYearObjects[[i]][["PO Actualized"]],
                                          Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPre"]],
                                          Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])[1]
  
  #Calculates total average price, without storage
  noStorageAvg[i] = weighted.mean(Corn_CropYearObjects[[i]][["PO Actualized"]][["Price"]], 
                                  Corn_CropYearObjects[[i]][["PO Actualized"]][["Percent.Sold"]])
  
  #Finds pre harvest and post harvest rows
  preRows = which(Corn_CropYearObjects[[i]][["PO Actualized"]][["Date"]] %within% Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPre"]])
  postRows = which(Corn_CropYearObjects[[i]][["PO Actualized"]][["Date"]] %within% Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  
  #Calculates pre harvest average without storage
  preharvestAverage[i] = weighted.mean(Corn_CropYearObjects[[i]][["PO Actualized"]][["Price"]][preRows], 
                                       Corn_CropYearObjects[[i]][["PO Actualized"]][["Percent.Sold"]][preRows])
  
  #Calculates post harvest average without storage
  postharvestAverage[i] = weighted.mean(Corn_CropYearObjects[[i]][["PO Actualized"]][["Price"]][postRows], 
                                        Corn_CropYearObjects[[i]][["PO Actualized"]][["Percent.Sold"]][postRows])
  
  #Calculates post harvest average with storage
  postharvestAverageStorage[i] = getStorageActualized(Corn_CropYearObjects[[i]][["PO Actualized"]],
                                                      Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPre"]],
                                                      Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])[2]
  
}

#Aggregates all adjusted prices by crop year
finalizedPrices = data.frame("CropYear" = Corn_CropYears$CropYear, noStorageAvg, storageAdjAvg, preharvestAverage,
                             postharvestAverage, postharvestAverageStorage)








