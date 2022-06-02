# Final Project
library(shiny) 
library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)
library(markdown)


source("server.R")
source("ui.R")


shinyApp(ui = ui, server = server)