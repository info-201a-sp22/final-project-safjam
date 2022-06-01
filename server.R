# Final Server
library(shiny)
library("ggplot2")
library("plotly")
library("dplyr")
library("tidyverse")

# load data
ev_data <- read.csv("https://data.wa.gov/api/views/f6w7-q2d2/rows.csv?accessType=DOWNLOAD", stringsAsFactors = FALSE)

server <- function(input, output) { # opening bracket
  
  output$electric_range_plot <- renderPlotly({
    
    filtered <- ev_data %>%
      filter(Make == input$make_choice)
    
    ev_plot <- ggplotly(data = filtered) +
      geom_line(mapping = aes(x = Model.Year, 
                              y = Electric.Range), color = Make) 
    
    return(ev_plot)
  })
}