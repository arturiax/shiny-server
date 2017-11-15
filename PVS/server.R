
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
library(leaflet)


addr<-list("Elorrio", "Bolueta", "Landako", "Otxarkoaga", "Etxebarri", "Arrigorriaga")

addr<-paste0("Centro de salud ", addr)
lugar <-  ", Basque Country, Spain"


addresses <- lapply(addr, paste0, lugar)

getGeoDetails <- function(address){   
  #use the gecode function to query google servers
  geo_reply = geocode(address, output='all', messaging=TRUE, override_limit=TRUE)
  #now extract the bits that we need from the returned list
  answer <- data.frame(lat=NA, long=NA, accuracy=NA, formatted_address=NA, address_type=NA, status=NA)
  answer$status <- geo_reply$status
  
  #return Na's if we didn't get a match:
  if (geo_reply$status != "OK"){
    return(answer)
  }   
  
  #else, extract what we need from the Google server reply into a dataframe:
  answer$lat <- geo_reply$results[[1]]$geometry$location$lat
  answer$long <- geo_reply$results[[1]]$geometry$location$lng   
  if (length(geo_reply$results[[1]]$types) > 0){
    answer$accuracy <- geo_reply$results[[1]]$types[[1]]
  }
  answer$address_type <- paste(geo_reply$results[[1]]$types, collapse=',')
  answer$formatted_address <- geo_reply$results[[1]]$formatted_address
  
  return(answer)
}

getGeoDetails(addr)

do.call(rbind, lapply(addresses, getGeoDetails))->bas
bas$nombre <- addr
jj<-bas
jj$direc_corta <- gsub("Bilbo, Bizkaia, Spain","", jj$formatted_address)
jj$popup <- paste(sep = "<br/>",paste0("<b>",jj$nombre,"</b>"),jj$direc_corta)
icons <- awesomeIcons(
  icon = ifelse(jj$accuracy== "bar", 'fa-beer', "fa-shopping-bag"),
  iconColor = 'black',
  library = 'fa',
  markerColor = "blue"
)

shinyServer(function(input, output, session) {
  
  base<-read_csv2("/home/art/shiny-server/PVS/pruevashiny.csv")
  
  
  
  
  
  #output$mymap <- renderLeaflet({
   # leaflet(jj) %>%
    #  addTiles() %>%  # Add default OpenStreetMap map tiles
     # addAwesomeMarkers(lng=~long, lat=~lat, icon = icons, popup=~popup, label=~nombre) 
  #})
  
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