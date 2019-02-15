# Corn

library(readxl)

Corn_FuturesMarket <- read_excel("Data/Corn_FuturesMarket.xlsx", sheet = "Sheet1", col_types = c("date", "numeric", "numeric"))
Corn_Basis <- read_excel("Data/Corn_Basis.xlsx", sheet = "Sheet1")
Corn_Baseline <- read_excel("Data/Corn_Baseline.xlsx", sheet = "Sheet1", col_types = c("date", 
                                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
lockBinding("Corn_FuturesMarket", globalenv())
lockBinding("Corn_Basis", globalenv())
lockBinding("Corn_Baseline", globalenv())
