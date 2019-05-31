# Main Script Execution
# Corn and Soybean Model

getCropType = function(){
  type = readline(prompt = "Enter crop type (soybean or corn. Anything else to quit): ")
  type = tolower(type)
  
  if(type != "soybean" && type != "corn"){
    type = "quit"
  }
  return(type)
}

type = getCropType()

# Set up the Data and Crop Year Objects
source("Model/Main.R")

# Create common trigger functions
source("Model/Triggers.R")

# Load Multi-year marketing year
#source("Soybean/MultiYearTrigger.R")

# Run the strategies
source("Model/PriceObjective.R")
source("Model/TrailingStop.R")

# SPLIT UP AND DO THE ACTUALIZATION STUFF
if(type == "soybean"){

}

if(type == "corn"){

}

# Adjust for storage
source("Model/Storage.R")

# Graph the Strategies
source("Model/Graphing.R")

# Code I used to save the objects
#saveRDS(list(Soybean_CropYearObjects, Soybean_CropYears, finalizedPriceObject), file = "appObjectsSoybean.rds")