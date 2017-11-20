
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(readr)
library(leaflet)
library(ggmap)
library(dplyr)
library(ggvis)


shinyServer(function(input, output, session) {
  
  base<-read_csv2("/home/art/shiny-server/PVS/pruevashiny.csv")
  jj<- readRDS("/home/art/shiny-server/PVS/base")
  
  data=data.frame(x=jj$long, y=jj$lat, id=c("ELORRIO", "BOLUETA", "LANDAKO", "OTXARKOAGA", "ETXEBARRI", "ARRIGORRIAGA"), nombre=jj$nombre)
  consultantes<-base %>% group_by(UAP) %>% summarise(n=n())
  consul<-base %>% group_by(UAP, Sexo) %>% summarise(n=n())
  
  data_of_click <- reactiveValues(clickedMarker=NULL)
  
  
  observeEvent(input$map_marker_click,{
    data_of_click$clickedMarker <- input$map_marker_click
  })
  
  
  
  
  data$direc_corta <- gsub(", Spain","", jj$formatted_address)
  data$popup <- paste(sep = "<br/>",paste0("<b>",jj$nombre,"</b>"),jj$direc_corta)
  icons <- awesomeIcons(
    icon = "medkit",
    iconColor = 'black',
    library = 'fa',
    markerColor = ifelse(rownames(jj) %in% c(1,2,6), "blue", "green")
  )
  
  
  output$map <- renderLeaflet({
    leaflet() %>%
      setView(lat=43.2, lng=-2.8, zoom=11)  %>% 
      addTiles(options = providerTileOptions(noWrap = TRUE)) %>%  # Add default OpenStreetMap map tiles
      #addCircleMarkers(data=data, ~x , ~y, layerId=~id, popup=~id, radius=8 , color="black",  fillColor="red", stroke = TRUE, fillOpacity = 0.8)
    addAwesomeMarkers(data=data, ~x , ~y, layerId=~id, icon = icons, popup=~popup, label=~nombre) 
  })
  
  output$box=renderValueBox({
  my_place=data_of_click$clickedMarker$id
  if(is.null(my_place)){my_place="ELORRIO"}
   valueBox(consultantes$n[consultantes$UAP==my_place][1], "Consultantes", color="blue", width=5, icon=icon("user"))
   })

  output$box1=renderValueBox({
    my_place=data_of_click$clickedMarker$id
    if(is.null(my_place)){my_place="ELORRIO"}
    valueBox(consul$n[consul$UAP==my_place][1], "Hombres", color="red", width=5, icon=icon("male"))
  })
  
  output$box2=renderValueBox({
    my_place=data_of_click$clickedMarker$id
    if(is.null(my_place)){my_place="ELORRIO"}
    valueBox(consul$n[consul$UAP==my_place][2], "Mujeres", color="red", width=5, icon=icon("female"))
  })
  
  
  
  
  
 
  
 # 
 #output$puntos <- renderValueBox({
#   valueBox(puntosa(), "Puntos", icon = icon(iconpts()), color = colorpts(), width = 4)
 #  })
   
 #output$riesgo <- renderValueBox({
  #   valueBox(toppts(), "Riesgo" , icon = icon(iconpts()), color = colorpts(), width = 8)
  # })
 
 #observeEvent(input$limpia, {
  # updateSliderInput(session, "age", value = 40)
  # updateCheckboxGroupInput(session, "cronicas", selected = character(0))
  # # })
 
 #output$punt <- renderText({ puntosa()  })
 
  vis <- reactive({
  
    
    faithful %>%
      ggvis(~waiting, ~eruptions, fill := input_radiobuttons(label= "Choose color:", choices=  c("black", "red", "blue", "green") ) )%>%
      layer_points()
    
  })
  
  vis %>% bind_shiny("plot2", "gg_ui")
  
  output$plot1 <-  renderPlot({

    
    
    
      p<- ggplot(base, aes(x=UAP)) +
      geom_bar(stat="count") +
      ylab("N") +
      xlab("Centro")+
      theme_light()+
      scale_x_discrete(breaks=NULL)  
       
      print(p)
 })
 
})