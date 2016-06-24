# Tab layout and sidebar panels for a shiny app that helps user
#See the hydrological impact of mountaintop mining to accompnay
#Nippgen et al., 2016


# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(leaflet)
library(shiny)
library(dygraphs)

shinyUI(fluidPage(sidebarLayout(
  sidebarPanel(
    p(
      "This application shows how mountaintop mining in Central Appalachia has changed
      the hydrology of two catchments that have been heavily mined. The study follows a paired
      watershed approach, where we have two reference catchment that are unmined paired with two
      catchments that have been mined. The small catchments (~1km2) are Rich's Branch (reference) and
      Laurel Branch (99% mined), while the large ones (35 km2) are Left Fork (reference) and Mud River.
      To interact with the app click on a catchment and then select tabs. "
    ),
    leafletOutput("MapMine", height = 350),
    p(
      em(
        "This application was built by Matt Ross and Fabian Nippgen with support from NSF EAR"
      )
    ),
    width = 4
  ),
  mainPanel(width = 8,
            tabsetPanel(
              #Bit of code to containerize the gif plot
              
              tabPanel(
                "Geomorphology",
                textOutput('Sum.Text'),
                tags$head(
                  tags$style(type = "text/css",
                             "#geogif img {max-width: 100%; width: 100%; height: auto}")
                ),
                imageOutput('geogif')
              ),
              tabPanel(
                "Hydrologic Flux",
                br(),
                fluidRow(column(
                  6,
                  selectInput(
                    'comp',
                    label = 'Compare Selected Catchment With:',
                    choices = list(
                      'Different Treatment (Mined or Unmined)' = 1,
                      'Different Size (1st vs 4th order)' = 2,
                      'No Comparison' = 3
                    ),
                    selected = 3
                  )
                )),
                #   column(6,
                #          selectInput('comp2',label='Compare Data for:',
                #                      choices=list('1st Order Catchments'=1,
                #                                   '4th Order Catchments'=2)))
                #)
                br(),
                dygraphOutput('pplots', width = '95%', height =
                                '100px'),
                br(),
                dygraphOutput('qplots', width = '95%', height =
                                '200px'),
                br(),
                plotOutput('cume.plot', width = '95%', height =
                             '300px')
              ),
              tabPanel(
                "Baseflow",
                br(),
                fluidRow(column(
                  12,
                  selectInput(
                    'base',
                    label = 'Choose baseflow data to explore',
                    choices=list(
                    'Compare baseflow between sites' = 1)
                  )
                )),
                br(),
                dygraphOutput('p.base', width = '95%',height='100px'),
                dygraphOutput('q1.base',width='95%',height='200px'),
                dygraphOutput('q4.base',width='95%',height='200px')
              )
            ))
)))
