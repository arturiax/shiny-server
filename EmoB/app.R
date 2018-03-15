

source("global.R", local = TRUE)

#### MINIPAGE #################################################################

# body {
#   background-image : url('beer2.jpg');
#   background-repeat: no-repeat;
#   background-size: auto;
# }  


appCSS <- "
#loading-content {
  position: absolute;
  background: #000000;
  opacity: 0.9;
  z-index: 100;
  left: 0;
  right: 0;
  height: 100%;
  text-align: center;
  color: #FFFFFF;
}
"



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
  
  inlineCSS(appCSS),
  
  # Loading message
  div(
    id = "loading-content",
    h2("Loading...")
  ),
  
  hidden(
    div(
      id = "app-content",
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
            uiOutput("alcohol"),
            hr(),
            p("Otros: ",
              img(id = "navi", src = "navi.png", height = 30),
              img(id = "halo", src = "halo.png", height = 30),
              img(id = "reti", src = "reti.png", height = 30),
              img(id = "indu", src = "indu.png", height = 30),
              img(id = "cola", src = "cola.png", height = 30)
            )
         ),
         box( title = "Aroma",
              p(img(src = "olfato.png", height = 30), checkboxInput("olfato", "Extra olfato", value=FALSE)),
              img(src = "equi.png", id = "equi", height = 30),
              img(src = "dulce.png", id = "dulce", height = 30),
              img(src = "tri.png", id = "tri", height = 30),
              img(src = "herb.png", id = "herb", height = 30),
              img(src = "frut.png", id = "frut", height = 30),
              img(src = "alco.png", id = "alco", height = 30),
              img(src = "flor.png", id = "flor", height = 30),
              img(src = "tropi.png", id = "tropi", height = 30),
              img(src = "limo.png", id = "limo", height = 30),
              img(src = "nara.png", id = "nara", height = 30),
              img(src = "bana.png", id = "bana", height = 30),
              img(src = "cere.png", id = "cere", height = 30),
              img(src = "manz.png", id = "manz", height = 30),
              img(src = "ciru.png", id = "ciru", height = 30),
              img(src = "pina.png", id = "pina", height = 30),
              img(src = "coco.png", id = "coco", height = 30),
              img(src = "pera.png", id = "pera", height = 30),
              img(src = "fresa.png", id = "fresa", height = 30),
              img(src = "uva.png", id = "uva", height = 30),
              img(src = "melon.png", id = "melon", height = 30),
              img(src = "cara.png", id = "cara", height = 30),
              img(src = "choc.png", id = "choc", height = 30),
              img(src = "cafe.png", id = "cafe", height = 30),
              img(src = "vani.png", id = "vani", height = 30),
              img(src = "tofe.png", id = "tofe", height = 30),
              img(src = "miel.png", id = "miel", height = 30),
              img(src = "arce.png", id = "arce", height = 30),
              img(src = "pan.png", id = "pan", height = 30),
              img(src = "gum.png", id = "gum", height = 30),
              img(src = "pino.png", id = "pino", height = 30),
              img(src = "roble.png", id = "roble", height = 30),
              img(src = "bour.png", id = "bour", height = 30),
              img(src = "bacon.png", id = "bacon", height = 30),
              img(src = "tosta.png", id = "tosta", height = 30),
              img(src = "tier.png", id = "tier", height = 30),
              img(src = "spicy.png", id = "spicy", height = 30),
              img(src = "nuez.png", id = "nuez", height = 30),
              img(src = "maiz.png", id = "maiz", height = 30),
              img(src = "humo.png", id = "humo", height = 30),
              img(src = "chile.png", id = "chile", height = 30),
              img(src = "galle.png", id = "galle", height = 30),
              img(src = "metal.png", id = "metal", height = 30),
              img(src = "milk.png", id = "milk", height = 30),
              img(src = "agua.png", id = "agua", height = 30),
              img(src = "heno.png", id = "heno", height = 30),
              img(src = "soja.png", id = "soja", height = 30),
              img(src = "cuero.png", id = "cuero", height = 30),
              img(src = "baw.png", id = "baw", height = 30),
              img(src = "queso.png", id = "queso", height = 30),
              img(src = "mine.png", id = "mine", height = 30),
              img(src = "tea.png", id = "tea", height = 30)
          ),
          box( title = "Sabor",
               p(img(src = "paladar.png", height = 30), checkboxInput("paladar", "Extra paladar", value=FALSE)),
               img(src = "equi.png", id = "equi_s", height = 30),
               img(src = "dulce.png", id = "dulce_s", height = 30),
               img(src = "tri.png", id = "tri_s", height = 30),
               img(src = "herb.png", id = "herb_s", height = 30),
               img(src = "frut.png", id = "frut_s", height = 30),
               img(src = "alco.png", id = "alco_s", height = 30),
               img(src = "flor.png", id = "flor_s", height = 30),
               img(src = "tropi.png", id = "tropi_s", height = 30),
               img(src = "limo.png", id = "limo_s", height = 30),
               img(src = "nara.png", id = "nara_s", height = 30),
               img(src = "bana.png", id = "bana_s", height = 30),
               img(src = "cere.png", id = "cere_s", height = 30),
               img(src = "manz.png", id = "manz_s", height = 30),
               img(src = "ciru.png", id = "ciru_s", height = 30),
               img(src = "pina.png", id = "pina_s", height = 30),
               img(src = "coco.png", id = "coco_s", height = 30),
               img(src = "pera.png", id = "pera_s", height = 30),
               img(src = "fresa.png", id = "fresa_s", height = 30),
               img(src = "uva.png", id = "uva_s", height = 30),
               img(src = "melon.png", id = "melon_s", height = 30),
               img(src = "cara.png", id = "cara_s", height = 30),
               img(src = "choc.png", id = "choc_s", height = 30),
               img(src = "cafe.png", id = "cafe_s", height = 30),
               img(src = "vani.png", id = "vani_s", height = 30),
               img(src = "tofe.png", id = "tofe_s", height = 30),
               img(src = "miel.png", id = "miel_s", height = 30),
               img(src = "arce.png", id = "arce_s", height = 30),
               img(src = "pan.png", id = "pan_s", height = 30),
               img(src = "gum.png", id = "gum_s", height = 30),
               img(src = "pino.png", id = "pino_s", height = 30),
               img(src = "roble.png", id = "roble_s", height = 30),
               img(src = "bour.png", id = "bour_s", height = 30),
               img(src = "bacon.png", id = "bacon_s", height = 30),
               img(src = "tosta.png", id = "tosta_s", height = 30),
               img(src = "tier.png", id = "tier_s", height = 30),
               img(src = "spicy.png", id = "spicy_s", height = 30),
               img(src = "nuez.png", id = "nuez_s", height = 30),
               img(src = "maiz.png", id = "maiz_s", height = 30),
               img(src = "humo.png", id = "humo_s", height = 30),
               img(src = "chile.png", id = "chile_s", height = 30),
               img(src = "galle.png", id = "galle_s", height = 30),
               img(src = "metal.png", id = "metal_s", height = 30),
               img(src = "milk.png", id = "milk_s", height = 30),
               img(src = "agua.png", id = "agua_s", height = 30),
               img(src = "heno.png", id = "heno_s", height = 30),
               img(src = "soja.png", id = "soja_s", height = 30),
               img(src = "cuero.png", id = "cuero_s", height = 30),
               img(src = "baw.png", id = "baw_s", height = 30),
               img(src = "queso.png", id = "queso_s", height = 30),
               img(src = "mine.png", id = "mine_s", height = 30),
               img(src = "tea.png", id = "tea_s", height = 30) 
         )
        ), 
        h1("Selecciona cerveza")  
          
      )
    ),
    tabItem(tabName = "leyen",
            
        fluidPage(    
          box(title ="Estilos", status = "info", solidHeader = TRUE,
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
          box(title ="Apariencia", status = "info", solidHeader = TRUE,
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
          box(title ="Puntuación", status = "info", solidHeader = TRUE,
              p(img(src = "p15.png", height = 30), ": <1.5"),
              p(img(src = "p2.png", height = 30), ": 1.5 - 2"),
              p(img(src = "p25.png", height = 30), ": 2 - 2.5"),
              p(img(src = "p3.png", height = 30), ": 2.5 - 3"),
              p(img(src = "p35.png", height = 30), ": 3 - 3.5"),
              p(img(src = "p375.png", height = 30), ": 3.5 - 3.75"),
              p(img(src = "p4.png", height = 30), ": 3.75 - 4"),
              p(img(src = "ptop.png", height = 30), ": >4")
          ),
          box(title ="Alcohol", status = "info", solidHeader = TRUE,
              p(img(src = "al15.png", height = 30), ": < 2% de alcohol"),
              p(img(src = "al5.png", height = 30), ": 2% - 5%"),
              p(img(src = "al75.png", height = 30), ": 5% - 7.5%"),
              p(img(src = "al10.png", height = 30), ": 7.5% - 10%"),
              p(img(src = "al125.png", height = 30), ": 10% - 12.5%"),
              p(img(src = "altop.png", height = 30), ": > 12.5%")
          ),
          box(title ="Otros", status = "info", solidHeader = TRUE,
              p(img(src = "halo.png", height = 30), ": De haloween, otoño"),
              p(img(src = "navi.png", height = 30), ": De navidad, invierno"),
              p(img(src = "reti.png", height = 30), ": Retirada del mercado"),
              p(img(src = "indu.png", height = 30), ": Cervecera industrial"),
              p(img(src = "cola.png", height = 30), ": Colaboración o nómada")
          ), 
          box(title ="Aroma y sabor", status = "info", solidHeader = TRUE,
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
              p(img(src = "spicy.png", height = 30), ": Especiado"),
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
              p(img(src = "queso.png", height = 30), ": Queso"),
              p(img(src = "mine.png", height = 30), ": Mineral"),
              p(img(src = "tea.png", height = 30), ": Té")
           )
        )  
)
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
  Sys.sleep(0.1)
  hide(id = "loading-content", anim = TRUE, animType = "fade")    
  shinyjs::show("app-content")
  
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
    p(img(src = logo(), height =50, style="display: block; margin-left: auto; margin-right: auto;")),
    hr(),
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
  
  
  output$alcohol<- renderUI ({ 
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
  
  
  observe({
    if (input$search != "") {
      lapply(tex_a, hide)
      lapply(tex_s, hide)
      mapply(mostrar, cerve()[, 13:63], tex_a, modifica, "a", input$olfato)
      mapply(mostrar, cerve()[, 64:114], tex_s, modifica, "s", input$paladar)
    }
  })
  
  

  
  
  
  
  
}  
  
  



##### SHINY APP CALL ###########################################################

shinyApp(ui, server)