# Corn

# Set up the data and Crop Year Objects
source("Corn/Main.R")

# Create common trigger functions
source("Corn/Triggers.R")

# Run the strategies (without multi-year)
source("Corn/PriceObjective.R")
source("Corn/PriceObjectiveActualized.R")
source("Corn/TrailingStop.R")
source("Corn/TrailingStopActualized.R")
source("Corn/SeasonalSaleActualized.R")


# Run the strategies (with multi-year)
source("Corn/MultiYearTrigger.R")
source("Corn/PriceObjectiveActualizedMultiYear.R")
source("Corn/TrailingStopActualizedMultiYear.R")
source("Corn/SeasonalSaleActualizedMultiYear.R")

# Adjust for storage
source("Corn/StorageMerge.R")

# Graph the Strategies
source("Corn/Graphing.R")

# Code I used to save the objects
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjects.rds")
