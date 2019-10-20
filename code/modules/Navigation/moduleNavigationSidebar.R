# Ui functions ------------------------------------------------------------
uiNavigationSidebar <- function()
{
  ns <- NS("moduleNavigationSidebar")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiNavigationSidebar"))
  )
  
  return(userInterfaceOutput)
}

# Server functions --------------------------------------------------------
serverNavigationSidebar <- function(input, output, session, moduleData)
{
  ns <- NS("moduleNavigationSidebar")
  
  aceEditorTheme <- moduleData$appSettings$codeChunks$aceEditorTheme
  aceEditorMode <- moduleData$appSettings$codeChunks$aceEditorMode
  aceEditorReadOnly <- moduleData$appSettings$codeChunks$aceEditorReadOnly
  packageUrls <- moduleData$appData$packageUrls
  codeChunks <- moduleData$appData$codeChunks

  userInterface <- tagList(
    
    tabBox(
      
      id = ns("tbxNavigationSidebar"),
      title = "Navigation - Sidebar Menu",
      width = 12,
      side = "left",
      selected = "Collapsible Sidebar",
      
      tabPanel(
        
        title = "Collapsible Sidebar",
        icon = icon("compress"),
        
        fluidRow(
          
          column(
            
            width = 12,
            
            column(
              
              width = 4,
              
              h4("Example"),
              h5(
                "Custom sidebar menu that is collapsed by default when opening the application,
                but still shows a column of icons, and expands to its full width when the user
                hovers a mouse cursor over the sidebar area."
              ),
              
              img(src = "collapsibleSidebar.gif")
              
            ),
            
            column(
              
              width = 8,
              
              h4("Instructions"),
              
              bs_accordion(id = ns("accNavigationSidebar")) %>%
                
                bs_append(
                  
                  title = "Step 1: Required Packages",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5("Install the below package(s) and ensure they're loaded in your code."),
                    
                    h5(packageUrls$shinyjs)
                    
                  )
                  
                ) %>%
                
                bs_append(
                  
                  title = "Step 2: Create helper functions",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5("Copy the below functions and ensure they are sourced within your application."),

                    aceEditor(
                      outputId = "chunkCollapsibleSidebarHelper",
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "390px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtCollapsibleSidebarHelper
                    )
                    
                  )
                  
                ) %>%
                
                bs_append(
                  
                  title = "Step 3: Ui changes",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5(
                      "Insert the useShinyjs() function within the sidebarMenu part of the application.
                       This will allow JavaScript to be injected from the Server into the Ui."
                    ),
                    h5(
                      "The uiCollapsibleSidebar() function can be used to set a permanent width for the
                      application logo area. Alternatively, the logo area will collapse along with the sidebar."
                    ),
                    
                    aceEditor(
                      outputId = "chunkCollapsibleSidebarUiChanges",
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "230px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtCollapsibleSidebarUiChanges
                    )
                    
                  )
                  
                ) %>%
                
                bs_append(
                  
                  title = "Step 4: Server changes",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5("Call the helper function created above."),
                    
                    aceEditor(
                      outputId = "chunkCollapsibleSidebarServerChanges",
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "120px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtCollapsibleSidebarServerChanges
                    )
                    
                  )
                  
                )
              
            )
            
          )
          
        )
        
      )
      
    )
    
  )
  
  output$uiNavigationSidebar <- renderUI({
    userInterface
  })
  
}