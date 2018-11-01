library(shiny)

plotsPanel <- tabPanel(
    title='Plots',
    fluidRow(
        column(
            width=4,
            selectInput(
                inputId='ColumnName',
                label='Choose a column',
                choices=names(mtcars)
            ),
            sliderInput(
                inputId='NumBins',
                label='Choose the number of bins',
                min=5, max=50, value=25
            )
        ),
        column(
            width=8,
            plotOutput(
                outputId='CarHistogram'
            )
        )
    )
)

navbarPage(
    title='My First Shiny App',
    selected='Plots',
    tabPanel(
        title='Legend of Zelda',
        'An adventure to save the world from an evil warmonger'
    ),
    tabPanel(
        title='A Link to the Past',
        'It happened again'
    ),
    plotsPanel
)
