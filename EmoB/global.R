#### Libraries needed #########################################################
library(shiny)
library(shinydashboard)
library(shinyjs)
# library(lubridate)
# library(dplyr)

setwd("/home/art/shiny-server/EmoB")
final <- readRDS("final")
tex_a <- readRDS("tex")
tex_s <- paste0(tex_a, "_s")
espuma <- c("sin", "med", "muc", "cre")
color <- c("rub", "roj", "mar", "neg")
puntu <- c("p15", "p2", "p25", "p3", "p35", "p375", "p4", "ptop")
alco <- c("al15", "al5", "al75", "al10", "al125", "altop", "nose")
otras <- c("halo", "navi", "reti", "indu", "cola")

# vari_a <- colnames(select(final, ends_with("_a")))
# vari_s <- colnames(select(final, ends_with("_s")))

mostrar <- function(x, y, base, n = 5) {
  if (x > n) shinyjs::show(y)
  

}

