#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Coronavirus Disease 2019 (COVID-19) in the U.S."),
  
  # Sidebar with a slider input for dates 
  sidebarLayout(
          sidebarPanel(
                  sliderInput("slider", "How many new cases of the day?", as.Date("2/13/20", format = "%m/%d/%y"), as.Date("3/5/20", format = "%m/%d/%y"), value = as.Date("2/13/20", format = "%m/%d/%y")),
                  checkboxInput("showcum", "Show/Hide cumulative line", value = TRUE),
                  checkboxInput("shownew", "Show/Hide new line", value = TRUE)
          ),
          mainPanel(
                  h1("Documentation"),
                  h5("To track an outbreak of respiratory disease caused by a novel (new) coronavirus that was first detected in China and which has now been detected in almost 70 locations internationally, including in the United States. The virus has been named “SARS-CoV-2” and the disease it causes has been named “coronavirus disease 2019” (abbreviated “COVID-19”)."),
                  h5("The cumulative data came from https://coronavirus.1point3acres.com/en.  From these data, we can calculate the new cases day by day to track the spread of the disease."),
                  plotOutput("plot"),
                  h3("number of cumulative cases:"),
                  textOutput("cumcases"),
                  h3("number of new cases:"),
                  textOutput("newcases"),
                  textOutput("l")
          )
  )
))