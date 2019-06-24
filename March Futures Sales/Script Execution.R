# Soybean

library(lubridate)
library(dplyr)
library(ggplot2)

# Set up the data and Crop Year Objects
source("March Futures Sales/Main.R")
# soybean

# Create common trigger functions
source("Model/Triggers.R")

# Load Multi-year marketing year
source("Model/MultiYearTrigger.R")

# Run the strategies
source("March Futures Sales/PriceObjective.R")
source("March Futures Sales/TrailingStop.R")

source("March Futures Sales/PriceObjectiveActualizedV8.R")
source("March Futures Sales/TrailingStopActualizedV8.R")
source("Soybean/SeasonalSaleActualized.R")

source("March Futures Sales/Storage.R")
source("March Futures Sales/Graphing.R")


saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybeanMarch.rds")




