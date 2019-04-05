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



# i = 9
# actualizedSales = Corn_CropYearObjects[[i]][["PO Actualized"]]
# marketingYear = Corn_CropYearObjects[[i]][["Marketing Year"]]
# intervalPost = Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]]




getStorageActualized = function(actualizedSales, intervalPost) {
  storageInterval = interval(mdy(paste("11-01", toString(year(int_start(intervalPost))), sep="-")), int_end(intervalPost))
  
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
  }
  #ELSE
  #AVERAGE SALES BEFORE STORAGE + 50% OF CROP IN ON-FARM STORAGE + REMAINING CROP IN COMMERCIAL STORAGE
  else{
    remainingCrop = 100 - actualizedSales$Total.Sold[firstDateRow]
    commercialCrop = remainingCrop - 50
    
    
    
    storageAdjAvg = weighted.mean(0)
  }
}

storageAdjAvg = NA
noStorageAvg = NA
for (i in 1:length(Corn_CropYearObjects)){
  preRows = 0
  postRows = 0
  preharvestAverage = 0
  postharvestAverage = 0
  
  #Calculates total average price, accounting for storage
  storageAdjAvg[i] = getStorageActualized(Corn_CropYearObjects[[i]][["PO Actualized"]],
                                          Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  #Calculates total average price, without storage
  noStorageAvg[i] = weighted.mean(Corn_CropYearObjects[[i]][["PO Actualized"]][["Price"]], 
                                  Corn_CropYearObjects[[i]][["PO Actualized"]][["Percent.Sold"]])
  
  preRows = which(Corn_CropYearObjects[[i]][["PO Actualized"]][["Date"]] %within% Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPre"]])
  postRows = which(Corn_CropYearObjects[[i]][["PO Actualized"]][["Date"]] %within% Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
  
  preharvestAverage[i] = weighted.mean(Corn_CropYearObjects[[i]][["PO Actualized"]][["Price"]][preRows], 
                                       Corn_CropYearObjects[[i]][["PO Actualized"]][["Percent.Sold"]][preRows]) 
  
}

#Pre-harvest averages




finalizedPrices = data.frame("CropYear" = Corn_CropYears$CropYear, noStorageAvg, storageAdjAvg, preharvestAverage)








