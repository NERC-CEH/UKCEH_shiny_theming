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
