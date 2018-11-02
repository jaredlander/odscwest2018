library(shiny)
library(ggplot2)
library(magrittr)
library(leaflet)

pizza <- jsonlite::fromJSON('FavoriteSpots.json') %>% 
    tidyr::unnest()

shinyServer(function(input, output, session){
    
    # reactivePoll(intervalMillis=1000, session=sesession, checkFunc=function(x) file.info(x)$mtime, valueFunc=function(y) y*2)
    
    output$CarHistogram <- renderPlot(
        ggplot(mtcars, aes_string(x=input$ColumnName)) + 
            geom_histogram(bins=input$NumBins)
    )
    
    output$PizzaTable <- DT::renderDataTable({
        DT::datatable(pizza, rownames=FALSE)
    })
    
    output$PizzaMap <- renderLeaflet({
        withProgress(message='Creating the map', {
        leaflet() %>% 
            addTiles() %>% 
            addMarkers(
                lng = ~ longitude, lat = ~ latitude,
                popup= ~ Name,
                data=pizza
            )
        })
    })
    
})
