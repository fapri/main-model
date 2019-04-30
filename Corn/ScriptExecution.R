# Corn

# Set up the data and Crop Year Objects
source("Corn/Main.R")

# Run the strategies
source("Corn/PriceObjective.R")
source("Corn/PriceObjectiveActualized.R")
source("Corn/TrailingStop.R")
source("Corn/TrailingStopActualized.R")
source("Corn/SeasonalSaleActualized.R")

# Graph the Strategies
source("Corn/Graphing.R")

# Adjust for storage
source("Corn/StorageMerge.R")