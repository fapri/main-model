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
source("Soybean/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3base.rds")

# V2
source("Soybean/PriceObjectiveActualizedV2.R")
source("Soybean/TrailingStopActualizedV2.R")
source("Soybean/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3V2.rds")

# V3
source("Soybean/PriceObjectiveActualizedV5.R")
source("Soybean/TrailingStopActualizedV5.R")
source("Soybean/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3V3.rds")

# V4
source("Soybean/PriceObjectiveActualizedV6.R")
source("Soybean/TrailingStopActualizedV6.R")
source("Soybean/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3V4.rds")

#V5
source("Soybean/PriceObjectiveActualizedV7.R")
source("Soybean/TrailingStopActualizedV7.R")
source("Soybean/Storage.R")
source("Model/Graphing.R")
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3V5.rds")









# Adjust for storage
source("Soybean/Storage.R")

# Graph the Strategies
source("Model/Graphing.R")

# Code I used to save the objects
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanV3/base.rds")
