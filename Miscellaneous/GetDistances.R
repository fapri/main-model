library(readxl)
library(gmapsdistance)

countyCenters = read_excel("Miscellaneous/County Centers.xlsx")

montgomeryCounty = countyCenters[which(countyCenters$County == "Montgomery"),]
montgomeryCounty_origin = paste(montgomeryCounty$Latitude, montgomeryCounty$Longitude, sep = "+")

countyCenters = countyCenters[which(countyCenters$County != "Montgomery"),]

results = list()
errors = list()
set.api.key("")
for (row in 1:nrow(countyCenters)) {
  county = countyCenters[row,]
  county_name = county$County
  county_dest = paste(county$Latitude, county$Longitude, sep = "+")
  
  result = gmapsdistance(origin = montgomeryCounty_origin,
                          destination = county_dest,
                          mode = "driving")
  
  if (result$Status == "OK") {
    results[[county_name]] = result$Distance
  } else {
    errors[[county_name]] = result$Status
  }
}


Montgomery_Distances = results
saveRDS(Montgomery_Distances, "Miscellaneous/Montgomery_Distances.rds")
Montgomery_Distances = readRDS("Miscellaneous/Montgomery_Distances.rds")



meters_to_miles = function(x) {
  return (x / 1609.344)
}

Montgomery_Distances = lapply(Montgomery_Distances,meters_to_miles)


# results = gmapsdistance(origin = montgomeryCounty_origin,
#                         destination = "38.989657+-92.310779",
#                         mode = "driving")
