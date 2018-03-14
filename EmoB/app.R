

source("global.R", local = TRUE)

#### MINIPAGE #################################################################

# body {
#   background-image : url('beer2.jpg');
#   background-repeat: no-repeat;
#   background-size: auto;
# }  




header <- dashboardHeader(title = "Emojicervezas")



sidebar <- dashboardSidebar(
  sidebarMenu(id = "menu",
    menuItem("Cerveza", tabName = "cerve",  icon = icon("beer")),
    conditionalPanel("input.menu == 'cerve'",
            selectInput("search", "Cerveza:", choices = c("", final$cer_name)),
            actionButton("ale", "Aleatoria")
    ),
    hr(),
    menuItem("Explicación", tabName = "leyen", icon = icon("info"))
  )
)


body <- dashboardBody(
  useShinyjs(),
  tags$head( 
    tags$link(href="https://fonts.googleapis.com/css?family=Krona+One", rel="stylesheet"),
    tags$style(HTML (
      "p {
       font-family : 'Krona One';
       color : red;
          }


       "  
      
    ))),
  
  tabItems(
    tabItem(tabName = "cerve",
        fluidPage(   
         div(id="todo",  
          box(
            title = "Ficha", background = "black",status = "primary", solidHeader = TRUE,
           
            #img(src = paste0(textOutput(output$text), ".jpg"), height =50),
            uiOutput("primero"),
            div(id = "sesion", uiOutput("ses")),
            div(id = "imper", uiOutput("imp")),
            div(id = "normal", uiOutput("nor")),
            uiOutput("puntu"),
            uiOutput("alco"),
            hr(),
            p("Otros: ",
              img(id = "navi", src = "navi.png", height = 30),
              img(id = "halo", src = "halo.png", height = 30),
              img(id = "reti", src = "reti.png", height = 30),
              img(id = "indu", src = "indu.png", height = 30),
              img(id = "cola", src = "cola.png", height = 30)
            
            
            ),
            tableOutput("table")
          )
          
         ),  
        h1("Selecciona cerveza")  
          
      )
    ),
    tabItem(tabName = "leyen",
            
          box("Estilos", 
              p(img(src = "bel.png", height = 30), ": Abadía, Dubble, Tripple, Quad, Belgian ale"),
              p(img(src = "apa.png", height = 30), ": America Pale Ale, amber, golden"),
              p(img(src = "eng.png", height = 30), ": Estilos británicos EPA, Bitter, Brown ale, Scotch ale"),
              p(img(src = "iri.png", height = 30), ": Irish Ale"),
              p(img(src = "lag.png", height = 30), ": Lagers, Pilsners, Marzen"),
              p(img(src = "ipa.png", height = 30), ": Indian (sí, lo sé) Pale Ale"),
              p(img(src = "bip.png", height = 30), ": Black IPA"),
              p(img(src = "sto.png", height = 30), ": Petroleos, Stouts y Porters"),
              p(img(src = "lam.png", height = 30), ": Lambic, Berliner"),
              p(img(src = "baw.png", height = 30), ": Barley wine, Old ale, Strong american"),
              p(img(src = "ahu.png", height = 30), ": Ahumadas"),
              p(img(src = "tri.png", height = 30), ": De trigo"),
              p(img(src = "dop.png", height = 30), ": Dopplebok"),
              p(img(src = "low.png", height = 30), ": De bajo alcohol"),
              p(img(src = "veg.png", height = 30), ": Especiadas, con verduras"),
              p(img(src = "fru.png", height = 30), ": De frutas"),
              hr(),
              p("Modificadores"),
              p(img(src = "ses.png", height = 30), ": Session"),
              p(img(src = "imp.png", height = 30), ": Imperial")
          ),
          box("Apariencia", 
              p(img(src = "sin_rub.png", height = 30), img(src = "med_rub.png", height = 30), 
                img(src = "muc_rub.png", height = 30), img(src = "cre_rub.png", height = 30), 
                ": Rubia (Espuma: Sin o poca - medio - mucha - cremosa)") ,
              p(img(src = "sin_roj.png", height = 30), img(src = "med_roj.png", height = 30), 
                img(src = "muc_roj.png", height = 30), img(src = "cre_roj.png", height = 30), 
                ": Rojiza, naranja, cobre, miel") ,
              p(img(src = "sin_mar.png", height = 30), img(src = "med_mar.png", height = 30), 
                img(src = "muc_mar.png", height = 30), img(src = "cre_mar.png", height = 30), 
                ": Marrón, caramelo") ,
              p(img(src = "sin_neg.png", height = 30), img(src = "med_neg.png", height = 30), 
                img(src = "muc_neg.png", height = 30), img(src = "cre_neg.png", height = 30), 
                ": Negra, marrón oscura") 
           ),
          box("Puntuación", 
              p(img(src = "p15.png", height = 30), ": <1.5"),
              p(img(src = "p2.png", height = 30), ": 1.5 - 2"),
              p(img(src = "p25.png", height = 30), ": 2 - 2.5"),
              p(img(src = "p3.png", height = 30), ": 2.5 - 3"),
              p(img(src = "p35.png", height = 30), ": 3 - 3.5"),
              p(img(src = "p375.png", height = 30), ": 3.5 - 3.75"),
              p(img(src = "p4.png", height = 30), ": 3.75 - 4"),
              p(img(src = "ptop.png", height = 30), ": >4")
          ),
          box("Alcohol",
              p(img(src = "al15.png", height = 30), ": < 2% de alcohol"),
              p(img(src = "al5.png", height = 30), ": 2% - 5%"),
              p(img(src = "al75.png", height = 30), ": 5% - 7.5%"),
              p(img(src = "al10.png", height = 30), ": 7.5% - 10%"),
              p(img(src = "al125.png", height = 30), ": 10% - 12.5%"),
              p(img(src = "altop.png", height = 30), ": > 12.5%")
          ),
          box("Otros", 
              p(img(src = "halo.png", height = 30), ": De haloween, otoño"),
              p(img(src = "navi.png", height = 30), ": De navidad, invierno"),
              p(img(src = "reti.png", height = 30), ": Retirada del mercado"),
              p(img(src = "indu.png", height = 30), ": Cervecera industrial"),
              p(img(src = "cola.png", height = 30), ": Colaboración o nómada")
          ), 
          box("Aroma y sabor",
              p(img(src = "equi.png", height = 30), ": Equilibrado"),
              p(img(src = "dulce.png", height = 30), ": Dulce"),
              p(img(src = "tri.png", height = 30), ": Maltas, cereal, grano"),
              p(img(src = "herb.png", height = 30), ": Herbal, lupulado"),
              p(img(src = "frut.png", height = 30), ": Afrutado"),
              p(img(src = "alco.png", height = 30), ": Alcohólico"),
              p(img(src = "flor.png", height = 30), ": Floral"),
              p(img(src = "tropi.png", height = 30), ": Tropical, mango, papaya, maracuyá"),
              p(img(src = "limo.png", height = 30), ": Cítrico, limón, lima"),
              p(img(src = "nara.png", height = 30), ": Naranja, pomelo, mandarina"),
              p(img(src = "bana.png", height = 30), ": Plátano"),
              p(img(src = "cere.png", height = 30), ": Cereza"),
              p(img(src = "manz.png", height = 30), ": Manzana"),
              p(img(src = "ciru.png", height = 30), ": Melocotón, ciruela"),
              p(img(src = "pina.png", height = 30), ": Piña"),
              p(img(src = "coco.png", height = 30), ": Coco"),
              p(img(src = "pera.png", height = 30), ": Pera"),
              p(img(src = "fresa.png", height = 30), ": Fresa"),
              p(img(src = "uva.png", height = 30), ": Uva"),
              p(img(src = "melon.png", height = 30), ": Melón"),
              p(img(src = "cara.png", height = 30), ": Caramelo líquido"),
              p(img(src = "choc.png", height = 30), ": Chocolate, cacao"),
              p(img(src = "cafe.png", height = 30), ": Café"),
              p(img(src = "vani.png", height = 30), ": Vainilla"),
              p(img(src = "tofe.png", height = 30), ": Toffe"),
              p(img(src = "miel.png", height = 30), ": Miel"),
              p(img(src = "arce.png", height = 30), ": Sirope de arce, melaza"),
              p(img(src = "pan.png", height = 30), ": Pan"),
              p(img(src = "gum.png", height = 30), ": Golosina, chicle"),
              p(img(src = "pino.png", height = 30), ": Pino, resina"),
              p(img(src = "roble.png", height = 30), ": Roble, madera"),
              p(img(src = "bour.png", height = 30), ": Bourbon, whiskey, brandy, cognac"),
              p(img(src = "bacon.png", height = 30), ": Bacon"),
              p(img(src = "tosta.png", height = 30), ": Tostado"),
              p(img(src = "tier.png", height = 30), ": A tierra"),
              p(img(src = "spicy.png", height = 30), ": A especias"),
              p(img(src = "nuez.png", height = 30), ": Cacahuete, nuez, frutos secos"),
              p(img(src = "maiz.png", height = 30), ": Maiz"),
              p(img(src = "humo.png", height = 30), ": Tabaco, humo"),
              p(img(src = "chile.png", height = 30), ": Picante, chile"),
              p(img(src = "galle.png", height = 30), ": Galleta"),
              p(img(src = "metal.png", height = 30), ": Metálico"),
              p(img(src = "milk.png", height = 30), ": Leche, lactosa"),
              p(img(src = "agua.png", height = 30), ": Agua, acuoso"),
              p(img(src = "heno.png", height = 30), ": Hoja seca, heno"),
              p(img(src = "soja.png", height = 30), ": Salsa de soja"),
              p(img(src = "cuero.png", height = 30), ": Cuero"),
              p(img(src = "baw.png", height = 30), ": Vino"),
              p(img(src = "tea.png", height = 30), ": Té")
              
              
              
              
              
              
          )              
)
)
)

ui <- dashboardPage(header, sidebar, body)
  
  

#### SERVER FUNCTION ###########################################################

server <- function(input, output, session) {
  tags$head( 
    tags$link(href="https://fonts.googleapis.com/css?family=Krona+One", rel="stylesheet"),
    tags$style(HTML (
       "p {
       font-family : 'Krona One';
       color : red;
       }
       "  
    ))
    
  )
  # output$nombre <- renderUI({
  #   h2()
  #   
  # })
  
  cerve <- reactive({
    if (input$search != "") final[final$cer_name == input$search, ]
    #else cer_ale
  })
  
  observeEvent(input$ale, {
    updateSelectInput(session, "search",selected = sample(final$cer_name,1)) 
  })
  
  observe({ 
  toggle(id = "todo", condition = (input$search != ""))
  }) 
  
  logo <- reactive({
    if (input$search != ""){
    if (rvest::html_session(cerve()$bre_logo_url)$response$status_code == 404) logo <- "nologo.png"
    else cerve()$bre_logo_url
    }
  })

  apariencia <- reactive({
   paste0(espuma[cerve()$head_m], "_", color[cerve()$color], ".png")
  })
  
  
  
  output$primero <- renderUI({
    list(
    h2(cerve()$cer_name),  
    img(src = logo(), height =50),
    p("Pais: ", img(src = cerve()$Flag, height = 30)),
    p("Año: ", lubridate::year(cerve()$cer_f_ini)),
    
    p("Apariencia: ", img(src = apariencia(), height = 30))
    )
  })
  
  
  observe({
    if (input$search != "") {
      hide("sesion")
      hide("imper")
      shinyjs::show("normal")
      if (cerve()$mod_est == 1) {
        shinyjs::show("sesion", anim =TRUE)
        hide("normal")
      }
      if (cerve()$mod_est == 2) {
        shinyjs::show("imper", anim =TRUE)
        hide("normal")
      }
    }
  })
  
  output$ses <- renderUI ({ 
           p("Estilo: ",
           img(src = "ses.png", height=30), 
           img(src = paste0(cerve()$tipo, ".png"), height = 30))
  })
  
  output$imp <- renderUI ({ 
   p("Estilo: ",
     img(src = "imp.png", height=30), 
     img(src = paste0(cerve()$tipo, ".png"), height = 30))
  })
  output$nor <- renderUI ({ 
    p("Estilo: ", img(src = paste0(cerve()$tipo, ".png"), height = 30))
  })
 
  output$puntu <- renderUI ({ 
    p("Puntuación (RateBeer): ", img(src = paste0(puntu[cerve()$puntu], ".png"), height = 30))
  })
  
  
  output$alco <- renderUI ({ 
    p("Alcohol: ", img(src = paste0(alco[cerve()$alco], ".png"), height = 30))
  })
  

  observe({
    if (input$search != "") {
      # hide("halo")
      # hide("navi")
      # hide("reti")
      # hide("indu")
      # hide("cola")
      lapply(otras, hide)
      if (cerve()$seasonal == "Autumn" & !is.na(cerve()$seasonal))  shinyjs::show("halo")
      if (cerve()$industrial)   shinyjs::show("indu")
      if (cerve()$seasonal == "Winter" & !is.na(cerve()$seasonal))  shinyjs::show("navi")
      if (cerve()$repetido == 2)   shinyjs::show("cola")
      if (cerve()$cer_retired)   shinyjs::show("reti")
    }
  })
  

  
  
  
  
  
}  
  
  



##### SHINY APP CALL ###########################################################

shinyApp(ui, server)