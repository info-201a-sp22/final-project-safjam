# Final Project
library(shiny) 
library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)
library(markdown)
library(thematic)
thematic_shiny(font = "auto")


source("server.R")
source("ui.R")


shinyApp(ui = ui, server = server)