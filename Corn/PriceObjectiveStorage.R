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
binStorage1 = 0.247
# Total cost of bin storage(exlcuding interest), 2nd month forward
binStorageAfter = 0.003

getStorageCost = function(actualizedSales, marketingYear, intervalPost) {
  salePrice = actualizedSales$Price
  CommercialStorage = NA
  onFarmStorage = NA
  actualizedSales$monthsSinceOct = NA
  
  # Calculate months since October for post harvest dates only
  for(i in 1:nrow(actualizedSales)) {
    if(actualizedSales$Date[i] %within% intervalPost) {
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
    # Check that date is in post harvest
    if(actualizedSales$Date[i] %within% intervalPost) {
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
      CommercialStorage[i] = (A + B) - salePrice[i]
    }
  }
  
  # for (i in 1:nrow(actualizedSales)){
  #   #Check that date is in post harvest
  #   if (actualizedSales$Date[i] %within% intervalPost){
  #     A = salePrice[i] * ((1 + (interestRate/12)) ^ (monthsSinceOct[i])) + binStorage1 + (binStorageAfter*(monthsSinceOct[i] - 1))
  #   }
  #   #Comute on farm storage cost
  #   onFarmStorage[i] = A - salePrice[i]
  # }
      
  #return(onFarmStorage)  
  return(CommercialStorage)
}

for (i in 1:length(Corn_CropYearObjects)){
  # Initialize Variable
  Corn_CropYearObjects[[i]]$`PO Actualized`$CommercialStorage = NA
  # Call storage function. This will return the base cost of storage and the crop price less storage
  Corn_CropYearObjects[[i]]$`PO Actualized`$CommercialStorage = getStorageCost(Corn_CropYearObjects[[i]][["PO Actualized"]],
                                                                               Corn_CropYearObjects[[i]][["Marketing Year"]],
                                                                               Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]])
}

# i = 3
# actualizedSales = Corn_CropYearObjects[[i]][["PO Actualized"]]
# marketingYear = Corn_CropYearObjects[[i]][["Marketing Year"]]
# intervalPost = Corn_CropYearObjects[[i]][["Pre/Post Interval"]][["intervalPost"]]