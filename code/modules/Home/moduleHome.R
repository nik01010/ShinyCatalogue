# Ui functions ------------------------------------------------------------
uiHome <- function()
{
  ns <- NS("moduleHome")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiHome"))
  )
  
  return(userInterfaceOutput)
}


# Server functions --------------------------------------------------------
serverHome <- function(input, output, session)
{
  ns <- NS("moduleHome")
  
  # Tab Ui
  output$uiHome <- renderUI({
    
    tagList(
      
      br(),
      
      fluidRow(
        
        column(
          
          width = 12,
          
          box(
            width = 9,
            title = NULL,
            status = "info",
            collapsible = FALSE,
            solidHeader = TRUE,
            
            column(
              width = 12,
              h1("Shiny Catalogue"),
              hr(),
              h5("A collection of re-usable components, modules and tutorials for using advanced R Shinydashboard functionality.")
            )
          )

        )
        
      ),
      
      fluidRow(
          
        column(
          
          width = 3,
          
          box(
            width = 12,
            title = NULL,
            status = "info",
            collapsible = FALSE,
            solidHeader = TRUE,
            
            column(
              width = 2,
              h1(icon("arrow-circle-right"))
            ),
            column(
              width = 10,
              h3("Navigation"),
              h6("Improved sidebar and linking between tabs.")
            )
          ),
          
          box(
            width = 12,
            title = NULL,
            status = "info",
            collapsible = FALSE,
            solidHeader = TRUE,
            
            column(
              width = 2,
              h1(icon("recycle"))
            ),
            
            column(
              width = 8,
              h3("Reactivity"),
              h6("Updating UI content dynamically.")
            )
          ),
          
          box(
            width = 12,
            title = NULL,
            status = "info",
            collapsible = FALSE,
            solidHeader = TRUE,
            
            column(
              width = 2,
              h1(icon("table"))
            ),
            
            column(
              width = 8,
              h3("Data tables"),
              h6("Customisable data table features.")
            )
          )
          
        ),
        
        column(
          
          width = 3,
          
          box(
            width = 12,
            title = NULL,
            status = "info",
            collapsible = FALSE,
            solidHeader = TRUE,
            
            column(
              width = 2,
              h1(icon("user-o"))
            ),
            column(
              width = 10,
              h3("User experience"),
              h6("Popups, input validation and more.")
            )
          ),
          
          box(
            width = 12,
            title = NULL,
            status = "info",
            collapsible = FALSE,
            solidHeader = TRUE,
            
            column(
              width = 2,
              h1(icon("hand-pointer-o"))
            ),
            column(
              width = 10,
              h3("User interaction"),
              h6("Popup input screens and tree structures.")
            )
          ),
          
          box(
            width = 12,
            title = NULL,
            status = "info",
            collapsible = FALSE,
            solidHeader = TRUE,
            
            column(
              width = 2,
              h1(icon("adjust"))
            ),
            column(
              width = 10,
              h3("Appearance"),
              h6("Customisable themes and logos.")
            )
          )
          
        )

        
      )

    )
    
  })
  
}