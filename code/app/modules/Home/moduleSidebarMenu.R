# Ui functions ------------------------------------------------------------
uiSidebarMenuItems <- function()
{
  userInterfaceOutput <- tagList(
    
    menuItem(text = "Home", tabName = "tabHome", icon = icon("th")),

    menuItem(text = "Navigation", tabName = "tabNavigation", icon = icon("arrow-circle-right"),
      menuSubItem(text = "Sidebar menu", tabName = "tabNavigationSidebar", icon = icon("bars")),
      menuSubItem(text = "Link between tabs", tabName = "tabNavigationLinks", icon = icon("object-group"))
    ),

    menuItem(text = "Reactivity", tabName = "tabReactivity", icon = icon("recycle"),
      menuSubItem(text = "Dynamic drop-downs", tabName = "tabReactivityDropdowns", icon = icon("chevron-circle-down"))
    ),

    menuItem(text = "Data tables", tabName = "tabDataTables", icon = icon("table")),

    menuItem(text = "User experience", tabName = "tabExperience", icon = icon("user-o"),
             menuSubItem(text = "Popup messages", tabName = "tabExperiencePopups", icon = icon("info-circle")),
             menuSubItem(text = "Input validation", tabName = "tabExperienceValidation", icon = icon("times-circle")),
             menuSubItem(text = "Progress indicators", tabName = "tabExperienceProgress", icon = icon("spinner"))
    ),

    menuItem(text = "User interaction", tabName = "tabUserInteraction", icon = icon("hand-pointer-o"),
             menuSubItem(text = "Popup input screens", tabName = "tabInteractionPopupScreens", icon = icon("object-ungroup")),
             menuSubItem(text = "Collapsible Trees", tabName = "tabInteractionTrees", icon = icon("sitemap"))
    ),

    menuItem(text = "Appearance", tabName = "tabAppearance", icon = icon("adjust"),
      menuSubItem(text = "Themes", tabName = "tabAppearanceThemes", icon = icon("paint-brush"))
    )
    
  )
  
  return(userInterfaceOutput)
}
