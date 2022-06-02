# Final Server

# load data
ev_data <- read.csv("https://data.wa.gov/api/views/f6w7-q2d2/rows.csv", stringsAsFactors = FALSE)

server <- function(input, output) { # opening bracket
  
  output$electric_range_plot <- renderPlotly({
    
    filtered <- ev_data %>%
      filter(Make %in% input$make_choice)
    
    ev_plot <- ggplotly(data = filtered) +
      geom_point(mapping = aes(x = Model.Year, 
                              y = Electric.Range,
                              group = 1))
    
    return(ev_plot)
  })
}