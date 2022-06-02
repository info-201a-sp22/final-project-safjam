# Final Server
library(shiny) 
library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)
library(markdown)
library(tidyverse)

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

  
  # vehicle dominance chart
  output$popular_vehicles_plot <- renderPlotly({
    
    # filter type of vehicle: BEV/PHEV/Both
    if(input$vehicle_type_checkbox == 1) {
      filtered_vehicles <- ev_data %>% 
        filter(Electric.Vehicle.Type == 'Battery Electric Vehicle (BEV)') %>% 
        mutate(Vehicle = paste(Make, Model))
    } else if(input$vehicle_type_checkbox == 2) {
      filtered_vehicles <- ev_data %>% 
        filter(Electric.Vehicle.Type == 'Plug-in Hybrid Electric Vehicle (PHEV)') %>% 
        mutate(Vehicle = paste(Make, Model))
    } else {
      filtered_vehicles <- ev_data %>% 
        mutate(Vehicle = paste(Make, Model))
    }
    
    # filter to descending county densities by Vehicle
    county_ev_density <- filtered_vehicles %>% 
      group_by(County, Vehicle) %>% 
      summarize(Count = n()) %>% 
      mutate(Count) %>% 
      arrange(-Count)
    
    widgeted_data <- head(county_ev_density, input$county_popularity_slider) %>% 
      select(Vehicle, Count)
    
    dominance_pie_chart <- ggplot(widgeted_data, aes(x = factor(1), y = Count, fill = Vehicle)) + 
      geom_bar(stat = 'identity', width = 1) +
      coord_polar(theta = "y")
    
    return(dominance_pie_chart)
  })
}