# Final UI

library("plotly")
library("bslib")

# load data 
ev_data <- read.csv("https://data.wa.gov/api/views/f6w7-q2d2/rows.csv?accessType=DOWNLOAD", stringsAsFactors = FALSE)

# set a theme base
my_theme <- bs_theme(bg = "#F58686",
                     fg = "white", 
                     primary = "#F58686",
                     base_font = font_google("Roboto"),
                     code_font = font_google("JetBrains Mono")
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

# cafv bar plot on main page
main_panel_bar_plot <- mainPanel(
  plotlyOutput("cafv_chart")
)

# cafv page widgets
sidebar_panel_bar_plot <- sidebarPanel(
  selectInput(inputId = "city", 
              label = "Choose a City", 
              choices = unique(ev_data$City),
              multiple = TRUE,
              selected = "RENTON")
)

# vehicle popularity 
popular_vehicles <- mainPanel(
  plotOutput(outputId = "popular_vehicles_plot")
)

# vehicle popularity widgets
popular_vehicles_panel <- sidebarPanel(
  # select cities
  sliderInput(inputId = "county_popularity_slider", 
              label = "Top 80 Counties by Electric Vehicle Density", 
              min = 1, 
              max = 80, 
              value = 15),
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


# combine into a tab
electric_range_tab <- tabPanel(
  "Efficiency of Makes",
  sidebarLayout(
    electric_range_panel,
    er_main_panel_plot,
  ),
  br(),
  p("This dot plot maps out",
    span("electric range (amount of miles a vehicle can travel purely on electric charge)", style = "color:green"),
    "of electric vehicles from 1993-2022, organized by different makes to observe efficiency!"),
  p("The scatterplot is also organized by vehicle models, allowing observations of specific models by makers.")
)

# combine into a tab
CAFV_info <- tabPanel(
  "Clean Fuel Eligibility",
  sidebarLayout(
    main_panel_bar_plot,
    sidebar_panel_bar_plot
  ),
  br(),
  p("The chart represents the proportion of vehicles in each city that are
    eligible for clean alternative fuel energy. We chose this chart because we
    believe it’s important to recognize how many cities have vehicles that have
    clean alternative fuel. Clean alternative fuels are any source of fuel that
    is not gasoline or diesel. This means that clean alternative fuel vehicles
    (CAFV) are less likely to contribute towards air pollution with carbon dioxide.
    So, by creating this chart, we’re able to show how many cities have people
    who use CAFV eligible vehicles which then shows us how many cities are less
    prone to air pollution.")
)

# combine into a tab
top_vehicle_info <- tabPanel(
  "Vehicle Dominance",
  h2("Dominating Vehicles in Top Washington Counties"),
  sidebarLayout(
    popular_vehicles,
    popular_vehicles_panel
  ), 
  paste("Based on the top number of EV-dense counties you select, you will see the most popular electric vehicle models people own.",
        "Since the green benefits of BEVs and PHEVs differ, you can also choose to see which car models are dominating for either vehicle type."
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
  "Electric Vehicles in WA",
  intro_tab,
  electric_range_tab,
  CAFV_info,
  top_vehicle_info, 
  conclusion_tab
)

