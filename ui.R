

library(shiny)
library(ggplot2)
library(magrittr)
library(DT)



  shinyUI(fluidPage(
    
    
    titlePanel(title= h2("Black Friday", align="center")),
    sidebarLayout(
      #siderbar panel
      sidebarPanel(
        #Genera el cuadro de opciones a elegir
        selectInput("instate", "Seleccione una opcion:",choices = c("Gender"=1, 
                                                                "Age"=2,   
                                                                 "City_Category"=3,   
                                                                  "Stay_In_Current_City_Years"=4, 
                                                                  "Marital_Status"=5,
                                                                  "Purchase"=6)),
      br(),
      helpText("Formatos para los graficos"),
      selectInput("opciones", "Seleccione el tipo de grafico:", 
                  choices=c("Boxplot"=1, "Histograma"=2)),
      radioButtons("botones", "Formatos:", choices = c("Vertical"=1, "Horizontal"=2)),
      br(),
      
      #Para generar los datos segun el "N" que el usuario ingrese
      #se llama con el nombre "valores" en el main panel
      helpText("Valor de N para los registros completos"),
      numericInput("entradas", "Valor de N:", 1, min=1, max=550069),
      br(),
      numericInput("obs", "Digite la cantidad de registros a listar:", 1, min = 1, max = 550068),
      verbatimTextOutput("value"),
      verbatimTextOutput("value1"),
      selectInput("sexo", "Seleccione una opcion:",choices = c("F"=1, 
                                                               "M"=2)),
      numericInput("monto", "Digite el monto de la compra:", 1, min = 1, max = 5000000),
      verbatimTextOutput("value2")
      
      #Para generar el textInput
      #Se llama con el nombre "consultas" en el main panel
      #textInput("compras", "Monto de la compra:", "" ),
      
      #Genera los botones de los generos del comprador
      #se llama con el nombre "sexos" en el main panel
      #radioButtons("generos", "Sexo del comprador:", choices = c("Femenino"=1, "Masculino"=2))
  ),
  
  
  
    #MAIN PANEL  
    #Se generan las diviciones en el panel central 
    mainPanel(
      tabsetPanel(type="tab",
                  tabPanel("Estadisticas", verbatimTextOutput("sum"),
                           verbatimTextOutput("marital") ),
                  tabPanel("Registros",tableOutput("registro")),
                  tabPanel("Datos Completos",dataTableOutput("valores")),
                  tabPanel("Histograma",plotOutput("DatosData")),  
                  tabPanel("Graficos", plotOutput("box")),
                  tabPanel("Consultas",DT::dataTableOutput("Mytable"))
      )))
  ))
        
      

      
  


