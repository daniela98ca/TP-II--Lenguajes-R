

library(shiny)
library(ggplot2)
library(magrittr)



  shinyUI(fluidPage(
    
    
    titlePanel(title= h3("Black Friday", align="center")),
    sidebarLayout(
      #siderbar panel
      sidebarPanel(
        selectInput("instate", "Seleccione una opcion:",choices = c("Gender"=1, 
                                                                "Age"=2,   
                                                                 "City_Category"=3,   
                                                                  "Stay_In_Current_City_Years"=4, 
                                                                  "Marital_Status"=5,
                                                                  "Purchase"=6))),
    #MAIN PANEL     
    mainPanel(
      tabsetPanel(type="tab",
                  tabPanel("Estadisticas", verbatimTextOutput("sum")),
                  tabPanel("Registros",tableOutput("registro")),
                  tabPanel("Datos Completos"),
                  tabPanel("Histograma",plotOutput("DatosData")),  
                  tabPanel("Graficos"),
                  tabPanel("Consultas")
      ))
  )))
        
      

      
  


