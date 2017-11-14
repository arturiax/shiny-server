
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinythemes)
library(shinydashboard)


shinyUI(
  dashboardPage(
    dashboardHeader(title = "FINGER"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("FINGER", tabName = "finger", icon = icon("info-circle")),
        menuItem("Paciente individual", tabName = "paci_uni", icon = icon("male")),
        menuItem("Resultados", icon = icon("bar-chart"), tabName = "resulta")
      )),
    
   dashboardBody(
    tabItems( 
      tabItem(tabName="finger", 
              h1("Sistema de estratificación FINGER"),
              hr(),
              h4("El sistema de estratificación FINGER, bla blab bla bla bla bla bla ................
                 dsafsdafsdafasdfasdf sdfdasfsdafasdfasd
                 sdfsdafasdfasd
                 sdfasdfasdfasd
                 asdfasdfasdf
                 asdfasdfasd
                 ")
              
              
      ),
      
      
      tabItem(tabName = "paci_uni",
      fluidRow(        
        box(status="primary", 
          checkboxGroupInput("cronicas",
                             "Patologías:",
                             choices = list(
                               "Metástasis" = 1,
                               "Neoplasia Maligna" = 2,
                               "ICC" = 3,
                               "EPOC" = 4,
                               "Otras Enf Vasculares" = 5,
                               "Otras Enf Cardiacas" = 6,
                               "Enf Sangre y org hematopoyéticos" = 7,
                               "Diabetes Mellitus" = 8,
                               "Abuso de alcohol y sustancias" = 9,
                               "Accidente Cerebrovascular" = 10,
                               "Esquizofrenia y psicosis" = 11,
                               "Enf Aparato Digestivo" = 12,
                               "HTA" = 13,
                               "Asma" = 14,
                               "Enf Sistema Nervioso" = 15,
                               "Enf Org Sentidos" = 16,
                               "Enf Musculoesqueleticas" = 17,
                               "Enf Piel y tejido subcutaneo" = 18,
                               "Anomalías Congénitas" =19,
                               "Otras Enf Mentales" = 20,
                               "Enf Sistema Genitourinario" = 21,
                               "Otras Enf Sistema Endocrino" = 22,
                               "Miscelánea" = 23),
                             
                             selected = NULL)
        ),
        box(status="primary", 
        sliderInput("age",
                  "Edad:",
                  min = 0,
                  max = 100,
                  value = 40),
      
      radioButtons("sexo", "Sexo",
                   choices = list("Hombre" = 1, "Mujer" = 2), 
                   selected = 1)
          ),
      
      box(title="Utilización año previo", status="primary", 
        radioButtons("ingresos", "Ingresos Hospital",
                   choices = list("0" = 1, "1" = 2, "2" = 3, "3" = 4, "4+" = 5), 
                   selected = 1),
        hr(),
        checkboxInput("urgencias", label = "Al menos una visita urgencias", value = F),
        hr(),
        checkboxInput("dialisis", label = "Diálisis crónica", value = F)
      ),
      
      box(status="success", 
        actionButton("limpia", label = "Empezar de nuevo", color="blue", icon = icon("refresh"), style='padding:10px; font-size:130%')
      )
      
       ),
      
      hr(),
      
      fluidRow(
       
                # Dynamic valueBoxes
        valueBoxOutput("puntos"),
        
        valueBoxOutput("riesgo")
      )
      
      
      ),
      
     
    tabItem(tabName ="resulta", 
    # Show a plot of the generated distribution
 
   
      plotOutput('plot1'),
      h4("El número de puntos es:"),
      h1(textOutput("punt"))
    )
   )
  )
))
