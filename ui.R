# Final UI

library("plotly")
library("bslib")
# thematic_shiny(font = "auto")

# load data 
ev_data <- read.csv("https://data.wa.gov/api/views/f6w7-q2d2/rows.csv?accessType=DOWNLOAD", stringsAsFactors = FALSE)

# set a theme base
my_theme <- bs_theme(bg = "#F58686",
                     fg = "white", 
                     primary = "#F58686",
) 

# update BootSwatch Theme
my_theme <- bs_theme_update(my_theme, bootswatch = "flatly") %>% 
  bs_add_rules(sass::sass_file("my_style.scss"))

# home page tab
intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    includeMarkdown("index.md"),
  )
)

# plot on main page
main_panel_plot <- mainPanel(
  "insert output plot here"
)

# vehicle popularity 
popular_vehicles <- mainPanel(
  plotlyOutput(outputId = "popular_vehicles_plot")
)

# vehicle popularity widgets
popular_vehicles_panel <- sidebarPanel(
  # select cities
  sliderInput(inputId = "county_popularity_slider", 
              label = "Top Counties in Order of Vehicle Density", 
              min = 1, 
              max = 163, 
              value = 10),
  # select vehicle type
  checkboxGroupInput(inputId = "vehicle_type_checkbox",
               label = "Vehicle Type",
               choices = list("Battery Electric Vehicles" = 1, "Plug-in Hybrid Electric Vehicles" = 2), 
               selected = c(1, 2))
)

# electric range widget
electric_range_panel <- sidebarPanel(
  # select the make type option
  selectInput(
    inputId = "make_selection",
    label = "Makes of Vehicles",
    choices = unique(ev_data$Make),
    multiple = TRUE,
    selected = "TESLA"
  )
)

# electric range plot
er_main_panel_plot <- mainPanel(
  plotlyOutput(outputId = "electric_range_plot")
)

# sidebar panel for installing the widget
sidebar_panel <- sidebarPanel(
  # select an emissions type option
  radioButtons(inputId = "choose_emission_type",
               label = "Select An Emissions Source",
               choices = list("Cement" = "share_global_cement_co2",
                              "Coal" = "share_global_coal_co2",
                              "Flaring" = "share_global_flaring_co2",
                              "Gas" = "share_global_gas_co2",
                              "Oil" = "share_global_oil_co2"),
               selected = "share_global_cement_co2"
  )
)

# combine into a tab
electric_range_tab <- tabPanel(
  "Electric Vehicle Efficiency",
  sidebarLayout(
    electric_range_panel,
    er_main_panel_plot,
  ),
  p("This dot plot maps out",
    span("electric range (how far a vehicle can travel purely on electric charge)", style = "color:blue"),
    "of electric vehicles from 1993-2022, organized by different makes to observe efficiency!")
)

# combine into a tab
CAFV_info <- tabPanel(
  "CAVF variation",
  sidebarLayout(
    main_panel_plot,
    sidebar_panel
  )
)

# combine into a tab
top_vehicle_info <- tabPanel(
  "Vehicle Dominance",
  sidebarLayout(
    popular_vehicles,
    popular_vehicles_panel
  )
)

# conclusion tab
conclusion_tab <- tabPanel(
  "Conclusion",
  fluidPage(
    includeMarkdown("conclusion.md"),
  )
)

# set up the navbar
ui <- navbarPage(
  theme = my_theme,
  "BEVs and PHEVs",
  intro_tab,
  electric_range_tab,
  CAFV_info,
  top_vehicle_info, 
  conclusion_tab
)

