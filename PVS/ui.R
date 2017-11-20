
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinythemes)
library(shinydashboard)
library(readr)
library(leaflet)
library(ggvis)


shinyUI(
  dashboardPage(
    dashboardHeader(title = "PVS"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("PVS", tabName = "pvs", icon = icon("info-circle")),
        menuItem("Población estudio", tabName = "Poblacion", icon = icon("male")),
        menuItem("Resultados encuesta", icon = icon("bar-chart"), tabName = "resulta")
      )),
    
   dashboardBody(
    tabItems( 
      tabItem(tabName="pvs", 
              h1("PROGRAMA PRESCRIBE VIDA SALUDABLE"),
              hr(),
              h4("El programa vida saludable PVS , bla blab bla bla bla bla bla ................
                 dsafsdafsdafasdfasdf sdfdasfsdafasdfasd
                 sdfsdafasdfasd
                 sdfasdfasdfasd
                 asdfasdfasdf
                 asdfasdfasdf/n
                 dsfdasfasdfdasfasdfasdfa
                   dsfsafasdfdasfads/n
                     adfdasfdasfads "),
              hr(),
              column(8,leafletOutput("map", height="500px")),
              column(4,br(),br(),br(),br(),valueBoxOutput("box")),
              hr(),
              column(4,valueBoxOutput("box1")),
              column(4,valueBoxOutput("box2"))
                           
      ),
      
      
      tabItem(tabName = "Poblacion",
      fluidRow(   
        h2("Gráfico población estudio PVS"),
        
        box(status="primary", 
              radioButtons("estra1", "Estratificar por:", choices = list("Centros" = 1, "Sexo" = 2, "Grupo" = 3, "Edad"=4), 
                   selected = 1)),
        hr(),
        box(status="primary", 
            radioButtons("estra2", "Estratificar también por:", choices = list("Nada" =  1, "Centros" = 2, "Sexo" = 3, "Grupo" = 4, "Edad"=5), 
                         selected = 1)),
        hr(),
        column(6,plotOutput("plot3"))
      )
        
      
      #box(title="Utilización año previo", status="primary", 
       # radioButtons("ingresos", "Ingresos Hospital",
        #           choices = list("0" = 1, "1" = 2, "2" = 3, "3" = 4, "4+" = 5), 
         #          selected = 1),
      #  hr(),
       # checkboxInput("urgencias", label = "Al menos una visita urgencias", value = F),
        #hr(),
        #checkboxInput("dialisis", label = "Diálisis crónica", value = F)
      #)
      
      #box(status="success", 
       # actionButton("limpia", label = "Empezar de nuevo", color="blue", icon = icon("refresh"), style='padding:10px; font-size:130%')
      #)
      
      # ),
      
           #fluidRow(                # Dynamic valueBoxes
       # valueBoxOutput("puntos"),     valueBoxOutput("riesgo")      )      ),
      
      ),
    tabItem(tabName ="resulta", 
    # Show a plot of the generated distribution
 
    fluidRow( 
      h2("Grafico alcance del programa"),
      plotOutput('plot1') )
      #h4("El número de puntos es:"),
      #h1(textOutput("punt"))
    
   )
  )
)))

