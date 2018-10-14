

library(shiny)
library(ggplot2)
library(magrittr)



  shinyUI(fluidPage(
    
    datos<- read.csv("blackFriday.csv", header= TRUE, sep=";", stringsAsFactors = FALSE),
    datos<- na.omit(datos),
    
    # UI = Interfaz 
    
    gender<- na.omit(factor(datos$Gender)),
  nuevoGender <- as.numeric(as.character(gender)),
    
    age <- na.omit(factor(datos$Age)),
    nuevoAge<- as.numeric(as.character(age)),
    
    purchase<- as.numeric(as.character(datos$Purchase)),
    cityC<- na.omit(factor(datos$City_Category)),
    nuevoCityC<- as.numeric(as.character(cityC)),
    
    maritalS<- as.numeric(as.character(datos$Marital_Status)),
    years<- na.omit(factor(datos$Stay_In_Current_City_Years)),
    nuevoYears <- as.numeric(as.character(years)),
    
    
    titlePanel(title= h4("Black Friday", align="center")),
    sidebarLayout(
      #siderbar panel
      sidebarPanel(
        selectInput("instate", "Seleccione una opcion:",choices = c("gender"= nuevoGender, 
                                                                "age"=nuevoAge, 
                                                                 "city_category"=nuevoCityC, 
                                                                  "stay_in_current_city_years"= nuevoYears, 
                                                                  "marital_status"=maritalS,
                                                                  "purchase"= purchase), 
        br(),
        sliderInput("bins", "2. Seleccione el numero para el histograma", min=5, max=25, value=15),
        br(),
        radioButtons("Color", "3. Seleccione el color del histograma", choices = c("Blue", "Yellow", "Pink"),selected= "Pink")
        
      )),
 #MAIN PANEL     
      mainPanel(
        tabsetPanel(type="tab",
                    tabPanel("Estadisticas", verbatimTextOutput("sum")),
                    tabPanel("Registros",tableOutput("registro")),
                    tabPanel("Datos Completos"),
                    tabPanel("Histograma", plotOutput("DatosData")), #plotOutput("myhist")
                    tabPanel("Graficos"),
                    tabPanel("Consultas")
                    )))
  ))


