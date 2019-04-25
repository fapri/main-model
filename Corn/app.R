
# Code I used to save the objects
# saveRDS(list(mcvfinal,polypc1),file="polypc.rds")


library(shiny)
library(DT)
library(htmltools)
library(formattable)

appObjects = readRDS("appObjects.rds")
Corn_CropYearObjects = appObjects[[1]]
Corn_CropYears = appObjects[[2]]

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
  navbarPage("Corn Marketing Strategies",
             navbarMenu("Price Objective",
               tabPanel("Base Model",         
                      fluidPage(
                        # titlePanel("Corn: Price Objective"),
                        
                        fluidRow(
                          plotOutput('distPlot'),
                          style = "padding-bottom:50px"
                        ),
                          
                          
                        tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                        
                        sidebarLayout(
                          sidebarPanel(
                            fluidRow(selectInput('yearPO','Crop Year', choices = u.n, width = "25%"),
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
               tabPanel("New Model",
                        titlePanel("Future Models"))
             ),
             tabPanel("Trailing Stop",         
                      fluidPage(
                       
                        fluidRow(
                          plotOutput('TSdistPlot'),
                          style = "padding-bottom:50px"
                        ),
                        
                        tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                        
                        sidebarLayout(
                          sidebarPanel(
                            fluidRow(selectInput('yearTS','Crop Year', choices = u.n, width = "25%"),
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
             tabPanel("Seasonal Sales",         
                      fluidPage(
                        
                        fluidRow(
                          plotOutput('SSdistPlot'),
                          style = "padding-bottom:50px"
                        ),
                        
                        tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                        
                        sidebarLayout(
                          sidebarPanel(
                            fluidRow(selectInput('yearSS','Crop Year', choices = u.n, width = "25%"),
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
             )
      )
  )

server <- shinyServer(function(input,output,session){
  output$distPlot <- renderPlot({
    if (input$yearPO == "2008-09") {
      Corn_CropYearObjects[[1]]$POPlot
    }
    
    else if (input$yearPO == "2009-10") {
      Corn_CropYearObjects[[2]]$POPlot
    }
    
    else if (input$yearPO == "2010-11") {
      Corn_CropYearObjects[[3]]$POPlot
    }
    
    else if (input$yearPO == "2011-12") {
      Corn_CropYearObjects[[4]]$POPlot
    }
    
    else if (input$yearPO == "2012-13") {
      Corn_CropYearObjects[[5]]$POPlot
    }
    
    else if (input$yearPO == "2013-14") {
      Corn_CropYearObjects[[6]]$POPlot
    }
    
    else if (input$yearPO == "2014-15") {
      Corn_CropYearObjects[[7]]$POPlot
    }
    
    else if (input$yearPO == "2015-16") {
      Corn_CropYearObjects[[8]]$POPlot
    }
    
    else if (input$yearPO == "2016-17" ) {
      Corn_CropYearObjects[[9]]$POPlot
    }
  })
  
  output$storageTables = renderDataTable({
    if (input$yearPO == "2008-09") {
      as.datatable(getTables(Corn_CropYearObjects[[1]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2009-10") {
      as.datatable(getTables(Corn_CropYearObjects[[2]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2010-11") {
      as.datatable(getTables(Corn_CropYearObjects[[3]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2011-12") {
      as.datatable(getTables(Corn_CropYearObjects[[4]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2012-13") {
      as.datatable(getTables(Corn_CropYearObjects[[5]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2013-14") {
      as.datatable(getTables(Corn_CropYearObjects[[6]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2014-15") {
      as.datatable(getTables(Corn_CropYearObjects[[7]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2015-16") {
      as.datatable(getTables(Corn_CropYearObjects[[8]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2016-17" ) {
      as.datatable(getTables(Corn_CropYearObjects[[9]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$summaryTables = renderDataTable({
    if (input$yearPO == "2008-09") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2009-10") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2010-11") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2011-12") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2012-13") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2013-14") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2014-15") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2015-16") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearPO == "2016-17" ) {
      as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  
  #############################
  #TRAILING STOP
  #############################
  
  
  output$TSdistPlot <- renderPlot({
    if (input$yearTS == "2008-09") {
      Corn_CropYearObjects[[1]]$TSPlot
    }
    
    else if (input$yearTS == "2009-10") {
      Corn_CropYearObjects[[2]]$TSPlot
    }
    
    else if (input$yearTS == "2010-11") {
      Corn_CropYearObjects[[3]]$TSPlot
    }
    
    else if (input$yearTS == "2011-12") {
      Corn_CropYearObjects[[4]]$TSPlot
    }
    
    else if (input$yearTS == "2012-13") {
      Corn_CropYearObjects[[5]]$TSPlot
    }
    
    else if (input$yearTS == "2013-14") {
      Corn_CropYearObjects[[6]]$TSPlot
    }
    
    else if (input$yearTS == "2014-15") {
      Corn_CropYearObjects[[7]]$TSPlot
    }
    
    else if (input$yearTS == "2015-16") {
      Corn_CropYearObjects[[8]]$TSPlot
    }
    
    else if (input$yearTS == "2016-17" ) {
      Corn_CropYearObjects[[9]]$TSPlot
    }
  })
  
  output$TSstorageTables = renderDataTable({
    if (input$yearTS == "2008-09") {
      as.datatable(getTables(Corn_CropYearObjects[[1]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2009-10") {
      as.datatable(getTables(Corn_CropYearObjects[[2]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2010-11") {
      as.datatable(getTables(Corn_CropYearObjects[[3]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2011-12") {
      as.datatable(getTables(Corn_CropYearObjects[[4]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2012-13") {
      as.datatable(getTables(Corn_CropYearObjects[[5]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2013-14") {
      as.datatable(getTables(Corn_CropYearObjects[[6]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2014-15") {
      as.datatable(getTables(Corn_CropYearObjects[[7]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2015-16") {
      as.datatable(getTables(Corn_CropYearObjects[[8]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2016-17" ) {
      as.datatable(getTables(Corn_CropYearObjects[[9]]$`TS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$TSsummaryTables = renderDataTable({
    if (input$yearTS == "2008-09") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2009-10") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2010-11") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2011-12") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2012-13") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2013-14") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2014-15") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2015-16") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearTS == "2016-17" ) {
      as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`TS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  ############################
  #SEASONAL SALES
  ############################
  
  
  output$SSdistPlot <- renderPlot({
    if (input$yearSS == "2008-09") {
      Corn_CropYearObjects[[1]]$SSPlot
    }
    
    else if (input$yearSS == "2009-10") {
      Corn_CropYearObjects[[2]]$SSPlot
    }
    
    else if (input$yearSS == "2010-11") {
      Corn_CropYearObjects[[3]]$SSPlot
    }
    
    else if (input$yearSS == "2011-12") {
      Corn_CropYearObjects[[4]]$SSPlot
    }
    
    else if (input$yearSS == "2012-13") {
      Corn_CropYearObjects[[5]]$SSPlot
    }
    
    else if (input$yearSS == "2013-14") {
      Corn_CropYearObjects[[6]]$SSPlot
    }
    
    else if (input$yearSS == "2014-15") {
      Corn_CropYearObjects[[7]]$SSPlot
    }
    
    else if (input$yearSS == "2015-16") {
      Corn_CropYearObjects[[8]]$SSPlot
    }
    
    else if (input$yearSS == "2016-17" ) {
      Corn_CropYearObjects[[9]]$SSPlot
    }
  })
  
  output$SSstorageTables = renderDataTable({
    if (input$yearSS == "2008-09") {
      as.datatable(getTables(Corn_CropYearObjects[[1]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2009-10") {
      as.datatable(getTables(Corn_CropYearObjects[[2]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2010-11") {
      as.datatable(getTables(Corn_CropYearObjects[[3]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2011-12") {
      as.datatable(getTables(Corn_CropYearObjects[[4]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2012-13") {
      as.datatable(getTables(Corn_CropYearObjects[[5]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2013-14") {
      as.datatable(getTables(Corn_CropYearObjects[[6]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2014-15") {
      as.datatable(getTables(Corn_CropYearObjects[[7]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2015-16") {
      as.datatable(getTables(Corn_CropYearObjects[[8]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2016-17" ) {
      as.datatable(getTables(Corn_CropYearObjects[[9]]$`SS Storage`), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
  
  output$SSsummaryTables = renderDataTable({
    if (input$yearSS == "2008-09") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2009-10") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2010-11") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2011-12") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2012-13") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2013-14") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2014-15") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2015-16") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$yearSS == "2016-17" ) {
      as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`SS Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
  })
})

shinyApp(ui=ui,server = server)
