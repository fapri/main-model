# Main Script Execution
# Corn and Soybean Model

library(lubridate)
library(dplyr)
library(ggplot2)

getCropType = function(){
  type = readline(prompt = "Enter crop type (soybean or corn. Anything else to quit): ")
  type = tolower(type)
  
  if(type != "soybean" && type != "corn") {
    type = "quit"
  }
  return(type)
}

type = getCropType()

if(type != "quit"){
  # Set up the Data and Crop Year Objects
  source("Model/Main.R")
  
  # Create common trigger functions
  source("Model/Triggers.R")
  source("Model/MultiYearTrigger.R")
  
  # Run the strategy triggers
  source("Model/PriceObjective.R")
  
  source("Model/TrailingStop.R")
  source("Model/TrailingStopV3.R")
  
  
  # RUN THE ACTUALIZATION SCRIPTS
  if(type == "soybean"){
    # prompt to select the actualization version
  } else if(type == "corn"){
    # prompt to select the actualization version
  } else {
    # maybe have an option to do both??
  }
  
  # Adjust for storage
  # STORAGE WORKS FOR BOTH CORN AND SOYBEANS
  source("Model/Storage.R")
  
  # Graph the Strategies
  source("Model/Graphing.R")
  
  # Code I used to save the objects
  #saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybean.rds")
}