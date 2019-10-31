library(readxl)
library(readr)
library(lubridate)
library(dplyr)
library(svDialogs)

fullSet = data.frame()
dates = read_excel("Miscellaneous/Dates.xlsx")

cropType = dlg_message(message = "Yes for Corn, No for Soybeans", type = "yesno")[["res"]]

if (cropType == "yes") {
  files = list.files("Miscellaneous/Data")
} else {
  files = list.files("Miscellaneous/SoybeanData")
}

for (filename in files) {
  print(paste("FILENAME:", filename))
  split = unlist(strsplit(filename, " - "))
  print(paste("LOCATION:", split[1]))
  print(paste("COMPANY:", split[2]))
  print("----------------------------------------------------------------------")
  
  if (cropType == "yes") {
    basis = read_csv(paste("Miscellaneous/Data/", filename, sep = ""), skip = 1)
  } else {
    basis = read_csv(paste("Miscellaneous/SoybeanData/", filename, sep = ""), skip = 1)
  }
  
  # Remove any escape characters
  colnames(basis) = gsub("[\r\n]", "", colnames(basis))
  
  # Add any missing years from requiredYears
  requiredYears = c("2019", "2018", "2017", "2016", "2015", "2014")
  for (year in requiredYears) {
    if (is.na(match(year, colnames(basis)))) {
      basis$temp = NA
      colnames(basis) = gsub("temp", year, colnames(basis))
    }
  }
  
  # Reorder the columns and add the prefix
  basis <- basis[c(c("Week"), requiredYears)]
  colnames(basis) = paste("basis", colnames(basis), sep = "")
  
  # Convert to data.frame
  basis = data.frame(basis)
  dates = data.frame(dates)
  
  # Merge dates and basis
  mergedSet = merge(x = dates, y = basis, by.x = c("Week"), by.y = c("basisWeek"), all.y = TRUE)
  mergedSet$City = rep(split[1], nrow(mergedSet))
  mergedSet$Company = rep(split[2], nrow(mergedSet))
  
  fullSet = rbind(fullSet, mergedSet)
}

# Export large basis set to CSV
if (dlg_message(message = "Export data to a CSV?", type = "yesno")[["res"]] == "yes") {
  filename = dlgInput("Enter the filename (without .csv):", Sys.info()["user"])$res
  write.csv(fullSet, paste("Miscellaneous/", filename, ".csv", sep = ""), row.names = FALSE)
}
