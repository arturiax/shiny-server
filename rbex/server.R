library(ggvis)
library(dplyr)
library(emojifont)
library(plotly)
library(shiny)
library(ggiraph)
library(stringr)
#devtools::install_github("dill/emoGG",TRUE)

#library(emoGG)



df_cervezas <- readRDS("cerve")



axis_vars <- c(
  "ABV" = "abv",
  "Rating" = "average",
  "Number of reviews" = "n_ratings"
)  

df_cervezas <- df_cervezas %>% mutate(tipo = case_when(
                                      #average<1.75 ~ emoji("face_vomiting"),
                                      average<2 ~ emoji('nauseated_face'),
                                      #average<2.5 ~ emoji('slight_frown'),
                                      average<3 ~ emoji('neutral_face'),
                                      #average<3.25 ~ emoji('slight_smile'),
                                      average<3.5 ~ emoji("smiley"),
                                      average <3.75 ~ emoji("yum"),
                                      average <4 ~ emoji('heart_eyes'),
                                      TRUE ~ emoji('crown')))


function(input, output, session) {
  
  output$isItMobile <- renderText({
    ifelse(input$isMobile, "You are on a mobile device", "You are not on a mobile device")
  })
  
  # Filter the movies, returning a data frame
  cerves <- reactive({
    # Due to dplyr issue #318, we need temp variables for input values
    reviews <- input$reviews
    percen <- input$ibus
    minabv <- input$abv[1]
    maxabv <- input$abv[2]
   
    # Apply filters
    m <- df_cervezas %>%
      filter(
        n_ratings >= reviews,
        percentil >= percen,
        abv >= minabv,
        abv <= maxabv
      ) 
    
    # Optional: filter by genre
    if (input$style != "All") {
      m <- m %>% filter(style == input$style)
    }
    # Optional: filter by director
    if (!is.null(input$search) && input$search != "") {
      m <- m %>% filter(brewer %in% input$search)
    }
   
   
    m <- as.data.frame(m)
    
    
    
    # Add column which says whether the movie won any Oscars
  #   # Be a little careful in case we have a zero-row data frame
  #   m$has_oscar <- character(nrow(m))
  #   m$has_oscar[m$Oscars == 0] <- "No"
  #   m$has_oscar[m$Oscars >= 1] <- "Yes"
  #   m
   })
  
  output$mob1 <- reactive({input$isMobile})
  output$mob2 <- reactive({!input$isMobile})
  outputOptions(output, 'mob1', suspendWhenHidden = FALSE)
  outputOptions(output, 'mob2', suspendWhenHidden = FALSE)
  
  
  
  # 
  # Function for generating tooltip text
  cerve_tooltip <- function(x) {
    if (is.null(x)) return(NULL)
   if (is.null(x$name)) return(NULL)

#   Pick out the movie with this ID
    df_cervezas <- isolate(cerves())
    cerve <- df_cervezas[df_cervezas$name== x$name, ]
  #   4percentil
   paste0("<b>", cerve$name, "</b><br>",
          cerve$average, "<br>",
          cerve$percentil)
   
  }
  #          "$", format(movie$BoxOffice, big.mark = ",", scientific = FALSE)
  #   )
  # }
  # 
  # A reactive expression with the ggvis plot
  #vis <- reactive({
    # Lables for axes
    # xvar <- reactive({names(axis_vars)[axis_vars == input$xvar]})
    # yvar <-  reactive({names(axis_vars)[axis_vars == input$yvar]})
    # 
    # # Normally we could do something like props(x = ~BoxOffice, y = ~Reviews),
    # but since the inputs are strings, we need to do a little more work.
    # xvar <- prop("x", as.symbol(input$xvar))
    # yvar <- prop("y", as.symbol(input$yvar))
    # 
    # cerves %>%
    #   ggvis(x = xvar, y = yvar) %>%
    #   layer_points(size := 50, size.hover := 200,
    #                fillOpacity := 0.2, fillOpacity.hover := 0.5,
    #                stroke = ~tipo,
    #                 key := ~name) %>%
    #   add_tooltip(cerve_tooltip, "hover") %>%
    #   add_axis("x", title = xvar_name) %>%
    #   add_axis("y", title = yvar_name) %>%
    #   #add_legend("stroke", title = "Won Oscar", values = c("Yes", "No")) %>%
    #   #scale_nominal("stroke", domain = c("Yes", "No"),
    #    #             range = c("orange", "#aaa")) %>%
    #   set_options(width = 500, height = 500)
  #})
  output$pl1 <- renderPlotly ({
    nombres<-cerves()$name
    
    Comentarios<-cerves()$tipo
    q<-ggplot(data=cerves(), aes_string(x= input$xvar, y = input$yvar, text="nombres"))  + geom_text(aes(label =Comentarios),family="EmojiOne", size =4, alpha=.6)
    #p <- cerves() %>% ggplot(aes_string(x= input$xvar, y = input$yvar)) + geom_emoji(d))ata = cerves(), emoji = tipo)
    p <- ggplotly(q)
    
    #print(p)
    })
  ranges <- reactiveValues(x = NULL, y = NULL)
  
  
  output$pl2 <- renderPlot ({
    nombres<-cerves()$name
    Comentarios<-cerves()$tipo
    # cerves()$xv<-input$xvar
    # cerves()$yv <- input$yvar
    
    q<-ggplot(data=cerves(), aes_string(x= input$xvar, y = input$yvar, text="nombres"))  + 
      geom_text(aes(label =Comentarios),family="EmojiOne", size =6, alpha=.8) +
      coord_cartesian(xlim = ranges$x, ylim = ranges$y, expand = FALSE)
    #p <- cerves() %>% ggplot(aes_string(x= input$xvar, y = input$yvar)) + geom_emoji(d))ata = cerves(), emoji = tipo)
    #q<-ggplot(data=cerves(), aes_string(x= input$xvar, y = input$yvar))  + geom_point()
    
    q
    #print(q)
  })
  
  
  output$pl3 <- renderggiraph ({
    nombres<-cerves()$name
    nombres2<-str_replace(nombres,"'", "")
    Comentarios<-cerves()$tipo
    # cerves()$xv<-input$xvar
    # cerves()$yv <- input$yvar
    
    q<-ggplot(data=cerves(), aes_string(x= input$xvar, y = input$yvar, text="nombres"))  
      #geom_text(aes(label =Comentarios),family="EmojiOne", size =6, alpha=.8) 
    #p <- cerves() %>% ggplot(aes_string(x= input$xvar, y = input$yvar)) + geom_emoji(d))ata = cerves(), emoji = tipo)
    #q<-ggplot(data=cerves(), aes_string(x= input$xvar, y = input$yvar))  + geom_point()
    
    my_gg <- q + geom_text_interactive(aes(label =Comentarios, tooltip = nombres2, data_id=nombres2), family="EmojiOne",size = 5) 
    
    
    ggiraph(code = print(my_gg), hover_css = "cursor:pointer;fill:red;size:7;" )
    #print(q)
  })
  
  observeEvent(input$plot1_dblclick, {
    brush <- input$plot1_brush
    if (!is.null(brush)) {
      ranges$x <- c(brush$xmin, brush$xmax)
      ranges$y <- c(brush$ymin, brush$ymax)
      
    } else {
      ranges$x <- NULL
      ranges$y <- NULL
    }
  })
 # vis %>% bind_shiny("plot1")
  
  output$n_cerve <- renderText({ nrow(cerves()) })
  output$cervezas <- renderText({
   
    
    aux<-nearPoints(cerves(), input$pl2_click, maxpoints = 5, threshold = 10)
    aux$name
  })
}