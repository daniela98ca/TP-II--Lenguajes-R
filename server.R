

library(shiny)
library(ggplot2)
library(magrittr)
library(DT)

#Server = Funcionalidades 
server <- function(input, output) {
  
  #Variable que lee los datos del archivo "BlackFriday"
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
  registrosCompletos<- nrow(TodoRegistros) #Cantidad total de todos los registros
  cantidadRegistros<- nrow(registros) #Cantidad de todos los registros completos
  
  
 #Para generar las estadisticas 
#Genera una tabla con los datos de la variable elegida segun el numero   
  output$sum<- renderPrint({
    if (input$instate==1){
      table(datos$Gender)
    }
    else if (input$instate==2){
      table(datos$Age)
    }
    else if(input$instate==3){
      table(datos$City_Category)
    }
    else if (input$instate==4){
      table(datos$Stay_In_Current_City_Years)
    }
    else if (input$instate==5){
      table(datos$Marital_Status)
    }
    else if (input$instate==6){
      summary(datos$Purchase)
    }
  })
  
#Generar la tabla de los registros 
  #Tiene como salida la cantidad de registros totales
  #Y la cantidad total de registros completos
  output$registro <- renderText({
  registrosCompletos
  })
  
#Para generar los datos segun el "N" que el usuario ingrese
#el input$entradas recibe el numero "N" del numericInput, 
#este se va a utilizar para generar la tabla
output$valores <- renderDataTable({ 
  TodoRegistros[1:input$entradas, ]})


 
#Para generar el histograma  
#se basa en los numeros asignados a las variables seleccionadas
#ggplot es la libreria que permite generar el histograma 
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
    ggplot(datos, aes(datos$Purchase))+geom_histogram(fill="pink", colour="black")
  }

  })
  
#Para generar los graficos boxplot
  output$box<- renderPlot({
    if(input$opciones==1){ #Si elige usar el boxplot
      if(input$instate==1 && input$botones==1){ #Si elige el grafico en forma vertical
        ggplot(datos, (aes(datos$Gender)))+ geom_bar()+facet_grid(datos$Gender ~.)
      }
      else if(input$instate==1 && input$botones==2){ #si elige el grafico en forma horizontal
        ggplot(datos, (aes(datos$Gender)))+ geom_bar()+facet_grid(. ~datos$Gender)
      }
      else if(input$instate==2 && input$botones==1){ #Si elige el grafico en forma vertical
        ggplot(datos, (aes(datos$Age)))+ geom_bar()+facet_grid(datos$Age ~.)
      }
      else if(input$instate==2 && input$botones==2){ #Si elige el grafico en forma horizontal
        ggplot(datos, (aes(datos$Age)))+ geom_bar()+facet_grid(. ~datos$Age)
      }
      else if (input$instate==3  && input$botones==1){ #Si elige el grafico en forma vertical
        ggplot(datos, (aes_string(datos$City_Category)))+geom_histogram()+facet_grid(datos$City_Category~ .)
      }
      else if(input$instate==3 && input$botones==2){ #Si elige el grafico en forma horizontal
        ggplot(datos, (aes_string(datos$City_Category)))+ geom_histogram()+facet_grid(. ~datos$City_Category)
      }
      else if(input$instate==4  && input$botones==1){ #Si elige el grafico en forma vertical
        ggplot(datos, (aes(datos$Stay_In_Current_City_Years)))+ geom_bar()+facet_grid(datos$Stay_In_Current_City_Years ~.)
      }
      else if(input$instate==4 && input$botones==2){ #Si elige el grafico en forma horizontal
        ggplot(datos, (aes(datos$Stay_In_Current_City_Years)))+ geom_bar()+facet_grid(. ~datos$Stay_In_Current_City_Years)
      }
      else if(input$instate==5  && input$botones==1){ #Si elige el grafico en forma vertical
        ggplot(datos, (aes(datos$Marital_Status)))+ geom_bar()+facet_grid(datos$Marital_Status ~.)
      }
      else if(input$instate==5  && input$botones==2){ #Si elige el grafico en forma horizontal
        ggplot(datos, (aes(datos$Marital_Status)))+ geom_bar()+facet_grid(. ~datos$Marital_Status)
      }
      else if(input$instate==6  && input$botones==1){ #Si elige el grafico en forma vertical
        ggplot(datos, (aes(datos$Purchase)))+ geom_histogram(binwidth=6)+facet_grid(datos$Purchase ~.)
      }
      else if(input$instate==6  && input$botones==2){ #Si elige el grafico en forma horizontal
        ggplot(datos, (aes(datos$Purchase)))+ geom_histogram(binwidth=6)+facet_grid(. ~datos$Purchase)
      }
    }
    
    #Si decide usar los histogramas
    else if(input$opciones==2){ 
      if(input$instate==1){ 
        ggplot(datos, (aes(datos$Gender)))+ geom_bar()
      }

      else if(input$instate==2){ 
        ggplot(datos, (aes(datos$Age)))+ geom_bar()
      }

      else if (input$instate==3){
        ggplot(datos, (aes(datos$City_category)))+geom_bar()
      }

      else if(input$instate==4){ 
        ggplot(datos, (aes(datos$Stay_In_Current_City_Years)))+ geom_bar()
      }

      else if(input$instate==5){ 
        ggplot(datos, (aes(datos$Marital_Status)))+ geom_bar()
      }

      else if(input$instate==6){ 
        ggplot(datos, (aes(datos$Purchase)))+ geom_histogram()
      }}
      
    })
  
#Para generar las consultas
  output$Mytable<- DT::renderDataTable({
    if (input$sexo == 1){
      Purchase <- TodoRegistros[TodoRegistros$purchase >= input$monto & TodoRegistros$gender == "F",]
    }
    else if(input$sexo == 2){
      Purchase <- TodoRegistros[TodoRegistros$purchase >= input$monto & TodoRegistros$gender == "M",]
    }
    
    purchaseData<- data.frame(Purchase)
    DT::datatable(purchaseData, options = list(lengthMenu = c(10),5))
  })
  

  }
  
  

  
  
  
  

  
  
  
  

    
  
