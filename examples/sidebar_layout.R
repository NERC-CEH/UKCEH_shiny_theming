#
# This is an example Shiny web application with a UKCEH theme. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(bslib)

devtools::source_url("https://github.com/NERC-CEH/UKCEH_shiny_theming/blob/main/theme_elements.R?raw=TRUE")


# Define UI for application that draws a histogram
ui <- fluidPage(
  #theme
  theme = UKCEH_theme,
  
  # Application title
  UKCEH_titlePanel("Old Faithful Geyser Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
      textInput("textinput","Text input"),
      actionButton("action","Action button"),
      dateRangeInput("daterange","Date range"),
      fileInput("file","Upload file")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = '#0483A4', border = 'white')
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
