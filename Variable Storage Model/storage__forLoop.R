#Loops to fill objects for each crop year for each 
#on-farm storage percentage from 0 to 100 in steps of 10

library(lubridate)
library(dplyr)

if (type == 'corn') {
  
  tempObjects = list()
  tempPriceObject = list()
  temp = list()
  finalizedPriceObject = list()
  percentStored = 0
  
  while (percentStored < 110) {
    for (i in 1:11) {
      temp[[i]] = storageFunction(percentStored, type, Corn_CropYears, Corn_CropYearObjects)
      tempObjects[[i]] = temp[[i]][[1]]
      tempPriceObject[[i]] = temp[[i]][[2]]
      percentStored = percentStored + 10
      
    }
  }
  Corn_CropYearObjects = tempObjects
  finalizedPriceObject = tempPriceObject
}

if (type == 'soybean') {
  
  tempObjects = list()
  tempPriceObject = list()
  temp = list()
  finalizedPriceObject = list()
  percentStored = 0
  
  while (percentStored < 110) {
    for (i in 1:11) {
      temp[[i]] = storageFunction(percentStored, type, Soybean_CropYears, Soybean_CropYearObjects)
      tempObjects[[i]] = temp[[i]][[1]]
      tempPriceObject[[i]] = temp[[i]][[2]]
      percentStored = percentStored + 10
    }
  }
  Soybean_CropYearObjects = tempObjects
  finalizedPriceObject = tempPriceObject
}
