# Corn

# Libraries
library(lubridate)
library(dplyr)
library(ggplot2)
library(data.table)

# Set up the data and Crop Year Objects
source("Corn/MainMultiyear.R")

# Create common trigger functions
source("Corn/Triggers.R")

# Run if multi-year sales
source("Corn/MultiYearTrigger.R")

# Run the strategies
source("Corn/PriceObjective.R")
source("Corn/TrailingStop.R")

# These actualize for Mutli-year and non-multi-year
source("Corn/PriceObjectiveActualizedMultiYear.R")
source("Corn/TrailingStopActualizedMultiYear.R")
source("Corn/SeasonalSaleActualizedMultiYear.R")

# Adjust for storage
source("Corn/StorageMerge.R")

# Graph the Strategies
source("Corn/Graphing.R")

# Code I used to save the objects
saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = "appObjects.rds")
