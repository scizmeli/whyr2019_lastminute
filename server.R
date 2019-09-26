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
        #req(input$mymap_bounds)
        
        isolate(bds <- input$mymap_bounds)  # -> NESW bounds
        
        #browser()
        
        if (is.null(bds)){
            pls <- places %>%
                filter(type == input$plTypes )  ## can  we also filter on the coordinates that lie in the current field of view? 
        } else {
            pls <- places %>%
                filter(type == input$plTypes ) # &
                           # lat >= bds$south &
                           # lat <= bds$north &
                           # lng >= bds$east &
                           # lng <= bds$west)
        }
        message(nrow(pls))
        
        #browser()
        
        df <- data.frame(long=pls$lng, lat=pls$lat, layerId=1:nrow(pls),name=pls$name,
                   vicinity = pls$vicinity, rating=pls$rating)
        #occupancy_index=occupancy_index        day=pls$day, hour=pls$hour
        
    })
    
    
    output$mymap <- renderLeaflet({
        #myid <- currentPT()$id
        #req(myid)
        popupStr = ""
        # if (!is.null(myid))
        #     popupStr = paste("Name:", points()$name[myid], "Address:", points()$vicinity[myid],
        #                      "Type:", points()$type[myid], "Rating:", points()$rating[myid], sep = "<br/>")
        #if (!is.null(myid))
            popupStr = paste("Name:", points()$name, "Address:", points()$vicinity,
                             "Type:", points()$type, "Rating:", points()$rating,
                             sep = "<br/>")
        p <- points()
        set.seed(1)
        leaflet() %>%
            addTiles() %>%
            addMarkers(data = p[sample(1:nrow(p), min(200, nrow(p))), 
                                1:2], 
                       layerId = p[,3],
                       popup = popupStr)
    })
    
    # output$occlvl <- renderPlot({
    #     isolate({
    #         #myid <- currentPT()$id
    #         #if (!is.null(myid)){
    #             occ.plot(points()$id)#[myid])
    #         #}
    #     })
    # })
    
    # Generate a summary of the data ----
    # output$summary <- renderPrint({
    #     summary(d())
    # })
    
    # Generate an HTML table view of the data ----
    # output$table <- renderTable({
    #     d()
    # })
    
}