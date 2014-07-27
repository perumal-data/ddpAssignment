library(shiny)

shinyServer(function(input, output, session) {
    
    randomData <- reactive({
        distFunc <- switch(input$distType,
                           "Normal" = rnorm,
                           "Uniform" = runif,
                           "Exponential" = rexp,
                           rnorm
        )
        bins <- input$bins
        nData <- ifelse(input$npoints < 500 || input$npoints > 10000, 1000, input$npoints)
        distFunc(nData)
    })
    
    showDensity <- reactive({as.logical(input$showdensity)})
    
    output$plot <- renderPlot({
        
        currData <- randomData()
        nData <- length(currData)
        distName <- input$distType
        bins <- input$bins
        
        thisHist <- hist(currData, breaks = bins)
        if (showDensity()) {
            multiplier <- thisHist$counts / thisHist$density
            thisDensity <- density(currData)
            thisDensity$y <- thisDensity$y * multiplier[1]
            tYLim <- c(0, max(max(thisHist$counts),max(thisDensity$y))) * 1.1
            plot(thisHist, main=paste(distName, " (", nData, " points)", sep=""), xlab = "", col="skyblue", border="darkblue", ylim=tYLim)      
            lines(thisDensity, col="red", lwd=2)
        } else
            plot(thisHist, main=paste(distName, " (", nData, " points)", sep=""), xlab = "", col="skyblue", border="darkblue")
        
        grid()
    })
    
    output$summaryTitle <- renderText({
        currData <- randomData()
        nData <- length(currData)
        distName <- input$distType
        paste("Random ", distName, " (", nData, " points)", sep="")    
    })
    
    output$summary <- renderPrint({
        currData <- randomData()
        print(summary(currData))
    })
    
})