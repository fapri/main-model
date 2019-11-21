# Load libraries
library(httr)
library(jsonlite)

# Define information to pull
url = "http://quickstats.nass.usda.gov/api/api_GET/?key="
key = ""
stateName = "&state_name=MISSOURI"
statistcCat = "&statisticcat_desc=PRODUCTION"
year = "&year__GE=2014"

# Choose corn or soybeans
if (type == "corn") {
  commodity = "&commodity_desc=CORN"
} else if (type == "soybeans") {
  commodity = "&commodity_desc=SOYBEANS"
}

# Pull and convert data from NASS
call = paste(url, key, commodity, stateName, statistcCat, year, sep = "")
get_Data = GET(call)
to_Text = content(get_Data, "text")
from_JSON = fromJSON(to_Text, flatten = TRUE)
productionFinal = as.data.frame(from_JSON)

# Save raw data pulled from API
if (type == "corn") {
  saveRDS(productionFinal, "Miscellaneous/Production By County/Raw_Producton_Corn.rds")
} else if (type == "soybeans") {
  saveRDS(productionFinal, "Miscellaneous/Production By County/Raw_Producton_Soybeans.rds")
}

# Remove extra columns
keeps <- c("data.county_name", "data.location_desc", "data.commodity_desc", "data.Value", "data.year", "data.source_desc")
productionFinal = productionFinal[keeps]

# Clean data
productionFinal = productionFinal[which(productionFinal$data.county_name != ""), ]
productionFinal = productionFinal[which(productionFinal$data.county_name != "OTHER (COMBINED) COUNTIES"), ]
productionFinal = productionFinal[which(productionFinal$data.source_desc != "CENSUS"), ]
productionFinal = productionFinal[ , -which(names(productionFinal) %in% c("data.source_desc"))]

colnames(productionFinal) = c("County", "Location", "Commodity", "Production", "Year")

productionFinal$Production = as.numeric(gsub(pattern = ",", replacement = "", x = productionFinal[, "Production"]))

# Create list segementing data by year
production_List = split(productionFinal, f = list(productionFinal$Year))

# Save final lists
if (type == "corn") {
  saveRDS(production_List, "Miscellaneous/Production By County/Data/Production_List_Corn.rds")
} else if (type == "soybeans") {
  saveRDS(production_List, "Miscellaneous/Production By County/Data/Production_List_Soybeans.rds")
}
