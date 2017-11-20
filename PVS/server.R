
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
library(lubridate)

base<-read_delim("/home/art/shiny-server/PVS/pruevashiny.csv", ";", escape_double = FALSE, locale = locale(date_names = "es", date_format = " %d/%m/%Y"), trim_ws = TRUE)
#base<-read_delim("/media/Datos/Data_science/Mis proyectos/shiny-server/PVS/pruevashiny.csv", ";", escape_double = FALSE, locale = locale(date_names = "es", date_format = " %d/%m/%Y"), trim_ws = TRUE)

base<-base[!is.na(base$Sexo),]

base$grupo <-ifelse(base$grupo=="Control","Control", "Intervención")

jj<- readRDS("/home/art/shiny-server/PVS/base")
#jj<- readRDS("/media/Datos/Data_science/Mis proyectos/shiny-server/PVS/base") 

data=data.frame(x=jj$long, y=jj$lat, id=c("ELORRIO", "BOLUETA", "LANDAKO", "OTXARKOAGA", "ETXEBARRI", "ARRIGORRIAGA"), nombre=jj$nombre)
consultantes<-base %>% group_by(UAP) %>% summarise(n=n())
consul<-base %>% group_by(UAP, Sexo) %>% summarise(n=n())


shinyServer(function(input, output, session) {
  
 
  
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
      ggvis(~waiting, ~eruptions, fill := input_radiobuttons(label= "Choose tamaño:", choices=  c("black", "red", "blue", "green") ) )%>%
      layer_points()
    
  })
  
  vis %>% bind_shiny("plot2", "gg_ui")
  
  
  output$plot3 <-  renderPlot({
    
    if(input$estra1==1) p<- ggplot(base, aes(x=UAP, fill=UAP))
    else if(input$estra1==2) p<- ggplot(base, aes(x=Sexo, fill=Sexo))
    else if(input$estra1==3) p<- ggplot(base, aes(x=grupo, fill=grupo))
    else if(input$estra1==4) p<- ggplot(base, aes(x=edad, fill=edad))
    
    p<- p +
      geom_bar(stat="count") +
      ylab("N") +
      theme_light()+
      scale_x_discrete(breaks=NULL)
    
    if(input$estra2==2) p<- p + facet_grid(~UAP)
    else if(input$estra2==3) p<- p + facet_grid(~Sexo)
    else if(input$estra2==4) p<- p + facet_grid(~grupo)
    else if(input$estra2==5) p<- p + facet_grid(~edad)
    
    print(p)
  })
  
  output$plot4 <-  renderPlot({

    if (input$estra5==2) base<-base %>% filter(UAP=="ARRIGORRIAGA")
    else if (input$estra5==3) base<-base %>% filter(UAP=="BOLUETA")
    else if (input$estra5==4) base<-base %>% filter(UAP=="LANDAKO")
    
    if (input$estra6==2) base<-base %>% filter(Sexo=="Hombre")
    else if (input$estra6==3) base<-base %>% filter(Sexo=="Mujer")
    
    
    
      p<- ggplot(base, aes(x=UAP)) +
      geom_bar(stat="count") +
      ylab("N") +
      xlab("Centro")+
      theme_light()+
      scale_x_discrete(breaks=NULL)  
       
      print(p)
 })
 
})