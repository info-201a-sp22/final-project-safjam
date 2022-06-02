# Final UI

library("plotly")
library("bslib")

# load data 
ev_data <- read.csv("https://data.wa.gov/api/views/f6w7-q2d2/rows.csv?accessType=DOWNLOAD", stringsAsFactors = FALSE)

# set a theme base
my_theme <- bs_theme(bg = "#0b3d91",
                     fg = "white", 
                     primary = "#FCC780",
) 

# update BootSwatch Theme
my_theme <- bs_theme_update(my_theme, bootswatch = "solar") %>% 
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

# electric range widget
electric_range_panel <- sidebarPanel(
  # select the make type option
  selectInput(
    inputId = "make_choice",
    label = "Make",
    choices = unique(ev_data$Make),
    multiple = TRUE
  )
)

# electric range plot
electric_range_panel_plot <- mainPanel(
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
    electric_range_panel_plot,
    electric_range_panel
  ),
  fluidPage(
    includeMarkdown("electric_range.md"),
  )
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
geo_info <- tabPanel(
  "Mapping",
  sidebarLayout(
    main_panel_plot,
    sidebar_panel
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
  geo_info, 
  conclusion_tab
)

