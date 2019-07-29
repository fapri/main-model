# Main Script Execution
# Corn and Soybean Model

library(lubridate)
library(dplyr)
library(ggplot2)

exit <- function() {
  .Internal(.invokeRestart(list(NULL, NULL), NULL))
}

getCropType = function() {
  type = readline(prompt = "Enter crop type (soybean or corn. 'quit' to quit): ")
  type = tolower(type)
  
  if(type == "quit"){
    cat("\nEnding session now")
    exit()
  }
  while(type != "soybean" && type != "corn") {
    type = readline(prompt = "Enter crop type (soybean or corn. 'quit' to quit): ")
    type = tolower(type)
    if(type == "quit"){
      cat("\nEnding session now")
      exit()
    }
  }
  
  return(type)
}

getFullRun = function() {
  run = readline(prompt = "Run entire model? ('yes' for full model, 'no' to start at actualization. 'quit' to quit): ")
  run = tolower(run)
  
  if(run == "quit"){
    cat("\nEnding session now")
    exit()
  }
  while(run != "yes" && run != "no") {
    run = readline(prompt = "Run entire model? ('yes' for full model, 'no' to start at actualization. 'quit' to quit): ")
    run = tolower(run)
    if(run == "quit"){
      cat("\nEnding session now")
      exit()
    }
  }
  
  return(run)
}

getTStrigger = function() {
  cat("\nBase = FAPRI Baselines
      V3 = 1% Drop from the FAPRI Baselines")
  version = readline(prompt = "Enter Trigger Script Choice (Base or V3. 'quit' to quit): ")
  version = tolower(version)
  
  if(version == "quit"){
    cat("\nEnding session now")
    exit()
  }
  while(version != "base" && version != "v3") {
    version = readline(prompt = "Enter Trigger Script Choice (Base or V3. 'quit' to quit): ")
    version = tolower(version)
    if(version == "quit"){
      cat("\nEnding session now")
      exit()
    }
  }
  
  return(version)
}

getPOactualizion = function() {
  cat("\n       Base = 10% Sales
       V2 = 20% Sales at 90th percentile
       V5 = July 20th dump date (June for Corn), each PO sale is at 20% of whatever is on Sept 1st. 
       (ex. if 50% of crop remains, PO sales will be made at 10%)
       V6 = 10% Sales, July 20th dump date
       V7 = 20% Sales at 90th percentile, July 20th dump date")
  version = readline(prompt = "Enter Actualization Script Choice (Base, V2, V5, V6, or V7. 'quit' to quit): ")
  version = tolower(version)
  
  if(version == "quit"){
    cat("\nEnding session now")
    exit()
  }
  
  while(version != "base" & version != "v2" & version != "v5" & version != "v6" & version != "v7") {
    version = readline(prompt = "Enter Actualization Script Choice (Base, V2, V5, V6, or V7. 'quit' to quit): ")
    version = tolower(version)
    if(version == "quit"){
      cat("\nEnding session now")
      exit()
    }
  }
  return(version)
}

getTSactualizion = function() {
  cat("\n       Base = 10% Sales
       V2 = 20% Sales at 90th percentile
       V5 = July 20th dump date (June for Corn), each PO sale is at 20% of whatever is on Sept 1st. 
       (ex. if 50% of crop remains, PO sales will be made at 10%)
       V6 = 10% Sales, July 20th dump date
       V7 = 20% Sales at 90th percentile, July 20th dump date")
  version = readline(prompt = "Enter Actualization Script Choice (Base, V2, V5, V6, or V7. 'quit' to quit): ")
  version = tolower(version)
  
  if(version == "quit"){
    cat("\nEnding session now")
    exit()
  }
  
  while(version != "base" & version != "v2" & version != "v5" & version != "v6" & version != "v7") {
    version = readline(prompt = "Enter Actualization Script Choice (Base, V2, V5, V6, or V7. 'quit' to quit): ")
    version = tolower(version)
    if(version == "quit"){
      cat("\nEnding session now")
      exit()
    }
  }
  return(version)
}

getFileName = function() {
  fileName = readline(prompt = "Enter the name to save the file as. Do not include '.rds' (example: appObjectsSoybeanBase): ")
  sub_str = substr(fileName, 1, 1)
  hasNumbers = grep("[0-9]", sub_str)
  while(length(hasNumbers) > 0){
    cat("\nFirst character cannot be numeric.")
    fileName = readline(prompt = "Enter the name to save the file as. Do not include '.rds' (example: appObjectsSoybeanBase): ")
  }
  
  fileName = paste(fileName, ".rds", sep = "")
  
  return(fileName)
}

getEnvironment = function() {
  fileName = readline(prompt = "Enter the name of the RData environment (case sensitive) to be loaded (ex. test.RData). 'quit' to quit: ")
  
  if(fileName == "quit"){
    cat("\nEnding session now")
    exit()
  }
  
  if(!grepl(".RData", fileName)){
    fileName = paste(fileName, ".RData", sep = "")
  }
  
  while (!file.exists(fileName)){
    cat("\nFile not found! Check for proper working directory. Check spelling. Check case and punctuation.")
    fileName = readline(prompt = "Enter the name of the RData environment (case sensitive) to be loaded (ex. test.RData). 'quit' to quit: ")
    if(fileName == "quit"){
      cat("\nEnding session now")
      exit()
    }
    if(!grepl(".RData", fileName)){
      fileName = paste(fileName, ".RData", sep = "")
    }
  }

  return(fileName)
}

checkEnvironment = function(){
  # Check for crop year objects
  if(!exists("Soybean_CropYearObjects") && !exists("Corn_CropYearObjects") ){
    cat("\nEnvironment does not include Crop Year Objects.\n")
    return(FALSE)
  }

  # Check for price objective triggers
  if(!all(grepl("PO Triggers", Soybean_CropYearObjects)) && !all(grepl("PO Triggers", Corn_CropYearObjects))){
    cat("\nEnvironment does not include Price Objective Triggers.\n")
    return(FALSE)
  }

  # Check for trailing stop triggers
  if(!all(grepl("TS Triggers", Soybean_CropYearObjects)) && !all(grepl("TS Triggers", Corn_CropYearObjects))){
    cat("\nEnvironment does not include Trailing Stop Triggers.\n")
    return(FALSE)
  }

  return(TRUE)
}

type = getCropType()

fullRun = getFullRun()

# load(file='emergencyRecovery.RData')

# full run
if(type != "quit" && fullRun == "yes") {
  # Set up the Data and Crop Year Objects
  cat("\nRunning Main...")
  source("Model/Main.R")
  
  save.image(file='emergencyRecovery.RData')
  
  # Create common trigger functions
  cat("\nRunning Triggers...")
  source("Model/Triggers.R")
  cat("\nRunning MultiYearTrigger...")
  source("Model/MultiYearTrigger.R")
  
  save.image(file='emergencyRecovery.RData')
  
  # Run the strategy triggers
  cat("\nRunning Price Objective Trigger...")
  source("Model/PriceObjective.R")
  
  save.image(file='emergencyRecovery.RData')
  
  if(type == "soybean") {
    TSTrigger = getTStrigger()
    
    if(TSTrigger == "quit"){
      cat("\nEnding session now")
      exit()
    }
    cat("\nRunning Trailing Stop Trigger...")
    switch(TSTrigger,
           "base" = source("Model/TrailingStop.R"),
           "v3" = source("Model/TrailingStopV3.R")
    )
    save.image(file='emergencyRecovery.RData') 
  } else if(type == "corn") {
    TSTrigger = getTStrigger()
    
    if(TSTrigger == "quit") {
      cat("\nEnding session now")
      exit()
    }
    cat("\nRunning Trailing Stop Trigger...")
    switch(TSTrigger,
           "base" = source("Model/TrailingStop.R"),
           "v3" = source("Model/TrailingStopV3.R")
    )
    save.image(file='emergencyRecovery.RData')
  } 
  
  
  
  # RUN THE ACTUALIZATION SCRIPTS
  if(type == "soybean") {
    POVersion = getPOactualizion()
    
    if(POVersion == "quit") {
      cat("\nEnding session now")
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
    
    if(TSVersion == "quit") {
      cat("\nEnding session now")
      exit()
    }
    cat("\nRunning Trailing Stop Actualization...")
    switch(TSVersion,
           "base" = source("Soybean/TrailingStopActualized.R"),
           "v2" = source("Soybean/TrailingStopActualizedV2.R"),
           "v5" = source("Soybean/TrailingStopActualizedV5.R"),
           "v6" = source("Soybean/TrailingStopActualizedV6.R"),
           "v7" = source("Soybean/TrailingStopActualizedV7.R"))
  } else if(type == "corn") {
    POVersion = getPOactualizion()
    
    if(POVersion == "quit") {
      cat("\nEnding session now")
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
    
    if(TSVersion == "quit") {
      cat("\nEnding session now")
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
  
  cat("\nRunning Seasonal Sales Actualizations...")
  source("Soybean/SeasonalSaleActualized.R")
  
  save.image(file='emergencyRecovery.RData')
  
  # Adjust for storage
  # STORAGE WORKS FOR BOTH CORN AND SOYBEANS
  cat("\nRunning Storage...")
  source("Model/Storage.R")
  
  # Graph the Strategies
  cat("\nRunning Graphing...")
  source("Model/Graphing.R")
  
  if(type == "corn") {
    cat("\nSaving Objects...")
    fileName = getFileName()
    saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = fileName)
    if (file.exists('emergencyRecovery.RData')) file.remove('emergencyRecovery.RData')
  } else if(type == "soybean") {
    cat("\nSaving Objects...")
    fileName = getFileName()
    saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = fileName)
    if (file.exists('emergencyRecovery.RData')) file.remove('emergencyRecovery.RData')
  }
  
  cat("\nModel complete. Ending session now")
  exit()
}

# Starting at actualization
if(type != "quit" && fullRun == "no") {
  
  # load in appropriate environment 
  envName = getEnvironment()
  lapply(envName, load, .GlobalEnv)
  
  while(checkEnvironment() == FALSE){
    envName = getEnvironment()
    lapply(envName, load, .GlobalEnv)
  }
  
  
  # RUN THE ACTUALIZATION SCRIPTS
  if(type == "soybean") {
    POVersion = getPOactualizion()
    
    if(POVersion == "quit") {
      cat("\nEnding session now")
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
    
    if(TSVersion == "quit") {
      cat("\nEnding session now")
      exit()
    }
    cat("\nRunning Trailing Stop Actualization...")
    switch(TSVersion,
           "base" = source("Soybean/TrailingStopActualized.R"),
           "v2" = source("Soybean/TrailingStopActualizedV2.R"),
           "v5" = source("Soybean/TrailingStopActualizedV5.R"),
           "v6" = source("Soybean/TrailingStopActualizedV6.R"),
           "v7" = source("Soybean/TrailingStopActualizedV7.R"))
  } else if(type == "corn") {
    POVersion = getPOactualizion()
    
    if(POVersion == "quit") {
      cat("\nEnding session now")
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
    
    if(TSVersion == "quit") {
      cat("\nEnding session now")
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
  
  cat("\nRunning Seasonal Sales Actualizations...")
  source("Soybean/SeasonalSaleActualized.R")
  
  save.image(file='emergencyRecovery.RData')
  
  # Adjust for storage
  # STORAGE WORKS FOR BOTH CORN AND SOYBEANS
  cat("\nRunning Storage...")
  source("Model/Storage.R")
  
  # Graph the Strategies
  cat("\nRunning Graphing...")
  source("Model/Graphing.R")
  
  if(type == "corn") {
    cat("\nSaving Objects...")
    fileName = getFileName()
    saveRDS(list(Corn_CropYearObjects, Corn_CropYears, finalizedPriceObject), file = fileName)
    if (file.exists('emergencyRecovery.RData')) file.remove('emergencyRecovery.RData')
  } else if(type == "soybean") {
    cat("\nSaving Objects...")
    fileName = getFileName()
    saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = fileName)
    if (file.exists('emergencyRecovery.RData')) file.remove('emergencyRecovery.RData')
  }
  
  cat("\nModel complete. Ending session now")
  exit()
}
