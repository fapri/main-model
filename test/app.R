library(shiny)
library(plotly)

ui = shinyUI(pageWithSidebar(
    headerPanel("Dynamic number of plots"),
    sidebarPanel(
        sliderInput(inputId = "weekNum",
                    label = "Choose a week",
                    min = 1,
                    max = 10,
                    value = 1)
    ),
    mainPanel(
        plotlyOutput("plots")
    )
)
)
server = shinyServer(function(input, output) {
    week <- reactive({
       switch(input$weekNum,
             "1" = 1,
             "2" = 2,
             "3" = 3,
             "4" = 4,
             "5" = 5,
             "6" = 6,
             "7" = 7,
             "8" = 8,
             "9" = 9,
             "10" = 10)
    })
    output$plots <- renderPlotly({
        p = plots[[week()]]
        ggplotly(p) %>%
            layout(height = 900, autosize = TRUE)
    })
})
shinyApp(ui = ui, server = server)

































