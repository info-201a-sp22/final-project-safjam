# Final Server
library(shiny) 
library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)
library(markdown)

# load data
ev_data <- read.csv("https://data.wa.gov/api/views/f6w7-q2d2/rows.csv", stringsAsFactors = FALSE)

server <- function(input, output) { 
  
  # electric range plot
  output$electric_range_plot <- renderPlotly({
    
    er_filtered <- ev_data %>%
      filter(Make %in% input$make_selection)
    
    ev_plot <- ggplot(data = er_filtered, aes(color = Make)) +
      geom_point(mapping = aes(group = 1, 
                               x = Model.Year, 
                               y = Electric.Range)) + 
      labs(x = "Model Year",
           y = "Electric Range") +
      ggtitle(paste("Electric Ranges of Makes Throughout Model Years"))
    
    return(ggplotly(ev_plot))
  })
  
  county_ev_density <- ev_data %>% 
    group_by(County) %>% 
    summarize(Count = n()) %>% 
    mutate(Count) %>% 
    arrange(-Count)
  
  # vehicle dominance chart
  output$popular_vehicles_plot <- renderPlotly({
    
  })
}