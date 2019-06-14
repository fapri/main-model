library(shiny)
library(DT)
library(htmltools)
library(formattable)
library(lubridate)


# Corn Base/__
appObjectsCornBase = readRDS("appObjectsCornBase.rds")
Corn_CropYearObjectsBase = appObjectsCornBase[[1]]
Corn_CropYearsBase = appObjectsCornBase[[2]]
finalizedPriceObjectCornBase = appObjectsCornBase[[3]]

appObjectsCornV2 = readRDS("appObjectsCornV2.rds")
Corn_CropYearObjectsV2 = appObjectsCornV2[[1]]
Corn_CropYearsV2 = appObjectsCornV2[[2]]
finalizedPriceObjectCornV2 = appObjectsCornV2[[3]]

appObjectsCornV3 = readRDS("appObjectsCornV3.rds")
Corn_CropYearObjectsV3 = appObjectsCornV3[[1]]
Corn_CropYearsV3 = appObjectsCornV3[[2]]
finalizedPriceObjectCornV3 = appObjectsCornV3[[3]]

appObjectsCornV4 = readRDS("appObjectsCornV4.rds")
Corn_CropYearObjectsV4 = appObjectsCornV4[[1]]
Corn_CropYearsV4 = appObjectsCornV4[[2]]
finalizedPriceObjectCornV4 = appObjectsCornV4[[3]]

appObjectsCornV5 = readRDS("appObjectsCornV5.rds")
Corn_CropYearObjectsV5 = appObjectsCornV5[[1]]
Corn_CropYearsV5 = appObjectsCornV5[[2]]
finalizedPriceObjectCornV5 = appObjectsCornV5[[3]]



# Corn V3/__
appObjectsCornV3Base = readRDS("appObjectsCornV3Base.rds")
Corn_CropYearObjectsV3Base = appObjectsCornV3Base[[1]]
Corn_CropYearsV3Base = appObjectsCornV3Base[[2]]
finalizedPriceObjectCornV3Base = appObjectsCornV3Base[[3]]

appObjectsCornV3V2 = readRDS("appObjectsCornV3V2.rds")
Corn_CropYearObjectsV3V2 = appObjectsCornV3V2[[1]]
Corn_CropYearsV3V2 = appObjectsCornV3V2[[2]]
finalizedPriceObjectCornV3V2 = appObjectsCornV3V2[[3]]

appObjectsCornV3V3 = readRDS("appObjectsCornV3V3.rds")
Corn_CropYearObjectsV3V3 = appObjectsCornV3V3[[1]]
Corn_CropYearsV3V3 = appObjectsCornV3V3[[2]]
finalizedPriceObjectCornV3V3 = appObjectsCornV3V3[[3]]

appObjectsCornV3V4 = readRDS("appObjectsCornV3V4.rds")
Corn_CropYearObjectsV3V4 = appObjectsCornV3V4[[1]]
Corn_CropYearsV3V4 = appObjectsCornV3V4[[2]]
finalizedPriceObjectCornV3V4 = appObjectsCornV3V4[[3]]

appObjectsCornV3V5 = readRDS("appObjectsCornV3V5.rds")
Corn_CropYearObjectsV3V5 = appObjectsCornV3V5[[1]]
Corn_CropYearsV3V5 = appObjectsCornV3V5[[2]]
finalizedPriceObjectCornV3V5 = appObjectsCornV3V5[[3]]


# Soybean Base/__
appObjectsSoybean = readRDS("appObjectsSoybeanBase.rds")
Soybean_CropYearObjectsBase = appObjectsSoybean[[1]]
Soybean_CropYearsBase = appObjectsSoybean[[2]]
finalizedPriceObjectSoybeanBase = appObjectsSoybean[[3]]

appObjectsSoybeanV2 = readRDS("appObjectsSoybeanV2.rds")
Soybean_CropYearObjectsV2 = appObjectsSoybeanV2[[1]]
Soybean_CropYearsV2 = appObjectsSoybeanV2[[2]]
finalizedPriceObjectSoybeanV2 = appObjectsSoybeanV2[[3]]

appObjectsSoybeanV3 = readRDS("appObjectsSoybeanV3.rds")
Soybean_CropYearObjectsV3 = appObjectsSoybeanV3[[1]]
Soybean_CropYearsV3 = appObjectsSoybeanV3[[2]]
finalizedPriceObjectSoybeanV3 = appObjectsSoybeanV3[[3]]

appObjectsSoybeanV4 = readRDS("appObjectsSoybeanV4.rds")
Soybean_CropYearObjectsV4 = appObjectsSoybeanV4[[1]]
Soybean_CropYearsV4 = appObjectsSoybeanV4[[2]]
finalizedPriceObjectSoybeanV4 = appObjectsSoybeanV4[[3]]

appObjectsSoybeanV5 = readRDS("appObjectsSoybeanV5.rds")
Soybean_CropYearObjectsV5 = appObjectsSoybeanV5[[1]]
Soybean_CropYearsV5 = appObjectsSoybeanV5[[2]]
finalizedPriceObjectSoybeanV5 = appObjectsSoybeanV5[[3]]


# Soybean V3/__
appObjectsSoybeanV3Base = readRDS("appObjectsSoybeanV3Base.rds")
Soybean_CropYearObjectsV3Base = appObjectsSoybeanV3Base[[1]]
Soybean_CropYearsV3Base = appObjectsSoybeanV3Base[[2]]
finalizedPriceObjectSoybeanV3Base = appObjectsSoybeanV3Base[[3]]

appObjectsSoybeanV3V2 = readRDS("appObjectsSoybeanV3V2.rds")
Soybean_CropYearObjectsV3V2 = appObjectsSoybeanV3V2[[1]]
Soybean_CropYearsV3V2 = appObjectsSoybeanV3V2[[2]]
finalizedPriceObjectSoybeanV3V2 = appObjectsSoybeanV3V2[[3]]

appObjectsSoybeanV3V3 = readRDS("appObjectsSoybeanV3V3.rds")
Soybean_CropYearObjectsV3V3 = appObjectsSoybeanV3V3[[1]]
Soybean_CropYearsV3V3 = appObjectsSoybeanV3V3[[2]]
finalizedPriceObjectSoybeanV3V3 = appObjectsSoybeanV3V3[[3]]

appObjectsSoybeanV3V4 = readRDS("appObjectsSoybeanV3V4.rds")
Soybean_CropYearObjectsV3V4 = appObjectsSoybeanV3V4[[1]]
Soybean_CropYearsV3V4 = appObjectsSoybeanV3V4[[2]]
finalizedPriceObjectSoybeanV3V4 = appObjectsSoybeanV3V4[[3]]

appObjectsSoybeanV3V5 = readRDS("appObjectsSoybeanV3V5.rds")
Soybean_CropYearObjectsV3V5 = appObjectsSoybeanV3V5[[1]]
Soybean_CropYearsV3V5 = appObjectsSoybeanV3V5[[2]]
finalizedPriceObjectSoybeanV3V5 = appObjectsSoybeanV3V5[[3]]



POCorn = c("Base" = "base",
           "Multi-Year" = "multiyear",
           "Version 2" = "V2",
           "Multi-Year Version 2" = "MYV2",
           "Version 3" = "V3",
           "Multi-Year Version 3" = "MYV3",
           "Version 4" = "V4",
           "Multi-Year Version 4"="MYV4",
           "Version 5" = "V5",
           "Multi-Year Version 5"="MYV5")

POSoybean = c("Base" = "base",
              "Multi-Year" = "multiyear",
              "Version 2" = "V2",
              "Multi-Year Version 2" = "MYV2",
              "Version 3" = "V3",
              "Multi-Year Version 3" = "MYV3",
              "Version 4" = "V4",
              "Multi-Year Version 4"="MYV4",
              "Version 5" = "V5",
              "Multi-Year Version 5"="MYV5")

TSCorn = c(Base = "base",
           "Multi-Year" = "multiyear",
           "Version 2" = "V2",
           "Multi-Year Version 2" = "MYV2",
           "Version 3" = "V3",
           "Multi-Year Version 3" = "MYV3",
           "Version 4" = "V4",
           "Multi-Year Version 4" = "MYV4",
           "Version 5" = "V5",
           "Multi-Year Version 5" = "MYV5",
           "Version 3/Base" = "V3Base",
           "Multi-Year Version 3/Base" = "MYV3Base",
           "Version 3/V2" = "V3V2",
           "Multi-Year Version 3/V2" = "MYV3V2",
           "Version 3/V3" = "V3V3",
           "Multi-Year Version 3/V3" = "MYV3V3",
           "Version 3/V4" = "V3V4",
           "Multi-Year Version 3/V4" = "MYV3V4",
           "Version 3/V5" = "V3V5",
           "Multi-Year Version 3/V5" = "MYV3V5")

TSSoybean = c(Base = "base",
              "Multi-Year" = "multiyear",
              "Version 2" = "V2",
              "Multi-Year Version 2" = "MYV2",
              "Version 3" = "V3",
              "Multi-Year Version 3" = "MYV3",
              "Version 4" = "V4",
              "Multi-Year Version 4" = "MYV4",
              "Version 5" = "V5",
              "Multi-Year Version 5" = "MYV5",
              "Version 3/Base" = "V3Base",
              "Multi-Year Version 3/Base" = "MYV3Base",
              "Version 3/V2" = "V3V2",
              "Multi-Year Version 3/V2" = "MYV3V2",
              "Version 3/V3" = "V3V3",
              "Multi-Year Version 3/V3" = "MYV3V3",
              "Version 3/V4" = "V3V4",
              "Multi-Year Version 3/V4" = "MYV3V4",
              "Version 3/V5" = "V3V5",
              "Multi-Year Version 3/V5" = "MYV3V5")

SSCorn = c("Base" = "base",
           "Multi-Year" = "multiyear")

SSSoybean = c("Base" = "base",
              "Multi-Year" = "multiyear")

POVersions = list("Corn" = POCorn, "Soybeans" = POSoybean)
TSVersions = list("Corn" = TSCorn, "Soybeans" = TSSoybean)
SSVersions = list("Corn" = SSCorn, "Soybeans" = SSSoybean)




u.n <-  Corn_CropYearsBase$CropYear
names(u.n) <- u.n

typeList <- c("Corn", "Soybeans")
names(typeList) = typeList

getTables = function(data) {
  data = cbind(" " = data[,1], round(data[, 2:3], digits = 2))
  table = formattable(data, 
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
                                                                   "text-align" = "left"))))
  return(table)
}

getFirstSummaryTable = function(data) {
  data = cbind(" " = data[,1], round(data[, 2:3], digits = 2))
  table = formattable(data, 
                      align = "c",
                      list(~ formatter("span",
                                       style = x ~ style(display = "block",
                                                         "border-radius" = "0px",
                                                         "padding" = "0px",
                                                         "text-align" = "center")),
                           `Total Avg Price` = formatter("span",
                                                         style = x ~ style(color = "white", background = "gray")),
                           `Pre-Harvest Avg Price` = formatter("span",
                                                               style = x ~ style(color = "white", background = "blue")),
                           `Post-Harvest Avg Price` = formatter("span",
                                                                style = x ~ style(color = "white", background = "green")),
                           ` ` = formatter("span", style = ~ style(display = "block",
                                                                   "border-radius" = "0px",
                                                                   "padding" = "0px",
                                                                   "font.weight" = "bold",  
                                                                   "text-align" = "left"))))
  return(table)
}

getRemainingSummaryTables = function(data) {
  data = round(data[,], digits = 2)
  table = formattable(data, align = "c")
  return(table)
}

getSalesTable = function(data) {
  table = formattable(data, 
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
                                                                      "text-align" = "left"))))
  return(table)
}

ui <- shinyUI(
  navbarPage("Marketing Strategies",
             tabPanel("Home",
                      fluidPage(
                        fluidRow(column(12, includeHTML("homePage.html"),
                                        selectInput("cropType", "", typeList, width = "33%")
                        )
                        )
                      )
             ),
             tabPanel("Price Objective",
                      fluidPage(
                        selectInput(inputId = "POstrategy", label = "Select Price Objective Strategy", choices = NULL),
                        conditionalPanel(
                          condition = "input.POstrategy == 'base'",         
                          fluidPage(
                            fluidRow(
                              plotOutput('distPlot'),
                              style = "padding-bottom:50px"
                            ),
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
                            sidebarLayout(
                              sidebarPanel(
                                fluidRow(selectInput('yearPO','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('storageTables')),
                                         tags$style(type="text/css", '#storageTables tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('summaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearPOMY','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTables')),
                                         tags$style(type="text/css", '#POMYstorageTables tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearPOV2','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesV2')),
                                         tags$style(type="text/css", '#POstorageTablesV2 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesV2'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearPOMYV2','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesV2')),
                                         tags$style(type="text/css", '#POMYstorageTablesV2 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesV2'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearPOV3','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesV3')),
                                         tags$style(type="text/css", '#POstorageTablesV3 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesV3'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearPOMYV3','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesV3')),
                                         tags$style(type="text/css", '#POMYstorageTablesV3 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesV3'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearPOV4','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesV4')),
                                         tags$style(type="text/css", '#POstorageTablesV4 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesV4'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearPOMYV4','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesV4')),
                                         tags$style(type="text/css", '#POMYstorageTablesV4 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesV4'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearPOV5','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('POstorageTablesV5')),
                                         tags$style(type="text/css", '#POstorageTablesV5 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POsummaryTablesV5'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearPOMYV5','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('POMYstorageTablesV5')),
                                         tags$style(type="text/css", '#POMYstorageTablesV5 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('POMYsummaryTablesV5'),
                                  style = "padding-bottom:100px")
                              )
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
                                fluidRow(selectInput('yearTS','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTables')),
                                         tags$style(type="text/css", '#TSstorageTables tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSMY','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTables')),
                                         tags$style(type="text/css", '#TSMYstorageTables tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSV2','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV2')),
                                         tags$style(type="text/css", '#TSstorageTablesV2 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV2'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSMYV2','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV2')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV2 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV2'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSV3','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3')),
                                         tags$style(type="text/css", '#TSstorageTablesV3 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSMYV3','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSV4','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV4')),
                                         tags$style(type="text/css", '#TSstorageTablesV4 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV4'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSMYV4','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV4')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV4 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV4'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSV5','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV5')),
                                         tags$style(type="text/css", '#TSstorageTablesV5 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV5'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSMYV5','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV5')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV5 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV5'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSV3Base','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3Base')),
                                         tags$style(type="text/css", '#TSstorageTablesV3Base tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3Base'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSMYV3Base','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3Base')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3Base tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3Base'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSV3V2','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3V2')),
                                         tags$style(type="text/css", '#TSstorageTablesV3V2 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3V2'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSMYV3V2','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3V2')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3V2 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3V2'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSV3V3','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3V3')),
                                         tags$style(type="text/css", '#TSstorageTablesV3V3 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3V3'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSMYV3V3','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3V3')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3V3 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3V3'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSV3V4','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3V4')),
                                         tags$style(type="text/css", '#TSstorageTablesV3V4 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3V4'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSMYV3V4','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3V4')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3V4 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3V4'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSV3V5','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSstorageTablesV3V5')),
                                         tags$style(type="text/css", '#TSstorageTablesV3V5 tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSsummaryTablesV3V5'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearTSMYV3V5','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('TSMYstorageTablesV3V5')),
                                         tags$style(type="text/css", '#TSMYstorageTablesV3V5 tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('TSMYsummaryTablesV3V5'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                                fluidRow(selectInput('yearSS','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('SSstorageTables')),
                                         tags$style(type="text/css", '#SSstorageTables tfoot {display:none;}'))
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
                              
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
                                fluidRow(selectInput('yearSSMY','Crop Year', choices = u.n, width = "100%"),
                                         column(12, dataTableOutput('SSMYstorageTables')),
                                         tags$style(type="text/css", '#SSMYstorageTables tfoot {display:none;}'))
                                
                              ),
                              mainPanel(
                                fluidRow(
                                  dataTableOutput('SSMYsummaryTables'),
                                  style = "padding-bottom:100px")
                                
                              )
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
                        # tags$div(class="title", titlePanel("Without Multi-Year Sales")),
                        # splitLayout( dataTableOutput("finalPriceTable")),
                        #              dataTableOutput("TSfinalPriceTable"),
                        #              dataTableOutput("SSfinalPriceTable"),
                        #              dataTableOutput("TSfinalPriceTableV2"),
                        #              dataTableOutput("TSfinalPriceTableV3")),
                        # tags$div(class="title", titlePanel("With Multi-Year Sales")),
                        # splitLayout( dataTableOutput("POMYfinalPriceTable"),
                        #             dataTableOutput("TSMYfinalPriceTable"),
                        #             dataTableOutput("SSMYfinalPriceTable"),
                        #             dataTableOutput("TSMYfinalPriceTableV2"),
                        #             dataTableOutput("TSMYfinalPriceTableV3"))
                        
                        fluidRow(
                          # Without Multi Year
                          column(12,
                                 tags$div(class="title", titlePanel("Without Multi-Year Sales")),
                                 div(style = "display: inline-block;", dataTableOutput("finalPriceTable"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("POfinalPriceTableV2"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("POfinalPriceTableV3"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("POfinalPriceTableV4"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("POfinalPriceTableV5"), height=150, width=150)),
                          column(12,
                                 div(style = "display: inline-block;", dataTableOutput("TSfinalPriceTable"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSfinalPriceTableV2"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSfinalPriceTableV3"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSfinalPriceTableV4"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSfinalPriceTableV5"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSfinalPriceTableV3Base"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSfinalPriceTableV3V2"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSfinalPriceTableV3V3"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSfinalPriceTableV3V4"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSfinalPriceTableV3V5"), height=150, width=150)),
                          column(12,
                                 div(style = "display: inline-block;", dataTableOutput("SSfinalPriceTable"), height=150, width=150)),
                          
                          # With Multi Year
                          column(12,
                                 tags$div(class="title", titlePanel("With Multi-Year Sales")),
                                 div(style = "display: inline-block;", dataTableOutput("POMYfinalPriceTable"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("POMYfinalPriceTableV2"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("POMYfinalPriceTableV3"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("POMYfinalPriceTableV4"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("POMYfinalPriceTableV5"), height=150, width=150)),
                          column(12,
                                 div(style = "display: inline-block;", dataTableOutput("TSMYfinalPriceTable"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSMYfinalPriceTableV2"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSMYfinalPriceTableV3"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSMYfinalPriceTableV4"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSMYfinalPriceTableV5"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSMYfinalPriceTableV3Base"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSMYfinalPriceTableV3V2"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSMYfinalPriceTableV3V3"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSMYfinalPriceTableV3V4"), height=150, width=150),
                                 div(style = "display: inline-block;", dataTableOutput("TSMYfinalPriceTableV3V5"), height=150, width=150)),
                          column(12,
                                 div(style = "display: inline-block;", dataTableOutput("SSMYfinalPriceTable"), height=150, width=150)))
                      )
             ),
             tabPanel("About Our Strategies",
                      fluidPage(
                        fluidRow(column(12, includeHTML("index.html")
                        )
                        
                        )
                      )),
             tabPanel("Version Descriptions",
                      fluidPage(
                        fluidRow(column(12, includeHTML("versions.html")
                        )
                        
                        )
                      ))
  )
) 

server <- shinyServer(function(input,output,session){
  
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
           "2016-17" = 9)
  })
  
  output$distPlot <- renderPlot({
    if(input$cropType == "Corn"){
      Corn_CropYearObjectsBase[[yearPO()]]$POPlot
    }
    else if(input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPO()]]$POPlot
    }
  })
  
  output$storageTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsBase[[yearPO()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPO()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$summaryTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsBase[[yearPO()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPO()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$finalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectCornBase$POResultsTable), rownames = FALSE, 
                   caption = tags$caption("Price Objective", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectSoybeanBase$POResultsTable), rownames = FALSE, 
                   caption = tags$caption("Price Objective", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  
  output$POdistPlotV2 <- renderPlot({
    if(input$cropType == "Corn"){
      Corn_CropYearObjectsV2[[yearPOV2()]]$POPlot
    }
    else if(input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV2[[yearPOV2()]]$POPlot
    }
  })
  
  output$POstorageTablesV2 = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV2[[yearPOV2()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV2[[yearPOV2()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POsummaryTablesV2 = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV2[[yearPOV2()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[yearPOV2()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POfinalPriceTableV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV2$POResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV2$POResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  
  output$POdistPlotV3 <- renderPlot({
    if(input$cropType == "Corn"){
      Corn_CropYearObjectsV3[[yearPOV3()]]$POPlot
    }
    else if(input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3[[yearPOV3()]]$POPlot
    }
  })
  
  
  
  output$POstorageTablesV3 = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV3[[yearPOV3()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV3[[yearPOV3()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  
  output$POsummaryTablesV3 = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3[[yearPOV3()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3[[yearPOV3()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POfinalPriceTableV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3$POResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3$POResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  
  output$POdistPlotV4 <- renderPlot({
    if(input$cropType == "Corn"){
      Corn_CropYearObjectsV4[[yearPOV4()]]$POPlot
    }
    else if(input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV4[[yearPOV4()]]$POPlot
    }
  })
  
  
  
  output$POstorageTablesV4 = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV4[[yearPOV4()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV4[[yearPOV4()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  
  output$POsummaryTablesV4 = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV4[[yearPOV4()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV4[[yearPOV4()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POfinalPriceTableV4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV4$POResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV4$POResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  
  output$POdistPlotV5 <- renderPlot({
    if(input$cropType == "Corn"){
      Corn_CropYearObjectsV5[[yearPOV5()]]$POPlot
    }
    else if(input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV5[[yearPOV5()]]$POPlot
    }
  })
  
  
  
  output$POstorageTablesV5 = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV5[[yearPOV5()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV5[[yearPOV5()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  
  output$POsummaryTablesV5 = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV5[[yearPOV5()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV5[[yearPOV5()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POfinalPriceTableV5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV5$POResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV5$POResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsBase[[yearTS()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTS()]]$TSPlot
    }
  })
  
  output$TSstorageTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsBase[[yearTS()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTS()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsBase[[yearTS()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTS()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectCornBase$TSResultsTable), rownames = FALSE, 
                   caption = tags$caption("Trailing Stop", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectSoybeanBase$TSResultsTable), rownames = FALSE, 
                   caption = tags$caption("Trailing Stop", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSdistPlotV2 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV2[[yearTSV2()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV2[[yearTSV2()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV2[[yearTSV2()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV2[[yearTSV2()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV2[[yearTSV2()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[yearTSV2()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV2$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV2$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSdistPlotV3 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3[[yearTSV3()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3[[yearTSV3()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV3[[yearTSV3()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV3[[yearTSV3()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3[[yearTSV3()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3[[yearTSV3()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSfinalPriceTableV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSdistPlotV4 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV4[[yearTSV4()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV4[[yearTSV4()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV4[[yearTSV4()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV4[[yearTSV4()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV4[[yearTSV4()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV4[[yearTSV4()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV4$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV4$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSdistPlotV5 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV5[[yearTSV5()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV5[[yearTSV5()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV5[[yearTSV5()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV5[[yearTSV5()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV5[[yearTSV5()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV5[[yearTSV5()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV5$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV5$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSdistPlotV3Base <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3Base[[yearTSV3Base()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3Base[[yearTSV3Base()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3Base = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV3Base[[yearTSV3Base()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV3Base[[yearTSV3Base()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV3Base = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3Base[[yearTSV3Base()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3Base[[yearTSV3Base()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3Base = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3Base$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/Base", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3Base$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/Base", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSdistPlotV3V2 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3V2[[yearTSV3V2()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3V2[[yearTSV3V2()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3V2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV3V2[[yearTSV3V2()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV3V2[[yearTSV3V2()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV3V2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3V2[[yearTSV3V2()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3V2[[yearTSV3V2()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3V2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3V2$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3V2$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSdistPlotV3V3 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3V3[[yearTSV3V3()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3V3[[yearTSV3V3()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3V3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV3V3[[yearTSV3V3()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV3V3[[yearTSV3V3()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV3V3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3V3[[yearTSV3V3()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3V3[[yearTSV3V3()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3V3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3V3$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3V3$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSdistPlotV3V4 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3V4[[yearTSV3V4()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3V4[[yearTSV3V4()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3V4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV3V4[[yearTSV3V4()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV3V4[[yearTSV3V4()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV3V4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3V4[[yearTSV3V4()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3V4[[yearTSV3V4()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3V4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3V4$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3V4$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSdistPlotV3V5 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3V5[[yearTSV3V5()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3V5[[yearTSV3V5()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3V5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjectsV3V5[[yearTSV3V5()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV3V5[[yearTSV3V5()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV3V5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3V5[[yearTSV3V5()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3V5[[yearTSV3V5()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3V5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3V5$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3V5$TSResultsTable[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$SSdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsBase[[yearSS()]]$SSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearSS()]]$SSPlot
    }
  })
  
  output$SSstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsBase[[yearSS()]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearSS()]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$SSsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsBase[[yearSS()]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearSS()]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$SSfinalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectCornBase$SSResultsTable), rownames = FALSE, 
                   caption = tags$caption("Seasonal Sales", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectSoybeanBase$SSResultsTable), rownames = FALSE, 
                   caption = tags$caption("Seasonal Sales", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$POMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsBase[[yearPOMY()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPOMY()]]$POMYPlot
    }
  })
  
  output$POMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsBase[[yearPOMY()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPOMY()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsBase[[yearPOMY()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPOMY()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POMYfinalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectCornBase$POResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Price Objective", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectSoybeanBase$POResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Price Objective", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$POMYdistPlotV2 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV2[[yearPOMYV2()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV2[[yearPOMYV2()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesV2 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV2[[yearPOMYV2()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV2[[yearPOMYV2()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POMYsummaryTablesV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV2[[yearPOMYV2()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[yearPOMYV2()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POMYfinalPriceTableV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV2$POResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV2$POResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$POMYdistPlotV3 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3[[yearPOMYV3()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3[[yearPOMYV3()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesV3 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV3[[yearPOMYV3()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV3[[yearPOMYV3()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POMYsummaryTablesV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3[[yearPOMYV3()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3[[yearPOMYV3()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POMYfinalPriceTableV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3$POResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3$POResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$POMYdistPlotV4 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV4[[yearPOMYV4()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV4[[yearPOMYV4()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesV4 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV4[[yearPOMYV4()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV4[[yearPOMY4()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POMYsummaryTablesV4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV4[[yearPOMYV4()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV4[[yearPOMYV4()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POMYfinalPriceTableV4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV4$POResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV4$POResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$POMYdistPlotV5 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV5[[yearPOMYV5()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV5[[yearPOMYV5()]]$POMYPlot
    }
  })
  
  output$POMYstorageTablesV5 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV5[[yearPOMYV5()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV5[[yearPOMYV5()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POMYsummaryTablesV5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV5[[yearPOMYV5()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV5[[yearPOMYV5()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POMYfinalPriceTableV5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV5$POResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV5$POResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Price Objective V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsBase[[yearTSMY()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSMY()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsBase[[yearTSMY()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSMY()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsBase[[yearTSMY()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSMY()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectCornBase$TSResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Trailing Stop", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectSoybeanBase$TSResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Trailing Stop", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSMYdistPlotV2 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV2[[yearTSMYV2()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV2[[yearTSMYV2()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV2 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV2[[yearTSMYV2()]]$`TS Storage MY`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV2[[yearTSMYV2()]]$`TS Storage MY`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSMYsummaryTablesV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV2[[yearTSMYV2()]]$`TS Sales Summary MY`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[yearTSMYV2()]]$`TS Sales Summary MY`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV2$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV2$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSMYdistPlotV3 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3[[yearTSMYV3()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3[[yearTSMYV3()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV3[[yearTSMYV3()]]$`TS Storage MY`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV3[[yearTSMYV3()]]$`TS Storage MY`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSMYsummaryTablesV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3[[yearTSMYV3()]]$`TS Sales Summary MY`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3[[yearTSMYV3()]]$`TS Sales Summary MY`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSMYdistPlotV4 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV4[[yearTSMYV4()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV4[[yearTSMYV4()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV4 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV4[[yearTSMYV4()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV4[[yearTSMYV4()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTablesV4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV4[[yearTSMYV4()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV4[[yearTSMYV4()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV4$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV4$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSMYdistPlotV5 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV5[[yearTSMYV5()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV5[[yearTSMYV5()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV5 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV5[[yearTSMYV5()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV5[[yearTSMYV5()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTablesV5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV5[[yearTSMYV5()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV5[[yearTSMYV5()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV5$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV5$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSMYdistPlotV3Base <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3Base[[yearTSMYV3Base()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3Base[[yearTSMYV3Base()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3Base = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV3Base[[yearTSMYV3Base()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV3Base[[yearTSMYV3Base()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTablesV3Base = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3Base[[yearTSMYV3Base()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3Base[[yearTSMYV3Base()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  }) 
  
  
  output$TSMYfinalPriceTableV3Base = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3Base$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/Base", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3Base$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/Base", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSMYdistPlotV3V2 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3V2[[yearTSMYV3V2()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3V2[[yearTSMYV3V2()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3V2 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV3V2[[yearTSMYV3V2()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV3V2[[yearTSMYV3V2()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTablesV3V2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3V2[[yearTSMYV3V2()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3V2[[yearTSMYV3V2()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3V2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3V2$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3V2$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSMYdistPlotV3V3 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3V3[[yearTSMYV3V3()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3V3[[yearTSMYV3V3()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3V3 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV3V3[[yearTSMYV3V3()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV3V3[[yearTSMYV3V3()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTablesV3V3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3V3[[yearTSMYV3V3()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3V3[[yearTSMYV3V3()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3V3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3V3$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3V3$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSMYdistPlotV3V4 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3V4[[yearTSMYV3V4()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3V4[[yearTSMYV3V4()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3V4 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV3V4[[yearTSMYV3V4()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV3V4[[yearTSMYV3V4()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTablesV3V4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3V4[[yearTSMYV3V4()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3V4[[yearTSMYV3V4()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3V4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3V4$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3V4$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V4", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$TSMYdistPlotV3V5 <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsV3V5[[yearTSMYV3V5()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3V5[[yearTSMYV3V5()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3V5 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsV3V5[[yearTSMYV3V5()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV3V5[[yearTSMYV3V5()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTablesV3V5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsV3V5[[yearTSMYV3V5()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3V5[[yearTSMYV3V5()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3V5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectCornV3V5$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV3V5$TSResultsTableMY[,2:3]), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3/V5", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
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
           "2016-17" = 9)
  })
  
  output$SSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjectsBase[[yearSSMY()]]$SSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearSSMY()]]$SSMYPlot
    }
  })
  
  output$SSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjectsBase[[yearSSMY()]]$`SS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearSSMY()]]$`SS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$SSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjectsBase[[yearSSMY()]]$`SS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearSSMY()]]$`SS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$SSMYfinalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectCornBase$SSResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Seasonal Sales", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectSoybeanBase$SSResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Seasonal Sales", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
})

shinyApp(ui = ui,server = server)