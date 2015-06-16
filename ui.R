fluidPage(
    # Application title
    titlePanel("Word Analysis of Mark Twain Novels"),
    
    sidebarLayout(
        # Sidebar with a slider and selection inputs
        sidebarPanel(
            selectInput("selection", "Choose a book:",
                        choices = books),
            actionButton("update", "Change"),
            hr(),
            sliderInput("freq",
                        "Minimum Frequency:",
                        min = 1,  max = 30, value = 15),
            sliderInput("max",
                        "Maximum Number of Words:",
                        min = 1,  max = 300,  value = 100)
        ),
        
        # Show Word Cloud and Histogram
        mainPanel(
            helpText("Below are the Word Cloud and Histogram representations
                    of text in several Mark Twain novels."),
            
            tabsetPanel(
                tabPanel("Plot", plotOutput("plot")), 
                tabPanel("Histogram", plotOutput("histogram"))
            ),
            helpText("Details on this Shiny App can be found here")
        )
    )
)