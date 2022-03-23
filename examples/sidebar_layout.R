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

#theming with bslib
UKCEH_theme <- bs_theme(
  bg = "#fff",
  fg = "#292C2F",
  primary = "#0483A4",
  secondary = "#EAEFEC",
  success = "#37a635",
  info = "#34b8c7",
  warning = "#F49633",
  base_font = font_link(family = "Montserrat",href = "https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap")
)

#increase the font weight of the headings (h1, h2, h3, h4, h5, h6)
UKCEH_theme <- bs_add_variables(UKCEH_theme,
                                # low level theming
                                "headings-font-weight" = 600)

#titlePanel replacement
UKCEH_titlePanel <- function(title = "UKCEH Shiny app", windowTitle = title){
  
  div(
    img(src="https://www.ceh.ac.uk/sites/default/files/images/theme/ukceh_logo_long_720x170_rgb.png",style="height: 50px;vertical-align:middle;"),
      
    h2(  
      title,
      style ='vertical-align:middle; display:inline;padding-left:40px;'
    ),
    tagList(tags$head(tags$title(paste0(windowTitle," | UK Centre for Ecology & Hydrology")),
                      tags$link(rel="shortcut icon", href="https://brandroom.ceh.ac.uk/themes/custom/ceh/favicon.ico"))),
    style = "padding: 30px;"
  )
}


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
