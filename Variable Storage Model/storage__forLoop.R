library(dplyr)

tempObjects = list()
tempPriceObject = list()

if(type == 'corn'){

  temp = list()
  finalizedPriceObject = list()
  percentStored = 0
  
  while(percentStored < 110){
    
  for (i in 1:11){
    
    temp[[i]] = storageFunction(percentStored,type,Corn_CropYears,Corn_CropYearObjects)
    tempObjects[[i]] = temp[[i]][[1]]
    tempPriceObject[[i]] = temp[[i]][[2]]
    percentStored = percentStored + 10
    
  }
  
    
  }
    Corn_CropYearObjects = tempObjects
    finalizedPriceObject = tempPriceObject
}
