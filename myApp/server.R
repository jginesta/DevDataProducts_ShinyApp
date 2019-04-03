#
# This is the server logic of a Shiny web application. We will be using the dataset ChickWeight for this App.
# This logic will do the following:
# 1. Calculate the slope and intercept based on the selected points on the graph.
# 2. Display the plot of Age vs Weight in Chicks with the x and y limitations inputted by the user.
# 3. Display a table with the full dataset on the left and a filtered table on the right that contains only the Chicks with
# the selected Diet chosen by the user.
#

library(shiny)
library(MASS)
library(RColorBrewer)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  data <- reactive({
          ChickWeight
  })
  

  modelChickWeight<-reactive({
          if(input$x=='weight'){
                  i<-1
          }
          
          if(input$x=='Time'){
                  i<-2
          }
          
          if(input$x=='Chick'){
                  i<-3
          }
          
          if(input$x=='Diet'){
                  i<-4
          }
          
          if(input$y=='weight'){
                  j<-1
          }
          
          if(input$y=='Time'){
                  j<-2
          }
          
          if(input$y=='Chick'){
                  j<-3
          }
          
          if(input$y=='Diet'){
                  j<-4
          }
         brushed_chickWeight<-brushedPoints(ChickWeight,input$brushweight, xvar=input$x ,yvar=input$y)
          
          if(nrow(brushed_chickWeight)<3){
                  return(NULL)
          }
         xaxis    <- ChickWeight[, i]
         yaxis    <- ChickWeight[, j]
          lm(weight~Time,data=brushed_chickWeight)
  })
  
  
  output$slopeOut<-renderText({
          if(is.null(modelChickWeight())){
                  "No Model Found"
          } else{
                  modelChickWeight()[[1]][[2]]
          }
          
  })
  
  output$intOut<-renderText({
          if(is.null(modelChickWeight())){
                  "No Model Found"
          } else{
                  modelChickWeight()[[1]][[1]]
          }
          
  })
  
  cols<-brewer.pal(n=4,name="Set1")
  cols_t1<-cols[ChickWeight$Diet]
  
  output$plotChickWeight <- renderPlot({
          if(input$x=='weight'){
                  i<-1
          }
          
          if(input$x=='Time'){
                  i<-2
          }
          
          if(input$x=='Chick'){
                  i<-3
          }
          
          if(input$x=='Diet'){
                  i<-4
          }
          
          if(input$y=='weight'){
                  j<-1
          }
          
          if(input$y=='Time'){
                  j<-2
          }
          
          if(input$y=='Chick'){
                  j<-3
          }
          
          if(input$y=='Diet'){
                  j<-4
          }
          
          xaxis    <- ChickWeight[, i]
          yaxis    <- ChickWeight[, j]
          
          plot(xaxis, yaxis, xlab = "X Axis",
               ylab = "Y Axis", main = "Variable Analysis in Chicks",
               cex = 1.2, pch = 16, bty = "n",col=ChickWeight$Diet)
          
          legend("topright",legend=unique(ChickWeight$Diet),col=1:length(ChickWeight$Diet),pch=16,bty="n",ncol=1,cex=0.7,pt.cex=0.7)
          
  })
  
  output$dataset <- renderTable({
          ChickWeight
  })
  
  output$dataDiet<-renderTable({
          ChickWeight[ChickWeight$Diet==input$diet,]
  })


})
