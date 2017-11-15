
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(readr)


shinyServer(function(input, output, session) {
  
  base<-read_csv2("/home/art/shiny-server/PVS/pruevashiny.csv")
  
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
   # })
 
 #output$punt <- renderText({ puntosa()  })
 
  
  output$plot1 <-  renderPlot({

    
    
    
      p<- ggplot(base, aes(1, y = nvisitas, fill = Personas)) +
      geom_bar(stat="identity") +
      ylab("Porcentaje") +
      xlab("")+
      theme_light()+
      scale_x_discrete(breaks=NULL) +
      expand_limits(y=c(0,100))
       
      print(p)
 })
 
})