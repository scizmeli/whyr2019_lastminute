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
        pls <- places %>%
            filter(type == input$plTypes)
        # pts <- strsplit(pls$point, split = ",")
        # lat = sapply(pts, function(x){as.numeric(x[1])})
        # long = sapply(pts, function(x){as.numeric(x[2])})
        #data.frame(long=long, lat=lat)
        data.frame(long=pls$lng, lat=pls$lat, layerId=1:nrow(pls),name=pls$name,
                   vicinity=pls$vicinity,rating=pls$rating)
    })
    
    
    output$mymap <- renderLeaflet({
        myid <- currentPT()$id
        popupStr = ""
        if (!is.null(myid))
            popupStr = paste("Name:", points()$name[myid], "Address:", points()$vicinity[myid],
               "Type:", points()$type[myid], "Rating:", points()$rating[myid], sep = "<br/>")
        p <- points()
        leaflet() %>%
            addTiles() %>%
            addMarkers(data = p[sample(1:nrow(p), 200),1:2], layerId = p[,3], popup = popupStr)
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