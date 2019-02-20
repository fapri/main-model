# Corn

library(readxl)

Corn_CropYears <- read_excel("Data/Corn_CropYears.xlsx", sheet = "Sheet1", col_types = c("text", "date", "date"))
Corn_FuturesMarket <- read_excel("Data/Corn_FuturesMarket.xlsx", sheet = "Sheet1", col_types = c("date", "numeric", "numeric"))
Corn_Basis <- read_excel("Data/Corn_Basis.xlsx", sheet = "Sheet1")
Corn_Baseline <- read_excel("Data/Corn_Baseline.xlsx", sheet = "Sheet1", col_types = c("date", 
                                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
lockBinding("Corn_CropYears", globalenv())
lockBinding("Corn_FuturesMarket", globalenv())
lockBinding("Corn_Basis", globalenv())
lockBinding("Corn_Baseline", globalenv())

Corn_CropYearObjects = list()
for(i in 1:nrow(Corn_CropYears)) {
  Corn_CropYearObjects[i] = createCropYear(Corn_CropYears[i,1], Corn_CropYears[i,2], Corn_CropYears[i,3])
}

createCropYear <- function(cropYear, startDate, stopDate) {
  cropYearObj = list(cropYear = cropYear)
  
  # TODO Match the baseline, basis, and historical futures market prices which lie between startDate and stopDate
  # set any other constant variables such as number of sales, percentage sold, etc...
  
  return(cropYearObj)
}
