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

u.n <-  Corn_CropYears$CropYear
names(u.n) <- u.n

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
                        selectInput("cropType", "",
                                    c("Corn" = "corn",
                                      "Soybeans" = "soybean"), width = "33%")
                        )
                        )
                      )
             ),
             navbarMenu("Price Objective",
                        tabPanel("Base Model",         
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
                        tabPanel("Multi-Year",
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
                        )
             ),
             navbarMenu("Trailing Stop",
                        tabPanel("Base Model",         
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
                        tabPanel("Multi-Year",
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
                        tabPanel("Base Model V2",
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
                        tabPanel("Multi-Year V2",
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
                        )
             ),
             navbarMenu("Seasonal Sales",
                        tabPanel("Base Model",         
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
                        tabPanel("Multi-Year",
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
                        # splitLayout(cellWidths = c("33%", "33%", "33%"), dataTableOutput("finalPriceTable"), 
                        #             dataTableOutput("TSfinalPriceTable"), dataTableOutput("SSfinalPriceTable")),
                        # splitLayout(cellWidths = "33%", align="center", dataTableOutput("TSfinalPriceTableV2")),
                        # tags$div(class="title", titlePanel("With Multi-Year Sales")),
                        # splitLayout(cellWidths = c("33%", "33%", "33%"), dataTableOutput("POMYfinalPriceTable"), 
                        #             dataTableOutput("TSMYfinalPriceTable"), dataTableOutput("SSMYfinalPriceTable")),
                        # 
                        # # tags$div(class="title", titlePanel("Without Multi-Year Sales")),
                        # # splitLayout(dataTableOutput("TSfinalPriceTableV2"),
                        # # tags$div(class="title", titlePanel("With Multi-Year Sales")),
                        # splitLayout(cellWidths = "33%", align="center", dataTableOutput("TSMYfinalPriceTableV2"))
                        
                        
                        fluidRow(
                          #Change column(x, for desired width
                          column(12,
                                 tags$div(class="title", titlePanel("Without Multi-Year Sales")),
                                 div(style = "display: inline-block; width: 33%;", dataTableOutput("finalPriceTable"), height=150, width=150),
                                 div(style = "display: inline-block; width: 33%;", dataTableOutput("TSfinalPriceTable"), height=150, width=150),
                                 div(style = "display: inline-block; width: 33%;", dataTableOutput("SSfinalPriceTable"), height=150, width=150),
                                 tags$div(class = "table", dataTableOutput("TSfinalPriceTableV2")),
                                 tags$div(class="title", titlePanel("With Multi-Year Sales")),
                                 div(style = "display: inline-block; width: 33%;", dataTableOutput("POMYfinalPriceTable"), height=150, width=150),
                                 div(style = "display: inline-block; width: 33%;", dataTableOutput("TSMYfinalPriceTable"), height=150, width=150),
                                 div(style = "display: inline-block; width: 33%;", dataTableOutput("SSMYfinalPriceTable"), height=150, width=150),
                                 div(style = "display: inline-block; width: 33%;", dataTableOutput("TSMYfinalPriceTableV2"), height=150, width=150)))
                        
                        
                      )
             ),
             tabPanel("About Our Strategies",
                      fluidPage(
                        fluidRow(column(12, includeHTML("index.html")
                        )
                        
                        )
                      ))
  )
)

server <- shinyServer(function(input,output,session){
  
  
  #################################################################################################
  # Price Objective
  #################################################################################################
  
  
  output$distPlot <- renderPlot({
    if (input$yearPO == "2008-09"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[1]]$POPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[1]]$POPlot
      }
    }
    
    else if (input$yearPO == "2009-10"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[2]]$POPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[2]]$POPlot
      }
    }
    
    else if (input$yearPO == "2010-11"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[3]]$POPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[3]]$POPlot
      }
    }
    
    else if (input$yearPO == "2011-12"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[4]]$POPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[4]]$POPlot
      }
    }
    
    else if (input$yearPO == "2012-13"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[5]]$POPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[5]]$POPlot
      }
    }
    
    else if (input$yearPO == "2013-14"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[6]]$POPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[6]]$POPlot
      }
    }
    
    else if (input$yearPO == "2014-15"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[7]]$POPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[7]]$POPlot
      }
    }
    
    else if (input$yearPO == "2015-16"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[8]]$POPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[8]]$POPlot
      }
    }
    
    else if (input$yearPO == "2016-17"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[9]]$POPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[9]]$POPlot
      }
    }
  })
  
  output$storageTables = renderDataTable({
    if (input$yearPO == "2008-09"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[1]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[1]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2009-10"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[2]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[2]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2010-11"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[3]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[3]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2011-12"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[4]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[4]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2012-13"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[5]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[5]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2013-14"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[6]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[6]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2014-15"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[7]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[7]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2015-16"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[8]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[8]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2016-17"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[9]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[9]]$`PO Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$summaryTables = renderDataTable({
    if (input$yearPO == "2008-09") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[1]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2009-10") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[2]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2010-11") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[3]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2011-12") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[4]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2012-13") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[5]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2013-14") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[6]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2014-15") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[7]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2015-16") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[8]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPO == "2016-17") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[9]]$`Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$finalPriceTable = renderDataTable({
    if (input$cropType == "corn"){
      as.datatable(getTables(finalizedPriceObject$POResultsTable), rownames = FALSE, 
                   caption = tags$caption("Price Objective", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "soybean"){
      as.datatable(getTables(finalizedPriceObjectSoybeanBase$POResultsTable), rownames = FALSE, 
                   caption = tags$caption("Price Objective", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  #################################################################################################
  # Trailing Stop
  #################################################################################################
  
  
  output$TSdistPlot <- renderPlot({
    if (input$yearTS == "2008-09"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[1]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[1]]$TSPlot
      }
    }
    
    else if (input$yearTS == "2009-10"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[2]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[2]]$TSPlot
      }
    }
    
    else if (input$yearTS == "2010-11"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[3]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[3]]$TSPlot
      }
    }
    
    else if (input$yearTS == "2011-12"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[4]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[4]]$TSPlot
      }
    }
    
    else if (input$yearTS == "2012-13"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[5]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[5]]$TSPlot
      }
    }
    
    else if (input$yearTS == "2013-14"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[6]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[6]]$TSPlot
      }
    }
    
    else if (input$yearTS == "2014-15"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[7]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[7]]$TSPlot
      }
    }
    
    else if (input$yearTS == "2015-16"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[8]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[8]]$TSPlot
      }
    }
    
    else if (input$yearTS == "2016-17"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[9]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[9]]$TSPlot
      }
    }
  })
  
  output$TSstorageTables = renderDataTable({
    if (input$yearTS == "2008-09"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[1]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[1]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2009-10"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[2]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[2]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2010-11"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[3]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[3]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2011-12"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[4]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[4]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2012-13"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[5]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[5]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2013-14"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[6]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[6]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2014-15"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[7]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[7]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2015-16"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[8]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[8]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2016-17"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[9]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[9]]$`TS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$TSsummaryTables = renderDataTable({
    if (input$yearTS == "2008-09") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[1]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2009-10") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[2]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2010-11") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[3]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2011-12") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[4]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2012-13") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[5]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2013-14") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[6]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2014-15") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[7]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2015-16") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[8]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTS == "2016-17") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[9]]$`TS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$TSfinalPriceTable = renderDataTable({
    if (input$cropType == "corn"){
      as.datatable(getTables(finalizedPriceObject$TSResultsTable), rownames = FALSE, 
                   caption = tags$caption("Trailing Stop", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "soybean"){
      as.datatable(getTables(finalizedPriceObjectSoybeanBase$TSResultsTable), rownames = FALSE, 
                   caption = tags$caption("Trailing Stop", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  #################################################################################################
  # Trailing Stop VERSION 2
  #################################################################################################
  
  
  output$TSdistPlotV2 <- renderPlot({
    if (input$yearTSV2 == "2008-09"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[1]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[1]]$TSPlot
      }
    }

    else if (input$yearTSV2 == "2009-10"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[2]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[2]]$TSPlot
      }
    }

    else if (input$yearTSV2 == "2010-11"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[3]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[3]]$TSPlot
      }
    }

    else if (input$yearTSV2 == "2011-12"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[4]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[4]]$TSPlot
      }
    }

    else if (input$yearTSV2 == "2012-13"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[5]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[5]]$TSPlot
      }
    }

    else if (input$yearTSV2 == "2013-14"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[6]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[6]]$TSPlot
      }
    }

    else if (input$yearTSV2 == "2014-15"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[7]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[7]]$TSPlot
      }
    }

    else if (input$yearTSV2 == "2015-16"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[8]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[8]]$TSPlot
      }
    }

    else if (input$yearTSV2 == "2016-17"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[9]]$TSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[9]]$TSPlot
      }
    }
  })

  output$TSstorageTablesV2 = renderDataTable({
    if (input$yearTSV2 == "2008-09"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[1]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[1]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2009-10"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[2]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[2]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2010-11"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[3]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[3]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2011-12"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[4]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[4]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2012-13"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[5]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[5]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2013-14"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[6]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[6]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2014-15"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[7]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[7]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2015-16"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[8]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[8]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2016-17"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[9]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[9]]$`TS Storage`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })

  output$TSsummaryTablesV2 = renderDataTable({
    if (input$yearTSV2 == "2008-09") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[1]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2009-10") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[2]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2010-11") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[3]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2011-12") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[4]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2012-13") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[5]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2013-14") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[6]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2014-15") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[7]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2015-16") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[8]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSV2 == "2016-17") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[9]]$`TS Sales Summary`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })

  output$TSfinalPriceTableV2 = renderDataTable({
    if (input$cropType == "corn"){
      NULL
    }
    else if (input$cropType == "soybean"){
      as.datatable(getTables(finalizedPriceObjectSoybeanV2$TSResultsTable), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales
  #################################################################################################
  
  
  output$SSdistPlot <- renderPlot({
    if (input$yearSS == "2008-09"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[1]]$SSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[1]]$SSPlot
      }
    }
    
    else if (input$yearSS == "2009-10"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[2]]$SSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[2]]$SSPlot
      }
    }
    
    else if (input$yearSS == "2010-11"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[3]]$SSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[3]]$SSPlot
      }
    }
    
    else if (input$yearSS == "2011-12"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[4]]$SSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[4]]$SSPlot
      }
    }
    
    else if (input$yearSS == "2012-13"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[5]]$SSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[5]]$SSPlot
      }
    }
    
    else if (input$yearSS == "2013-14"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[6]]$SSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[6]]$SSPlot
      }
    }
    
    else if (input$yearSS == "2014-15"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[7]]$SSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[7]]$SSPlot
      }
    }
    
    else if (input$yearSS == "2015-16"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[8]]$SSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[8]]$SSPlot
      }
    }
    
    else if (input$yearSS == "2016-17"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[9]]$SSPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[9]]$SSPlot
      }
    }
  })
  
  output$SSstorageTables = renderDataTable({
    if (input$yearSS == "2008-09"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[1]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[1]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2009-10"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[2]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[2]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2010-11"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[3]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[3]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2011-12"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[4]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[4]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2012-13"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[5]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[5]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2013-14"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[6]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[6]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2014-15"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[7]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[7]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2015-16"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[8]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[8]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2016-17"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[9]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[9]]$`SS Storage`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$SSsummaryTables = renderDataTable({
    if (input$yearSS == "2008-09") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[1]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2009-10") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[2]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2010-11") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[3]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2011-12") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[4]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2012-13") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[5]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2013-14") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[6]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2014-15") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[7]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2015-16") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[8]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSS == "2016-17") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[9]]$`SS Sales Summary`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$SSfinalPriceTable = renderDataTable({
    if (input$cropType == "corn"){
      as.datatable(getTables(finalizedPriceObject$SSResultsTable), rownames = FALSE, 
                   caption = tags$caption("Seasonal Sales", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "soybean"){
      as.datatable(getTables(finalizedPriceObjectSoybeanBase$SSResultsTable), rownames = FALSE, 
                   caption = tags$caption("Seasonal Sales", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  #################################################################################################
  # Price Objective With Multi Year
  #################################################################################################
  
  
  output$POMYdistPlot <- renderPlot({
    if (input$yearPOMY == "2008-09"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[1]]$POMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[1]]$POMYPlot
      }
    }
    
    else if (input$yearPOMY == "2009-10"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[2]]$POMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[2]]$POMYPlot
      }
    }
    
    else if (input$yearPOMY == "2010-11"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[3]]$POMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[3]]$POMYPlot
      }
    }
    
    else if (input$yearPOMY == "2011-12"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[4]]$POMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[4]]$POMYPlot
      }
    }
    
    else if (input$yearPOMY == "2012-13"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[5]]$POMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[5]]$POMYPlot
      }
    }
    
    else if (input$yearPOMY == "2013-14"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[6]]$POMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[6]]$POMYPlot
      }
    }
    
    else if (input$yearPOMY == "2014-15"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[7]]$POMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[7]]$POMYPlot
      }
    }
    
    else if (input$yearPOMY == "2015-16"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[8]]$POMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[8]]$POMYPlot
      }
    }
    
    else if (input$yearPOMY == "2016-17"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[9]]$POMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[9]]$POMYPlot
      }
    }
  })
  
  output$POMYstorageTables = renderDataTable({
    if (input$yearPOMY == "2008-09"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[1]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[1]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2009-10"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[2]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[2]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2010-11"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[3]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[3]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2011-12"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[4]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[4]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2012-13"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[5]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[5]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2013-14"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[6]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[6]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2014-15"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[7]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[7]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2015-16"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[8]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[8]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2016-17"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[9]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[9]]$`PO Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$POMYsummaryTables = renderDataTable({
    if (input$yearPOMY == "2008-09") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[1]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2009-10") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[2]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2010-11") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[3]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2011-12") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[4]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2012-13") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[5]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2013-14") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[6]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2014-15") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[7]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2015-16") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[8]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearPOMY == "2016-17") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[9]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$POMYfinalPriceTable = renderDataTable({
    if (input$cropType == "corn"){
      as.datatable(getTables(finalizedPriceObject$POResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Price Objective", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "soybean"){
      as.datatable(getTables(finalizedPriceObjectSoybeanBase$POResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Price Objective", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  #################################################################################################
  # Trailing Stop With Multi Year
  #################################################################################################
  
  
  output$TSMYdistPlot <- renderPlot({
    if (input$yearTSMY == "2008-09"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[1]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[1]]$TSMYPlot
      }
    }
    
    else if (input$yearTSMY == "2009-10"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[2]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[2]]$TSMYPlot
      }
    }
    
    else if (input$yearTSMY == "2010-11"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[3]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[3]]$TSMYPlot
      }
    }
    
    else if (input$yearTSMY == "2011-12"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[4]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[4]]$TSMYPlot
      }
    }
    
    else if (input$yearTSMY == "2012-13"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[5]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[5]]$TSMYPlot
      }
    }
    
    else if (input$yearTSMY == "2013-14"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[6]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[6]]$TSMYPlot
      }
    }
    
    else if (input$yearTSMY == "2014-15"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[7]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[7]]$TSMYPlot
      }
    }
    
    else if (input$yearTSMY == "2015-16"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[8]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[8]]$TSMYPlot
      }
    }
    
    else if (input$yearTSMY == "2016-17"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[9]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[9]]$TSMYPlot
      }
    }
  })
  
  output$TSMYstorageTables = renderDataTable({
    if (input$yearTSMY == "2008-09"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[1]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[1]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2009-10"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[2]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[2]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2010-11"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[3]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[3]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2011-12"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[4]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[4]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2012-13"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[5]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[5]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2013-14"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[6]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[6]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2014-15"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[7]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[7]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2015-16"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[8]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[8]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2016-17"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[9]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[9]]$`TS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$TSMYsummaryTables = renderDataTable({
    if (input$yearTSMY == "2008-09") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[1]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2009-10") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[2]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2010-11") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[3]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2011-12") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[4]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2012-13") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[5]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2013-14") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[6]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2014-15") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[7]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2015-16") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[8]]$`TS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearTSMY == "2016-17") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[9]]$`PO Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$TSMYfinalPriceTable = renderDataTable({
    if (input$cropType == "corn"){
      as.datatable(getTables(finalizedPriceObject$TSResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Trailing Stop", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "soybean"){
      as.datatable(getTables(finalizedPriceObjectSoybeanBase$TSResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Trailing Stop", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  #################################################################################################
  # Trailing Stop With Multi Year VERSION 2
  #################################################################################################
  
  
  output$TSMYdistPlotV2 <- renderPlot({
    if (input$yearTSMYV2 == "2008-09"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[1]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[1]]$TSMYPlot
      }
    }

    else if (input$yearTSMYV2 == "2009-10"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[2]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[2]]$TSMYPlot
      }
    }

    else if (input$yearTSMYV2 == "2010-11"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[3]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[3]]$TSMYPlot
      }
    }

    else if (input$yearTSMYV2 == "2011-12"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[4]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[4]]$TSMYPlot
      }
    }

    else if (input$yearTSMYV2 == "2012-13"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[5]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[5]]$TSMYPlot
      }
    }

    else if (input$yearTSMYV2 == "2013-14"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[6]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[6]]$TSMYPlot
      }
    }

    else if (input$yearTSMYV2 == "2014-15"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[7]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[7]]$TSMYPlot
      }
    }

    else if (input$yearTSMYV2 == "2015-16"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[8]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[8]]$TSMYPlot
      }
    }

    else if (input$yearTSMYV2 == "2016-17"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[9]]$TSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsV2[[9]]$TSMYPlot
      }
    }
  })

  output$TSMYstorageTablesV2 = renderDataTable({
    if (input$yearTSMYV2 == "2008-09"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[1]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[1]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2009-10"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[2]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[2]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2010-11"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[3]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[3]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2011-12"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[4]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[4]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2012-13"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[5]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[5]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2013-14"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[6]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[6]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2014-15"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[7]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[7]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2015-16"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[8]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[8]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2016-17"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[9]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsV2[[9]]$`TS Storage MY`), rownames = FALSE,
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })

  output$TSMYsummaryTablesV2 = renderDataTable({
    if (input$yearTSMYV2 == "2008-09") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[1]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2009-10") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[2]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2010-11") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[3]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2011-12") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[4]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2012-13") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[5]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2013-14") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[6]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2014-15") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[7]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2015-16") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[8]]$`TS Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }

    else if (input$yearTSMYV2 == "2016-17") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`PO Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[9]]$`PO Sales Summary MY`), rownames = FALSE,
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })

  output$TSMYfinalPriceTableV2 = renderDataTable({
    if (input$cropType == "corn"){
      NULL
    }
    else if (input$cropType == "soybean"){
      as.datatable(getTables(finalizedPriceObjectSoybeanV2$TSResultsTableMY), rownames = FALSE,
                   caption = tags$caption("Trailing Stop V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  #################################################################################################
  # Seasonal Sales With Multi Year
  #################################################################################################
  
  
  output$SSMYdistPlot <- renderPlot({
    if (input$yearSSMY == "2008-09"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[1]]$SSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[1]]$SSMYPlot
      }
    }
    
    else if (input$yearSSMY == "2009-10"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[2]]$SSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[2]]$SSMYPlot
      }
    }
    
    else if (input$yearSSMY == "2010-11"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[3]]$SSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[3]]$SSMYPlot
      }
    }
    
    else if (input$yearSSMY == "2011-12"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[4]]$SSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[4]]$SSMYPlot
      }
    }
    
    else if (input$yearSSMY == "2012-13"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[5]]$SSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[5]]$SSMYPlot
      }
    }
    
    else if (input$yearSSMY == "2013-14"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[6]]$SSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[6]]$SSMYPlot
      }
    }
    
    else if (input$yearSSMY == "2014-15"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[7]]$SSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[7]]$SSMYPlot
      }
    }
    
    else if (input$yearSSMY == "2015-16"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[8]]$SSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[8]]$SSMYPlot
      }
    }
    
    else if (input$yearSSMY == "2016-17"){
      if (input$cropType == "corn"){
        Corn_CropYearObjects[[9]]$SSMYPlot
      }
      else if (input$cropType == "soybean"){
        Soybean_CropYearObjectsBase[[9]]$SSMYPlot
      }
    }
  })
  
  output$SSMYstorageTables = renderDataTable({
    if (input$yearSSMY == "2008-09"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[1]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[1]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2009-10"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[2]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[2]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2010-11"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[3]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[3]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2011-12"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[4]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[4]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2012-13"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[5]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[5]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2013-14"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[6]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[6]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2014-15"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[7]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[7]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2015-16"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[8]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[8]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2016-17"){
      if(input$cropType == "corn") {
        as.datatable(getTables(Corn_CropYearObjects[[9]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if(input$cropType == "soybean") {
        as.datatable(getTables(Soybean_CropYearObjectsBase[[9]]$`SS Storage MY`), rownames = FALSE, 
                     caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$SSMYsummaryTables = renderDataTable({
    if (input$yearSSMY == "2008-09") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[1]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2009-10") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[2]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2010-11") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[3]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2011-12") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[4]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2012-13") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[5]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2013-14") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[6]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2014-15") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[7]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2015-16") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[8]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
    
    else if (input$yearSSMY == "2016-17") {
      if (input$cropType == "corn"){
        as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
      else if (input$cropType == "soybean"){
        as.datatable(getSalesTable(Soybean_CropYearObjectsBase[[9]]$`SS Sales Summary MY`), rownames = FALSE, 
                     caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
      }
    }
  })
  
  output$SSMYfinalPriceTable = renderDataTable({
    if (input$cropType == "corn"){
      as.datatable(getTables(finalizedPriceObject$SSResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Seasonal Sales", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    else if (input$cropType == "soybean"){
      as.datatable(getTables(finalizedPriceObjectSoybeanBase$SSResultsTableMY), rownames = FALSE, 
                   caption = tags$caption("Seasonal Sales", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
})

shinyApp(ui = ui,server = server)