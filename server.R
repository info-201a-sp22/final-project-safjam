# Final Server
library(shiny) 
library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)
library(markdown)

# load data
ev_data <- read.csv("https://data.wa.gov/api/views/f6w7-q2d2/rows.csv", stringsAsFactors = FALSE)

server <- function(input, output) { # opening bracket
  
  output$electric_range_plot <- renderPlotly({
    
    er_filtered <- ev_data %>%
      filter(Make %in% input$make_selection,
             Model.Year >= input$year_input[1],
             Model.Year <= input$year_input[2])
    
    ev_plot <- ggplot(data = er_filtered, aes(color = Make)) +
      geom_point(mapping = aes(group = 1, x = Model.Year, y = Electric.Range))
    
    return(ggplotly(ev_plot))
  })
}