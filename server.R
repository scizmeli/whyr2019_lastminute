library(leaflet)
library(dplyr)

# Define server logic for random distribution app ----
server <- function(input, output, session) {
    myTypes = type.list()
    
    output$placeTypes <- renderUI({
         selectInput("plTypes", "What kind of place are you interested in?",
                     myTypes, myTypes[1])
    })
    
    currentPT <- reactive({
        pt <- input$mymap_marker_click
    })
    points <- reactive({
        req(input$dayOfWeek)

        pls <- places %>%
            filter(type == input$plTypes)

        #browser()
        
        df <- data.frame(long=pls$lng, lat=pls$lat, layerId=1:nrow(pls),name=pls$name,
                   vicinity=pls$vicinity,rating=pls$rating)
        #occupancy_index=occupancy_index        day=pls$day, hour=pls$hour
        
    })
    
    
    output$mymap <- renderLeaflet({
        myid <- currentPT()$id
        #req(myid)
        popupStr = ""
        if (!is.null(myid))
            popupStr = paste("Name:", points()$name[myid], "Address:", points()$vicinity[myid],
               "Type:", points()$type[myid], "Rating:", points()$rating[myid], sep = "<br/>")
        
        leaflet() %>%
            addTiles() %>%
            addMarkers(data = head(points()[,1:2], 200), layerId = points()[,3], popup = popupStr)
    })
    
    # Generate a summary of the data ----
    # output$summary <- renderPrint({
    #     summary(d())
    # })
    
    # Generate an HTML table view of the data ----
    # output$table <- renderTable({
    #     d()
    # })
    
}