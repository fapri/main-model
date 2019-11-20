library(httr)
library(jsonlite)

url = "http://quickstats.nass.usda.gov/api/api_GET/?key="
key = ""
commodity = "&commodity_desc=CORN"
stateName = "&state_name=MISSOURI"
statistcCat = "&statisticcat_desc=PRODUCTION"
year = "&year__GE=2014"

call = paste(url, key, commodity, stateName, statistcCat, year, sep = "")

get_Data = GET(call)

to_Text = content(get_Data, "text")

from_JSON = fromJSON(to_Text, flatten = TRUE)

productionFinal = as.data.frame(from_JSON)
