# Ui functions ------------------------------------------------------------
uiNavigationLinks <- function()
{
  ns <- NS("moduleNavigationTabLinks")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiNavigationLinks"))
  )
  
  return(userInterfaceOutput)
}

# Server functions --------------------------------------------------------
serverNavigationTabLinks <- function(input, output, session, moduleData)
{
  ns <- NS("moduleNavigationTabLinks")

  parentSession <- moduleData$parentSession
  aceEditorTheme <- moduleData$appSettings$codeChunks$aceEditorTheme
  aceEditorMode <- moduleData$appSettings$codeChunks$aceEditorMode
  aceEditorReadOnly <- moduleData$appSettings$codeChunks$aceEditorReadOnly
  codeChunks <- moduleData$appData$codeChunks
  
  userInterface <- tagList(
    
    # Generate user interface
    tabBox(
      
      id = ns("tbxNavigationTabLinks"),
      title = "Navigation - Link between tabs",
      width = 12,
      side = "left",
      selected = "Sidebar links",
      
      tabPanel(
        
        title = "Sidebar links",
        icon = icon("external-link"),
        
        fluidRow(
          
          column(
            
            width = 12,
            
            column(
              
              width = 4,
              
              h4("Example"),
              h5("Use buttons or text hyperlinks to change the selected sidebar tab."),
              br(),
              
              fluidRow(
                
                column(
                  
                  width = 12,
                  
                  h5("Button links"),
                  actionButton(inputId = ns("cmdLinkToHome"), label = "Link to Homepage", icon = icon("th")),
                  actionButton(inputId = ns("cmdLinkToThemes"), label = "Link to Themes", icon = icon("paint-brush"))
                  
                )
                
              ),
              
              br(),
              
              fluidRow(
                
                column(
                  
                  width = 12,
                  
                  h5("Text links"),
                  actionLink(inputId = ns("lnkLinkToHome"), label = "Link To Homepage", icon = icon("th")),
                  br(),
                  actionLink(inputId = ns("lnkLinkToThemes"), label = "Link To Themes", icon = icon("paint-brush")) 
                  
                )
                
              )
              
            ),
            
            column(
              
              width = 8,
              
              h4("Instructions"),
              
              bs_accordion(id = ns("accNavigationTabLinks")) %>%
                
                bs_append(
                  
                  title = "Step 1: Ui changes",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5(
                      "Set an Id for the application sidebar."
                    ),
                    
                    aceEditor(
                      outputId = "chunkTabLinksSidebarId",
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "120px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtTabLinksSidebarId
                    ),
                    
                    h5(
                      "For a button link create an actionButton, or for a text hyperlink create 
                      an actionLink, and set a specific Id that can be monitored in the Server."
                    ),

                    aceEditor(
                      outputId = "chunkTabLinksSidebarUi",
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "190px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtTabLinksSidebarUi
                    )
                    
                  )
                  
                ) %>% 
                
                bs_append(
                  
                  title = "Step 2: Server changes",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5(
                      "Add an observeEvent to monitor when the link Id created above is pressed,
                       and subsequently change the selected tab of the application sidebar."
                    ),
                    h5(
                      "Note, for actionLinks, the ignoreInit = TRUE parameter is set to avoid
                      the link being activated when the page is first rendered."
                    ),
                    
                    aceEditor(
                      outputId = "chunkTabLinksButtonServer",
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "300px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtTabLinksSidebarServer
                    )
                    
                  )
                  
                )
              
            )
            
          )
          
        )
      
      )
      
    )
    
  )
  
  # Send user interface to Ui
  output$uiNavigationLinks <- renderUI({
    userInterface
  })
  
  # Monitor buttons and change selected tab
  observeEvent(
    input$cmdLinkToHome,
    {
      updateTabItems(session = parentSession, inputId = "tbsSidebar", selected = "tabHome")
    }
  )
  
  observeEvent(
    input$cmdLinkToThemes,
    {
      updateTabItems(session = parentSession, inputId = "tbsSidebar", selected = "tabAppearanceThemes")
    }
  )
  
  # Monitor links and change selected tab
  observeEvent(
    input$lnkLinkToHome,
    {
      updateTabItems(session = parentSession, inputId = "tbsSidebar", selected = "tabHome")
    },
    ignoreInit = TRUE
  )
  
  observeEvent(
    input$lnkLinkToThemes,
    {
      updateTabItems(session = parentSession, inputId = "tbsSidebar", selected = "tabAppearanceThemes")
    },
    ignoreInit = TRUE
  )
  
}