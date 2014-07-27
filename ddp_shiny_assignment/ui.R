library(shiny)

shinyUI(fluidPage( theme = "bootstrap.css",
    
    # Application title
    titlePanel("Simulate Distributions"),
    
    # Sidebar with dropbox, slider, input box,checkbox
    sidebarLayout(
        sidebarPanel(
            selectInput("distType", "Distribution Type", choices = c("Normal", "Uniform", "Exponential")),
            sliderInput("bins", "Number of bins:",min = 5, max = 40,value = 20),
            numericInput("npoints", "Number of data points:", 5000, min=2000, max=10000, step=100),         
            checkboxInput("showdensity", "Plot density", value = TRUE),
            br(),
            helpText(                
                p(paste("The app demonstrates the Normal, Uniform, and Exponential distributions. ")),
                h4("Usage"),                
                tags$ol(
                    tags$li("Select the distribution type"),
                    tags$li("Select the number of bins"),
                    tags$li("Select number of data points (2000 to 10000)"),
                    tags$li("Check 'Plot density' option if desired")
                )
            )
        ),
        
        # main panel   
        mainPanel(
            textOutput("summaryTitle"), 
            verbatimTextOutput("summary"),
            plotOutput("plot")
        )
    )
)
)
