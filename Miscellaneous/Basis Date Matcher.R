library(readxl)
library(readr)
library(lubridate)
library(dplyr)
library(svDialogs)

dates = read_excel("Miscellaneous/Dates.xlsx")

# Take in working large basis set if present
if (dlg_message(message = "Do you have a basis file in progress?", type = "yesno")[["res"]] == "yes") {
  fullSet = read_csv(file.choose())
} else {
  fullSet = data.frame()
}

# Loop to add multiple locations at once
while (dlg_message(message = "Add more data?", type = "yesno")[["res"]] == "yes") {
  basis = read_csv(file.choose(), skip = 1)
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
  
  # Add the city and the company to the dataframe
  city = dlgInput("Enter the City:", Sys.info()["user"])$res
  company = dlgInput("Enter the Company:", Sys.info()["user"])$res
  
  # Merge dates and basis
  mergedSet = merge(x = dates, y = basis, by.x = c("Week"), by.y = c("basisWeek"), all.y = TRUE)
  mergedSet$City = rep(city, nrow(mergedSet))
  mergedSet$Company = rep(company, nrow(mergedSet))
  
  fullSet = rbind(fullSet, mergedSet)
}

# Export large basis set to CSV
if (dlg_message(message = "Export data to a CSV?", type = "yesno")[["res"]] == "yes") {
  filename = dlgInput("Enter the filename (without .csv):", Sys.info()["user"])$res
  write.csv(fullSet, paste("Miscellaneous/", filename, ".csv", sep = ""), row.names = FALSE)
}





