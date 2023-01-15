
library(shiny)

TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

fluidPage(
          navbarPage(theme = "sandstone","WQD7001 - Group 11 Project App",
                     
                     tabPanel("Home",
                              # Page header
                              headerPanel('Solar Radiation Forecasting using SVM'),
                              # Input values
                              sidebarPanel(
                                HTML("<h3>Input meteorological parameters</h4>"),
                                sliderInput("temperature", label = "24 Hour Mean Temperature (°C)", value = 30.5,
                                            min = 0,
                                            max = 100),
                                sliderInput("humidity", label = "24 Hour Mean Relative Humidity (%)", value = 75.5,
                                            min = 0,
                                            max = 100),
                                sliderInput("wind", label = "24 Hour Mean Wind (m/s)", value = 1.5,
                                            min = min(TrainSet$wind),
                                            max = max(TrainSet$wind)),
                                sliderInput("msl_pressure", label = "Mean MSL Pressure(Hpa)", value = 1010.8,
                                            min = min(TrainSet$msl_pressure),
                                            max = max(TrainSet$msl_pressure)),
                                
                                actionButton("submitbutton", "Submit", class = "btn btn-primary")
                              ),
                              
                              mainPanel(
                                tags$label(h3('Forecast Status & Output')), # Status/Output Text Box
                                verbatimTextOutput('contents'),
                                tableOutput('tabledata') # Prediction results table
                              )
                              
                     ),
                     
     
          )
)
