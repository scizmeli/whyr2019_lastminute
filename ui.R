library(shiny)
library(shinyWidgets) # for sliderTextInput
library(leaflet)

# Define UI for random distribution app ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("Why Warsaw?"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            uiOutput("placeTypes"), 
            
            # radioButtons("dayOfWeek", "Which day of week to go out?",
            #              c("Monday" = 1,
            #                "Tuesday" = 2,
            #                "Wednesday" = 3,
            #                "Thursday" = 4,
            #                "Friday" = 5,
            #                "Saturday" = 6, 
            #                "Sunday" = 7
            #                )),
            
            sliderTextInput("dayOfWeek", "slide for day?", 
                            choices = c("Monday","Tuesday","Wednesday",
                                        "Thursday", "Friday", "Saturday" ,
                                        "Sunday"),
                            selected = weekdays(now())    ),
            
            sliderInput("hourOfDay", "What hour of day?", 0, 23, 8),
            
            # br() element to introduce extra vertical spacing ----
            br()
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Tabset w/ plot, summary, and table ----
            tabsetPanel(type = "tabs",
                        tabPanel("Plot", 
                                 leafletOutput("mymap")
                                 )
                        #,tabPanel("Summary", verbatimTextOutput("summary"))
                        #,tabPanel("Table", tableOutput("table"))
            )
            
        )
    )
)