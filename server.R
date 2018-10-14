

library(shiny)
library(ggplot2)
library(magrittr)

#Server = Funcionalidades 
server <- function(input, output) {
  datos<- read.csv("blackFriday.csv", header= TRUE, sep=";", stringsAsFactors = FALSE)
  datos<- na.omit(datos)

  
  
 #Para generar las estadisticas 
  output$sum<- renderPrint({
    summary(datos)
  })
 
  
#Generar la tabla de los registros   
  output$registro <- renderTable({
    head(datos)
    #Si se quiere visualizar solo una columna:
    #colm <- as.numeric(input$var)
    #iris[colm]
    
  })
 
#Para generar el histograma    
  output$DatosData <- renderPlot({
  colm<- as.numeric(input$instate)
  #El valor va iniciar desde 0 y va a llevar hasta el maximo de la columna
  hist(iris[,colm], breaks=seq(0, max(iris[,colm], l=input$bins+1)), col=input$Color, main="Histograma")
  
  #output$DatosData<- renderPlot({
    #hist(input$instate)
    #main=input$instate
    #ylab= "Datos"
    #xlab="Respuestas"
  })

    
  
  }
  
  
  
  

    
  
