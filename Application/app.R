library(shiny)
library(DT)
library(htmltools)
library(formattable)
# library(lubridate)
# library(ggplot2)
library(lubridate)
library(dplyr)
library(ggplot2)

####################################################################################
# REFER TO THE MANUAL FOR INSTRUCTIONS ON HOW TO SET EVERYTHING UP FOR REMOTE ACCESS
####################################################################################

# Load GitHub links for remote access to appObjects and HTML files
load(url("https://github.com/fapri/main-model/blob/feature/newCropYears/Application/cornV1.RData?raw=true"))
load(url("https://github.com/fapri/main-model//blob/feature/newCropYears/Application/cornV3.RData?raw=true"))
load(url("https://github.com/fapri/main-model/blob/feature/newCropYears/Application/soybeanV1.RData?raw=true"))
load(url("https://github.com/fapri/main-model/blob/feature/newCropYears/Application/soybeanV3.RData?raw=true"))
load(url("https://github.com/fapri/main-model/blob/feature/newCropYears/Application/otherStrategies.RData?raw=true"))

versionsHTML = url("https://raw.githubusercontent.com/fapri/main-model/master/Application/versions.html")
indexHTML = url("https://raw.githubusercontent.com/fapri/main-model/master/Application/index.html")
homePageHTML = url("https://raw.githubusercontent.com/fapri/main-model/master/Application/homePage.html")

# versionsHTML = "versions.html"
# indexHTML = "index.html"
# homePageHTML = "homePage.html"


# load("cornV1.RData")
# load("cornV3.RData")
# load("soybeanV1.RData")
# load("soybeanV3.RData")


# #Corn Base/__
# appObjectsCornBase = readRDS("appObjectsCornBase.rds")
# Corn_CropYearObjectsBase = appObjectsCornBase[[1]]
# Corn_CropYearsBase = appObjectsCornBase[[2]]
# finalizedPriceObjectCornBase = appObjectsCornBase[[3]]
# 
# appObjectsCornV2 = readRDS("appObjectsCornV2.rds")
# Corn_CropYearObjectsV2 = appObjectsCornV2[[1]]
# Corn_CropYearsV2 = appObjectsCornV2[[2]]
# finalizedPriceObjectCornV2 = appObjectsCornV2[[3]]
# 
# appObjectsCornV3 = readRDS("appObjectsCornV3.rds")
# Corn_CropYearObjectsV3 = appObjectsCornV3[[1]]
# Corn_CropYearsV3 = appObjectsCornV3[[2]]
# finalizedPriceObjectCornV3 = appObjectsCornV3[[3]]
# 
# appObjectsCornV4 = readRDS("appObjectsCornV4.rds")
# Corn_CropYearObjectsV4 = appObjectsCornV4[[1]]
# Corn_CropYearsV4 = appObjectsCornV4[[2]]
# finalizedPriceObjectCornV4 = appObjectsCornV4[[3]]
# 
# appObjectsCornV5 = readRDS("appObjectsCornV5.rds")
# Corn_CropYearObjectsV5 = appObjectsCornV5[[1]]
# Corn_CropYearsV5 = appObjectsCornV5[[2]]
# finalizedPriceObjectCornV5 = appObjectsCornV5[[3]]
# 
# appObjectsCornV6 = readRDS("appObjectsCornV6.rds")
# Corn_CropYearObjectsV6 = appObjectsCornV6[[1]]
# Corn_CropYearsV6 = appObjectsCornV6[[2]]
# finalizedPriceObjectCornV6 = appObjectsCornV6[[3]]
# 
# appObjectsCornHarvestTime = readRDS("appObjectsCornHarvestTime.rds")
# Corn_CropYearObjectsHarvestTime = appObjectsCornHarvestTime[[1]]
# Corn_CropYearsHarvestTime = appObjectsCornHarvestTime[[2]]
# finalizedPriceObjectCornHarvestTime = appObjectsCornHarvestTime[[3]]
# 
# appObjectsCorn404020 = readRDS("appObjectsCorn404020.rds")
# Corn_CropYearObjects404020 = appObjectsCorn404020[[1]]
# Corn_CropYears404020 = appObjectsCorn404020[[2]]
# finalizedPriceObjectCorn404020 = appObjectsCorn404020[[3]]
#  
# # Corn V3/__
# appObjectsCornV3Base = readRDS("appObjectsCornV3Base.rds")
# Corn_CropYearObjectsV3Base = appObjectsCornV3Base[[1]]
# Corn_CropYearsV3Base = appObjectsCornV3Base[[2]]
# finalizedPriceObjectCornV3Base = appObjectsCornV3Base[[3]]
# 
# appObjectsCornV3V2 = readRDS("appObjectsCornV3V2.rds")
# Corn_CropYearObjectsV3V2 = appObjectsCornV3V2[[1]]
# Corn_CropYearsV3V2 = appObjectsCornV3V2[[2]]
# finalizedPriceObjectCornV3V2 = appObjectsCornV3V2[[3]]
# 
# appObjectsCornV3V3 = readRDS("appObjectsCornV3V3.rds")
# Corn_CropYearObjectsV3V3 = appObjectsCornV3V3[[1]]
# Corn_CropYearsV3V3 = appObjectsCornV3V3[[2]]
# finalizedPriceObjectCornV3V3 = appObjectsCornV3V3[[3]]
# 
# appObjectsCornV3V4 = readRDS("appObjectsCornV3V4.rds")
# Corn_CropYearObjectsV3V4 = appObjectsCornV3V4[[1]]
# Corn_CropYearsV3V4 = appObjectsCornV3V4[[2]]
# finalizedPriceObjectCornV3V4 = appObjectsCornV3V4[[3]]
# 
# appObjectsCornV3V5 = readRDS("appObjectsCornV3V5.rds")
# Corn_CropYearObjectsV3V5 = appObjectsCornV3V5[[1]]
# Corn_CropYearsV3V5 = appObjectsCornV3V5[[2]]
# finalizedPriceObjectCornV3V5 = appObjectsCornV3V5[[3]]
# 
# appObjectsCornV3V6 = readRDS("appObjectsCornV3V6.rds")
# Corn_CropYearObjectsV3V6 = appObjectsCornV3V6[[1]]
# Corn_CropYearsV3V6 = appObjectsCornV3V6[[2]]
# finalizedPriceObjectCornV3V6 = appObjectsCornV3V6[[3]]
# 
# # Corn March NC
# appObjectsCornMarch = readRDS("appObjectsCornMarch.rds")
# Corn_CropYearObjectsMarch = appObjectsCornMarch[[1]]
# Corn_CropYearsMarch = appObjectsCornMarch[[2]]
# finalizedPriceObjectCornMarch = appObjectsCornMarch[[3]]
# 
# # Corn March Baselines Only
# appObjectsCornMarchBaselines = readRDS("appObjectsCornMarchBaselines.rds")
# Corn_CropYearObjectsMarchBaselines = appObjectsCornMarchBaselines[[1]]
# Corn_CropYearsMarchBaselines = appObjectsCornMarchBaselines[[2]]
# finalizedPriceObjectCornMarchBaselines = appObjectsCornMarchBaselines[[3]]
# 
# 
# # Soybean Base/__
# appObjectsSoybean = readRDS("appObjectsSoybeanBase.rds")
# Soybean_CropYearObjectsBase = appObjectsSoybean[[1]]
# Soybean_CropYearsBase = appObjectsSoybean[[2]]
# finalizedPriceObjectSoybeanBase = appObjectsSoybean[[3]]
# 
# appObjectsSoybeanV2 = readRDS("appObjectsSoybeanV2.rds")
# Soybean_CropYearObjectsV2 = appObjectsSoybeanV2[[1]]
# Soybean_CropYearsV2 = appObjectsSoybeanV2[[2]]
# finalizedPriceObjectSoybeanV2 = appObjectsSoybeanV2[[3]]
# 
# appObjectsSoybeanV3 = readRDS("appObjectsSoybeanV3.rds")
# Soybean_CropYearObjectsV3 = appObjectsSoybeanV3[[1]]
# Soybean_CropYearsV3 = appObjectsSoybeanV3[[2]]
# finalizedPriceObjectSoybeanV3 = appObjectsSoybeanV3[[3]]
# 
# appObjectsSoybeanV4 = readRDS("appObjectsSoybeanV4.rds")
# Soybean_CropYearObjectsV4 = appObjectsSoybeanV4[[1]]
# Soybean_CropYearsV4 = appObjectsSoybeanV4[[2]]
# finalizedPriceObjectSoybeanV4 = appObjectsSoybeanV4[[3]]
# 
# appObjectsSoybeanV5 = readRDS("appObjectsSoybeanV5.rds")
# Soybean_CropYearObjectsV5 = appObjectsSoybeanV5[[1]]
# Soybean_CropYearsV5 = appObjectsSoybeanV5[[2]]
# finalizedPriceObjectSoybeanV5 = appObjectsSoybeanV5[[3]]
# 
# appObjectsSoybeanV6 = readRDS("appObjectsSoybeanV6.rds")
# Soybean_CropYearObjectsV6 = appObjectsSoybeanV6[[1]]
# Soybean_CropYearsV6 = appObjectsSoybeanV6[[2]]
# finalizedPriceObjectSoybeanV6 = appObjectsSoybeanV6[[3]]
# 
# appObjectsSoybeanHarvestTime = readRDS("appObjectsSoybeanHarvestTime.rds")
# Soybean_CropYearObjectsHarvestTime = appObjectsSoybeanHarvestTime[[1]]
# Soybean_CropYearsHarvestTime = appObjectsSoybeanHarvestTime[[2]]
# finalizedPriceObjectSoybeanHarvestTime = appObjectsSoybeanHarvestTime[[3]]
# 
# appObjectsSoybean404020 = readRDS("appObjectsSoybean404020.rds")
# Soybean_CropYearObjects404020 = appObjectsSoybean404020[[1]]
# Soybean_CropYears404020 = appObjectsSoybean404020[[2]]
# finalizedPriceObjectSoybean404020 = appObjectsSoybean404020[[3]]
# 
# # Soybean V3/__
# appObjectsSoybeanV3Base = readRDS("appObjectsSoybeanV3Base.rds")
# Soybean_CropYearObjectsV3Base = appObjectsSoybeanV3Base[[1]]
# Soybean_CropYearsV3Base = appObjectsSoybeanV3Base[[2]]
# finalizedPriceObjectSoybeanV3Base = appObjectsSoybeanV3Base[[3]]
# 
# appObjectsSoybeanV3V2 = readRDS("appObjectsSoybeanV3V2.rds")
# Soybean_CropYearObjectsV3V2 = appObjectsSoybeanV3V2[[1]]
# Soybean_CropYearsV3V2 = appObjectsSoybeanV3V2[[2]]
# finalizedPriceObjectSoybeanV3V2 = appObjectsSoybeanV3V2[[3]]
# 
# appObjectsSoybeanV3V3 = readRDS("appObjectsSoybeanV3V3.rds")
# Soybean_CropYearObjectsV3V3 = appObjectsSoybeanV3V3[[1]]
# Soybean_CropYearsV3V3 = appObjectsSoybeanV3V3[[2]]
# finalizedPriceObjectSoybeanV3V3 = appObjectsSoybeanV3V3[[3]]
# 
# appObjectsSoybeanV3V4 = readRDS("appObjectsSoybeanV3V4.rds")
# Soybean_CropYearObjectsV3V4 = appObjectsSoybeanV3V4[[1]]
# Soybean_CropYearsV3V4 = appObjectsSoybeanV3V4[[2]]
# finalizedPriceObjectSoybeanV3V4 = appObjectsSoybeanV3V4[[3]]
# 
# appObjectsSoybeanV3V5 = readRDS("appObjectsSoybeanV3V5.rds")
# Soybean_CropYearObjectsV3V5 = appObjectsSoybeanV3V5[[1]]
# Soybean_CropYearsV3V5 = appObjectsSoybeanV3V5[[2]]
# finalizedPriceObjectSoybeanV3V5 = appObjectsSoybeanV3V5[[3]]
# 
# appObjectsSoybeanV3V6 = readRDS("appObjectsSoybeanV3V6.rds")
# Soybean_CropYearObjectsV3V6 = appObjectsSoybeanV3V6[[1]]
# Soybean_CropYearsV3V6 = appObjectsSoybeanV3V6[[2]]
# finalizedPriceObjectSoybeanV3V6 = appObjectsSoybeanV3V6[[3]]
# 
# # Soybean March NC
# appObjectsSoybeanMarch = readRDS("appObjectsSoybeanMarch.rds")
# Soybean_CropYearObjectsMarch = appObjectsSoybeanMarch[[1]]
# Soybean_CropYearsMarch = appObjectsSoybeanMarch[[2]]
# finalizedPriceObjectSoybeanMarch = appObjectsSoybeanMarch[[3]]
# 
# # Soybean March Baselines Only
# appObjectsSoybeanMarchBaselines = readRDS("appObjectsSoybeanMarchBaselines.rds")
# Soybean_CropYearObjectsMarchBaselines = appObjectsSoybeanMarchBaselines[[1]]
# Soybean_CropYearsMarchBaselines = appObjectsSoybeanMarchBaselines[[2]]
# finalizedPriceObjectSoybeanMarchBaselines = appObjectsSoybeanMarchBaselines[[3]]


# Create strategy results tables
priceObjectListCorn = list(finalizedPriceObjectCornBase,
                           finalizedPriceObjectCornV2,
                           finalizedPriceObjectCornV3,
                           finalizedPriceObjectCornV4,
                           finalizedPriceObjectCornV5,
                           finalizedPriceObjectCornV6,
                           finalizedPriceObjectCornV3Base,
                           finalizedPriceObjectCornV3V2,
                           finalizedPriceObjectCornV3V3,
                           finalizedPriceObjectCornV3V4,
                           finalizedPriceObjectCornV3V5,
                           finalizedPriceObjectCornV3V6,
                           finalizedPriceObjectCornMarch,
                           finalizedPriceObjectCornMarchBaselines,
                           finalizedPriceObjectCornHarvestTime,
                           finalizedPriceObjectCorn404020)

priceObjectListSoybean = list(finalizedPriceObjectSoybeanBase,
                              finalizedPriceObjectSoybeanV2,
                              finalizedPriceObjectSoybeanV3,
                              finalizedPriceObjectSoybeanV4,
                              finalizedPriceObjectSoybeanV5,
                              finalizedPriceObjectSoybeanV6,
                              finalizedPriceObjectSoybeanV3Base,
                              finalizedPriceObjectSoybeanV3V2,
                              finalizedPriceObjectSoybeanV3V3,
                              finalizedPriceObjectSoybeanV3V4,
                              finalizedPriceObjectSoybeanV3V5,
                              finalizedPriceObjectSoybeanV3V6,
                              finalizedPriceObjectSoybeanMarch,
                              finalizedPriceObjectSoybeanMarchBaselines,
                              finalizedPriceObjectSoybeanHarvestTime,
                              finalizedPriceObjectSoybean404020)


# These could be different for corn and soybean if we have different strategies
versions = c("Base",
             "V2",
             "V3",
             "V4",
             "V5",
             "V6",
             "V3Base",
             "V3V2",
             "V3V3",
             "V3V4",
             "V3V5",
             "V3V6",
             "March",
             "MarchBaselines",
             "HarvestTime",
             "404020")

MYversions = c("Multiyear",
               "MYV2",
               "MYV3",
               "MYV4",
               "MYV5",
               "MYV6",
               "MYV3Base",
               "MYV3V2",
               "MYV3V3",
               "MYV3V4",
               "MYV3V5",
               "MYV3V6",
               "MYMarch",
               "MYMarchBaselines",
               "MYHarvestTime",
               "MY404020")

POversions = c("Base",
               "Multiyear",
               "V2",
               "MYV2",
               "V3",
               "MYV3",
               "V4",
               "MYV4",
               "V5",
               "MYV5",
               "V6",
               "MYV6",
               "March",
               "MYMarch",
               "MarchBaselines",
               "MYMarchBaselines")

TSversions = c("Base",
               "Multiyear",
               "V2",
               "MYV2",
               "V3",
               "MYV3",
               "V4",
               "MYV4",
               "V5",
               "MYV5",
               "V6",
               "MYV6",
               "V3Base",
               "MYV3Base",
               "V3V2",
               "MYV3V2",
               "V3V3",
               "MYV3V3",
               "V3V4",
               "MYV3V4",
               "V3V5",
               "MYV3V5",
               "V3V6",
               "MYV3V6",
               "March",
               "MYMarch",
               "MarchBaselines",
               "MYMarchBaselines")

SSversions = c("Base",
               "Multiyear",
               "March",
               "MYMarch",
               "MarchBaselines",
               "MYMarchBaselines",
               "HarvestTime",
               "MYHarvestTime",
               "404020",
               "MY404020")

# Initialize objects
nonMultiYearCorn = data.frame()
multiYearCorn = data.frame()
nonMultiYearSoybean = data.frame()
multiYearSoybean = data.frame()

# Function to create the "Strategy Results" tab tables
getResults = function(strategy, resultsTable, resultsTableMY, strategyName, MY) {
  if (MY == FALSE) {
    if (nrow(resultsTable) == 0) {
      resultsTable = data.frame(matrix(nrow = 0, ncol = 7))
      colnames(resultsTable) = c("Strategy", "Version", "RawAveragePrice", "PreHarvestAverage", "PostHarvestAverage", 
                                 "StorageAdjustedAverage", "StorageAdjustedPostHarvestAverage")
    }
    
    if (strategyName %in% TSversions) {
      TS = which(names(strategy) == "TSResultsTable")
      TSRow = cbind("Trailing Stop", 
                    strategyName,
                    strategy[[TS]][1, 2],
                    strategy[[TS]][2, 2],
                    strategy[[TS]][3, 2],
                    strategy[[TS]][1, 3],
                    strategy[[TS]][3, 3])
      
      
      colnames(TSRow) = c("Strategy", "Version", "RawAveragePrice", "PreHarvestAverage", "PostHarvestAverage", 
                          "StorageAdjustedAverage", "StorageAdjustedPostHarvestAverage")
    } else {
      TSRow = NULL
    }
    
    if (strategyName %in% POversions) {
      PO = which(names(strategy) == "POResultsTable")
      PORow = cbind("Price Objective", 
                    strategyName,
                    strategy[[PO]][1, 2],
                    strategy[[PO]][2, 2],
                    strategy[[PO]][3, 2],
                    strategy[[PO]][1, 3],
                    strategy[[PO]][3, 3])
      
      colnames(PORow) = c("Strategy", "Version", "RawAveragePrice", "PreHarvestAverage", "PostHarvestAverage", 
                          "StorageAdjustedAverage", "StorageAdjustedPostHarvestAverage")
    } else {
      PORow = NULL
    }
    
    if (strategyName %in% SSversions) {
      SS = which(names(strategy) == "SSResultsTable")
      
      SSRow = cbind("Seasonal Sales", 
                    strategyName,
                    strategy[[SS]][1, 2],
                    strategy[[SS]][2, 2],
                    strategy[[SS]][3, 2],
                    strategy[[SS]][1, 3],
                    strategy[[SS]][3, 3])
      
      colnames(SSRow) = c("Strategy", "Version", "RawAveragePrice", "PreHarvestAverage", "PostHarvestAverage", 
                          "StorageAdjustedAverage", "StorageAdjustedPostHarvestAverage")
    } else {
      SSRow = NULL
    }
    
    resultsTable = rbind(resultsTable, PORow, TSRow, SSRow)
    resultsTable = resultsTable[order(resultsTable$Strategy), ]
    return(resultsTable)
  }
  
  if (MY == TRUE) {
    if (nrow(resultsTableMY) == 0) {
      resultsTableMY = data.frame(matrix(nrow = 0, ncol = 7))
      colnames(resultsTableMY) = c("Strategy", "Version", "RawAveragePrice", "PreHarvestAverage", "PostHarvestAverage", 
                                   "StorageAdjustedAverage", "StorageAdjustedPostHarvestAverage")
    }
    
    if (strategyName %in% TSversions) {
      TSMY = which(names(strategy) == "TSResultsTableMY")
      TSMYRow = cbind("Trailing Stop", 
                      strategyName,
                      strategy[[TSMY]][1, 2],
                      strategy[[TSMY]][2, 2],
                      strategy[[TSMY]][3, 2],
                      strategy[[TSMY]][1, 3],
                      strategy[[TSMY]][3, 3])
      
      colnames(TSMYRow) = c("Strategy", "Version", "RawAveragePrice", "PreHarvestAverage", "PostHarvestAverage", 
                            "StorageAdjustedAverage", "StorageAdjustedPostHarvestAverage")
    } else {
      TSMYRow = NULL
    }
    
    if (strategyName %in% POversions) {
      POMY = which(names(strategy) == "POResultsTableMY")
      POMYRow = cbind("Price Objective", 
                      strategyName,
                      strategy[[POMY]][1, 2],
                      strategy[[POMY]][2, 2],
                      strategy[[POMY]][3, 2],
                      strategy[[POMY]][1, 3],
                      strategy[[POMY]][3, 3])
      colnames(POMYRow) = c("Strategy", "Version", "RawAveragePrice", "PreHarvestAverage", "PostHarvestAverage", 
                            "StorageAdjustedAverage", "StorageAdjustedPostHarvestAverage")
    } else {
      POMYRow = NULL
    }
    
    if (strategyName %in% SSversions) {
      SSMY = which(names(strategy) == "SSResultsTableMY")
      
      SSMYRow = cbind("Seasonal Sales", 
                      strategyName,
                      strategy[[SSMY]][1, 2],
                      strategy[[SSMY]][2, 2],
                      strategy[[SSMY]][3, 2],
                      strategy[[SSMY]][1, 3],
                      strategy[[SSMY]][3, 3])
      
      colnames(SSMYRow) = c("Strategy", "Version", "RawAveragePrice", "PreHarvestAverage", "PostHarvestAverage", 
                            "StorageAdjustedAverage", "StorageAdjustedPostHarvestAverage")
    } else {
      SSMYRow = NULL
    }
    
    resultsTableMY = rbind(resultsTableMY, POMYRow, TSMYRow, SSMYRow)
    resultsTableMY = resultsTableMY[order(resultsTableMY$Strategy), ]
    return(resultsTableMY)
  }
}

# Load the tables for later use. Strategy Results
for(i in 1:length(priceObjectListCorn)) {
  nonMultiYearCorn = data.frame(getResults(priceObjectListCorn[[i]], nonMultiYearCorn, multiYearCorn, versions[i], FALSE))
  multiYearCorn = data.frame(getResults(priceObjectListCorn[[i]], nonMultiYearCorn, multiYearCorn, MYversions[i], TRUE))
}

for(i in 1:length(priceObjectListSoybean)) {
  nonMultiYearSoybean = data.frame(getResults(priceObjectListSoybean[[i]], nonMultiYearSoybean, multiYearSoybean, versions[i], FALSE))
  multiYearSoybean = data.frame(getResults(priceObjectListSoybean[[i]], nonMultiYearSoybean, multiYearSoybean, MYversions[i], TRUE))
}

# Gets a results table for all crop years in a single strategy
yearlyResultsByStrategy = function(finalizedPriceList, strategyName) {
  
  resultsTable = data.frame(matrix(nrow = 0, ncol = 6))
  
  resultsList = which(names(finalizedPriceList) == strategyName)
  
  strategyList = finalizedPriceList[[resultsList]]
  
  year = which(colnames(strategyList) == "Crop Year")
  rawAveragePrice = which(colnames(strategyList) == "noStorageAvg")
  preHarvestAverage = which(colnames(strategyList) == "preharvestAverage")
  postHarvestAverage = which(colnames(strategyList) == "postharvestAverage")
  storageAdjustedAverage = which(colnames(strategyList) == "storageAdjAvg")
  storageAdjustedPostHarvestAverage = which(colnames(strategyList) == "postharvestAverageStorage")
  
  resultsTable = data.frame(cbind(strategyList[, year],
                                  strategyList[, rawAveragePrice],
                                  strategyList[, preHarvestAverage],
                                  strategyList[, postHarvestAverage],
                                  strategyList[, storageAdjustedAverage],
                                  strategyList[, storageAdjustedPostHarvestAverage]))
  
  colnames(resultsTable) = c("Year", "RawAveragePrice", "PreHarvestAverage", "PostHarvestAverage", 
                             "StorageAdjustedAverage", "StorageAdjustedPostHarvestAverage")
  
  return(resultsTable)
}


# Formats a results table for all crop years in a single strategy
getYearlyResultsTable = function(data, cropType) {
  data[,2:6] = lapply(data[2:6], function(x) as.numeric(as.character(x)))
  rownames(data) <- c()
  data = cbind("Crop Year" = data[,1], round(data[, 2:6], digits = 2))
  if (cropType == "corn") {
    tableCaption = tags$caption("USDA Average: $4.59", style = "color:#000000; font-weight:bold; font-size:100%; text-align:center;")
  }
  if (cropType == "soybean") {
    tableCaption = tags$caption("USDA Average: $10.90", style = "color:#000000; font-weight:bold; font-size:100%; text-align:center;")
  }
  table = as.datatable(formattable(data, 
                                   align = "c",
                                   list(~ formatter("span",
                                                    style = x ~ style(display = "block",
                                                                      "border-radius" = "0px",
                                                                      "padding" = "0px",
                                                                      "text-align" = "center")),
                                        `Strategy` = formatter("span", style = x ~ style(font.weight = "bold")),
                                        `Version` = formatter("span", style = x ~ style(font.weight = "bold")))),
                       rownames = FALSE, 
                       caption = tableCaption, 
                       options = list(dom = 't', pageLength = 30))
  return(table)
}


# Load in values for dynamic drop down menus. These can be different for corn and soybeans
POCorn = c("Base" = "base",
           "Multi-Year" = "multiyear",
           "Version 2" = "V2",
           "Multi-Year Version 2" = "MYV2",
           "Version 3" = "V3",
           "Multi-Year Version 3" = "MYV3",
           "Version 4" = "V4",
           "Multi-Year Version 4"="MYV4",
           "Version 5" = "V5",
           "Multi-Year Version 5"="MYV5",
           "Version 6" = "V6",
           "Multi-Year Version 6"="MYV6",
           "March" = "March",
           "Multi-Year March" = "MYMarch",
           "March Baselines" = "MarchBaselines",
           "Multi-Year March Baselines" = "MYMarchBaselines")

POSoybean = c("Base" = "base",
              "Multi-Year" = "multiyear",
              "Version 2" = "V2",
              "Multi-Year Version 2" = "MYV2",
              "Version 3" = "V3",
              "Multi-Year Version 3" = "MYV3",
              "Version 4" = "V4",
              "Multi-Year Version 4"="MYV4",
              "Version 5" = "V5",
              "Multi-Year Version 5"="MYV5",
              "Version 6" = "V6",
              "Multi-Year Version 6"="MYV6",
              "March" = "March",
              "Multi-Year March" = "MYMarch",
              "March Baselines" = "MarchBaselines",
              "Multi-Year March Baselines" = "MYMarchBaselines")

TSCorn = c("Base" = "base",
           "Multi-Year" = "multiyear",
           "Version 2" = "V2",
           "Multi-Year Version 2" = "MYV2",
           "Version 3" = "V3",
           "Multi-Year Version 3" = "MYV3",
           "Version 4" = "V4",
           "Multi-Year Version 4" = "MYV4",
           "Version 5" = "V5",
           "Multi-Year Version 5" = "MYV5",
           "Version 6" = "V6",
           "Multi-Year Version 6" = "MYV6",
           "Version 3/Base" = "V3Base",
           "Multi-Year Version 3/Base" = "MYV3Base",
           "Version 3/V2" = "V3V2",
           "Multi-Year Version 3/V2" = "MYV3V2",
           "Version 3/V3" = "V3V3",
           "Multi-Year Version 3/V3" = "MYV3V3",
           "Version 3/V4" = "V3V4",
           "Multi-Year Version 3/V4" = "MYV3V4",
           "Version 3/V5" = "V3V5",
           "Multi-Year Version 3/V5" = "MYV3V5",
           "Version 3/V6" = "V3V6",
           "Multi-Year Version 3/V6" = "MYV3V6",
           "March" = "March",
           "Multi-Year March" = "MYMarch",
           "March Baselines" = "MarchBaselines",
           "Multi-Year March Baselines" = "MYMarchBaselines")

TSSoybean = c("Base" = "base",
              "Multi-Year" = "multiyear",
              "Version 2" = "V2",
              "Multi-Year Version 2" = "MYV2",
              "Version 3" = "V3",
              "Multi-Year Version 3" = "MYV3",
              "Version 4" = "V4",
              "Multi-Year Version 4" = "MYV4",
              "Version 5" = "V5",
              "Multi-Year Version 5" = "MYV5",
              "Version 6" = "V6",
              "Multi-Year Version 6" = "MYV6",
              "Version 3/Base" = "V3Base",
              "Multi-Year Version 3/Base" = "MYV3Base",
              "Version 3/V2" = "V3V2",
              "Multi-Year Version 3/V2" = "MYV3V2",
              "Version 3/V3" = "V3V3",
              "Multi-Year Version 3/V3" = "MYV3V3",
              "Version 3/V4" = "V3V4",
              "Multi-Year Version 3/V4" = "MYV3V4",
              "Version 3/V5" = "V3V5",
              "Multi-Year Version 3/V5" = "MYV3V5",
              "Version 3/V6" = "V3V6",
              "Multi-Year Version 3/V6" = "MYV3V6",
              "March" = "March",
              "Multi-Year March" = "MYMarch",
              "March Baselines" = "MarchBaselines",
              "Multi-Year March Baselines" = "MYMarchBaselines")

SSCorn = c("Base" = "base",
           "Multi-Year" = "multiyear",
           "March" = "March",
           "Multi-Year March" = "MYMarch",
           "March Baselines" = "MarchBaselines",
           "Multi-Year March Baselines" = "MYMarchBaselines",
           "Harvest Time Sales" = "HarvestTime",
           "Multi-Year Harvest Time Sales" = "MYHarvestTime",
           "Oct/Jan/Aug Sales" = "404020",
           "Multi-Year Oct/Jan/Aug Sales" = "MY404020")

SSSoybean = c("Base" = "base",
              "Multi-Year" = "multiyear",
              "March" = "March",
              "Multi-Year March" = "MYMarch",
              "March Baselines" = "MarchBaselines",
              "Multi-Year March Baselines" = "MYMarchBaselines",
              "Harvest Time Sales" = "HarvestTime",
              "Multi-Year Harvest Time Sales" = "MYHarvestTime",
              "Oct/Jan/Aug Sales" = "404020",
              "Multi-Year Oct/Jan/Aug Sales" = "MY404020")

POVersions = list("Corn" = POCorn, "Soybeans" = POSoybean)
TSVersions = list("Corn" = TSCorn, "Soybeans" = TSSoybean)
SSVersions = list("Corn" = SSCorn, "Soybeans" = SSSoybean)

cropYearMenuChoices <-  Corn_CropYearsBase$CropYear
names(cropYearMenuChoices) <- cropYearMenuChoices

typeList <- c("Corn", "Soybeans")
names(typeList) = typeList

# Storage Summary Table creation and formatting
getTables = function(data) {
  data = cbind(" " = data[,1], round(data[, 2:3], digits = 2))
  table = as.datatable(formattable(data, 
                                   align = "c",
                                   list(~ formatter("span",
                                                    style = x ~ style(display = "block",
                                                                      "border-radius" = "2px",
                                                                      "padding" = "5px",
                                                                      "text-align" = "center")),
                                        `Total Avg Price` = formatter("span",
                                                                      style = x ~ style(color = "white", background = "gray",
                                                                                        padding.left = "10px",
                                                                                        padding.right = "10px",
                                                                                        border.radius = "5px")),
                                        `Pre-Harvest Avg Price` = formatter("span",
                                                                            style = x ~ style(color = "white", background = "blue",
                                                                                              padding.left = "10px",
                                                                                              padding.right = "10px",
                                                                                              border.radius = "5px")),
                                        `Post-Harvest Avg Price` = formatter("span",
                                                                             style = x ~ style(color = "white", background = "green",
                                                                                               padding.left = "10px",
                                                                                               padding.right = "10px",
                                                                                               border.radius = "5px")),
                                        ` ` = formatter("span", style = ~ style(display = "block",
                                                                                "border-radius" = "2px",
                                                                                "padding" = "5px",
                                                                                "font.weight" = "bold",  
                                                                                "text-align" = "left")))),
                       rownames = FALSE, 
                       caption = tags$caption("Storage Summary", 
                                              style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), 
                       options = list(dom = 't'))
  return(table)
}

# Sales Summary Table creation and formatting
getSalesTable = function(data) {
  if (!is.null(data)) {
    table = as.datatable(formattable(data, 
                                     align = "c",
                                     list(~ formatter("span",
                                                      style = x ~ style(display = "block",
                                                                        "border-radius" = "2px",
                                                                        "padding" = "5px",
                                                                        "text-align" = "center")),
                                          `Date` = formatter("span", style = ~ style(display = "block",
                                                                                     "border-radius" = "2px",
                                                                                     "padding" = "5px",
                                                                                     "font.weight" = "bold",  
                                                                                     "text-align" = "left")))), 
                         rownames = FALSE, 
                         caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), 
                         options = list(dom = 't'))
  } else {
    data = data.frame("NO SALES ACTUALIZED" = "NO SALES ACTUALIZED")
    table = as.datatable(formattable(data, 
                                     align = "c",
                                     list(~ formatter("span",
                                                      style = x ~ style(display = "block",
                                                                        "border-radius" = "2px",
                                                                        "padding" = "5px",
                                                                        "font-size:200%",
                                                                        "font.weight" = "bold", 
                                                                        "text-align" = "center")),
                                          ` ` = formatter("span", style = ~ style(display = "block",
                                                                                  "border-radius" = "2px",
                                                                                  "padding" = "5px",
                                                                                  "font-size:00%",
                                                                                  "font.weight" = "bold",  
                                                                                  "text-align" = "center")))), 
                         rownames = FALSE, 
                         caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), 
                         options = list(dom = 't'),
                         colnames = c(" "))
  }
  return(table)
}

getFullResultsTable = function(data) {
  colnames(data) = c("Strategy", "Version", "Raw Average Price", "Pre-Harvest Average", "Post-Harvest Average", 
                     "Storage-Adjusted Average", "Storage-Adjusted Post-Harvest Average")
  data[,3:7] = lapply(data[3:7], function(x) as.numeric(as.character(x)))
  rownames(data) <- c()
  data = cbind(data[,1:2], round(data[, 3:7], digits = 2))
  table = formattable(data, 
                      align = "c",
                      list(~ formatter("span",
                                       style = x ~ style(display = "block",
                                                         "border-radius" = "0px",
                                                         "padding" = "0px",
                                                         "text-align" = "center")),
                           `Strategy` = formatter("span", style = x ~ style(font.weight = "bold")),
                           `Version` = formatter("span", style = x ~ style(font.weight = "bold"))))
  return(table)
}

ui <- shinyUI(
  navbarPage("Marketing Strategies",
             tabPanel("Home",
                      fluidPage(
                        fluidRow(column(12, includeHTML(homePageHTML),
                                        # fluidRow(column(12, includeHTML("homePage.html"),
                                        selectInput("cropType", "", typeList, width = "33%")
                        )
                        )
                        
                        # Code for slider
                        # fluidRow(column(12,
                        #                 sliderInput("availableFarmStorage", "On-Farm Storage Capacity:", min = 1, max = 11, value = 6, step = 1,
                        #                             label = " 0---------------------------------------------------------100")
                        # ))
                      )
             ),
             tabPanel("Price Objective",
                      fluidPage(
                        selectInput(inputId = "POstrategy", label = "Select Price Objective Strategy", choices = NULL),
                        conditionalPanel(
                          condition = "input.POstrategy == 'base'",   
                          fluidPage(
                            fluidRow(
                              plotOutput('POsalesPlot'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#POsummaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPO','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POstorageTables')),
                                         tags$style(type="text/css", '#sPOtorageTables tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POyearTable'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.POstrategy == 'multiyear'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POMYdistPlot'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#POMYsummaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOMY','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTables')),
                                         tags$style(type="text/css", '#POMYstorageTables tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POMYyearTable'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 2
                        conditionalPanel(
                          condition = "input.POstrategy == 'V2'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POdistPlotV2'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#POsummaryTablesV2 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOV2','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesV2')),
                                         tags$style(type="text/css", '#POstorageTablesV2 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesV2'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POyearTableV2'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.POstrategy == 'MYV2'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POMYdistPlotV2'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#POMYsummaryTablesV2 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOMYV2','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesV2')),
                                         tags$style(type="text/css", '#POMYstorageTablesV2 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesV2'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POMYyearTableV2'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 3
                        conditionalPanel(
                          condition = "input.POstrategy == 'V3'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POdistPlotV3'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOV3','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesV3')),
                                         tags$style(type="text/css", '#POstorageTablesV3 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesV3'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POyearTableV3'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.POstrategy == 'MYV3'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POMYdistPlotV3'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#POMYsummaryTablesV3 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOMYV3','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesV3')),
                                         tags$style(type="text/css", '#POMYstorageTablesV3 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesV3'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POMYyearTableV3'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 4
                        conditionalPanel(
                          condition = "input.POstrategy == 'V4'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POdistPlotV4'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOV4','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesV4')),
                                         tags$style(type="text/css", '#POstorageTablesV4 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesV4'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POyearTableV4'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.POstrategy == 'MYV4'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POMYdistPlotV4'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#POMYsummaryTablesV4 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOMYV4','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesV4')),
                                         tags$style(type="text/css", '#POMYstorageTablesV4 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesV4'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POMYyearTableV4'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 5
                        conditionalPanel(
                          condition = "input.POstrategy == 'V5'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POdistPlotV5'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOV5','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesV5')),
                                         tags$style(type="text/css", '#POstorageTablesV5 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesV5'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POyearTableV5'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.POstrategy == 'MYV5'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POMYdistPlotV5'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#POMYsummaryTablesV5 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOMYV5','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesV5')),
                                         tags$style(type="text/css", '#POMYstorageTablesV5 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesV5'),
                                  style = "padding-bottom:100px")
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POMYyearTableV5'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 6
                        conditionalPanel(
                          condition = "input.POstrategy == 'V6'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POdistPlotV6'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOV6','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesV6')),
                                         tags$style(type="text/css", '#POstorageTablesV6 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesV6'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POyearTableV6'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.POstrategy == 'MYV6'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POMYdistPlotV6'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#POMYsummaryTablesV6 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOMYV6','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesV6')),
                                         tags$style(type="text/css", '#POMYstorageTablesV6 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesV6'),
                                  style = "padding-bottom:100px")
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POMYyearTableV6'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION March
                        conditionalPanel(
                          condition = "input.POstrategy == 'March'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POdistPlotMarch'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOMarch','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesMarch')),
                                         tags$style(type="text/css", '#POstorageTablesMarch tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesMarch'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POyearTableMarch'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.POstrategy == 'MYMarch'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POMYdistPlotMarch'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#POMYsummaryTablesMarch tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOMYMarch','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesMarch')),
                                         tags$style(type="text/css", '#POMYstorageTablesMarch tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesMarch'),
                                  style = "padding-bottom:100px")
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POMYyearTableMarch'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION March Baselines Only
                        conditionalPanel(
                          condition = "input.POstrategy == 'MarchBaselines'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POdistPlotMarchBaselines'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOMarchBaselines','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesMarchBaselines')),
                                         tags$style(type="text/css", '#POstorageTablesMarchBaselines tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesMarchBaselines'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POyearTableMarchBaselines'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.POstrategy == 'MYMarchBaselines'",
                          fluidPage(
                            fluidRow(
                              plotOutput('POMYdistPlotMarchBaselines'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#POMYsummaryTablesMarchBaselines tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPOMYMarchBaselines','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesMarchBaselines')),
                                         tags$style(type="text/css", '#POMYstorageTablesMarchBaselines tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesMarchBaselines'),
                                  style = "padding-bottom:100px")
                              )
                            ),
                            fluidRow(
                              dataTableOutput('POMYyearTableMarchBaselines'),
                              style = "padding-bottom:50px"
                            )
                          )
                        )
                      )
             ),
             tabPanel("Trailing Stop",
                      fluidPage(
                        selectInput(inputId = "TSstrategy", label = "Select Trailing Stop Strategy", choices = NULL),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'base'",         
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlot'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTS','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTables')),
                                         tags$style(type="text/css", '#TSstorageTables tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTable'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'multiyear'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlot'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMY','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTables')),
                                         tags$style(type="text/css", '#TSMYstorageTables tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTable'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 2
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V2'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV2'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV2','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV2')),
                                         tags$style(type="text/css", '#TSstorageTablesV2 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV2'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV2'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV2'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV2'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV2 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV2','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV2')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV2 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV2'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV2'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 3
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V3'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV3'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV3','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3')),
                                         tags$style(type="text/css", '#TSstorageTablesV3 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV3'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV3'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV3'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV3 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV3','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV3'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION V4
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V4'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV4'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV4','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV4')),
                                         tags$style(type="text/css", '#TSstorageTablesV4 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV4'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV4'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV4'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV4'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV4 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV4','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV4')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV4 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV4'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV4'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION V5
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V5'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV5'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV5','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV5')),
                                         tags$style(type="text/css", '#TSstorageTablesV5 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV5'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV5'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV5'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV5'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV5 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV5','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV5')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV5 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV5'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV5'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION V6
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V6'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV6'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV6','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV6')),
                                         tags$style(type="text/css", '#TSstorageTablesV6 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV6'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV6'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV6'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV6'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV6 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV6','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV6')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV6 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV6'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV6'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION V3/Base
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V3Base'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV3Base'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV3Base','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3Base')),
                                         tags$style(type="text/css", '#TSstorageTablesV3Base tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3Base'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV3Base'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV3Base'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV3Base'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV3Base tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV3Base','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3Base')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3Base tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3Base'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV3Base'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 3/V2
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V3V2'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV3V2'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV3V2','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3V2')),
                                         tags$style(type="text/css", '#TSstorageTablesV3V2 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3V2'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV3V2'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV3V2'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV3V2'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV3V2 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV3V2','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3V2')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3V2 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3V2'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV3V2'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 3/V3
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V3V3'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV3V3'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV3V3','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3V3')),
                                         tags$style(type="text/css", '#TSstorageTablesV3V3 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3V3'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV3V3'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV3V3'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV3V3'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV3V3 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV3V3','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3V3')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3V3 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3V3'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV3V3'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 3/V4
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V3V4'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV3V4'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV3V4','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3V4')),
                                         tags$style(type="text/css", '#TSstorageTablesV3V4 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3V4'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV3V4'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV3V4'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV3V4'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV3V4 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV3V4','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3V4')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3V4 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3V4'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV3V4'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 3/V5
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V3V5'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV3V5'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV3V5','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3V5')),
                                         tags$style(type="text/css", '#TSstorageTablesV3V5 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3V5'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV3V5'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV3V5'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV3V5'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV3V5 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV3V5','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3V5')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3V5 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3V5'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV3V5'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION 3/V6
                        conditionalPanel(
                          condition = "input.TSstrategy == 'V3V6'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotV3V6'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSV3V6','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3V6')),
                                         tags$style(type="text/css", '#TSstorageTablesV3V6 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3V6'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableV3V6'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYV3V6'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotV3V6'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesV3V6 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYV3V6','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3V6')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3V6 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3V6'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableV3V6'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION March
                        conditionalPanel(
                          condition = "input.TSstrategy == 'March'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotMarch'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMarch','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesMarch')),
                                         tags$style(type="text/css", '#TSstorageTablesMarch tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesMarch'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableMarch'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYMarch'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotMarch'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesMarch tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYMarch','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesMarch')),
                                         tags$style(type="text/css", '#TSMYstorageTablesMarch tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesMarch'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableMarch'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        # MODEL VERSION March Baselines Only
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MarchBaselines'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSdistPlotMarchBaselines'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMarchBaselines','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesMarchBaselines')),
                                         tags$style(type="text/css", '#TSstorageTablesMarchBaselines tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesMarchBaselines'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSyearTableMarchBaselines'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.TSstrategy == 'MYMarchBaselines'",
                          fluidPage(
                            fluidRow(
                              plotOutput('TSMYdistPlotMarchBaselines'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTablesMarchBaselines tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearTSMYMarchBaselines','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesMarchBaselines')),
                                         tags$style(type="text/css", '#TSMYstorageTablesMarchBaselines tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesMarchBaselines'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('TSMYyearTableMarchBaselines'),
                              style = "padding-bottom:50px"
                            )
                          )
                        )
                      )
             ),
             tabPanel("Seasonal Sales",
                      fluidPage(
                        selectInput(inputId = "SSstrategy", label = "Select Seasonal Sales Strategy", choices = NULL),
                        conditionalPanel(
                          condition = "input.SSstrategy == 'base'",         
                          fluidPage(
                            fluidRow(
                              plotOutput('SSdistPlot'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearSS','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('SSstorageTables')),
                                         tags$style(type="text/css", '#SSstorageTables tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('SSyearTable'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.SSstrategy == 'multiyear'",
                          fluidPage(
                            fluidRow(
                              plotOutput('SSMYdistPlot'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#TSMYsummaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearSSMY','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('SSMYstorageTables')),
                                         tags$style(type="text/css", '#SSMYstorageTables tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSMYsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('SSMYyearTable'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        
                        # MODEL VERSION March NC
                        conditionalPanel(
                          condition = "input.SSstrategy == 'March'",
                          fluidPage(
                            fluidRow(
                              plotOutput('SSdistPlotMarch'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearSSMarch','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('SSstorageTablesMarch')),
                                         tags$style(type="text/css", '#SSstorageTablesMarch tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSsummaryTablesMarch'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('SSyearTableMarch'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.SSstrategy == 'MYMarch'",
                          fluidPage(
                            fluidRow(
                              plotOutput('SSMYdistPlotMarch'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#SSMYsummaryTablesMarch tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearSSMYMarch','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('SSMYstorageTablesMarch')),
                                         tags$style(type="text/css", '#SSMYstorageTablesMarch tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSMYsummaryTablesMarch'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('SSMYyearTableMarch'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        
                        # MODEL VERSION March Baselines Only
                        conditionalPanel(
                          condition = "input.SSstrategy == 'MarchBaselines'",
                          fluidPage(
                            fluidRow(
                              plotOutput('SSdistPlotMarchBaselines'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearSSMarchBaselines','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('SSstorageTablesMarchBaselines')),
                                         tags$style(type="text/css", '#SSstorageTablesMarchBaselines tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSsummaryTablesMarchBaselines'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('SSyearTableMarchBaselines'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.SSstrategy == 'MYMarchBaselines'",
                          fluidPage(
                            fluidRow(
                              plotOutput('SSMYdistPlotMarchBaselines'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#SSMYsummaryTablesMarchBaselines tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearSSMYMarchBaselines','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('SSMYstorageTablesMarchBaselines')),
                                         tags$style(type="text/css", '#SSMYstorageTablesMarchBaselines tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSMYsummaryTablesMarchBaselines'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('SSMYyearTableMarchBaselines'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ), 
                        # Harvest Time Sales
                        conditionalPanel(
                          condition = "input.SSstrategy == 'HarvestTime'",
                          fluidPage(
                            fluidRow(
                              plotOutput('SSdistPlotHarvestTime'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearSSHarvestTime','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('SSstorageTablesHarvestTime')),
                                         tags$style(type="text/css", '#SSstorageTablesHarvestTime tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSsummaryTablesHarvestTime'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('SSyearTableHarvestTime'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.SSstrategy == 'MYHarvestTime'",
                          fluidPage(
                            fluidRow(
                              plotOutput('SSMYdistPlotHarvestTime'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#SSMYsummaryTablesHarvestTime tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearSSMYHarvestTime','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('SSMYstorageTablesHarvestTime')),
                                         tags$style(type="text/css", '#SSMYstorageTablesHarvestTime tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSMYsummaryTablesHarvestTime'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('SSMYyearTableHarvestTime'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ), 
                        # 404020
                        conditionalPanel(
                          condition = "input.SSstrategy == '404020'",
                          fluidPage(
                            fluidRow(
                              plotOutput('SSdistPlot404020'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearSS404020','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('SSstorageTables404020')),
                                         tags$style(type="text/css", '#SSstorageTables404020 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSsummaryTables404020'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('SSyearTable404020'),
                              style = "padding-bottom:50px"
                            )
                          )
                        ),
                        conditionalPanel(
                          condition = "input.SSstrategy == 'MY404020'",
                          fluidPage(
                            fluidRow(
                              plotOutput('SSMYdistPlot404020'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#SSMYsummaryTables404020 tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearSSMY404020','Crop Year', choices = cropYearMenuChoices, width = "100%"),
                                         column(12, dataTableOutput('SSMYstorageTables404020')),
                                         tags$style(type="text/css", '#SSMYstorageTables404020 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSMYsummaryTables404020'),
                                  style = "padding-bottom:100px")
                                
                              )
                            ),
                            fluidRow(
                              dataTableOutput('SSMYyearTable404020'),
                              style = "padding-bottom:50px"
                            )
                          )
                        )
                      )
             ),
             tabPanel("Strategy Results",
                      fluidPage(
                        tags$head(
                          tags$style(
                            ".title {margin: auto; width: 400px; color:#c90e0e}"
                          )
                        ),
                        tags$head(
                          tags$style(
                            ".tables {align: center; width: 100px}"
                          )
                        ),
                        
                        fluidRow(
                          
                          column(12, align = "center",
                                 tags$div(class="title", titlePanel("Without Multi-Year Sales")),
                                 div(style = "display: inline-block;", dataTableOutput("fullResultsTable")),
                                 tags$div(class="title", titlePanel("With Multi-Year Sales")),
                                 div(style = "display: inline-block; padding-bottom: 50px", dataTableOutput("fullResultsTableMY"))
                          )
                          
                        )
                      )
             ),
             tabPanel("About Our Strategies",
                      fluidPage(
                        fluidRow(column(12, includeHTML(indexHTML)
                                        # fluidRow(column(12, includeHTML("index.html")
                        )
                        
                        )
                      )),
             tabPanel("Version Descriptions",
                      fluidPage(
                        fluidRow(column(12, includeHTML(versionsHTML)
                                        # fluidRow(column(12, includeHTML("versions.html")
                        )
                        
                        )
                      )
             )
  )
) 

server <- shinyServer(function(input,output,session) {
  
  #saves slider input for on-farm storage available
  # storagePercent <- reactive({
  #   percentStored = input$availableFarmStorage
  # })
  
  
  POchoices_versions <- reactive({
    POchoices_versions <- POVersions[[input$cropType]]
  })
  
  TSchoices_versions <- reactive({
    TSchoices_versions <- TSVersions[[input$cropType]]
  })
  
  SSchoices_versions <- reactive({
    SSchoices_versions <- SSVersions[[input$cropType]]
  })
  
  
  observe({
    updateSelectInput(session = session, inputId = "POstrategy", choices = POchoices_versions())
  })
  
  observe({
    updateSelectInput(session = session, inputId = "TSstrategy", choices = TSchoices_versions())
  })
  
  observe({
    updateSelectInput(session = session, inputId = "SSstrategy", choices = SSchoices_versions())
  })
  
  
  
  
  
  
  
  
  output$fullResultsTable = renderDataTable({
    if (input$cropType == "Corn") {
      as.datatable(getFullResultsTable(nonMultiYearCorn), rownames = FALSE, 
                   caption = tags$caption("USDA Average: $4.59", style = "color:#000000; font-weight:bold; font-size:100%; text-align:center;"), options = list(dom = 't', pageLength = 30))
    }
    else if (input$cropType == "Soybeans") {
      as.datatable(getFullResultsTable(nonMultiYearSoybean), rownames = FALSE, 
                   caption = tags$caption("USDA Average: $10.90", style = "color:#000000; font-weight:bold; font-size:100%; text-align:center;"), options = list(dom = 't', pageLength = 30))
    }
  })
  
  output$fullResultsTableMY = renderDataTable({
    if (input$cropType == "Corn") {
      as.datatable(getFullResultsTable(multiYearCorn), rownames = FALSE, 
                   caption = tags$caption("USDA Average: $4.59", style = "color:#000000; font-weight:bold; font-size:100%; text-align:center;"), options = list(dom = 't', pageLength = 30))
    }
    else if (input$cropType == "Soybeans") {
      as.datatable(getFullResultsTable(multiYearSoybean), rownames = FALSE, 
                   caption = tags$caption("USDA Average: $10.90", style = "color:#000000; font-weight:bold; font-size:100%; text-align:center;"), options = list(dom = 't', pageLength = 30))
    }
  })
  
  
  
  
  
  
  #################################################################################################
  # Price Objective
  #################################################################################################
  
  
  # type <- reactive({
  #     switch(input$cropType,
  #            "Corn" = 1,
  #            "Soybeans" = 2)
  # })
  
  yearPO <- reactive({
    switch(input$yearPO,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POsalesPlot <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsBase[[yearPO()]]$POPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsBase[[yearPO()]]$POPlot
    }
  })
  
  output$POstorageTables = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsBase[[yearPO()]]$`PO Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsBase[[yearPO()]]$`PO Storage`)
    }
  })
  
  output$POsummaryTables = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsBase[[yearPO()]]$`Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsBase[[yearPO()]]$`Sales Summary`)
    }
  })
  
  output$POyearTable = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornBase, "POfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanBase, "POfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective VERSION 2
  #################################################################################################
  
  
  yearPOV2 <- reactive({
    switch(input$yearPOV2,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POdistPlotV2 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV2[[yearPOV2()]]$POPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV2[[yearPOV2()]]$POPlot
    }
  })
  
  output$POstorageTablesV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV2[[yearPOV2()]]$`PO Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV2[[yearPOV2()]]$`PO Storage`)
    }
  })
  
  output$POsummaryTablesV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV2[[yearPOV2()]]$`Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV2[[yearPOV2()]]$`Sales Summary`)
    }
  })
  
  output$POyearTableV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV2, "POfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV2, "POfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective VERSION 3
  #################################################################################################
  
  
  yearPOV3 <- reactive({
    switch(input$yearPOV3,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POdistPlotV3 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3[[yearPOV3()]]$POPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3[[yearPOV3()]]$POPlot
    }
  })
  
  output$POstorageTablesV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3[[yearPOV3()]]$`PO Storage`)
      
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3[[yearPOV3()]]$`PO Storage`)
    }
  })
  
  output$POsummaryTablesV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3[[yearPOV3()]]$`Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3[[yearPOV3()]]$`Sales Summary`)
    }
  })
  
  output$POyearTableV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3, "POfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3, "POfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective VERSION 4
  #################################################################################################
  
  
  yearPOV4 <- reactive({
    switch(input$yearPOV4,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POdistPlotV4 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV4[[yearPOV4()]]$POPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV4[[yearPOV4()]]$POPlot
    }
  })
  
  output$POstorageTablesV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV4[[yearPOV4()]]$`PO Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV4[[yearPOV4()]]$`PO Storage`)
      
    }
  })
  
  output$POsummaryTablesV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV4[[yearPOV4()]]$`Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV4[[yearPOV4()]]$`Sales Summary`)
    }
  })
  
  output$POyearTableV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV4, "POfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV4, "POfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective VERSION 5
  #################################################################################################
  
  
  yearPOV5 <- reactive({
    switch(input$yearPOV5,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POdistPlotV5 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV5[[yearPOV5()]]$POPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV5[[yearPOV5()]]$POPlot
    }
  })
  
  output$POstorageTablesV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV5[[yearPOV5()]]$`PO Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV5[[yearPOV5()]]$`PO Storage`)
    }
  })
  
  output$POsummaryTablesV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV5[[yearPOV5()]]$`Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV5[[yearPOV5()]]$`Sales Summary`)
    }
  })
  
  output$POyearTableV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV5, "POfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV5, "POfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective VERSION 6
  #################################################################################################
  
  
  yearPOV6 <- reactive({
    switch(input$yearPOV6,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POdistPlotV6 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV6[[yearPOV6()]]$POPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV6[[yearPOV6()]]$POPlot
    }
  })
  
  output$POstorageTablesV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV6[[yearPOV6()]]$`PO Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV6[[yearPOV6()]]$`PO Storage`)
    }
  })
  
  output$POsummaryTablesV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV6[[yearPOV6()]]$`Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV6[[yearPOV6()]]$`Sales Summary`)
    }
  })
  
  output$POyearTableV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV6, "POfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV6, "POfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective VERSION March
  #################################################################################################
  
  
  yearPOMarch <- reactive({
    switch(input$yearPOMarch,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  
  output$POdistPlotMarch <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarch[[yearPOMarch()]]$POPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarch[[yearPOMarch()]]$POPlot
    }
  })
  
  output$POstorageTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarch[[yearPOMarch()]]$`PO Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarch[[yearPOMarch()]]$`PO Storage`)
    }
  })
  
  output$POsummaryTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarch[[yearPOMarch()]]$`Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarch[[yearPOMarch()]]$`Sales Summary`)
    }
  })
  
  output$POyearTableMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarch, "POfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarch, "POfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective VERSION March Baselines Only
  #################################################################################################
  
  
  yearPOMarchBaselines <- reactive({
    switch(input$yearPOMarchBaselines,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POdistPlotMarchBaselines <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarchBaselines[[yearPOMarchBaselines()]]$POPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarchBaselines[[yearPOMarchBaselines()]]$POPlot
    }
  })
  
  output$POstorageTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarchBaselines[[yearPOMarchBaselines()]]$`PO Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarchBaselines[[yearPOMarchBaselines()]]$`PO Storage`)
    }
  })
  
  output$POsummaryTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarchBaselines[[yearPOMarchBaselines()]]$`Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarchBaselines[[yearPOMarchBaselines()]]$`Sales Summary`)
    }
  })
  
  output$POyearTableMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarchBaselines, "POfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarchBaselines, "POfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop
  #################################################################################################
  
  
  yearTS <- reactive({
    switch(input$yearTS,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlot <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsBase[[yearTS()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsBase[[yearTS()]]$TSPlot
    }
  })
  
  output$TSstorageTables = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsBase[[yearTS()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsBase[[yearTS()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTables = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsBase[[yearTS()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsBase[[yearTS()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTable = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornBase, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanBase, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION 2
  #################################################################################################
  
  
  yearTSV2 <- reactive({
    switch(input$yearTSV2,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV2 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV2[[yearTSV2()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV2[[yearTSV2()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV2[[yearTSV2()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV2[[yearTSV2()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV2[[yearTSV2()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV2[[yearTSV2()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV2, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV2, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION 3
  #################################################################################################
  
  
  yearTSV3 <- reactive({
    switch(input$yearTSV3,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV3 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3[[yearTSV3()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3[[yearTSV3()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3[[yearTSV3()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3[[yearTSV3()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3[[yearTSV3()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3[[yearTSV3()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION 4
  #################################################################################################
  
  
  yearTSV4 <- reactive({
    switch(input$yearTSV4,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV4 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV4[[yearTSV4()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV4[[yearTSV4()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV4[[yearTSV4()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV4[[yearTSV4()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV4[[yearTSV4()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV4[[yearTSV4()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV4, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV4, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION 5
  #################################################################################################
  
  
  yearTSV5 <- reactive({
    switch(input$yearTSV5,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV5 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV5[[yearTSV5()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV5[[yearTSV5()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV5[[yearTSV5()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV5[[yearTSV5()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV5[[yearTSV5()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV5[[yearTSV5()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV5, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV5, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION 6
  #################################################################################################
  
  
  yearTSV6 <- reactive({
    switch(input$yearTSV6,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV6 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV6[[yearTSV6()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV6[[yearTSV6()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV6[[yearTSV6()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV6[[yearTSV6()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV6[[yearTSV6()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV6[[yearTSV6()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV6, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV6, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION 3/BASE
  #################################################################################################
  
  
  yearTSV3Base <- reactive({
    switch(input$yearTSV3Base,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV3Base <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3Base[[yearTSV3Base()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3Base[[yearTSV3Base()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3Base = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3Base[[yearTSV3Base()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3Base[[yearTSV3Base()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV3Base = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3Base[[yearTSV3Base()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3Base[[yearTSV3Base()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV3Base = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3Base, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3Base, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION 3/V2
  #################################################################################################
  
  
  yearTSV3V2 <- reactive({
    switch(input$yearTSV3V2,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV3V2 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3V2[[yearTSV3V2()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3V2[[yearTSV3V2()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3V2 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3V2[[yearTSV3V2()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3V2[[yearTSV3V2()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV3V2 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3V2[[yearTSV3V2()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3V2[[yearTSV3V2()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV3V2 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3V2, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3V2, "TSfinalizedPrices"), "soybean")
    }
  })
  
  #################################################################################################
  # Trailing Stop VERSION 3/V3
  #################################################################################################
  
  
  yearTSV3V3 <- reactive({
    switch(input$yearTSV3V3,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV3V3 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3V3[[yearTSV3V3()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3V3[[yearTSV3V3()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3V3 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3V3[[yearTSV3V3()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3V3[[yearTSV3V3()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV3V3 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3V3[[yearTSV3V3()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3V3[[yearTSV3V3()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV3V3 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3V3, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3V3, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION 3/V4
  #################################################################################################
  
  
  yearTSV3V4 <- reactive({
    switch(input$yearTSV3V4,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV3V4 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3V4[[yearTSV3V4()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3V4[[yearTSV3V4()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3V4 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3V4[[yearTSV3V4()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3V4[[yearTSV3V4()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV3V4 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3V4[[yearTSV3V4()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3V4[[yearTSV3V4()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV3V4 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3V4, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3V4, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION 3/V5
  #################################################################################################
  
  
  yearTSV3V5 <- reactive({
    switch(input$yearTSV3V5,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV3V5 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3V5[[yearTSV3V5()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3V5[[yearTSV3V5()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3V5 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3V5[[yearTSV3V5()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3V5[[yearTSV3V5()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV3V5 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3V5[[yearTSV3V5()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3V5[[yearTSV3V5()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV3V5 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3V5, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3V5, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION 3/V6
  #################################################################################################
  
  
  yearTSV3V6 <- reactive({
    switch(input$yearTSV3V6,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotV3V6 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3V6[[yearTSV3V6()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3V6[[yearTSV3V6()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3V6 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3V6[[yearTSV3V6()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3V6[[yearTSV3V6()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesV3V6 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3V6[[yearTSV3V6()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3V6[[yearTSV3V6()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableV3V6 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3V6, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3V6, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION March
  #################################################################################################
  
  
  yearTSMarch <- reactive({
    switch(input$yearTSMarch,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotMarch <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarch[[yearTSMarch()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarch[[yearTSMarch()]]$TSPlot
    }
  })
  
  output$TSstorageTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarch[[yearTSMarch()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarch[[yearTSMarch()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarch[[yearTSMarch()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarch[[yearTSMarch()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarch, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarch, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop VERSION March Baselines Only
  #################################################################################################
  
  
  yearTSMarchBaselines <- reactive({
    switch(input$yearTSMarchBaselines,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSdistPlotMarchBaselines <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarchBaselines[[yearTSMarchBaselines()]]$TSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarchBaselines[[yearTSMarchBaselines()]]$TSPlot
    }
  })
  
  output$TSstorageTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarchBaselines[[yearTSMarchBaselines()]]$`TS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarchBaselines[[yearTSMarchBaselines()]]$`TS Storage`)
    }
  })
  
  output$TSsummaryTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarchBaselines[[yearTSMarchBaselines()]]$`TS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarchBaselines[[yearTSMarchBaselines()]]$`TS Sales Summary`)
    }
  })
  
  output$TSyearTableMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarchBaselines, "TSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarchBaselines, "TSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales
  #################################################################################################
  
  
  yearSS <- reactive({
    switch(input$yearSS,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$SSdistPlot <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsBase[[yearSS()]]$SSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsBase[[yearSS()]]$SSPlot
    }
  })
  
  output$SSstorageTables = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsBase[[yearSS()]]$`SS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsBase[[yearSS()]]$`SS Storage`)
    }
  })
  
  output$SSsummaryTables = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsBase[[yearSS()]]$`SS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsBase[[yearSS()]]$`SS Sales Summary`)
    }
  })
  
  output$SSyearTable = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornBase, "SSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanBase, "SSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales VERSION March
  #################################################################################################
  
  
  yearSSMarch <- reactive({
    switch(input$yearSSMarch,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$SSdistPlotMarch <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarch[[yearSSMarch()]]$SSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarch[[yearSSMarch()]]$SSPlot
    }
  })
  
  output$SSstorageTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarch[[yearSSMarch()]]$`SS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarch[[yearSSMarch()]]$`SS Storage`)
    }
  })
  
  output$SSsummaryTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarch[[yearSSMarch()]]$`SS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarch[[yearSSMarch()]]$`SS Sales Summary`)
    }
  })
  
  output$SSyearTableMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarch, "SSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarch, "SSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales VERSION March Baselines Only
  #################################################################################################
  
  
  yearSSMarchBaselines <- reactive({
    switch(input$yearSSMarchBaselines,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$SSdistPlotMarchBaselines <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarchBaselines[[yearSSMarchBaselines()]]$SSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarchBaselines[[yearSSMarchBaselines()]]$SSPlot
    }
  })
  
  output$SSstorageTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarchBaselines[[yearSSMarchBaselines()]]$`SS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarchBaselines[[yearSSMarchBaselines()]]$`SS Storage`)
    }
  })
  
  output$SSsummaryTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarchBaselines[[yearSSMarchBaselines()]]$`SS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarchBaselines[[yearSSMarchBaselines()]]$`SS Sales Summary`)
    }
  })
  
  output$SSyearTableMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarchBaselines, "SSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarchBaselines, "SSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales VERSION Harvest Time
  #################################################################################################
  
  
  yearSSHarvestTime <- reactive({
    switch(input$yearSSHarvestTime,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$SSdistPlotHarvestTime <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsHarvestTime[[yearSSHarvestTime()]]$SSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsHarvestTime[[yearSSHarvestTime()]]$SSPlot
    }
  })
  
  output$SSstorageTablesHarvestTime = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsHarvestTime[[yearSSHarvestTime()]]$`SS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsHarvestTime[[yearSSHarvestTime()]]$`SS Storage`)
    }
  })
  
  output$SSsummaryTablesHarvestTime = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsHarvestTime[[yearSSHarvestTime()]]$`SS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsHarvestTime[[yearSSHarvestTime()]]$`SS Sales Summary`)
    }
  })
  
  output$SSyearTableHarvestTime = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornHarvestTime, "SSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanHarvestTime, "SSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales VERSION 404020
  #################################################################################################
  
  
  yearSS404020 <- reactive({
    switch(input$yearSS404020,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$SSdistPlot404020 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjects404020[[yearSS404020()]]$SSPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjects404020[[yearSS404020()]]$SSPlot
    }
  })
  
  output$SSstorageTables404020 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjects404020[[yearSS404020()]]$`SS Storage`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjects404020[[yearSS404020()]]$`SS Storage`)
    }
  })
  
  output$SSsummaryTables404020 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjects404020[[yearSS404020()]]$`SS Sales Summary`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjects404020[[yearSS404020()]]$`SS Sales Summary`)
    }
  })
  
  output$SSyearTable404020 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCorn404020, "SSfinalizedPrices"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybean404020, "SSfinalizedPrices"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective With Multi Year
  #################################################################################################
  
  
  yearPOMY <- reactive({
    switch(input$yearPOMY,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POMYdistPlot <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsBase[[yearPOMY()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsBase[[yearPOMY()]]$POMYPlot
    }
  })
  
  output$POMYstorageTables = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsBase[[yearPOMY()]]$`PO Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsBase[[yearPOMY()]]$`PO Storage MY`)
    }
  })
  
  output$POMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsBase[[yearPOMY()]]$`PO Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsBase[[yearPOMY()]]$`PO Sales Summary MY`)
    }
  })
  
  output$POMYyearTable = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornBase, "POfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanBase, "POfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective Multi Year VERSION 2
  #################################################################################################
  
  
  yearPOMYV2 <- reactive({
    switch(input$yearPOMYV2,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POMYdistPlotV2 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV2[[yearPOMYV2()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV2[[yearPOMYV2()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV2[[yearPOMYV2()]]$`PO Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV2[[yearPOMYV2()]]$`PO Storage MY`)
    }
  })
  
  output$POMYsummaryTablesV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV2[[yearPOMYV2()]]$`PO Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV2[[yearPOMYV2()]]$`PO Sales Summary MY`)
    }
  })
  
  output$POMYyearTableV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV2, "POfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV2, "POfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective Multi Year VERSION 3
  #################################################################################################
  
  
  yearPOMYV3 <- reactive({
    switch(input$yearPOMYV3,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POMYdistPlotV3 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3[[yearPOMYV3()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3[[yearPOMYV3()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3[[yearPOMYV3()]]$`PO Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3[[yearPOMYV3()]]$`PO Storage MY`)
    }
  })
  
  output$POMYsummaryTablesV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3[[yearPOMYV3()]]$`PO Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3[[yearPOMYV3()]]$`PO Sales Summary MY`)
    }
  })
  
  output$POMYyearTableV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3, "POfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3, "POfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective Multi Year VERSION 4
  #################################################################################################
  
  
  yearPOMYV4 <- reactive({
    switch(input$yearPOMYV4,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POMYdistPlotV4 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV4[[yearPOMYV4()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV4[[yearPOMYV4()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV4[[yearPOMYV4()]]$`PO Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV4[[yearPOMY4()]]$`PO Storage MY`)
    }
  })
  
  output$POMYsummaryTablesV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV4[[yearPOMYV4()]]$`PO Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV4[[yearPOMYV4()]]$`PO Sales Summary MY`)
    }
  })
  
  output$POMYyearTableV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV4, "POfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV4, "POfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective Multi Year VERSION 5
  #################################################################################################
  
  
  yearPOMYV5 <- reactive({
    switch(input$yearPOMYV5,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POMYdistPlotV5 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV5[[yearPOMYV5()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV5[[yearPOMYV5()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV5[[yearPOMYV5()]]$`PO Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV5[[yearPOMYV5()]]$`PO Storage MY`)
    }
  })
  
  output$POMYsummaryTablesV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV5[[yearPOMYV5()]]$`PO Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV5[[yearPOMYV5()]]$`PO Sales Summary MY`)
    }
  })
  
  output$POMYyearTableV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV5, "POfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV5, "POfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective Multi Year VERSION 6
  #################################################################################################
  
  
  yearPOMYV6 <- reactive({
    switch(input$yearPOMYV6,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POMYdistPlotV6 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV6[[yearPOMYV6()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV6[[yearPOMYV6()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV6[[yearPOMYV6()]]$`PO Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV6[[yearPOMYV6()]]$`PO Storage MY`)
    }
  })
  
  output$POMYsummaryTablesV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV6[[yearPOMYV6()]]$`PO Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV6[[yearPOMYV6()]]$`PO Sales Summary MY`)
    }
  })
  
  output$POMYyearTableV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV6, "POfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV6, "POfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective Multi Year March
  #################################################################################################
  
  
  yearPOMYMarch <- reactive({
    switch(input$yearPOMYMarch,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POMYdistPlotMarch <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarch[[yearPOMYMarch()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarch[[yearPOMYMarch()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarch[[yearPOMYMarch()]]$`PO Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarch[[yearPOMYMarch()]]$`PO Storage MY`)
    }
  })
  
  output$POMYsummaryTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarch[[yearPOMYMarch()]]$`PO Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarch[[yearPOMYMarch()]]$`PO Sales Summary MY`)
    }
  })
  
  output$POMYyearTableMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarch, "POfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarch, "POfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Price Objective Multi Year March Baselines Only
  #################################################################################################
  
  
  yearPOMYMarchBaselines <- reactive({
    switch(input$yearPOMYMarchBaselines,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$POMYdistPlotMarchBaselines <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarchBaselines[[yearPOMYMarchBaselines()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarchBaselines[[yearPOMYMarchBaselines()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarchBaselines[[yearPOMYMarchBaselines()]]$`PO Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarchBaselines[[yearPOMYMarchBaselines()]]$`PO Storage MY`)
    }
  })
  
  output$POMYsummaryTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarchBaselines[[yearPOMYMarchBaselines()]]$`PO Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarchBaselines[[yearPOMYMarchBaselines()]]$`PO Sales Summary MY`)
    }
  })
  
  output$POMYyearTableMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarchBaselines, "POfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarchBaselines, "POfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop With Multi Year
  #################################################################################################
  
  
  yearTSMY <- reactive({
    switch(input$yearTSMY,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsBase[[yearTSMY()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsBase[[yearTSMY()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsBase[[yearTSMY()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsBase[[yearTSMY()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsBase[[yearTSMY()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsBase[[yearTSMY()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTable = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornBase, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanBase, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop With Multi Year VERSION 2
  #################################################################################################
  
  
  yearTSMYV2<- reactive({
    switch(input$yearTSMYV2,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV2 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV2[[yearTSMYV2()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV2[[yearTSMYV2()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV2[[yearTSMYV2()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV2[[yearTSMYV2()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV2[[yearTSMYV2()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV2[[yearTSMYV2()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableV2 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV2, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV2, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop With Multi Year VERSION 3
  #################################################################################################
  
  
  yearTSMYV3<- reactive({
    switch(input$yearTSMYV3,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV3 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3[[yearTSMYV3()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3[[yearTSMYV3()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3[[yearTSMYV3()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3[[yearTSMYV3()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3[[yearTSMYV3()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3[[yearTSMYV3()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableV3 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION 4
  #################################################################################################
  
  
  yearTSMYV4 <- reactive({
    switch(input$yearTSMYV4,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV4 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV4[[yearTSMYV4()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV4[[yearTSMYV4()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV4[[yearTSMYV4()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV4[[yearTSMYV4()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV4[[yearTSMYV4()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV4[[yearTSMYV4()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableV4 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV4, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV4, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION 5
  #################################################################################################
  
  
  yearTSMYV5 <- reactive({
    switch(input$yearTSMYV5,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV5 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV5[[yearTSMYV5()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV5[[yearTSMYV5()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV5[[yearTSMYV5()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV5[[yearTSMYV5()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV5[[yearTSMYV5()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV5[[yearTSMYV5()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableV5 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV5, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV5, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION 6
  #################################################################################################
  
  
  yearTSMYV6 <- reactive({
    switch(input$yearTSMYV6,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV6 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV6[[yearTSMYV6()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV6[[yearTSMYV6()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV6[[yearTSMYV6()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV6[[yearTSMYV6()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV6[[yearTSMYV6()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV6[[yearTSMYV6()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableV6 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV6, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV6, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION 3/BASE
  #################################################################################################
  
  
  yearTSMYV3Base <- reactive({
    switch(input$yearTSMYV3Base,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV3Base <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3Base[[yearTSMYV3Base()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3Base[[yearTSMYV3Base()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3Base = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3Base[[yearTSMYV3Base()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3Base[[yearTSMYV3Base()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV3Base = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3Base[[yearTSMYV3Base()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3Base[[yearTSMYV3Base()]]$`TS Sales Summary MY`)
    }
  }) 
  
  output$TSMYyearTableV3Base = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3Base, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3Base, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION 3/V2 
  #################################################################################################
  
  
  yearTSMYV3V2 <- reactive({
    switch(input$yearTSMYV3V2,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV3V2 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3V2[[yearTSMYV3V2()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3V2[[yearTSMYV3V2()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3V2 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3V2[[yearTSMYV3V2()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3V2[[yearTSMYV3V2()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV3V2 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3V2[[yearTSMYV3V2()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3V2[[yearTSMYV3V2()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableV3V2 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3V2, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3V2, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION 3/V3
  #################################################################################################
  
  
  yearTSMYV3V3 <- reactive({
    switch(input$yearTSMYV3V3,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV3V3 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3V3[[yearTSMYV3V3()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3V3[[yearTSMYV3V3()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3V3 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3V3[[yearTSMYV3V3()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3V3[[yearTSMYV3V3()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV3V3 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3V3[[yearTSMYV3V3()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3V3[[yearTSMYV3V3()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableV3V3 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3V3, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3V3, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION 3/V4
  #################################################################################################
  
  
  yearTSMYV3V4 <- reactive({
    switch(input$yearTSMYV3V4,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV3V4 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3V4[[yearTSMYV3V4()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3V4[[yearTSMYV3V4()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3V4 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3V4[[yearTSMYV3V4()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3V4[[yearTSMYV3V4()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV3V4 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3V4[[yearTSMYV3V4()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3V4[[yearTSMYV3V4()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableV3V4 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3V4, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3V4, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION 3/V5
  #################################################################################################
  
  
  yearTSMYV3V5 <- reactive({
    switch(input$yearTSMYV3V5,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV3V5 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3V5[[yearTSMYV3V5()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3V5[[yearTSMYV3V5()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3V5 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3V5[[yearTSMYV3V5()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3V5[[yearTSMYV3V5()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV3V5 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3V5[[yearTSMYV3V5()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3V5[[yearTSMYV3V5()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableV3V5 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3V5, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3V5, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION 3/V6
  #################################################################################################
  
  
  yearTSMYV3V6 <- reactive({
    switch(input$yearTSMYV3V6,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotV3V6 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsV3V6[[yearTSMYV3V6()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsV3V6[[yearTSMYV3V6()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3V6 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsV3V6[[yearTSMYV3V6()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsV3V6[[yearTSMYV3V6()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesV3V6 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsV3V6[[yearTSMYV3V6()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsV3V6[[yearTSMYV3V6()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableV3V6 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornV3V6, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanV3V6, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION March
  #################################################################################################
  
  
  yearTSMYMarch <- reactive({
    switch(input$yearTSMYMarch,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotMarch <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarch[[yearTSMYMarch()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarch[[yearTSMYMarch()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarch[[yearTSMYMarch()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarch[[yearTSMYMarch()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarch[[yearTSMYMarch()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarch[[yearTSMYMarch()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarch, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarch, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Trailing Stop Multi Year VERSION March Baselines Only
  #################################################################################################
  
  
  yearTSMYMarchBaselines <- reactive({
    switch(input$yearTSMYMarchBaselines,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$TSMYdistPlotMarchBaselines <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarchBaselines[[yearTSMYMarchBaselines()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarchBaselines[[yearTSMYMarchBaselines()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarchBaselines[[yearTSMYMarchBaselines()]]$`TS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarchBaselines[[yearTSMYMarchBaselines()]]$`TS Storage MY`)
    }
  })
  
  output$TSMYsummaryTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarchBaselines[[yearTSMYMarchBaselines()]]$`TS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarchBaselines[[yearTSMYMarchBaselines()]]$`TS Sales Summary MY`)
    }
  })
  
  output$TSMYyearTableMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarchBaselines, "TSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarchBaselines, "TSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales With Multi Year
  #################################################################################################
  
  
  yearSSMY<- reactive({
    switch(input$yearSSMY,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$SSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsBase[[yearSSMY()]]$SSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsBase[[yearSSMY()]]$SSMYPlot
    }
  })
  
  output$SSMYstorageTables = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsBase[[yearSSMY()]]$`SS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsBase[[yearSSMY()]]$`SS Storage MY`)
    }
  })
  
  output$SSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsBase[[yearSSMY()]]$`SS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsBase[[yearSSMY()]]$`SS Sales Summary MY`)
    }
  })
  
  output$SSMYyearTable = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornBase, "SSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanBase, "SSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales Multi Year VERSION March NC
  #################################################################################################
  
  
  yearSSMYMarch <- reactive({
    switch(input$yearSSMYMarch,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$SSMYdistPlotMarch <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarch[[yearSSMYMarch()]]$SSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarch[[yearSSMYMarch()]]$SSMYPlot
    }
  })
  
  output$SSMYstorageTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarch[[yearSSMYMarch()]]$`SS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarch[[yearSSMYMarch()]]$`SS Storage MY`)
    }
  })
  
  output$SSMYsummaryTablesMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarch[[yearSSMYMarch()]]$`SS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarch[[yearSSMYMarch()]]$`SS Sales Summary MY`)
    }
  })
  
  output$SSMYyearTableMarch = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarch, "SSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarch, "SSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales Multi Year VERSION March Baselines Only
  #################################################################################################
  
  
  yearSSMYMarchBaselines <- reactive({
    switch(input$yearSSMYMarchBaselines,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$SSMYdistPlotMarchBaselines <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsMarchBaselines[[yearSSMYMarchBaselines()]]$SSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsMarchBaselines[[yearSSMYMarchBaselines()]]$SSMYPlot
    }
  })
  
  output$SSMYstorageTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsMarchBaselines[[yearSSMYMarchBaselines()]]$`SS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsMarchBaselines[[yearSSMYMarchBaselines()]]$`SS Storage MY`)
    }
  })
  
  output$SSMYsummaryTablesMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsMarchBaselines[[yearSSMYMarchBaselines()]]$`SS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsMarchBaselines[[yearSSMYMarchBaselines()]]$`SS Sales Summary MY`)
    }
  })
  
  output$SSMYyearTableMarchBaselines = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornMarchBaselines, "SSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanMarchBaselines, "SSfinalizedPricesMY"), "soybean")
    }
  })
  
  session$onSessionEnded(function() {
    closeAllConnections()
  })
  
  
  #################################################################################################
  # Seasonal Sales Multi Year VERSION Harvest Time
  #################################################################################################
  
  
  yearSSMYHarvestTime <- reactive({
    switch(input$yearSSMYHarvestTime,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$SSMYdistPlotHarvestTime <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjectsHarvestTime[[yearSSMYHarvestTime()]]$SSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjectsHarvestTime[[yearSSMYHarvestTime()]]$SSMYPlot
    }
  })
  
  output$SSMYstorageTablesHarvestTime = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjectsHarvestTime[[yearSSMYHarvestTime()]]$`SS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjectsHarvestTime[[yearSSMYHarvestTime()]]$`SS Storage MY`)
    }
  })
  
  output$SSMYsummaryTablesHarvestTime = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjectsHarvestTime[[yearSSMYHarvestTime()]]$`SS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjectsHarvestTime[[yearSSMYHarvestTime()]]$`SS Sales Summary MY`)
    }
  })
  
  output$SSMYyearTableHarvestTime = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCornHarvestTime, "SSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybeanHarvestTime, "SSfinalizedPricesMY"), "soybean")
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales Multi Year VERSION 404020
  #################################################################################################
  
  
  yearSSMY404020 <- reactive({
    switch(input$yearSSMY404020,
           "2008-09" = 1,
           "2009-10" = 2,
           "2010-11" = 3,
           "2011-12" = 4,
           "2012-13" = 5,
           "2013-14" = 6,
           "2014-15" = 7,
           "2015-16" = 8,
           "2016-17" = 9,
           "2017-18" = 10,
           "2018-19" = 11,
           "2019-20" = 12)
  })
  
  output$SSMYdistPlot404020 <- renderPlot({
    if (input$cropType == "Corn") {
      Corn_CropYearObjects404020[[yearSSMY404020()]]$SSMYPlot
    }
    else if (input$cropType == "Soybeans") {
      Soybean_CropYearObjects404020[[yearSSMY404020()]]$SSMYPlot
    }
  })
  
  output$SSMYstorageTables404020 = renderDataTable({
    if (input$cropType == "Corn") {
      getTables(Corn_CropYearObjects404020[[yearSSMY404020()]]$`SS Storage MY`)
    }
    else if (input$cropType == "Soybeans") {
      getTables(Soybean_CropYearObjects404020[[yearSSMY404020()]]$`SS Storage MY`)
    }
  })
  
  output$SSMYsummaryTables404020 = renderDataTable({
    if (input$cropType == "Corn") {
      getSalesTable(Corn_CropYearObjects404020[[yearSSMY404020()]]$`SS Sales Summary MY`)
    }
    else if (input$cropType == "Soybeans") {
      getSalesTable(Soybean_CropYearObjects404020[[yearSSMY404020()]]$`SS Sales Summary MY`)
    }
  })
  
  output$SSMYyearTable404020 = renderDataTable({
    if (input$cropType == "Corn") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectCorn404020, "SSfinalizedPricesMY"), "corn")
    }
    else if (input$cropType == "Soybeans") {
      getYearlyResultsTable(yearlyResultsByStrategy(finalizedPriceObjectSoybean404020, "SSfinalizedPricesMY"), "soybean")
    }
  })
  
})

shinyApp(ui = ui,server = server)