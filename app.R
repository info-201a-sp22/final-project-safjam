# Final Project

library("shiny")
library("rsconnect")
library("markdown")

source("server.R")
source("ui.R")


shinyApp(ui = ui, server = server)