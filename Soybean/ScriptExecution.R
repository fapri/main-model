# Soybean

library(lubridate)
library(dplyr)
library(ggplot2)

# Set up the data and Crop Year Objects
source("Soybean/Main.R")
# soybean

# Create common trigger functions
source("Soybean/Triggers.R")

# Load Multi-year marketing year
source("Soybean/MultiYearTrigger.R")

# Run the strategies
source("Soybean/PriceObjective.R")
source("Soybean/PriceObjectiveActualized.R")
source("Soybean/TrailingStop.R")
source("Soybean/TrailingStopActualized.R")
source("Soybean/SeasonalSaleActualized.R")

# Adjust for storage
source("Soybean/Storage.R")

# Graph the Strategies
source("Soybean/Graphing.R")

# Code I used to save the objects
saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybean.rds")
