library(ggvis)
library(shinysky)
library(plotly)

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


fluidPage(
  titlePanel("Beer explorer"),
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
             textInput.typeahead(id="search",
                                 placeholder="Type your name please",
                                 local=data.frame(name=unique(df_cervezas$brewer)),
                                 valueKey = "name",
                                 tokens=c(1:length(unique(df_cervezas$brewer))),
                                 template = HTML("<p class='repo-language'>{{info}}</p> <p class='repo-name'>{{name}}</p>")
             # ),
             # br(),br(),
             # # using select2Input
             # select2Input("select2Input1","",choices=unique(df_cervezas$brewer),type = c("input", "select"))
           )
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
           plotlyOutput("p"),
           wellPanel(
             span("Number of beers selected:",
                  textOutput("n_cerve")
             )
           )
    )
  )
)