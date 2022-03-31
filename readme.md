# Theming R Shiny Applications

## Quick start

Make sure your Shiny app loads the required packages:

```
library(shiny)
library(bslib)
```

1. Add the following to the top of `ui.R` or `app.R` (make sure the `devtools` package is installed)
```
devtools::source_url("https://github.com/NERC-CEH/UKCEH_shiny_theming/blob/main/theme_elements.R?raw=TRUE")
```

2.	Add the following to the UI
```
ui <- fluidPage( 
  #theme
  theme = UKCEH_theme,  # << add this line

  # Application title
  UKCEH_titlePanel("Old Faithful Geyser Data"), # << replace your titlePanel() with UKCEH_titlePanel()
  
  ...
)
```

See how it looks in a live Shiny app: https://connect-apps.ceh.ac.uk/content/5f616ea7-af1a-4716-a7bf-48ac970ce788

## Introduction

R Shiny is a very useful way of making your R code run in a user friendly way with a user interface. We can publish R Shiny applications using RStudio Connect: https://connect-apps.ceh.ac.uk/connect/

The generic R Shiny theme is based on bootstrap and doesn't conform to the UKCEH brand guidelines https://brandroom.ceh.ac.uk/. This guide aims to show how to adapt the default Shiny theme to fit in with other UKCEH web presences. You can either made the small additions to your existing Shiny app or work from a example template https://github.com/NERC-CEH/UKCEH_shiny_theming#examples

There are a number of different standard layouts you can use for R Shiny: https://shiny.rstudio.com/articles/layout-guide.html 

If you have any feedback on this guide then please create an issue on this gitub repository or email Simon Rolph (SimRol@ceh.ac.uk) and Kate Randall (KatRan@ceh.ac.uk).

## Incorporating the changes into your shiny app


In the `theme_elements.R` we define `UKCEH_theme` and `UKCEH_titlePanel`. They need to be included in the `fluidPage()` function when defining `ui`. This is an example using the sidebar layout.

The simplest way to get the theme is to use the `source_url()` function in the `devtools` package to source `theme_elements.R` (as suggested by Michael Tso). Alternatively, you could copy the code from https://github.com/NERC-CEH/UKCEH_shiny_theming/blob/main/theme_elements.R?raw=TRUE and put it directly into your app.

You need to install and load the `bslib` package. Presumably you've already installed the `shiny` package.

```{r}
install.packages("bslib")
library(bslib)
library(shiny)
```

```
devtools::source_url("https://github.com/NERC-CEH/UKCEH_shiny_theming/blob/main/theme_elements.R?raw=TRUE")

# Define UI for application that draws a histogram
ui <- fluidPage(
  #theme
  theme = UKCEH_theme,
  
  # Application title
  UKCEH_titlePanel("My first Shiny app"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      ...
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      ...
    )
  )
)
```

You can also change the appearance of plots drawn using `{ggplot2}` appear by using:

```
library(thematic)
thematic::thematic_shiny()
```

See https://rstudio.github.io/thematic/ for more details.

## Colours

The UKCEH colours are defined here: https://brandroom.ceh.ac.uk/sites/default/files/2022-01/UKCEH_Colour_Guidelines.pdf

Here they are in hex code if you want to use them in your plots. For example if you have a bar plot use the hero colour for the bars.

```{r}
logo_colours <- c("#007AC0","#59B444")

hero_colour <- '#0483A4'

primary_palette <- c("#292C2F",'#1685A3','#EAEFEC')

highlight_colour <- c("#F49633")
  
extended_colour_palette <- c("#8f7158","#fee9cd","#90c064","#37a635","#00883c","047e56","007370","#0383a4","#c9e7f2","34b8c7","009dcb","227fc1","0a5da4","00678e","f39532")

```

## Details: changing primary colours and fonts with `{bslib}`

The `bslib` package is designed for theming shiny apps and can be used to change some universal elements like colours and fonts https://shiny.rstudio.com/articles/themes.html

The UKCEH font is Montserrat. It is available on Google fonts: https://fonts.google.com/specimen/Montserrat

These settings make the most of the the existing UKCEH colour palette and sets the correct fonts. 

```
library(bslib)
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

UKCEH_theme <- bs_add_variables(UKCEH_theme,
                                # low level theming
                                "headings-font-weight" = 600)
bs_theme_preview(UKCEH_theme)
```

You can preview a theme with `bs_theme_preview()` which brings up a webpage like so:

*Inputs:*

![image](https://user-images.githubusercontent.com/17750766/159717824-32ca3012-329a-4796-91b1-04fcf0713cc9.png)

*Tables:*

![image](https://user-images.githubusercontent.com/17750766/159717971-c7e59693-da1c-43b0-9eef-55b0b3d5c34d.png)

*Fonts:*

![image](https://user-images.githubusercontent.com/17750766/159718071-d8657f35-a337-4ecc-b259-82c4156bea81.png)



## Logo, title and favicon

In R Shiny you can use the `titlePanel()` function (https://shiny.rstudio.com/reference/shiny/0.14/titlePanel.html) to give the page a title at the top of the page and it also updates the title in the tab to be the same text.

The favicon is the tiny little image that appears in the tab of the web browser, it can be accessed direct via a web link from the brand room https://brandroom.ceh.ac.uk/themes/custom/ceh/favicon.ico so we don't need to download it ourselves.

Here is a drop in replacement of that function which also adds the UKCEH logo and adds `| UK Centre for Ecology and Hydrology` after the title in the tab.


```
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
```

When `UKCEH_titlePanel` is included in the Shiny app it looks like this:
![image](https://user-images.githubusercontent.com/17750766/159720789-dff9186c-7bca-437a-a487-46a57f44e014.png)

Note how the favicon and tab title have changed:

![image](https://user-images.githubusercontent.com/17750766/159717427-a5454c2c-02d3-4241-8c23-fb769fd68e3e.png)


## Footer

Currently still working on the best way to format a footer and what content to include from the main site etc.

## Examples

### Sidebar layout

A UKCEH branded version of the standard R Shiny example with some extra false inputs added to the sidebar.

![image](https://user-images.githubusercontent.com/17750766/159717529-08361e20-bc3e-4c27-b7d2-3967c8317613.png)

Code: https://github.com/NERC-CEH/UKCEH_shiny_theming/blob/main/examples/sidebar_layout.R

Live preview: https://connect-apps.ceh.ac.uk/content/5f616ea7-af1a-4716-a7bf-48ac970ce788

### Fluid page layout

*Coming soon*

### Navbar layout

*Coming soon*
