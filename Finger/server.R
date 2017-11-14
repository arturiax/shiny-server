
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output, session) {
  
 puntosa <- function() {
   
   puntos <- 0
   val <- ifelse(input$age>=45,ifelse(input$age>=65,ifelse(input$age>=75,3,2),1),0)
   puntos <- puntos + val
   val <- ifelse(input$sexo == 1 & input$age>=70, 1, 0)
   puntos <- puntos + val
   val <- ifelse(1 %in% input$cronicas,10,0)
   puntos <- puntos + val
   val <- ifelse(2 %in% input$cronicas & !1 %in% input$cronicas,4,0)
   puntos <- puntos + val
   val <- sum(c(3,4) %in% input$cronicas)*4
   puntos <- puntos + val
   val <- sum(c(5,6) %in% input$cronicas)*3
   puntos <- puntos + val
   val <- sum(7:11 %in% input$cronicas)*2
   puntos <- puntos + val
   val <- sum(12:23 %in% input$cronicas)
   puntos <- puntos + val
   val <- ifelse(input$urgencias,1,0)
   puntos <- puntos + val
   val <- ifelse(input$dialisis,10,0)
   puntos <- puntos + val
   val <- ifelse(input$ingresos>3, ifelse(input$ingresos==5, 16, 8), 2*(as.numeric(input$ingresos)-1))
   puntos <- puntos + val
 }
 
 colorpts <- function() {
   pts <- puntosa()
   ifelse(pts>2, ifelse(pts>7, ifelse(pts>14, "red", "orange"), "yellow"), "green")
 } 
 
 iconpts <- function() {
   pts <-puntosa()
   paste0("thermometer-",ifelse(pts>2,ifelse(pts>7, ifelse(pts>14,"full","three-quarters"), "2"), "empty"))
}

 toppts <- function() {
   pts <-puntosa()
   ifelse(pts>2, ifelse(pts>7, ifelse(pts>14, "Muy alto (Top 1%)", "Alto (Top 5%)"), "Medio"), "Bajo")
 }
  
 output$puntos <- renderValueBox({
   valueBox(puntosa(), "Puntos", icon = icon(iconpts()), color = colorpts(), width = 4)
   })
   
 output$riesgo <- renderValueBox({
     valueBox(toppts(), "Riesgo" , icon = icon(iconpts()), color = colorpts(), width = 8)
   })
 
 observeEvent(input$limpia, {
   updateSliderInput(session, "age", value = 40)
   updateCheckboxGroupInput(session, "cronicas", selected = character(0))
   updateCheckboxInput(session, "urgencias", value = F)
   updateCheckboxInput(session, "dialisis", value = F)
   updateRadioButtons(session, "ingresos", selected = 1)
 
 })
 
 output$punt <- renderText({ puntosa()  })
 
  
  output$plot1 <-  renderPlot({

    
    base<-data.frame(Personas=c("Con menos riesgo"), y=100*puntosa()/15 )
    
      p<- ggplot(base, aes(1, y = y, fill = Personas)) +
      geom_bar(stat="identity") +
      ylab("Porcentaje") +
      xlab("")+
      theme_light()+
      scale_x_discrete(breaks=NULL) +
      expand_limits(y=c(0,100))
       
      print(p)
 })
 
})