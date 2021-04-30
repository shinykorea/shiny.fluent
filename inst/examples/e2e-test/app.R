library(shiny)
library(shiny.fluent)
library(leaflet)
library(DT)

ui <- fluidPage(
  fluentInputsUI("fluentInputs"),
  shinyInReactUI("shinyInReact"),
  scenariosUI("scenarios"),
  actionButtonsUI("actionButtons"),
  reactInShinyUI("reactInShiny"),
  customOutputUI("customOutput")
)

server <- function(input, output, session) {
  
  fluentInputsServer("fluentInputs")
  shinyInReactServer("shinyInReact")
  scenariosServer("scenarios")
  actionButtonsServer("actionButtons")
  reactInShinyServer("reactInShiny")
  customOutputServer("customOutput")
  
}

shinyApp(ui, server)
