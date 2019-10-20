### ReadMe ------------------------------------------------------------------
###     Purpose:        App start script for the ShinyCatalogue application.
###
###     Contact:        Nik Lilovski
###

# Loading packages --------------------------------------------------------
library(shinydashboard)
library(dashboardthemes)
library(shinyAce)
library(shinyjs)
library(styler)
library(readtext)
library(bsplus)
library(tools)
library(dplyr)
library(shinyalert)
library(DT)
library(lubridate)
library(data.tree)
library(collapsibleTree)


# Source functions --------------------------------------------------------
source("./code/functions/appStart.R")
importShinyModules()

# Ui ----------------------------------------------------------------------
ui <- dashboardPage(
  
  # Browser window title
  title = "Shiny Catalogue",
    
  # Header ------------------------------------------------------------------
  header = dashboardHeader(
    
    # Shiny app title
    title = shinyDashboardLogoDIY(
      boldText = paste(icon("bookmark"), "Shiny"),
      mainText = "Catalogue",
      textSize = 16,
      badgeText = "v1.0",
      badgeTextColor = "white",
      badgeTextSize = 2,
      badgeBackColor = "#40E0D0",
      badgeBorderRadius = 3
    )
    
  ),
  
  # Sidebar -----------------------------------------------------------------
  sidebar = dashboardSidebar(
  
    sidebarMenu(
      
      id = "tbsSidebar",
      
      # Allowing the shinyalert package to be used
      useShinyalert(),
      
      # Allowing the shinyjs package to be used
      useShinyjs(),
      
      # Allowing for collapsible sidebar with fixed width logo
      uiCollapsibleSidebar(sideBarWidthPixels = 230),
      
      ### sidebar tab links -------------------------------------------------------
      uiSidebarMenuItems()
      
    )

  ),

  # Body --------------------------------------------------------------------
  body = dashboardBody(

    # Custom theme ------------------------------------------------------------
    # Starting theme
    shinyDashboardThemes(theme = "grey_light"),
    # Enabling live theme switcher to work
    uiChangeThemeOutput(),
    
    # Ui tabs -----------------------------------------------------------------
    tabItems(

      tabItem(tabName = "tabHome", uiHome()),
      tabItem(tabName = "tabNavigationSidebar", uiNavigationSidebar()),
      tabItem(tabName = "tabNavigationLinks", uiNavigationLinks()),
      tabItem(tabName = "tabReactivityDropdowns", uiReactivityDropdowns()),
      tabItem(tabName = "tabDataTables", uiDataTables()),
      tabItem(tabName = "tabExperiencePopups", uiExperiencePopups()),
      tabItem(tabName = "tabExperienceValidation", uiExperienceValidation()),
      tabItem(tabName = "tabExperienceProgress", uiExperienceProgress()),
      tabItem(tabName = "tabInteractionPopupScreens", uiInteractionPopupScreens()),
      tabItem(tabName = "tabInteractionTrees", uiInteractionTrees()),
      tabItem(tabName = "tabAppearanceThemes", uiAppearanceThemes())
    
    )

  )

)

# Server ------------------------------------------------------------------
server <- function(input, output, session) 
{
  # Customisation -----------------------------------------------------------
  serverCollapsibleSidebar(sidebarHoverAreaId = "sidebarCollapsed")
  
  # Module data -------------------------------------------------------------
  moduleData <- list()
  moduleData$appSettings <- appSettings()
  moduleData$appData <- appData()
  moduleData$parentSession <- session
  
  # Loading modules ---------------------------------------------------------
  callModule(module = serverHome, id = "moduleHome")
  callModule(module = serverNavigationSidebar, id = "moduleNavigationSidebar", moduleData = moduleData)
  callModule(module = serverNavigationTabLinks, id = "moduleNavigationTabLinks", moduleData = moduleData)
  callModule(module = serverReactivityDropdowns, id = "moduleReactivityDropdowns", moduleData = moduleData)
  callModule(module = serverDataTables, id = "moduleDataTables", moduleData = moduleData)
  callModule(module = serverExperiencePopups, id = "moduleExperiencePopups", moduleData = moduleData)
  callModule(module = serverExperienceValidation, id = "moduleExperienceValidation", moduleData = moduleData)
  callModule(module = serverExperienceProgress, id = "moduleExperienceProgress", moduleData = moduleData)
  callModule(module = serverInteractionPopupScreens, id = "moduleInteractionPopupScreens", moduleData = moduleData)
  callModule(module = serverInteractionTrees, id = "moduleInteractionTrees", moduleData = moduleData)
  callModule(module = serverChangeTheme, id = "moduleChangeTheme")
  callModule(module = serverAppearanceThemes, id = "moduleAppearanceThemes", moduleData = moduleData)
}

# Dashboard launcher ------------------------------------------------------
shinyApp(ui = ui, server = server)
