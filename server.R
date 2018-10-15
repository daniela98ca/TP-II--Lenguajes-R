

library(shiny)
library(ggplot2)
library(magrittr)

#Server = Funcionalidades 
server <- function(input, output) {
  
  #Variable que llama al archivo "BlackFriday"
  datos<- read.csv("blackFriday.csv", header= TRUE, sep=";", stringsAsFactors = FALSE)
  
  #Se separan las columnas para convertilas en vectores
  user_ID <- c(datos[,1:1])
  product_ID <- c(datos[,2:2])
  gender <- c(datos[,3:3])
  age <- c(datos[,4:4])
  cityC <- c(datos[,5:5])
  years <- c(datos[,6:6]) 
  maritalS <- c(datos[,7:7])
  purchase <- c(datos[,8:8])
  
  #Se crea un data.frame con los vestores
  TodoRegistros<- data.frame(user_ID, product_ID, gender, age, cityC, years, maritalS, purchase)
  registros <- na.omit(TodoRegistros) #Eliminar los NA
  registrosCompletos<- nrow(TodoRegistros) #Cantidad total de los registros
  cantidadRegistros<- nrow(registros) #Cantidad de registros completos
  
  
 #Para generar las estadisticas 
  output$sum<- renderPrint({
    summary(datos)
  })
 
  
#Generar la tabla de los registros   
  output$registro <- renderPrint({
  
  })
 
#Para generar el histograma   
  output$DatosData<- renderPlot({ 
   if (input$instate== 1){
     ggplot(datos, aes(datos$Gender))+geom_bar()
   }
  else if(input$instate==2){
    ggplot(datos, aes(datos$Age))+geom_bar()
  }
  else if(input$instate==3){
      ggplot(datos, aes(datos$City_Category))+geom_bar()
    }
   else if(input$instate==4){
     ggplot(datos, aes(datos$Stay_In_Current_City_Years))+geom_bar()
   }
  else if(input$instate==5){
    ggplot(datos, aes(datos$Marital_Status))+geom_bar()
  }
  else if(input$instate==6){
    hist(datos$Purchase)
  }

  })

    
  
  }
  
  
  
  

    
  
