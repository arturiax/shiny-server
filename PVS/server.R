
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




shinyServer(function(input, output, session) {
  
  base<-read_csv2("/home/art/shiny-server/PVS/pruevashiny.csv")
  data=data.frame(x=c(43.13, 43.24), y=c(-2.54,-2.91), id=c("place1", "place2"))
  
  
  data_of_click <- reactiveValues(clickedMarker=NULL)
  observeEvent(input$map_marker_click,{
    data_of_click$clickedMarker <- input$map_marker_click
  })
  
  
  output$plot=renderPlot({
    my_place=data_of_click$clickedMarker$id
    if(is.null(my_place)){my_place="place1"}
    if(my_place=="place1"){
      plot(rnorm(1000), col=rgb(0.9,0.4,0.1,0.3), cex=3, pch=20)
    }else{
      barplot(rnorm(10), col=rgb(0.1,0.4,0.9,0.3))
    }    
  })

  
  jj<- readRDS("/home/art/shiny-server/PVS/base")
  jj$direc_corta <- gsub(", Spain","", jj$formatted_address)
  jj$popup <- paste(sep = "<br/>",paste0("<b>",jj$nombre,"</b>"),jj$direc_corta)
  icons <- awesomeIcons(
    icon = "medkit",
    iconColor = 'black',
    library = 'fa',
    markerColor = ifelse(rownames(jj) %in% c(1,2,6), "blue", "green")
  )
  
  
  
  output$mymap <- renderLeaflet({
   leaflet(jj) %>%
      setView(lat=43, lng=-2.3, zoom=4)  %>% 
    addTiles() %>%  # Add default OpenStreetMap map tiles
   addAwesomeMarkers(lng=~long, lat=~lat, icon = icons, popup=~popup, label=~nombre) 
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