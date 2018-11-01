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

mapPanel <- tabPanel(
    title='Pizza',
    fluidRow(
        column(
            width=6,
            DT::dataTableOutput(
                outputId='PizzaTable'
            )
        ),
        column(
            width=6,
            leaflet::leafletOutput(
                outputId='PizzaMap'
            )
        )
    )
)

navbarPage(
    title='My First Shiny App',
    selected='Pizza',
    tabPanel(
        title='Legend of Zelda',
        'An adventure to save the world from an evil warmonger',
        br(),
        actionButton(inputId='Gandolf', label='Grab the Triforce')
    ),
    tabPanel(
        title='A Link to the Past',
        'It happened again'
    ),
    plotsPanel,
    mapPanel
)
