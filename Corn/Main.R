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

# Creates a crop year based on the input parameters
createCropYear <- function(cropYear, startDate, stopDate) {
  # TODO Match the baseline, basis, and historical futures market prices which lie between startDate and stopDate
  # TODO set any other constant variables such as number of sales, percentage sold, etc
  
  model <- data.frame(
    emp_id = c (1:5), 
    emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
    salary = c(623.3,515.2,611.0,729.0,843.25), 
    start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11", "2015-03-27")),
    stringsAsFactors = FALSE
  )
  
  cropYearObj = list("Crop Year" = cropYear, "Model" = model)
  
  return(cropYearObj)
}

Corn_CropYearObjects = list()
for(i in 1:nrow(Corn_CropYears)) {
  Corn_CropYearObjects[[i]] = createCropYear(Corn_CropYears[i,1], Corn_CropYears[i,2], Corn_CropYears[i,3])
}
