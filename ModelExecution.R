# Main Script Execution
# Corn and Soybean Model

library(lubridate)
library(dplyr)
library(ggplot2)

exit <- function() {
  .Internal(.invokeRestart(list(NULL, NULL), NULL))
}

getCropType = function(){
  type = readline(prompt = "Enter crop type (soybean or corn. 'quit' to quit): ")
  type = tolower(type)
  
  if(type == "quit"){
    cat("Ending session now")
    exit()
  }
  while(type != "soybean" && type != "corn") {
    type = readline(prompt = "Enter crop type (soybean or corn. 'quit' to quit): ")
    type = tolower(type)
    if(type == "quit"){
      cat("Ending session now")
      exit()
    }
  }

  return(type)
}

getTStrigger = function(){
  cat("\nBase = FAPRI Baselines
      V3 = 1% Drop from the FAPRI Baselines")
  version = readline(prompt = "Enter Trigger Script Choice (Base or V3. 'quit' to quit): ")
  version = tolower(version)
  
  if(version == "quit"){
    cat("Ending session now")
    exit()
  }
  while(version != "base" && version != "v3") {
    version = readline(prompt = "Enter Trigger Script Choice (Base or V3. 'quit' to quit): ")
    version = tolower(version)
    if(version == "quit"){
      cat("Ending session now")
      exit()
    }
  }

  return(version)
}

getPOactualizion = function(){
  cat("\nBase = 10% Sales
       V2 = 20% Sales at 90th percentile
       V5 = July 20th dump date (June for Corn), each PO sale is at 20% of whatever is on Sept 1st. 
       (ex. if 50% of crop remains, PO sales will be made at 10%)
       V6 = 10% Sales, July 20th dump date
       V7 = 20% Sales at 90th percentile, July 20th dump date")
  version = readline(prompt = "Enter Actualization Script Choice (Base, V2, V5, V6, or V7. 'quit' to quit): ")
  version = tolower(version)
  
  if(version == "quit"){
    cat("Ending session now")
    exit()
  }
  
  while(version != "base" & version != "v2" & version != "v5" & version != "v6" & version != "v7") {
    version = readline(prompt = "Enter Actualization Script Choice (Base, V2, V5, V6, or V7. 'quit' to quit): ")
    version = tolower(version)
    if(version == "quit"){
      cat("Ending session now")
      exit()
    }
  }
  return(version)
}

getTSactualizion = function(){
  cat("\nBase = 10% Sales
       V2 = 20% Sales at 90th percentile
       V5 = July 20th dump date (June for Corn), each PO sale is at 20% of whatever is on Sept 1st. 
       (ex. if 50% of crop remains, PO sales will be made at 10%)
       V6 = 10% Sales, July 20th dump date
       V7 = 20% Sales at 90th percentile, July 20th dump date")
  version = readline(prompt = "Enter Actualization Script Choice (Base, V2, V5, V6, or V7. 'quit' to quit): ")
  version = tolower(version)
  
  if(version == "quit"){
    cat("Ending session now")
    exit()
  }
  
  while(version != "base" & version != "v2" & version != "v5" & version != "v6" & version != "v7") {
    version = readline(prompt = "Enter Actualization Script Choice (Base, V2, V5, V6, or V7. 'quit' to quit): ")
    version = tolower(version)
    if(version == "quit"){
      cat("Ending session now")
      exit()
    }
  }
  return(version)
}

getFileName = function(){
  fileName = readline(prompt = "Enter the name to save the file as. Do not include '.rds' (example: appObjectsSoybeanBase): ")
  sub_str = substr(fileName, 1, 1)
  hasNumbers = grep("[0-9]", sub_str)
  while(length(hasNumbers) > 0){
    cat("First character cannot be numeric.")
    fileName = readline(prompt = "Enter the name to save the file as. Do not include '.rds' (example: appObjectsSoybeanBase): ")
  }
  
  return(fileName)
}

type = getCropType()

if(type != "quit"){
  # Set up the Data and Crop Year Objects
  cat("\nRunning Main...")
  source("Model/Main.R")
  
  # Create common trigger functions
  cat("\nRunning Triggers...")
  source("Model/Triggers.R")
  cat("\nRunning MultiYearTrigger...")
  source("Model/MultiYearTrigger.R")
  
  # Run the strategy triggers
  cat("\nRunning Price Objective Trigger...")
  source("Model/PriceObjective.R")
  
  if(type == "soybean"){
    TSTrigger = getTStrigger()
    
    if(TSTrigger == "quit"){
      cat("Ending session now")
      exit()
    }
    cat("\nRunning Trailing Stop Trigger...")
    switch(TSTrigger,
           "base" = source("Model/TrailingStop.R"),
           "v3" = source("Model/TrailingStopV3.R")
    )
    
    
  } else if(type == "corn"){
    TSTrigger = getTStrigger()
    
    if(TSTrigger == "quit"){
      cat("Ending session now")
      exit()
    }
    cat("\nRunning Trailing Stop Trigger...")
    switch(TSTrigger,
           "base" = source("Model/TrailingStop.R"),
           "v3" = source("Model/TrailingStopV3.R")
    )
  } 
  
  # RUN THE ACTUALIZATION SCRIPTS
  if(type == "soybean"){
    POVersion = getPOactualizion()
    
    if(POVersion == "quit"){
      cat("Ending session now")
      exit()
    }
    cat("\nRunning Price Objective Actualization...")
    switch(POVersion,
           "base" = source("Soybean/PriceObjectiveActualized.R"),
           "v2" = source("Soybean/PriceObjectiveActualizedV2.R"),
           "v5" = source("Soybean/PriceObjectiveActualizedV5.R"),
           "v6" = source("Soybean/PriceObjectiveActualizedV6.R"),
           "v7" = source("Soybean/PriceObjectiveActualizedV7.R"))
    
    TSVersion = getTSactualizion()
    
    if(TSVersion == "quit"){
      cat("Ending session now")
      exit()
    }
    cat("\nRunning Trailing Stop Actualization...")
    switch(TSVersion,
           "base" = source("Soybean/TrailingStopActualized.R"),
           "v2" = source("Soybean/TrailingStopActualizedV2.R"),
           "v5" = source("Soybean/TrailingStopActualizedV5.R"),
           "v6" = source("Soybean/TrailingStopActualizedV6.R"),
           "v7" = source("Soybean/TrailingStopActualizedV7.R"))
  } else if(type == "corn"){
    POVersion = getPOactualizion()
    
    if(POVersion == "quit"){
      cat("Ending session now")
      exit()
    }
    cat("\nRunning Price Objective Actualization...")
    switch(POVersion,
           "base" = source("Soybean/PriceObjectiveActualized.R"),
           "v2" = source("Soybean/PriceObjectiveActualizedV2.R"),
           "v5" = source("Soybean/PriceObjectiveActualizedV5.R"),
           "v6" = source("Soybean/PriceObjectiveActualizedV6.R"),
           "v7" = source("Soybean/PriceObjectiveActualizedV7.R"))
    
    TSVersion = getTSactualizion()
    
    if(TSVersion == "quit"){
      cat("Ending session now")
      exit()
    }
    cat("\nRunning Trailing Stop Actualization...")
    switch(TSVersion,
           "base" = source("Soybean/TrailingStopActualized.R"),
           "v2" = source("Soybean/TrailingStopActualizedV2.R"),
           "v5" = source("Soybean/TrailingStopActualizedV5.R"),
           "v6" = source("Soybean/TrailingStopActualizedV6.R"),
           "v7" = source("Soybean/TrailingStopActualizedV7.R"))
  } else {
    # maybe have an option to do both??
  }
  
  # Adjust for storage
  # STORAGE WORKS FOR BOTH CORN AND SOYBEANS
  cat("\nRunning Storage...")
  source("Model/Storage.R")
  
  # Graph the Strategies
  cat("\nRunning Graphing...")
  source("Model/Graphing.R")
  
  if(type == "corn"){
    cat("Saving Objects...")
    fileName = getFileName()
    saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = fileName)
  } else if(type == "soybean"){
    cat("Saving Objects...")
    fileName = getFileName()
    saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = fileName)
  }
  
  cat("Model complete. Ending session now")
  exit()
}
