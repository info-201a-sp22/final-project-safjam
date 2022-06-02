# Final Server
library(shiny) 
library(ggplot2)
library(plotly)
library(dplyr)
library(bslib)
library(markdown)
library(tidyverse)
library(RColorBrewer)
library(thematic)

# load data
ev_data <- read.csv("https://data.wa.gov/api/views/f6w7-q2d2/rows.csv", stringsAsFactors = FALSE)

thematic_shiny(font = "auto")

# expand ggplot color palette capacity: credit to (https://www.r-bloggers.com/2013/09/how-to-expand-color-palette-with-ggplot-and-rcolorbrewer/)
colourCount = length(unique(mtcars$hp))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))

server <- function(input, output) { 
  
  # cafv bar chart
  output$cafv_chart <- renderPlotly({
    
    # making the dynamic dropdown menu
    # all cities with their vehicles count
    cities <- ev_data %>%
      filter(City %in% input$city) %>% 
      group_by(City) %>% 
      summarize(total_vehicles = n()) %>% 
      slice_max(n = 10, order_by = total_vehicles)
    
    # join tables to get all vehicles from top 10 cities
    cities_and_cafv <- left_join(cities, ev_data, by = "City")
    
    sum_groups <- cities_and_cafv %>% 
      group_by(Clean.Alternative.Fuel.Vehicle..CAFV..Eligibility, City) %>% 
      summarize(summed_vehicles = n())
    
    cities_and_cafv <- left_join(sum_groups, cities_and_cafv, by = "City")
    
    # create bar plot
    cafv_bar_chart <- ggplot(data = cities_and_cafv) +
      geom_col(mapping = aes(x = City, y = total_vehicles,
                             fill = Clean.Alternative.Fuel.Vehicle..CAFV..Eligibility.y),
                             #text = paste("Percent of Vehicles:", summed_vehicles)),
               position = "fill") +
      scale_x_discrete(guide = guide_axis(n.dodge=3)) +
      labs(title = 'Percentage of Vehicles That Are Either Eligible for Clean Alternative Fuels or Not in 10 Washington Cities', x = "Cities", y = 'Percent of Vehicles')
    
    return(ggplotly(cafv_bar_chart))
    # tooltip = c("text")
  })
  
  
  # electric range plot
  output$electric_range_plot <- renderPlotly({
    
    er_filtered <- ev_data %>%
      filter(Make %in% input$make_selection) %>%
      group_by(Model.Year) %>%
      filter(Electric.Range == max(Electric.Range)) %>%
      mutate(Vehicle = paste(Make, Model))
    
    ev_plot <- ggplot(data = er_filtered, aes(color = Vehicle)) +
      geom_point(mapping = aes(group = 1, 
                               x = Model.Year, 
                               y = Electric.Range)) + 
      labs(x = "Model Year of Vehicle",
           y = "Electric Range") +
      ggtitle(paste("Electric Ranges of Vehicles Throughout The Years"))
    
    return(ggplotly(ev_plot))
  })

  
  # vehicle dominance chart
  output$popular_vehicles_plot <- renderPlot({
    
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
      group_by(Vehicle) %>% 
      summarize(Sums = sum(Count))
    
    # make the pie chart
    dominance_pie_chart <- ggplot(widgeted_data, aes(x = '', y = Sums, fill = Vehicle)) + 
      geom_bar(stat = 'identity', color = 'white') +
      coord_polar(theta = "y") +
      theme_void() + 
      labs(fill = 'Vehicle Models') +
      scale_fill_manual(values = getPalette(colourCount))
    
    return(dominance_pie_chart)
  })
}