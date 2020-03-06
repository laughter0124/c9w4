#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyServer(function(input, output) {
        
        # create data frame
        dates <- c(as.Date("2/13/20", format = "%m/%d/%y"):as.Date("3/5/20", format = "%m/%d/%y"))
        dates <- as.Date(dates, origin = "1970-01-01")
        cases <- c(15, 15, 15, 15, 15, 16, 16, 17, 35, 35, 35, 53, 57, 60, 60, 66, 71, 91, 107, 130, 162, 234)
        COVID <- data.frame(dates, cases)
        
        cumcases <- reactive({
                datesInput <- input$slider
                COVID$cases[COVID$dates==datesInput]
        })
        newcases <- reactive({
                datesInput <- input$slider
                ifelse(datesInput==as.Date("2/13/20", format = "%m/%d/%y"), 0, COVID$cases[COVID$dates==datesInput]-COVID$cases[COVID$dates==datesInput-1])
        })

        output$plot <- renderPlot({
                datesInput <- input$slider
                plot(COVID, xlab = "date", 
                     ylab = "cases", bty = "n", pch = 16, ylim = c(0, 250))
                if(input$showcum){
                        lines(COVID, type = "l", col = "blue", lwd = 2)
                }
                new<-cases-cases[c(1, 1:21)]
                points(dates, new, bty="n", pch=10)
                if(input$shownew){
                        lines(dates, new, type="l", col = "red", lwd = 2)
                }
                legend("topleft", c("new cases", "cumulative cases"), pch = 16, col = c("red", "blue"), bty = c("n", "o"), cex = 1.2)
                points(datesInput, newcases(), col = "red", pch = 16, cex = 2)
                points(datesInput, cumcases(), col = "blue", pch = 16, cex = 2)
        })
        
        output$newcases <- renderText({
                newcases()
        })
        
        output$cumcases <- renderText({
                cumcases()
        })
        
})