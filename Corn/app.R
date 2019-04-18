library(shiny)
library(DT)
library(htmltools)
library(formattable)


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
             tabPanel("Price Objective",         
                      fluidPage(
                        # titlePanel("Corn: Price Objective"),
                        
                        dataTableOutput('summaryTables'),
                        
                        tags$style(type="text/css", '#summaryTables tfoot {display:none;}'),
                        
                        sidebarLayout(
                          sidebarPanel(
                            fluidRow(selectInput('year','Crop Year', choices = u.n),
                                     column(12, dataTableOutput('storageTables')),
                                     tags$style(type="text/css", '#storageTables tfoot {display:none;}'))
                            
                          ),
                          
                          mainPanel(
                            plotOutput('distPlot')
                          )
                          
                        )
                      )
                      
             ),
             tabPanel("Trailing Stop",         
                      fluidPage(
                        titlePanel("Future Work")
                      )
                        
             ),
             tabPanel("Seasonal Sales",         
                      fluidPage(
                        titlePanel("Future Work")
                      )
                      
             )
             
  )
)


server <- shinyServer(function(input,output,session){
  
  output$distPlot <- renderPlot({
    
    if (input$year == "2008-09") {
      Corn_CropYearObjects[[1]]$Plot
    }
    
    else if (input$year == "2009-10") {
      Corn_CropYearObjects[[2]]$Plot
    }
    
    else if (input$year == "2010-11") {
      Corn_CropYearObjects[[3]]$Plot
    }
    
    else if (input$year == "2011-12") {
      Corn_CropYearObjects[[4]]$Plot
    }
    
    else if (input$year == "2012-13") {
      Corn_CropYearObjects[[5]]$Plot
    }
    
    else if (input$year == "2013-14") {
      Corn_CropYearObjects[[6]]$Plot
    }
    
    else if (input$year == "2014-15") {
      Corn_CropYearObjects[[7]]$Plot
    }
    
    else if (input$year == "2015-16") {
      Corn_CropYearObjects[[8]]$Plot
    }
    
    else if (input$year == "2016-17" ) {
      Corn_CropYearObjects[[9]]$Plot
    }
    
    
  })
  
  output$storageTables = renderDataTable({
    
    if (input$year == "2008-09") {
      as.datatable(getTables(Corn_CropYearObjects[[1]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2009-10") {
      as.datatable(getTables(Corn_CropYearObjects[[2]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2010-11") {
      as.datatable(getTables(Corn_CropYearObjects[[3]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2011-12") {
      as.datatable(getTables(Corn_CropYearObjects[[4]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2012-13") {
      as.datatable(getTables(Corn_CropYearObjects[[5]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2013-14") {
      as.datatable(getTables(Corn_CropYearObjects[[6]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2014-15") {
      as.datatable(getTables(Corn_CropYearObjects[[7]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2015-16") {
      as.datatable(getTables(Corn_CropYearObjects[[8]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2016-17" ) {
      as.datatable(getTables(Corn_CropYearObjects[[9]]$Storage), rownames = FALSE, 
                   caption = tags$caption("Storage Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
  })
  
  output$summaryTables = renderDataTable({
    
    if (input$year == "2008-09") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2009-10") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[2]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2010-11") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[3]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2011-12") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[4]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2012-13") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[5]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2013-14") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[6]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2014-15") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[7]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2015-16") {
      as.datatable(getSalesTable(Corn_CropYearObjects[[8]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
    else if (input$year == "2016-17" ) {
      as.datatable(getSalesTable(Corn_CropYearObjects[[9]]$`Sales Summary`), rownames = FALSE, 
                   caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
    }
    
  })
})


shinyApp(ui=ui,server = server)


