library(ggvis)
#library(shinysky)
library(plotly)
library(shinythemes)
library(shinycssloaders)
library(shinyjqui)
library(ggiraph)
library(shinydashboard)

# # For dropdown menu
# actionLink <- function(inputId, ...) {
#   tags$a(href='javascript:void',
#          id=inputId,
#          class='action-button',
#          ...)
# }
axis_vars <- c(
  "ABV" = "abv",
  "Rating" = "average",
  "Number of reviews" = "n_ratings"
)  


# df_reviews <- readRDS("reviews")
# df_revisores <- readRDS("revisor")
# df_tags <- readRDS("tags")
# df_cerve_brew <- readRDS("cervebrew")
df_cervezas <- readRDS("cerve")
#df_breweries <- readRDS("brew")


mobileDetect <- function(inputId, value = 0) {
  tagList(
    singleton(tags$head(tags$script(src = "js/mobile.js"))),
    tags$input(id = inputId,
               class = "mobile-element",
               type = "hidden")
  )
}

fluidPage(#themeSelector(),
  titlePanel("Beer explorer"),
  mobileDetect('isMobile'),
  
  fluidRow(
    column(3, 
           wellPanel(
             h4("Filter"),
             sliderInput("reviews", "Minimum number of reviews on Ratebeer",
                         10, 300, 80, step = 10),
             sliderInput("ibus", "Minimum percentil",
                         0, 100, 0, step = 1),
             sliderInput("abv", "ABV",
                         0, 50, c(0, 50), step = 1),
             selectInput("style", "Style",
                         c("All", unique(df_cervezas$style))
             ),
             selectInput("search", "Cerveceras:", choices = c("",unique(df_cervezas$brewer)), multiple = TRUE)
             # textInput.typeahead(id="search",
             #                     placeholder="Type your name please",
             #                     local=data.frame(name=unique(df_cervezas$brewer)),
             #                     valueKey = "name",
             #                     tokens=c(1:length(unique(df_cervezas$brewer))),
             #                     template = HTML("<p class='repo-language'>{{info}}</p> <p class='repo-name'>{{name}}</p>")
             # ),
             # br(),br(),
             # # using select2Input
             # select2Input("select2Input1","",choices=unique(df_cervezas$brewer),type = c("input", "select"))
           
           ),
           wellPanel(
             selectInput("xvar", "X-axis variable", axis_vars, selected = "abv"),
             selectInput("yvar", "Y-axis variable", axis_vars, selected = "average"),
             tags$small(paste0(
               "Note: The Tomato Meter is the proportion of positive reviews",
               " (as judged by the Rotten Tomatoes staff), and the Numeric rating is",
               " a normalized 1-10 score of those reviews which have star ratings",
               " (for example, 3 out of 4 stars)."
             ))
           )
    ),
    column(9,
    tabsetPanel(
      tabPanel("Gráfico", 
     radioButtons("emoji", "Tipo de punto", choices = c("Normal" = "point", "Emojis" = "emo")),
           #conditionalPanel(condition = "output.mob2",plotOutput("pl2", click = "pl2_click")),
           #conditionalPanel(condition = "output.mob1",plotOutput("pl2", click = "pl2_click")),
           # plotOutput("pl2", click = "pl2_click",
           #            dblclick = "plot1_dblclick",
           #            brush = brushOpts(
           #              id = "plot1_brush",
           #              resetOnNew = TRUE)) %>% 
           #   withSpinner() %>% jqui_resizabled(),
           
           ggiraphOutput("pl3") %>% withSpinner(),
           
           
           
           wellPanel(
             span("Number of selected:",
                  textOutput("n_cerve")),
             span(DT::dataTableOutput("cervezas"))
             #span("mobile", textOutput('isItMobile')
             
             )
           ),
    tabPanel("Tabla", DT::dataTableOutput('tbl'))
  )
)
)
)
