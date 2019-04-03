#
# This is a Shiny App that shows the weight of different Chicks based on the weight and the diet that they receive.
# This App will allow the user determine what maximum Age and Weight they would like to view in the graph.
# It will allo the user the following parameters:
# 1. Select the X axis to be used in the plot.
# 2. Select the Y axis to be used in the plot.
# 3. Filter by Diet to display a table with Chicks that follow that diet.
# 4. Select points in the graph to be able to get the slope and intercept (the minimum points selected must be 3)

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("ChickWeight Data"),
  
  sidebarLayout(
     sidebarPanel(
        h3("Choose your parameters"),
  
      selectInput("diet", "Diet:",
                   c("Diet 1" = "1",
                     "Diet 2" = "2",
                     "Diet 3" = "3",
                     "Diet 4" = "4")),
      
      radioButtons("x", "Select X-axis:",
                   list("weight"='weight', "Time"='Time', "Chick"='Chick', "Diet"='Diet')),
      radioButtons("y", "Select Y-axis:",
                   list("Time"='Time',"weight"='weight', "Chick"='Chick', "Diet"='Diet' )),
      
      h3("Slope"),
        h5("Weight vs Time"),
       textOutput("slopeOut"),
       h3("Intercept"),
       h5("Weight vs TIme"),
       textOutput("intOut"),
      
       submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      plotOutput("plotChickWeight",brush="brushweight"),
      fluidRow(
              column(width=5,tags$b(tags$i("Full Dataset")),tableOutput("dataset")),
              column(width=5,tags$b(tags$i("Dataset Filtered by Diet")),tableOutput("dataDiet"))
           
      )
 
    )
  )
))
