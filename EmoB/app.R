

source("global.R", local = TRUE)

lista <- final$cer_name
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

.loader {
  color: #ffffff;
font-size: 90px;
text-indent: -9999em;
overflow: hidden;
width: 1em;
height: 1em;
border-radius: 50%;
margin: 72px auto;
position: relative;
-webkit-transform: translateZ(0);
-ms-transform: translateZ(0);
transform: translateZ(0);
-webkit-animation: load6 1.7s infinite ease, round 1.7s infinite ease;
animation: load6 1.7s infinite ease, round 1.7s infinite ease;
}
@-webkit-keyframes load6 {
0% {
box-shadow: 0 -0.83em 0 -0.4em, 0 -0.83em 0 -0.42em, 0 -0.83em 0 -0.44em, 0 -0.83em 0 -0.46em, 0 -0.83em 0 -0.477em;
}
5%,
95% {
box-shadow: 0 -0.83em 0 -0.4em, 0 -0.83em 0 -0.42em, 0 -0.83em 0 -0.44em, 0 -0.83em 0 -0.46em, 0 -0.83em 0 -0.477em;
}
10%,
59% {
box-shadow: 0 -0.83em 0 -0.4em, -0.087em -0.825em 0 -0.42em, -0.173em -0.812em 0 -0.44em, -0.256em -0.789em 0 -0.46em, -0.297em -0.775em 0 -0.477em;
}
20% {
box-shadow: 0 -0.83em 0 -0.4em, -0.338em -0.758em 0 -0.42em, -0.555em -0.617em 0 -0.44em, -0.671em -0.488em 0 -0.46em, -0.749em -0.34em 0 -0.477em;
}
38% {
box-shadow: 0 -0.83em 0 -0.4em, -0.377em -0.74em 0 -0.42em, -0.645em -0.522em 0 -0.44em, -0.775em -0.297em 0 -0.46em, -0.82em -0.09em 0 -0.477em;
}
100% {
box-shadow: 0 -0.83em 0 -0.4em, 0 -0.83em 0 -0.42em, 0 -0.83em 0 -0.44em, 0 -0.83em 0 -0.46em, 0 -0.83em 0 -0.477em;
}
}
@keyframes load6 {
0% {
box-shadow: 0 -0.83em 0 -0.4em, 0 -0.83em 0 -0.42em, 0 -0.83em 0 -0.44em, 0 -0.83em 0 -0.46em, 0 -0.83em 0 -0.477em;
}
5%,
95% {
box-shadow: 0 -0.83em 0 -0.4em, 0 -0.83em 0 -0.42em, 0 -0.83em 0 -0.44em, 0 -0.83em 0 -0.46em, 0 -0.83em 0 -0.477em;
}
10%,
59% {
box-shadow: 0 -0.83em 0 -0.4em, -0.087em -0.825em 0 -0.42em, -0.173em -0.812em 0 -0.44em, -0.256em -0.789em 0 -0.46em, -0.297em -0.775em 0 -0.477em;
}
20% {
box-shadow: 0 -0.83em 0 -0.4em, -0.338em -0.758em 0 -0.42em, -0.555em -0.617em 0 -0.44em, -0.671em -0.488em 0 -0.46em, -0.749em -0.34em 0 -0.477em;
}
38% {
box-shadow: 0 -0.83em 0 -0.4em, -0.377em -0.74em 0 -0.42em, -0.645em -0.522em 0 -0.44em, -0.775em -0.297em 0 -0.46em, -0.82em -0.09em 0 -0.477em;
}
100% {
box-shadow: 0 -0.83em 0 -0.4em, 0 -0.83em 0 -0.42em, 0 -0.83em 0 -0.44em, 0 -0.83em 0 -0.46em, 0 -0.83em 0 -0.477em;
}
}
@-webkit-keyframes round {
0% {
-webkit-transform: rotate(0deg);
transform: rotate(0deg);
}
100% {
-webkit-transform: rotate(360deg);
transform: rotate(360deg);
}
}
@keyframes round {
0% {
-webkit-transform: rotate(0deg);
transform: rotate(0deg);
}
100% {
-webkit-transform: rotate(360deg);
transform: rotate(360deg);
}
}





"



header <- dashboardHeader(title = "Emojicervezas")



sidebar <- dashboardSidebar(
  sidebarMenu(id = "menu",
    menuItem("Cerveza", tabName = "cerve",  icon = icon("beer")),
    menuItem("Explicación", tabName = "leyen", icon = icon("info"))
  )
)


body <- dashboardBody(
  useShinyjs(),
   tags$head(
   
     #tags$link(href="https://fonts.googleapis.com/css?family=Lobster", rel="stylesheet"),
   tags$link(href="https://fonts.googleapis.com/css?family=Krona+One", rel="stylesheet"),
    tags$style(HTML (
      
      "p {
       font-family : 'Krona One';
       color : 	black;
       size : 12 px;
          }
      
        h2 {
       font-family : 'Lobster';
      color : black;
      
      }

       "

    ))
    ),

  inlineCSS(appCSS),
  
  # Loading message
  div(
    id = "loading-content",
    h1("Cargando la base de cervezas..."),
    div( class="loader", "Cargando la base de cervezas...")
  ),
  
  hidden(
    div(
      id = "app-content",
  tabItems(
    tabItem(tabName = "cerve",
        fluidPage(   
          
          div(id="todo",  
              box(
                 
                
                #img(src = paste0(textOutput(output$text), ".jpg"), height =50),
                uiOutput("primero"),
                div(id = "sesion", uiOutput("ses")),
                div(id = "imper", uiOutput("imp")),
                div(id = "normal", uiOutput("nor")),
                uiOutput("puntu"),
                uiOutput("alcohol"),
                hr(),
                p("Otros: ",
                  img(id = "navi", src = "navi.png", height = 35),
                  img(id = "halo", src = "halo.png", height = 35),
                  img(id = "reti", src = "reti.png", height = 35),
                  img(id = "indu", src = "indu.png", height = 35),
                  img(id = "cola", src = "cola.png", height = 35)
                )
              ),
              box( title = "AROMA", status = "warning", 
                   checkboxInput("olfato", "Extra olfato", value=FALSE),
                   img(src = "equi.png", id = "equi", height = 35),
                   img(src = "dulce.png", id = "dulce", height = 35),
                   img(src = "tri.png", id = "tri", height = 35),
                   img(src = "herb.png", id = "herb", height = 35),
                   img(src = "frut.png", id = "frut", height = 35),
                   img(src = "alco.png", id = "alco", height = 35),
                   img(src = "flor.png", id = "flor", height = 35),
                   img(src = "tropi.png", id = "tropi", height = 35),
                   img(src = "limo.png", id = "limo", height = 35),
                   img(src = "nara.png", id = "nara", height = 35),
                   img(src = "bana.png", id = "bana", height = 35),
                   img(src = "cere.png", id = "cere", height = 35),
                   img(src = "manz.png", id = "manz", height = 35),
                   img(src = "ciru.png", id = "ciru", height = 35),
                   img(src = "pina.png", id = "pina", height = 35),
                   img(src = "coco.png", id = "coco", height = 35),
                   img(src = "pera.png", id = "pera", height = 35),
                   img(src = "fresa.png", id = "fresa", height = 35),
                   img(src = "uva.png", id = "uva", height = 35),
                   img(src = "melon.png", id = "melon", height = 35),
                   img(src = "cara.png", id = "cara", height = 35),
                   img(src = "choc.png", id = "choc", height = 35),
                   img(src = "cafe.png", id = "cafe", height = 35),
                   img(src = "vani.png", id = "vani", height = 35),
                   img(src = "tofe.png", id = "tofe", height = 35),
                   img(src = "miel.png", id = "miel", height = 35),
                   img(src = "arce.png", id = "arce", height = 35),
                   img(src = "pan.png", id = "pan", height = 35),
                   img(src = "gum.png", id = "gum", height = 35),
                   img(src = "pino.png", id = "pino", height = 35),
                   img(src = "roble.png", id = "roble", height = 35),
                   img(src = "bour.png", id = "bour", height = 35),
                   img(src = "bacon.png", id = "bacon", height = 35),
                   img(src = "tosta.png", id = "tosta", height = 35),
                   img(src = "tier.png", id = "tier", height = 35),
                   img(src = "spicy.png", id = "spicy", height = 35),
                   img(src = "nuez.png", id = "nuez", height = 35),
                   img(src = "maiz.png", id = "maiz", height = 35),
                   img(src = "humo.png", id = "humo", height = 35),
                   img(src = "chile.png", id = "chile", height = 35),
                   img(src = "galle.png", id = "galle", height = 35),
                   img(src = "metal.png", id = "metal", height = 35),
                   img(src = "milk.png", id = "milk", height = 35),
                   img(src = "agua.png", id = "agua", height = 35),
                   img(src = "heno.png", id = "heno", height = 35),
                   img(src = "soja.png", id = "soja", height = 35),
                   img(src = "cuero.png", id = "cuero", height = 35),
                   img(src = "baw.png", id = "baw", height = 35),
                   img(src = "queso.png", id = "queso", height = 35),
                   img(src = "mine.png", id = "mine", height = 35),
                   img(src = "tea.png", id = "tea", height = 35)
              ),
              box( title = "SABOR", status = "warning", 
                   checkboxInput("paladar", "Extra paladar", value=FALSE),
                   img(src = "equi.png", id = "equi_s", height = 35),
                   img(src = "dulce.png", id = "dulce_s", height = 35),
                   img(src = "tri.png", id = "tri_s", height = 35),
                   img(src = "herb.png", id = "herb_s", height = 35),
                   img(src = "frut.png", id = "frut_s", height = 35),
                   img(src = "alco.png", id = "alco_s", height = 35),
                   img(src = "flor.png", id = "flor_s", height = 35),
                   img(src = "tropi.png", id = "tropi_s", height = 35),
                   img(src = "limo.png", id = "limo_s", height = 35),
                   img(src = "nara.png", id = "nara_s", height = 35),
                   img(src = "bana.png", id = "bana_s", height = 35),
                   img(src = "cere.png", id = "cere_s", height = 35),
                   img(src = "manz.png", id = "manz_s", height = 35),
                   img(src = "ciru.png", id = "ciru_s", height = 35),
                   img(src = "pina.png", id = "pina_s", height = 35),
                   img(src = "coco.png", id = "coco_s", height = 35),
                   img(src = "pera.png", id = "pera_s", height = 35),
                   img(src = "fresa.png", id = "fresa_s", height = 35),
                   img(src = "uva.png", id = "uva_s", height = 35),
                   img(src = "melon.png", id = "melon_s", height = 35),
                   img(src = "cara.png", id = "cara_s", height = 35),
                   img(src = "choc.png", id = "choc_s", height = 35),
                   img(src = "cafe.png", id = "cafe_s", height = 35),
                   img(src = "vani.png", id = "vani_s", height = 35),
                   img(src = "tofe.png", id = "tofe_s", height = 35),
                   img(src = "miel.png", id = "miel_s", height = 35),
                   img(src = "arce.png", id = "arce_s", height = 35),
                   img(src = "pan.png", id = "pan_s", height = 35),
                   img(src = "gum.png", id = "gum_s", height = 35),
                   img(src = "pino.png", id = "pino_s", height = 35),
                   img(src = "roble.png", id = "roble_s", height = 35),
                   img(src = "bour.png", id = "bour_s", height = 35),
                   img(src = "bacon.png", id = "bacon_s", height = 35),
                   img(src = "tosta.png", id = "tosta_s", height = 35),
                   img(src = "tier.png", id = "tier_s", height = 35),
                   img(src = "spicy.png", id = "spicy_s", height = 35),
                   img(src = "nuez.png", id = "nuez_s", height = 35),
                   img(src = "maiz.png", id = "maiz_s", height = 35),
                   img(src = "humo.png", id = "humo_s", height = 35),
                   img(src = "chile.png", id = "chile_s", height = 35),
                   img(src = "galle.png", id = "galle_s", height = 35),
                   img(src = "metal.png", id = "metal_s", height = 35),
                   img(src = "milk.png", id = "milk_s", height = 35),
                   img(src = "agua.png", id = "agua_s", height = 35),
                   img(src = "heno.png", id = "heno_s", height = 35),
                   img(src = "soja.png", id = "soja_s", height = 35),
                   img(src = "cuero.png", id = "cuero_s", height = 35),
                   img(src = "baw.png", id = "baw_s", height = 35),
                   img(src = "queso.png", id = "queso_s", height = 35),
                   img(src = "mine.png", id = "mine_s", height = 35),
                   img(src = "tea.png", id = "tea_s", height = 35) 
              )
          ),        
                box(title ="SELECCIONA CERVEZA", status="primary",
                selectizeInput("search", "Busca:", choices = NULL, selected = 1),
                div(style="display:inline-block;width:32%;text-align: center;",actionButton(style="color: #fff; background-color: #337ab7; border-color: #2e6da4", "ale", "Aleatoria",icon = icon("ramdon")))
                )
                
          
      )
    ),
    tabItem(tabName = "leyen",
            
        fluidPage(    
          box(title ="Estilos", status = "info", solidHeader = TRUE,
              p(img(src = "bel.png", height = 35), ": Abadía, Dubble, Tripple, Quad, Belgian ale"),
              p(img(src = "apa.png", height = 35), ": America Pale Ale, amber, golden"),
              p(img(src = "eng.png", height = 35), ": Estilos británicos EPA, Bitter, Brown ale, Scotch ale"),
              p(img(src = "iri.png", height = 35), ": Irish Ale"),
              p(img(src = "lag.png", height = 35), ": Lagers, Pilsners, Marzen"),
              p(img(src = "ipa.png", height = 35), ": Indian (sí, lo sé) Pale Ale"),
              p(img(src = "bip.png", height = 35), ": Black IPA"),
              p(img(src = "sto.png", height = 35), ": Petroleos, Stouts y Porters"),
              p(img(src = "lam.png", height = 35), ": Lambic, Berliner"),
              p(img(src = "baw.png", height = 35), ": Barley wine, Old ale, Strong american"),
              p(img(src = "ahu.png", height = 35), ": Ahumadas"),
              p(img(src = "tri.png", height = 35), ": De trigo"),
              p(img(src = "dop.png", height = 35), ": Dopplebok"),
              p(img(src = "low.png", height = 35), ": De bajo alcohol"),
              p(img(src = "veg.png", height = 35), ": Especiadas, con verduras"),
              p(img(src = "fru.png", height = 35), ": De frutas"),
              hr(),
              p("Modificadores"),
              p(img(src = "ses.png", height = 35), ": Session"),
              p(img(src = "imp.png", height = 35), ": Imperial")
          ),
          box(title ="Apariencia", status = "info", solidHeader = TRUE,
              p(img(src = "sin_rub.png", height = 35), img(src = "med_rub.png", height = 35), 
                img(src = "muc_rub.png", height = 35), img(src = "cre_rub.png", height = 35), 
                ": Rubia (Espuma: Sin o poca - medio - mucha - cremosa)") ,
              p(img(src = "sin_roj.png", height = 35), img(src = "med_roj.png", height = 35), 
                img(src = "muc_roj.png", height = 35), img(src = "cre_roj.png", height = 35), 
                ": Rojiza, naranja, cobre, miel") ,
              p(img(src = "sin_mar.png", height = 35), img(src = "med_mar.png", height = 35), 
                img(src = "muc_mar.png", height = 35), img(src = "cre_mar.png", height = 35), 
                ": Marrón, caramelo") ,
              p(img(src = "sin_neg.png", height = 35), img(src = "med_neg.png", height = 35), 
                img(src = "muc_neg.png", height = 35), img(src = "cre_neg.png", height = 35), 
                ": Negra, marrón oscura") 
           ),
          box(title ="Puntuación (RateBeer)", status = "info", solidHeader = TRUE,
              p(img(src = "p15.png", height = 35), ": <1.5"),
              p(img(src = "p2.png", height = 35), ": 1.5 - 2"),
              p(img(src = "p25.png", height = 35), ": 2 - 2.5"),
              p(img(src = "p3.png", height = 35), ": 2.5 - 3"),
              p(img(src = "p35.png", height = 35), ": 3 - 3.5"),
              p(img(src = "p375.png", height = 35), ": 3.5 - 3.75"),
              p(img(src = "p4.png", height = 35), ": 3.75 - 4"),
              p(img(src = "ptop.png", height = 35), ": >4")
          ),
          box(title ="Alcohol", status = "info", solidHeader = TRUE,
              p(img(src = "al15.png", height = 35), ": < 2% de alcohol"),
              p(img(src = "al5.png", height = 35), ": 2% - 5%"),
              p(img(src = "al75.png", height = 35), ": 5% - 7.5%"),
              p(img(src = "al10.png", height = 35), ": 7.5% - 10%"),
              p(img(src = "al125.png", height = 35), ": 10% - 12.5%"),
              p(img(src = "altop.png", height = 35), ": > 12.5%")
          ),
          box(title ="Otros", status = "info", solidHeader = TRUE,
              p(img(src = "halo.png", height = 35), ": De haloween, otoño"),
              p(img(src = "navi.png", height = 35), ": De navidad, invierno"),
              p(img(src = "reti.png", height = 35), ": Retirada del mercado"),
              p(img(src = "indu.png", height = 35), ": Cervecera industrial"),
              p(img(src = "cola.png", height = 35), ": Colaboración o nómada")
          ), 
          box(title ="Aroma y sabor", status = "info", solidHeader = TRUE,
              p(img(src = "equi.png", height = 35), ": Equilibrado"),
              p(img(src = "dulce.png", height = 35), ": Dulce"),
              p(img(src = "tri.png", height = 35), ": Maltas, cereal, grano"),
              p(img(src = "herb.png", height = 35), ": Herbal, lupulado"),
              p(img(src = "frut.png", height = 35), ": Afrutado"),
              p(img(src = "alco.png", height = 35), ": Alcohólico"),
              p(img(src = "flor.png", height = 35), ": Floral"),
              p(img(src = "tropi.png", height = 35), ": Tropical, mango, papaya, maracuyá"),
              p(img(src = "limo.png", height = 35), ": Cítrico, limón, lima"),
              p(img(src = "nara.png", height = 35), ": Naranja, pomelo, mandarina"),
              p(img(src = "bana.png", height = 35), ": Plátano"),
              p(img(src = "cere.png", height = 35), ": Cereza"),
              p(img(src = "manz.png", height = 35), ": Manzana"),
              p(img(src = "ciru.png", height = 35), ": Melocotón, ciruela"),
              p(img(src = "pina.png", height = 35), ": Piña"),
              p(img(src = "coco.png", height = 35), ": Coco"),
              p(img(src = "pera.png", height = 35), ": Pera"),
              p(img(src = "fresa.png", height = 35), ": Fresa"),
              p(img(src = "uva.png", height = 35), ": Uva"),
              p(img(src = "melon.png", height = 35), ": Melón"),
              p(img(src = "cara.png", height = 35), ": Caramelo líquido"),
              p(img(src = "choc.png", height = 35), ": Chocolate, cacao"),
              p(img(src = "cafe.png", height = 35), ": Café"),
              p(img(src = "vani.png", height = 35), ": Vainilla"),
              p(img(src = "tofe.png", height = 35), ": Toffe"),
              p(img(src = "miel.png", height = 35), ": Miel"),
              p(img(src = "arce.png", height = 35), ": Sirope de arce, melaza"),
              p(img(src = "pan.png", height = 35), ": Pan"),
              p(img(src = "gum.png", height = 35), ": Golosina, chicle"),
              p(img(src = "pino.png", height = 35), ": Pino, resina"),
              p(img(src = "roble.png", height = 35), ": Roble, madera"),
              p(img(src = "bour.png", height = 35), ": Bourbon, whiskey, brandy, cognac"),
              p(img(src = "bacon.png", height = 35), ": Bacon"),
              p(img(src = "tosta.png", height = 35), ": Tostado"),
              p(img(src = "tier.png", height = 35), ": A tierra"),
              p(img(src = "spicy.png", height = 35), ": Especiado"),
              p(img(src = "nuez.png", height = 35), ": Cacahuete, nuez, frutos secos"),
              p(img(src = "maiz.png", height = 35), ": Maiz"),
              p(img(src = "humo.png", height = 35), ": Tabaco, humo"),
              p(img(src = "chile.png", height = 35), ": Picante, chile"),
              p(img(src = "galle.png", height = 35), ": Galleta"),
              p(img(src = "metal.png", height = 35), ": Metálico"),
              p(img(src = "milk.png", height = 35), ": Leche, lactosa"),
              p(img(src = "agua.png", height = 35), ": Agua, acuoso"),
              p(img(src = "heno.png", height = 35), ": Hoja seca, heno"),
              p(img(src = "soja.png", height = 35), ": Salsa de soja"),
              p(img(src = "cuero.png", height = 35), ": Cuero"),
              p(img(src = "baw.png", height = 35), ": Vino"),
              p(img(src = "queso.png", height = 35), ": Queso"),
              p(img(src = "mine.png", height = 35), ": Mineral"),
              p(img(src = "tea.png", height = 35), ": Té")
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
  # tags$head( 
  #   tags$link(href="https://fonts.googleapis.com/css?family=Krona+One", rel="stylesheet"),
  #   tags$style(HTML (
  #      "p {
  #      font-family : 'Krona One';
  #      color : red;
  #      }
  #      "  
  #   ))
  #   
  # )
  # output$nombre <- renderUI({
  #   h2()
  #   
  # })
  updateSelectizeInput(session = session, inputId = 'search', choices = c(Choose = '', lista), server = TRUE)
  Sys.sleep(0.1)
  hide(id = "loading-content", anim = TRUE, animType = "fade")    
  shinyjs::show("app-content")
  
  cerve <- reactive({
    if (input$search != "") final[final$cer_name == input$search, ]
    #else cer_ale
    #shinyjs::runjs("window.scrollTo(0, 50)")
  })
  
  observeEvent(input$ale, {
    updateSelectizeInput(session = session, inputId = 'search', choices = c(Choose = '', lista), selected = sample(lista,1), server = TRUE)
    #shinyjs::runjs("window.scrollTo(0, 50)")
  })
  
  observe({ 
    toggle(id = "todo", condition = (input$search != ""))
    shinyjs::runjs("window.scrollTo(0, 50)")
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
    p(img(src = logo(), height =70, style="display: block; margin-left: auto; margin-right: auto;")),
    hr(),
    p("Pais: ", img(src = cerve()$Flag, height = 35)),
    p("Año: ", lubridate::year(cerve()$cer_f_ini)),
    
    p("Apariencia: ", img(src = apariencia(), height = 35))
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
           img(src = "ses.png", height=35), 
           img(src = paste0(cerve()$tipo, ".png"), height = 35))
  })
  
  output$imp <- renderUI ({ 
   p("Estilo: ",
     img(src = "imp.png", height=35), 
     img(src = paste0(cerve()$tipo, ".png"), height = 35))
  })
  output$nor <- renderUI ({ 
    p("Estilo: ", img(src = paste0(cerve()$tipo, ".png"), height = 35))
  })
 
  output$puntu <- renderUI ({ 
    p("Puntuación (RB): ", img(src = paste0(puntu[cerve()$puntu], ".png"), height = 35))
  })
  
  
  output$alcohol<- renderUI ({ 
    p("Alcohol: ", img(src = paste0(alco[cerve()$alco], ".png"), height = 35))
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
      mapply(mostrar, cerve()[, 13:63], tex_a, modifica, "a", input$olfato)
     }
  })
  
  observe({
    if (input$search != "") {
      lapply(tex_s, hide)
      mapply(mostrar, cerve()[, 64:114], tex_s, modifica, "s", input$paladar)
    }
  })
  
  
  
  
}  
  
  



##### SHINY APP CALL ###########################################################

shinyApp(ui, server)