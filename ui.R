fluidPage(
    # Application title
    titlePanel("Word Analysis of Mark Twain Novels"),
    
    sidebarLayout(
        # Sidebar with a slider and selection inputs
        sidebarPanel(
            selectInput("selection", "Choose a book:",
                        choices = books),
            actionButton("update", "Select"),
            hr(),
            sliderInput("freq",
                        "Minimum Frequency:",
                        min = 1,  max = 30, value = 15),
            sliderInput("max",
                        "Maximum Number of Words:",
                        min = 1,  max = 300,  value = 10)
        ),
        
        # Show Word Cloud and Histogram
        mainPanel(
            helpText("Below are the Word Cloud and Histogram representations
                    of text in several Mark Twain novels."),
    
            tabsetPanel(
                tabPanel("Plot", plotOutput("plot")), 
                tabPanel("Histogram", plotOutput("histogram"))),
            
            helpText("Choose a novel by Mark Twain and press the Select button. After 
                    some processing time, a Word Cloud of the novel text will be created.
                    You can change the sliders and also look at the histogram of the
                    data as well."),
            
            helpText( a("Details/code on this Shiny App can be found here", 
                        href="https://github.com/slane2014/twain_analysis"))
            
        )
    )
)