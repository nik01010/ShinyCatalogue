# Ui functions ------------------------------------------------------------
uiCollapsibleSidebar <- function(sideBarWidthPixels = 230){
  logoWidthSettings <- tagList(
    inlineCSS(paste0(".main-header > .navbar {margin-left: ", sideBarWidthPixels, "px !important}")),
    inlineCSS(paste0(".main-header .logo {width: ", sideBarWidthPixels, "px !important}"))
  )
  
  return(logoWidthSettings)
}


# Server functions --------------------------------------------------------
serverCollapsibleSidebar <- function(sidebarHoverAreaId = "sidebarCollapsed")
{
  # Custom CSS styles -------------------------------------------------------
  # Sidebar collapsed by default
  addClass(selector = "body", class = "sidebar-collapse")
  # Sidebar shows icons even when collapsed  
  addClass(selector = "body", class = "sidebar-mini")
  
  # JavaScript events -------------------------------------------------------
  # Sidebar expands to default width on mouse hover
  onevent(event = "mouseenter", id = sidebarHoverAreaId, expr = removeClass(selector = "body", class = "sidebar-collapse"))
  # Sidebar contracts after mouse hover stops
  onevent(event = "mouseleave", id = sidebarHoverAreaId, expr = addClass(selector = "body", class = "sidebar-collapse"))
}
