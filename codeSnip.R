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



##################################################################################

output$TSsummaryTablesV2 = renderDataTable({
  if (input$cropType == "Corn"){
    as.datatable(getSalesTable(Corn_CropYearObjects[[1]]$`TS Sales Summary`), rownames = FALSE,
                 caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
  }
  else if (input$cropType == "Soybeans"){
    as.datatable(getSalesTable(Soybean_CropYearObjectsV2[[1]]$`TS Sales Summary`), rownames = FALSE,
                 caption = tags$caption("Sales Summary", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
  }
})

###################################################################################



output$TSfinalPriceTableV2 = renderDataTable({
  if (input$cropType == "Corn"){
    NULL
  }
  else if (input$cropType == "Soybeans"){
    as.datatable(getRemainingSummaryTables(finalizedPriceObjectSoybeanV2$TSResultsTable[,2:3]), rownames = FALSE,
                 caption = tags$caption("Trailing Stop V2", style = "color:#c90e0e; font-weight:bold; font-size:150%; text-align:center;"), options = list(dom = 't'))
  }
})