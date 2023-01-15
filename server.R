library(shiny)
library(shinythemes)
library(data.table)
library(e1071)

# Read in the RF model
model <- readRDS("model.rds")

shinyServer(function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    df <- data.frame(
      Name = c("temperature",
               "humidity",
               "wind",
               "msl_pressure"),
      Value = as.character(c(input$temperature,
                             input$humidity,
                             input$wind,
                             input$msl_pressure)),
      stringsAsFactors = FALSE)
    
    solar_radiation <- 0
    df <- rbind(df, solar_radiation)
    input <- transpose(df)
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    
    Output <- data.frame(Solar_Radiation_Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
    print(Output)['Solar_Radiation_Prediction']
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Solar Forecast Completed. Below the prediction of solar radiation (MJm-2): ") 
    } else {
      return("Server is ready for forecast.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
})