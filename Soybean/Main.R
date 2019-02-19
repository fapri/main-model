# Soybean

library(readxl)

Soybean_CropYears <- read_excel("Data/Soybean_CropYears.xlsx", sheet = "Sheet1", col_types = c("text", "date", "date"))
Soybean_FuturesMarket <- read_excel("Data/Soybean_FuturesMarket.xlsx", sheet = "Sheet1", col_types = c("date", "numeric", "numeric"))
Soybean_Basis <- read_excel("Data/Soybean_Basis.xlsx", sheet = "Sheet1")
Soybean_Baseline <- read_excel("Data/Soybean_Baseline.xlsx", sheet = "Sheet1", col_types = c("date", 
                                                                                       "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                                                       "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
lockBinding("Soybean_CropYears", globalenv())
lockBinding("Soybean_FuturesMarket", globalenv())
lockBinding("Soybean_Basis", globalenv())
lockBinding("Soybean_Baseline", globalenv())
