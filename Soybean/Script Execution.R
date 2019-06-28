# Soybean

library(lubridate)
library(dplyr)
library(ggplot2)

# Set up the data and Crop Year Objects
source("Model/Main.R")
# soybean

# Create common trigger functions
source("Model/Triggers.R")

# Load Multi-year marketing year
source("Model/MultiYearTrigger.R")

# Run the strategies
source("Model/PriceObjective.R")
source("Model/TrailingStop.R")

source("Model/TrailingStopV3.R")

source("Soybean/SeasonalSaleActualized.R")

# Base
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStopActualized.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, finalizedPriceObject), file = "appObjectsSoybeanV3Base.rds")

# V2
source("Soybean/PriceObjectiveActualizedV2.R")
source("Soybean/TrailingStopActualizedV2.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, finalizedPriceObject), file = "appObjectsSoybeanV3V2.rds")

# V3
source("Soybean/PriceObjectiveActualizedV5.R")
source("Soybean/TrailingStopActualizedV5.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, finalizedPriceObject), file = "appObjectsSoybeanV3V3.rds")

# V4
source("Soybean/PriceObjectiveActualizedV6.R")
source("Soybean/TrailingStopActualizedV6.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, finalizedPriceObject), file = "appObjectsSoybeanV3V4.rds")

#V5
source("Soybean/PriceObjectiveActualizedV7.R")
source("Soybean/TrailingStopActualizedV7.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, finalizedPriceObject), file = "appObjectsSoybeanV3V5.rds")

















for(i in 1:length(Soybean_CropYearObjects)){

  PO = which(names(Soybean_CropYearObjects[[i]]) == "POPlot")
  POMY = which(names(Soybean_CropYearObjects[[i]]) == "POMYPlot")
  TS = which(names(Soybean_CropYearObjects[[i]]) == "TSPlot")
  TSMY = which(names(Soybean_CropYearObjects[[i]]) == "TSMYPlot")
  SS = which(names(Soybean_CropYearObjects[[i]]) == "SSPlot")
  SSMY = which(names(Soybean_CropYearObjects[[i]]) == "SSMYPlot")
  
  removeThese = c(PO, POMY, TS, TSMY, SS, SSMY)
  
  Soybean_CropYearObjects[[i]] = Soybean_CropYearObjects[[i]][-removeThese]
  
}



Figure1 = Soybean_CropYearObjects[[1]]$POPlot

ggsave("Figure1.tiff", width = 14, height = 8, dpi=100, compression = "lzw")






which(names(Soybean_CropYearObjects[[i]]) == "TSPlot")# Adjust for storage
which(names(Soybean_CropYearObjects[[i]]) == "TSPlot")source("Soybean/Storage.R")

# Graph the Strategies
source("Model/Graphing.R")

# Code I used to save the objects
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3/base.rds")
