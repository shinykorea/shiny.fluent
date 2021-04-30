customOutputUI <- function(id) {
  ns <- NS(id)
  tagList(
    h1("Leaflet - a custom output inside React"),
    div(style = "display: none", leafletOutput(ns("elo"))),
    Stack(
      div(
        h3("Leaflet output"),
        PrimaryButton.shinyInput(ns("recalc"), text = "Refresh points"),
        p(),
        p("Leaflet output works inside JSX context"),
        leafletOutput(ns("map1")),
        h3("Pivot"),
        p("And inside a Pivot"),
        Pivot(
          PivotItem(
            headerText = ns("Tab 1"),
            Label("Hello 1")
          ),
          PivotItem(
            headerText = "Leaflet inside a Pivot",
            leafletOutput(ns("map2"))
          ),
          PivotItem(
            headerText = "DT inside a Pivot",
            DTOutput(ns("dt")),
            uiOutput(ns("dt_interaction_output"))
          )
        )
      )
    )
  )
}

customOutputServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    points <- eventReactive(input$recalc, {
      cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    }, ignoreNULL = FALSE)
    
    output$map1 <- renderLeaflet({
      leaflet() %>%
        addProviderTiles(providers$Stamen.TonerLite, options = providerTileOptions(noWrap = TRUE)) %>%
        addMarkers(data = points())
    })
    
    output$map2 <- renderLeaflet({
      leaflet() %>%
        addProviderTiles(providers$Stamen.TonerLite, options = providerTileOptions(noWrap = TRUE)) %>%
        addMarkers(data = points())
    })
    
    output$dt <- renderDT(iris, options = list(lengthChange = FALSE))
    
    output$dt_interaction_output <- renderUI({
      div(
        h3("Communication from DT back to Shiny works as well!"),
        h5(paste("Rows selected:", paste(input$dt_rows_selected, collapse = ", ")))
      )
    })
  })
}
