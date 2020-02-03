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

# source("Soybean/SeasonalSaleActualized.R")

##################################################################################################
# Soybean
##################################################################################################


# Base
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStopActualized.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanBase.rds")


rm(list = ls())
load("Environments/Soybean/SS.RData")

# V2
source("Soybean/PriceObjectiveActualizedV2.R")
source("Soybean/TrailingStopActualizedV2.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV2.rds")

rm(list = ls())
load("Environments/Soybean/SS.RData")

# V3
source("Soybean/PriceObjectiveActualizedV5.R")
source("Soybean/TrailingStopActualizedV5.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3.rds")

rm(list = ls())
load("Environments/Soybean/SS.RData")

# V4
source("Soybean/PriceObjectiveActualizedV6.R")
source("Soybean/TrailingStopActualizedV6.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV4.rds")

rm(list = ls())
load("Environments/Soybean/SS.RData")

#V5
source("Soybean/PriceObjectiveActualizedV7.R")
source("Soybean/TrailingStopActualizedV7.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV5.rds")

rm(list = ls())
load("Environments/Soybean/SS.RData")

#V6
source("Soybean/PriceObjectiveActualizedV9.R")
source("Soybean/TrailingStopActualizedV9.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV6.rds")

rm(list = ls())
load("Environments/Soybean/SS.RData")

#V7
source("Soybean/HarvestTimeSalesActualized.R")
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStopActualized.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV7.rds")



rm(list = ls())
load("Environments/Soybean/SSV3.RData")
 
# Base
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStopActualized.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3Base.rds")


rm(list = ls())
load("Environments/Soybean/SSV3.RData")

# V2
source("Soybean/PriceObjectiveActualizedV2.R")
source("Soybean/TrailingStopActualizedV2.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3V2.rds")

rm(list = ls())
load("Environments/Soybean/SSV3.RData")

# V3
source("Soybean/PriceObjectiveActualizedV5.R")
source("Soybean/TrailingStopActualizedV5.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3V3.rds")

rm(list = ls())
load("Environments/Soybean/SSV3.RData")

# V4
source("Soybean/PriceObjectiveActualizedV6.R")
source("Soybean/TrailingStopActualizedV6.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3V4.rds")

rm(list = ls())
load("Environments/Soybean/SSV3.RData")

#V5
source("Soybean/PriceObjectiveActualizedV7.R")
source("Soybean/TrailingStopActualizedV7.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3V5.rds")

rm(list = ls())
load("Environments/Soybean/SSV3.RData")

#V6
source("Soybean/PriceObjectiveActualizedV9.R")
source("Soybean/TrailingStopActualizedV9.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3V6.rds")

rm(list = ls())
load("Environments/Soybean/SSV3.RData")

#V7
source("Soybean/HarvestTimeSalesActualized.R")
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStopActualized.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3V7.rds")

rm(list = ls())




##################################################################################################
# Corn
##################################################################################################



# Base
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStopActualized.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornBase.rds")


rm(list = ls())
load("Environments/Corn/SS.RData")

# V2
source("Soybean/PriceObjectiveActualizedV2.R")
source("Soybean/TrailingStopActualizedV2.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV2.rds")

rm(list = ls())
load("Environments/Corn/SS.RData")

# V3
source("Soybean/PriceObjectiveActualizedV5.R")
source("Soybean/TrailingStopActualizedV5.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV3.rds")

rm(list = ls())
load("Environments/Corn/SS.RData")

# V4
source("Soybean/PriceObjectiveActualizedV6.R")
source("Soybean/TrailingStopActualizedV6.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV4.rds")

rm(list = ls())
load("Environments/Corn/SS.RData")

#V5
source("Soybean/PriceObjectiveActualizedV7.R")
source("Soybean/TrailingStopActualizedV7.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV5.rds")

rm(list = ls())
load("Environments/Corn/SS.RData")

#V6
source("Soybean/PriceObjectiveActualizedV9.R")
source("Soybean/TrailingStopActualizedV9.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV6.rds")

rm(list = ls())
load("Environments/Corn/SS.RData")

#V7
source("Soybean/HarvestTimeSalesActualized.R")
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStopActualized.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV7.rds")







rm(list = ls())
load("Environments/Corn/SSV3.RData")

# Base
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStopActualized.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV3Base.rds")


rm(list = ls())
load("Environments/Corn/SSV3.RData")

# V2
source("Soybean/PriceObjectiveActualizedV2.R")
source("Soybean/TrailingStopActualizedV2.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV3V2.rds")

rm(list = ls())
load("Environments/Corn/SSV3.RData")

# V3
source("Soybean/PriceObjectiveActualizedV5.R")
source("Soybean/TrailingStopActualizedV5.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV3V3.rds")

rm(list = ls())
load("Environments/Corn/SSV3.RData")

# V4
source("Soybean/PriceObjectiveActualizedV6.R")
source("Soybean/TrailingStopActualizedV6.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV3V4.rds")

rm(list = ls())
load("Environments/Corn/SSV3.RData")

#V5
source("Soybean/PriceObjectiveActualizedV7.R")
source("Soybean/TrailingStopActualizedV7.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV3V5.rds")

rm(list = ls())
load("Environments/Corn/SSV3.RData")

#V6
source("Soybean/PriceObjectiveActualizedV9.R")
source("Soybean/TrailingStopActualizedV9.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV3V6.rds")

#V7
source("Soybean/HarvestTimeSalesActualized.R")
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStopActualized.R")
source("Model/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjectsCornV3V7.rds")

rm(list = ls())

