
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


shinyUI(
  dashboardPage(
    dashboardHeader(title = "PVS"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("PVS", tabName = "finger", icon = icon("info-circle")),
        menuItem("Población estudio", tabName = "Poblacion", icon = icon("male")),
        menuItem("Resultados encuesta", icon = icon("bar-chart"), tabName = "resulta")
      )),
    
   dashboardBody(
    tabItems( 
      tabItem(tabName="finger", 
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
              column(8,leafletOutput("map", height="600px")),
              column(4,br(),br(),br(),br(),plotOutput("plot"))
             
      ),
      
      
      tabItem(tabName = "Poblacion",
      fluidRow(        
        
        box(status="primary", 
              radioButtons("sexo", "Sexo",
                   choices = list("Todos" = 1, "Hombres" = 2, "Mujeres" = 3), 
                   selected = 1)
          ),
        
      
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
      
      hr(),
      
      #fluidRow(                # Dynamic valueBoxes
       # valueBoxOutput("puntos"),     valueBoxOutput("riesgo")      )      ),
      
     
    tabItem(tabName ="resulta", 
    # Show a plot of the generated distribution
 
   
      plotOutput('plot1')
      #h4("El número de puntos es:"),
      #h1(textOutput("punt"))
    )
   )
  )
))))

