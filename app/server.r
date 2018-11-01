library(shiny)
library(ggplot2)

shinyServer(function(input, output, session){
    
    output$CarHistogram <- renderPlot(
        ggplot(mtcars, aes_string(x=input$ColumnName)) + 
            geom_histogram(bins=input$NumBins)
    )
    
})
