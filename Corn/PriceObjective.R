# Corn
# Price Objective

# Create the corn objects necessary to run the Price Objective strategy
source('Corn/Main.R')

# Finds all of the price objective triggers for a given crop year
priceObjectiveTrigger = function(cropYear) {
  priceObjectiveTriggers = list()
  triggers = 0
  
  marketingYear = cropYear[['Marketing Year']]
  
  # Checks the first day of the crop year
  if(marketingYear$Percentile[1] >= 70) {
    triggers = triggers + 1
    priceObjectiveTriggers[[triggers]] = c(marketingYear$Date[1], marketingYear$Percentile[1])
  }
  
  # Checks all subsequent days
  for(row in 2:nrow(marketingYear)) {
    if(marketingYear$Percentile[row] >= 70) {
      if(marketingYear$Percentile[row - 1] < marketingYear$Percentile[row]) {
        triggers = triggers + 1
        priceObjectiveTriggers[[triggers]] = c(marketingYear$Date[row], marketingYear$Percentile[row])
      }
    }
  }

  cropYear[['PO Triggers']] = priceObjectiveTriggers
  
  return(cropYear)
}

# Actualizes the sales for a given crop year
priceObjectiveActualize_v1 = function(cropYear) {
  # Blah
}

# Gets the price objective triggers for earch crop year
for(i in 1:length(Corn_CropYearObjects)) {
  Corn_CropYearObjects[[i]] = priceObjectiveTrigger(Corn_CropYearObjects[[i]])
}
