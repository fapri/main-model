library(readxl)
library(gmapsdistance)
library(svDialogs)

# Convert to miles
meters_to_miles = function(x) {
  return(x / 1609.344)
}

countyCenters = read_excel("Miscellaneous/County Centers.xlsx")

check = FALSE
while(check == FALSE) {
  countyName = dlgInput("What county do you want to pull distances for? ex. Montgomery", Sys.info()["user"])$res
  check = countyName %in% countyCenters$County
}

county = countyCenters[which(countyCenters$County == countyName),]
county_origin = paste(county$Latitude, county$Longitude, sep = "+")
countyCenters = countyCenters[which(countyCenters$County != countyName),]

results = list()
errors = list()
set.api.key("ASK DANIEL")
for (row in 1:nrow(countyCenters)) {
  c = countyCenters[row,]
  c_name = c$County
  c_dest = paste(c$Latitude, c$Longitude, sep = "+")
  
  result = gmapsdistance(origin = county_origin,
                         destination = c_dest,
                         mode = "driving")
  
  if (result$Status == "OK") {
    results[[c_name]] = result$Distance
  } else {
    errors[[c_name]] = result$Status
  }
}

results = lapply(results, meters_to_miles)

# Convert list to Data Frame
results = data.frame(County = names(results), 
                                     Distance = as.numeric(sapply(results, paste,collapse = " ")), 
                                     row.names = seq_along(results))

# Save RDS for later
saveRDS(results, paste("Miscellaneous/Distances/", countyName, ".rds", sep = ""))


# Test Read
# test = readRDS("Miscellaneous/Distances/Carroll.rds")
