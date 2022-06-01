# Final Server

library("ggplot2")
library("plotly")
library("dplyr")
library("tidyverse")

# load data
ev_data <- read.csv("https://data.wa.gov/api/views/f6w7-q2d2/rows.csv?accessType=DOWNLOAD", stringsAsFactors = FALSE)

server <- function(input, output) {
  
  return('hello')
}