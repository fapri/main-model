# Soybean

library(lubridate)
library(dplyr)
library(ggplot2)

# Set up the data and Crop Year Objects
source("Soybean/Main.R")

















# Create common trigger functions
source("Soybean/Triggers.R")

# Run the strategies (without multi-year)
source("Soybean/PriceObjective.R")
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStop.R")
source("Soybean/TrailingStopActualized.R")
source("Soybean/SeasonalSaleActualized.R")


# Run the strategies (with multi-year)
source("Soybean/MultiYearTrigger.R")
source("Soybean/PriceObjectiveActualizedMultiYear.R")
source("Soybean/TrailingStopActualizedMultiYear.R")
source("Soybean/SeasonalSaleActualizedMultiYear.R")

# Adjust for storage
source("Soybean/StorageMerge.R")

# Graph the Strategies
source("Soybean/Graphing.R")

# Code I used to save the objects
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjects.rds")
