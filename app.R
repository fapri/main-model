library(shiny)
library(DT)
library(htmltools)
library(formattable)
library(lubridate)

appObjectsCorn = readRDS("appObjects.rds")
Corn_CropYearObjects = appObjectsCorn[[1]]
Corn_CropYears = appObjectsCorn[[2]]
finalizedPriceObject = appObjectsCorn[[3]]

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









u.n <-  Corn_CropYears$CropYear
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
                        selectInput(
                          "POstrategy", "Price Objective Strategy",
                          c(Base = "base",
                            "Multi-Year" = "multiyear",
                            "Version 2" = "V2",
                            "Multi-Year Version 2" = "MYV2",
                            "Version 3" = "V3",
                            "Multi-Year Version 3" = "MYV3",
                            "Multi-Year Version 4"="MYV4",
                            "Multi-Year Version 5"="MYV5")),
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
                            
                            tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                            
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
                        selectInput(
                          "TSstrategy", "Trailing Stop Strategy",
                          c(Base = "base",
                            "Multi-Year" = "multiyear",
                            "Version 2" = "V2",
                            "Multi-Year Version 2" = "MYV2",
                            "Version 3" = "V3",
                            "Multi-Year Version 3" = "MYV3")),
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
                        )
                      )
             ),
             tabPanel("Seasonal Sales",
                      fluidPage(
                        selectInput(
                          "SSstrategy", "Seasonal Sales Strategy",
                          c(Base = "base",
                            MultiYear = "multiyear")),
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
      Corn_CropYearObjects[[yearPO()]]$POPlot
    }
    else if(input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPO()]]$POPlot
    }
  })
  
  
  
  output$storageTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearPO()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPO()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  
  output$summaryTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearPO()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPO()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$finalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObject$POResultsTable), rownames = FALSE, 
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
  
  
  output$distPlot <- renderPlot({
    if(input$cropType == "Corn"){
      Corn_CropYearObjects[[yearPOV2()]]$POPlot
    }
    else if(input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPOV2()]]$POPlot
    }
  })
  
  
  
  output$storageTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearPOV2()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPOV2()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  
  output$summaryTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearPOV2()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPOV2()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POfinalPriceTableV2 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  
  output$distPlot <- renderPlot({
    if(input$cropType == "Corn"){
      Corn_CropYearObjects[[yearPOV3()]]$POPlot
    }
    else if(input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPOV3()]]$POPlot
    }
  })
  
  
  
  output$storageTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearPOV3()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPOV3()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  
  output$summaryTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearPOV3()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPOV3()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POfinalPriceTableV3 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  
  output$distPlot <- renderPlot({
    if(input$cropType == "Corn"){
      Corn_CropYearObjects[[yearPOV4()]]$POPlot
    }
    else if(input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPOV4()]]$POPlot
    }
  })
  
  
  
  output$storageTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearPOV4()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPOV4()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  
  output$summaryTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearPOV4()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPOV4()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POfinalPriceTableV4 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  
  output$distPlot <- renderPlot({
    if(input$cropType == "Corn"){
      Corn_CropYearObjects[[yearPOV5()]]$POPlot
    }
    else if(input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPOV5()]]$POPlot
    }
  })
  
  
  
  output$storageTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearPOV5()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPOV5()]]$`PO Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  
  output$summaryTables = renderDataTable({
    if(input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearPOV5()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPOV5()]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POfinalPriceTableV5 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
      Corn_CropYearObjects[[yearTS()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTS()]]$TSPlot
    }
  })
  
  output$TSstorageTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearTS()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTS()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTS()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTS()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObject$TSResultsTable), rownames = FALSE, 
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
      Corn_CropYearObjects[[yearTSV2()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV2[[yearTSV2()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearTSV2()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV2[[yearTSV2()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSV2()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[yearTSV2()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV2 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
      Corn_CropYearObjects[[yearTSV3()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3[[yearTSV3()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearTSV3()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV3[[yearTSV3()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSV3()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3[[yearTSV3()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSfinalPriceTableV3 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(finalizedPriceObjectSoybeanV3$TSResultsTable), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V3", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
      Corn_CropYearObjects[[yearTSV4()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV4[[yearTSV4()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearTSV4()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV4[[yearTSV4()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV4 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSV4()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV4[[yearTSV4()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV4 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
      Corn_CropYearObjects[[yearTSV5()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV5[[yearTSV5()]]$TSPlot
    }
  })
  
  output$TSstorageTablesV5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearTSV5()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsV5[[yearTSV5()]]$`TS Storage`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTablesV5 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSV5()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV5[[yearTSV5()]]$`TS Sales Summary`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV5 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSV3Base()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSV3Base()]]$TSPlot
    }
  })
  
  output$TSstorageTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearTSV3Base()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSV3Base()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSv3Base()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSV3Base()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3Base = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSV3V2()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSV3V2()]]$TSPlot
    }
  })
  
  output$TSstorageTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearTSV3V2()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSV3V2()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSV3V3()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSV3V2()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3V2 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSV3V3()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSV3V3()]]$TSPlot
    }
  })
  
  output$TSstorageTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearTSV3V3()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSV3V3()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSV3V3()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSV3V3()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3V3 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSV3V4()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSV3V4()]]$TSPlot
    }
  })
  
  output$TSstorageTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearTSV3V4()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSV3V4()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSV3V4()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSV3V4()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3V4 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSV3V5()]]$TSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSV3V5()]]$TSPlot
    }
  })
  
  output$TSstorageTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getTables(Corn_CropYearObjects[[yearTSV3V5()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSV3V5()]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSV3V5()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSV3V5()]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSfinalPriceTableV3V5 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
      Corn_CropYearObjects[[yearSS()]]$SSPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearSS()]]$SSPlot
    }
  })
  
  output$SSstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearSS()]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearSS()]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$SSsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearSS()]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearSS()]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$SSfinalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObject$SSResultsTable), rownames = FALSE, 
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
      Corn_CropYearObjects[[yearPOMY()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPOMY()]]$POMYPlot
    }
  })
  
  output$POMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearPOMY()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPOMY()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearPOMY()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPOMY()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POMYfinalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObject$POResultsTableMY), rownames = FALSE, 
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
  
  output$POMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearPOMYV2()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPOMYV2()]]$POMYPlot
    }
  })
  
  output$POMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearPOMYV2()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPOMYV2()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearPOMYV2()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPOMYV2()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POMYfinalPriceTableV2 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$POMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearPOMYV3()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPOMYV3()]]$POMYPlot
    }
  })
  
  output$POMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearPOMYV3()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPOMYV3()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearPOMY3()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPOMYV3()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POMYfinalPriceTableV3 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$POMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearPOMYV4()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPOMYV4()]]$POMYPlot
    }
  })
  
  output$POMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearPOMYV4()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPOMY4()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearPOMYV4()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPOMYV4()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POMYfinalPriceTableV4 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$POMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearPOMYV5()]]$POMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearPOMYV5()]]$POMYPlot
    }
  })
  
  output$POMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearPOMYV5()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearPOMYV5()]]$`PO Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$POMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearPOMYV5()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearPOMYV5()]]$`PO Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$POMYfinalPriceTableV5 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
      Corn_CropYearObjects[[yearTSMY()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSMY()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearTSMY()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSMY()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSMY()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSMY()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObject$TSResultsTableMY), rownames = FALSE, 
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
      Corn_CropYearObjects[[yearTSMYV2()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV2[[yearTSMYV2()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV2 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearTSMYV2()]]$`TS Storage MY`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV2[[yearTSMYV2()]]$`TS Storage MY`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSMYsummaryTablesV2 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSMYV2()]]$`TS Sales Summary MY`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[yearTSMYV2()]]$`TS Sales Summary MY`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV2 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
      Corn_CropYearObjects[[yearTSMYV3()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsV3[[yearTSMYV3()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTablesV3 = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearTSMYV3()]]$`TS Storage MY`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsV3[[yearTSMYV3()]]$`TS Storage MY`), rownames = FALSE,
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSMYsummaryTablesV3 = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSMYV3()]]$`TS Sales Summary MY`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsV3[[yearTSMYV3()]]$`TS Sales Summary MY`), rownames = FALSE,
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSMYV4()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSMYV4()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearTSMYV4()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSMYV4()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSMYV4()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSMYV4()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV4 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSMYV5()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSMYV5()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearTSMYV5()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSMYV5()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSMYV5()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSMYV5()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV5 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSMYV3Base()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSMYV3Base()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearTSMYV3Base()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSMYV3Base()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSMYV3Base()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSMYV3Base()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3Base = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSMYV3V2()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSMYV3V2()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearTSMYV3V2()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSMYV3V2()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSMYV3V2()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSMYV3V2()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3V2 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSMYV3V3()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSMYV3V3()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearTSMYV3V3()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSMYV3V3()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSMYV3V3()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSMYV3V3()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3V3 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSMYV3V4()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSMYV3V4()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearTSMYV3V4()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSMYV3V4()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSMYV3V4()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSMYV3V4()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3V4 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
  
  output$TSMYdistPlot <- renderPlot({
    if (input$cropType == "Corn"){
      Corn_CropYearObjects[[yearTSMYV3V5()]]$TSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearTSMYV3V5()]]$TSMYPlot
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearTSMYV3V5()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearTSMYV3V5()]]$`TS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearTSMYV3V5()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearTSMYV3V5()]]$`TS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  output$TSMYfinalPriceTableV3V5 = renderDataTable({
    if (input$cropType == "Corn"){
      NULL
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
      Corn_CropYearObjects[[yearSSMY()]]$SSMYPlot
    }
    else if (input$cropType == "Soybeans"){
      Soybean_CropYearObjectsBase[[yearSSMY()]]$SSMYPlot
    }
  })
  
  output$SSMYstorageTables = renderDataTable({
    if(input$cropType == "Corn") {
      as.datatable(getTables(Corn_CropYearObjects[[yearSSMY()]]$`SS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if(input$cropType == "Soybeans") {
      as.datatable(getTables(Soybean_CropYearObjectsBase[[yearSSMY()]]$`SS Storage MY`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$SSMYsummaryTables = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getSalesTable(Corn_CropYearObjects[[yearSSMY()]]$`SS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[yearSSMY()]]$`SS Sales Summary MY`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$SSMYfinalPriceTable = renderDataTable({
    if (input$cropType == "Corn"){
      as.datatable(getFirstSummaryTable(finalizedPriceObject$SSResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Seasonal Sales", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "Soybeans"){
      as.datatable(getFirstSummaryTable(finalizedPriceObjectSoybeanBase$SSResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Seasonal Sales", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
})

shinyApp(ui = ui,server = server)