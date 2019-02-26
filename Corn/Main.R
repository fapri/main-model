# Corn

library(readxl)
library(lubridate)

Corn_CropYears <- read.csv("Data/Corn_CropYears.csv", stringsAsFactors = FALSE)
Corn_FuturesMarket <- read.csv("Data/Corn_FuturesMarket.csv", stringsAsFactors = FALSE)
Corn_Basis <- read.csv("Data/Corn_Basis.csv", stringsAsFactors = FALSE)
Corn_Baseline <- read.csv("Data/Corn_Baseline.csv", stringsAsFactors = FALSE)

lockBinding("Corn_CropYears", globalenv())
lockBinding("Corn_FuturesMarket", globalenv())
lockBinding("Corn_Basis", globalenv())
lockBinding("Corn_Baseline", globalenv())

# Creates a crop year based on the input parameters
createCropYear <- function(cropYear, startDate, stopDate) {
  harvest = paste("09-01", toString(year(mdy(startDate))), sep="-")
  
  intervalPre = interval(mdy(startDate), mdy(harvest) - days(1))
  intervalPost = interval(mdy(harvest), mdy(stopDate))
  
  marketingYearPre <- Corn_FuturesMarket[which(mdy(Corn_FuturesMarket$Date) %within% intervalPre), c(1, 2)]
  marketingYearPre <- setNames(marketingYearPre, c("Date","Price"))
  marketingYearPost <- Corn_FuturesMarket[which(mdy(Corn_FuturesMarket$Date) %within% intervalPost), c(1, 3)]
  marketingYearPost <- setNames(marketingYearPost, c("Date","Price"))
  marketingYear <- rbind(marketingYearPre, marketingYearPost)
  
  marketingYear[,c("Baseline", "60th", "70th", "80th", "90th", "95th")] <- NA
  for(row in 1:nrow(marketingYear)) {
    #if in inverval do these coulmns and subtract this basis??
    #else do these other columns and basis??
  }
  
  cropYearObj = list("Crop Year" = cropYear, "Start Date" = startDate, "Stop Date" = stopDate, 
                     "Interval" = interval, "Marketing Year" = marketingYear)
  
  return(cropYearObj)
}

Corn_CropYearObjects = list()
for(i in 1:nrow(Corn_CropYears)) {
  Corn_CropYearObjects[[i]] = createCropYear(Corn_CropYears[i,1], Corn_CropYears[i,2], Corn_CropYears[i,3])
}


#Maybe use this df (tempBaselineDates) of dates to replicate dates in for the baseline. Then merge the result with marketingYear
tempBaselineDates = data.frame(Date = seq(Corn_CropYearObjects[[1]]$`Marketing Year`$Date %>% mdy %>% head(1), Corn_CropYearObjects[[1]]$`Marketing Year`$Date %>% mdy %>% tail(1), by=1))

#Start of loop to determine which basline should be copied in. This issues but looks like a good start.

marchTemp1 =  tempBaselineDates[which(month(tempBaselineDates$Date) == 3),]
aprilTemp1 =  tempBaselineDates[which(month(tempBaselineDates$Date) == 4),]

baselineSegments1 = c(marchTemp1, aprilTemp1)
