
# Shiny web application.


library(shiny)
library(leaflet)
library(readxl)
library(dplyr)
library(tidygeocoder)
library(shinyWidgets)
library(leaflet.extras)

ui <- navbarPage(
  title = div(
    class = "navbar-brand-custom",
    img(src = "logo.png", height = "40px", style = "display: inline-block; margin-right: 10px; vertical-align: middle;"),
    span("PINELLAS COUNTY ENVIRONMENTAL RESOURCE TRACKING DASHBOARD", style = "vertical-align: middle;")
  ),
  id = "main_tabs",
  collapsible = TRUE,
  
  # Injecting Style Sheet Rules
  header = tags$head(
    tags$style(HTML("
      /* Top Navbar Container Styling */
      .navbar {
        background-color: #00244c !important;
        border-color: #000000 !important;
        font-family: 'system-ui' !important;
        font-weight: bold !important;
        margin-bottom: 0px !important;
      }
      
      /* Target Brand / Logo Area text color */
      .navbar-default .navbar-brand {
        color: #ffffff !important;
        font-weight: 800;
        font-size: 17px;
        display: flex;
        align-items: center;
      }
      
      /* Inactive Navbar Tabs Styling */
      .navbar-default .navbar-nav > li > a {
        color: #ffffff !important; /* Forces visible white text against deep blue */
        font-weight: bold;
        font-size: 15px;
        padding: 15px 20px;
      }
      
      /* Active Tab & Hover States */
      .navbar-default .navbar-nav > .active > a, 
      .navbar-default .navbar-nav > .active > a:hover, 
      .navbar-default .navbar-nav > .active > a:focus,
      .navbar-default .navbar-nav > li > a:hover {
        color: #ffffff !important;
        background-color: #616f71 !important;
        background-image: none !important;
      }
      
      /* Fallback handling for nested custom tab panels if needed */
      .nav-tabs-custom > .nav-tabs > li.active {
        border-top-color: #00244c;
      }
      .nav-tabs-custom > .nav-tabs > li > a {
        color: black;
        font-weight: bold;
        font-size: 12px;
        border-radius: 0;
        padding: 3px 10px 5px;
      }
      .nav-tabs-custom .nav-tabs > li.active > a {
        color: darkblue;
        font-weight: bold;
        font-size: 14px;
        border-radius: 0;
        padding: 3px 10px 5px;
      }
      
      /* Rest of existing body styles */
      body {
        font-family: 'system-ui';
        font-weight: 500;
        font-size: 16px;
        color: #636363;
        text-align: justify;
        text-justify: inter-word;
      }
      h1, h2, h3, h4, h5 {
        font-family: 'system-ui';
        font-weight: 800;
        color: #00244c;
      }
      .vertical-carousel { max-height: 700px; overflow-y: scroll; overflow-x: hidden; border: 1px solid #ddd; padding: 15px; background-color: #f9f9f9; border-radius: 6px; }
      .carousel-img { width: 100%; margin-bottom: 15px; border-radius: 4px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
    "))
  ),
  
  # OVERVIEW TAB 
  tabPanel(
    title = "Overview",
    fluidPage(
      br(),
      div(
        class = "info-section",
        h3("WELCOME TO THE ENVIRONMENTAL RESOURCE TRACKING DASHBOARD!"),
        br(),
        div(class = "collage-panel", style="text-align:center;", img(src = "welcome.banner.jpg", height = "400px"))
      ),
      br(),
      div(class = "info-section", 
          h4("Who we are"),
          p("This dashboard provides access to locations of environmental resources throughout the County."),
          h4("Why Resource Mapping Matters"),
          p("Use the tabs above to explore different maps and photos.")
      ),
      br(),
      div(class = "collage-panel", style="text-align:center;", img(src = "WN Dashboard Collage.jpg", height = "400px"))
    )
  ),
  
  # MANGROVES TAB
  tabPanel(
    "Mangroves",
    br(),
    div(
      class = "map-panel",
      fluidRow(
        column(width = 9, leafletOutput("map_data_mg", height = "700px")),
        column(
          width = 3,
          div(
            class = "vertical-carousel",
            h4("Mangrove Gallery", style = "margin-top:0; color: #00244c; font-weight:600;"),
            div(class = "carousel-item", img(src = "red.mang.JPG", class = "carousel-img"), p("Red Mangrove Prop Roots", class = "carousel-label")),
            div(class = "carousel-item", img(src = "redmang1.JPG", class = "carousel-img"), p("White Mangrove", class = "carousel-label")),
            div(class = "carousel-item", img(src = "100_0094.JPG", class = "carousel-img"), p("Black Mangrove", class = "carousel-label"))
          )
        )
      )
    )
  ),
  
  # SEAGRASS TAB
  tabPanel(
    "Seagrass",
    br(),
    div(
      class = "map-panel",
      fluidRow(
        column(width = 9, leafletOutput("map_data_sg", height = "700px")),
        column(
          width = 3,
          div(
            class = "vertical-carousel",
            h4("Seagrass Gallery", style = "margin-top:0; color: #00244c; font-weight:600;"),
            div(class = "carousel-item", img(src = "syring.sg.JPG", class = "carousel-img"), p("Manatee Grass-Syringodium filiformae", class = "carousel-label")),
            div(class = "carousel-item", img(src = "syring.sg.JPG", class = "carousel-img"), p("Manatee Grass-Syringodium filiformae", class = "carousel-label")),
            div(class = "carousel-item", img(src = "syring.sg.JPG", class = "carousel-img"), p("Manatee Grass-Syringodium filiformae", class = "carousel-label")),
            div(class = "carousel-item", img(src = "syring.sg.JPG", class = "carousel-img"), p("Manatee Grass-Syringodium filiformae", class = "carousel-label"))
          )
        )
      )
    )
  ), 
  
  # CORAL TAB
  tabPanel(
    "Coral",
    br(),
    div(
      class = "map-panel",
      fluidRow(
        column(width = 9, leafletOutput("map_data_cr", height = "650px")),
        column(
          width = 3,
          div(
            class = "vertical-carousel",
            h4("Coral Gallery", style = "margin-top:0; color: #00244c; font-weight:600;"),
            div(class = "carousel-item", img(src = "tube.coral.JPG", class = "carousel-img"), p("Tube Coral-<em>Syringodium filiformae</em>", class = "carousel-label")),
            div(class = "carousel-item", img(src = "seawhip2.JPG", class = "carousel-img"), p("Colorful Seawhip-Leptogorgia virgulata", class = "carousel-label")),
            div(class = "carousel-item", img(src = "smoothstar.JPG", class = "carousel-img"), p("Smooth Star Coral-Solenastrea bournoni", class = "carousel-label")),
            div(class = "carousel-item", img(src = "ivorytree2.JPG", class = "carousel-img"), p("Ivory Tree Coral-Oculina varicosa", class = "carousel-label")),
            div(class = "carousel-item", img(src = "hiddencup.JPG", class = "carousel-img"), p("Hidden Cup Coral-Phyllangia americana", class = "carousel-label")),
            div(class = "carousel-item", img(src = "knobby4.JPG", class = "carousel-img"), p("Knobby Star Coral-Solenastrea hyades", class = "carousel-label"))
          )
        )
      )
    )
  ),
  tabPanel(
    "Contact",
    br(),
    div(
      class = "info-section",
      h3("Contact us"),
      p("To learn more about Water and Navigation or if you have any inquiries pertaining permits for docks, dredge, or fill, please visiti (https://pinellas.gov/topic/environment/water-and-navigation/) to learn more."),
      p("Call our office at (727) 453-3385 or email WaterNavPermits@pinellas.gov ")
    ),
    br(),
    div(class = "collage-panel", img(src = "coral banner.JPG", height = "200px"))
  )
)

# SINGLE SERVER BLOCK ----------------------------------------
server <- function(input, output, session) {
  
  # Coral data
  map_data_cr <- read_excel("W:/Watershed/WaterNav/_Water and Navigation (Docks and Dredge-Fill)/Environmental Resource Tracking/Coral/Coral Maps/Coral Map R Files/Coral Locations Tracking.xlsm") %>%
    select(Address, Latitude, Longitude, WND, Species)%>%
    mutate(Latitude=as.numeric(Latitude))
  
  coralIcon <- makeIcon(
    iconUrl = "https://static.vecteezy.com/system/resources/previews/016/548/438/large_2x/watercolor-sea-coral-png.png",
    iconWidth = 30, iconHeight = 30
  )
  
  output$map_data_cr <- renderLeaflet({
    leaflet(map_data_cr) %>%
      addProviderTiles("Esri.WorldImagery") %>%
      addMarkers(~Longitude, ~Latitude, icon = coralIcon,
                 popup = ~paste0("<b>", WND, "</b><br>", Species))
  })
  
  # Seagrass data
  map_data_sg <- read_excel("W:/Watershed/WaterNav/_Water and Navigation (Docks and Dredge-Fill)/Environmental Resource Tracking/Seagrass/Seagrass Maps/Seagrass R Files/Seagrass Locations Tracking.xlsm") %>%
    select(Address, Latitude, Longitude, WND, Species)%>%
    mutate(Latitude=as.numeric(Latitude))
  
  seagrassIcon <- makeIcon(
    iconUrl = "https://png.pngtree.com/png-vector/20220813/ourmid/pngtree-green-seaweed-clipart-design-png-image_6109503.png",
    iconWidth = 40, iconHeight = 40
  )
  
  output$map_data_sg <- renderLeaflet({
    leaflet(map_data_sg) %>%
      addProviderTiles("Esri.WorldImagery") %>%
      addMarkers(~Longitude, ~Latitude, icon = seagrassIcon,
                 popup = ~paste0("<b>", WND, "</b><br>", Species))
  })
  
  # Mangroves data
  map_data_mg <- read_excel("W:/Watershed/WaterNav/_Water and Navigation (Docks and Dredge-Fill)/Environmental Resource Tracking/Mangroves/Mangrove Maps/Mangrove R Files/Mangrove Locations Tracking.xlsm") %>%
    select(Address, Latitude, Longitude, WND, Species)%>%
    mutate(Latitude=as.numeric(Latitude))
  
  mangroveIcon <- makeIcon(
    iconUrl = "https://png.pngtree.com/png-vector/20221210/ourmid/pngtree-mangrove-tree-with-the-strong-roots-png-image_6518985.png",
    iconWidth = 30, iconHeight = 30
  )
  
  output$map_data_mg <- renderLeaflet({
    leaflet(map_data_mg) %>%
      addProviderTiles("Esri.WorldImagery") %>%
      addMarkers(~Longitude, ~Latitude, icon = mangroveIcon,
                 popup = ~paste0("<b>", WND, "</b><br>", Species))
  })
  
  # Overview map (empty but valid)
  output$map_overview <- renderLeaflet({
    leaflet() %>% addTiles()
  })
  
}

shinyApp(ui, server)
