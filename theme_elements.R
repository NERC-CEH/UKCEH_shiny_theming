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