# Ui functions ------------------------------------------------------------
uiExperiencePopups <- function()
{
  ns <- NS("moduleExperiencePopups")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiExperiencePopups"))
  )
  
  return(userInterfaceOutput)
}

# Server functions --------------------------------------------------------
serverExperiencePopups <- function(input, output, session, moduleData)
{
  ns <- NS("moduleExperiencePopups")
 
  aceEditorTheme <- moduleData$appSettings$codeChunks$aceEditorTheme
  aceEditorMode <- moduleData$appSettings$codeChunks$aceEditorMode
  aceEditorReadOnly <- moduleData$appSettings$codeChunks$aceEditorReadOnly
  packageUrls <- moduleData$appData$packageUrls
  codeChunks <- moduleData$appData$codeChunks
  
  # Tab Ui
  output$uiExperiencePopups <- renderUI({
    
    tagList(
      
      tabBox(
        
        id = ns("tbxExperiencePopups"),
        title = "User experience - Popup messages",
        width = 12,
        side = "left",
        selected = "Shinyalert popups",
        
        tabPanel(
          
          title = "Shinyalert popups",
          icon = icon("bell-o"),
          
          fluidRow(
            
            column(
              
              width = 12,
              
              column(
                
                width = 5,
                
                h4("Example"),
                h5(
                  "Create popup alerts to notify the user of successfully completed tasks, 
                  warning/error messages or other useful information. These can be combined
                  with the input validation techniques shown separately in this catalogue."
                ),
                
                br(),
                
                fluidRow(
                  
                  column(
                    
                    width = 5,
                    
                    actionButton(
                      inputId = ns("cmdShowPopupSuccess"),
                      label = "Show success message",
                      icon = icon("check-circle"),
                      width = "100%"
                    )
                    
                  )
                  
                ),
                
                br(),
                
                fluidRow(
                  
                  column(
                    
                    width = 5,
                    
                    actionButton(
                      inputId = ns("cmdShowPopupInfo"),
                      label = "Show info message",
                      icon = icon("info-circle"),
                      width = "100%"
                    )
                    
                  )
                  
                ),
                
                br(),
                
                fluidRow(
                  
                  column(
                    
                    width = 5,
                    
                    actionButton(
                      inputId = ns("cmdShowPopupWarning"),
                      label = "Show warning message",
                      icon = icon("exclamation-circle"),
                      width = "100%"
                    )
                    
                  )
                  
                ),
                
                br(),
                
                fluidRow(
                  
                  column(
                    
                    width = 5,
                    
                    actionButton(
                      inputId = ns("cmdShowPopupError"),
                      label = "Show error message",
                      icon = icon("times-circle"),
                      width = "100%"
                    )
                    
                  )
                  
                )
                
                ),
              
              column(
                
                width = 7,
                
                h4("Instructions"),
                
                bs_accordion(id = ns("accExperiencePopups")) %>%
                  
                  bs_append(
                    
                    title = "Step 1: Required Packages",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("Install the below package(s) and ensure they're loaded in your code."),
                      
                      h5(packageUrls$shinyalert),
                      
                      fluidRow(
                        
                        column(
                          
                          width = 12,
                          
                          h5(
                            "In the Ui, add the below line to enable shinyalert functionality."
                          ),
                          
                          aceEditor(
                            outputId = "chunkExperiencePopupsShinyalert",
                            theme = aceEditorTheme,
                            mode = aceEditorMode,
                            height = "90px",
                            readOnly = aceEditorReadOnly,
                            value = codeChunks$txtInteractionPopupsShinyalert
                          )
                          
                        )
                        
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 2: Server changes",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Server, use the shinyalert() function to generate the required popups.
                        Further available options and settings are given in the package documentation."
                      ),
                      
                      aceEditor(
                        outputId = "chunkExperiencePopupsServer",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "400px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtExperiencePopupsServer
                      )
                      
                    )
                    
                  )
                
              )
              
            )
            
          )
          
        )
        
      )
    
    )
    
  })
  
  # Show popup alerts when prompted
  
  # Success
  observeEvent(
    input$cmdShowPopupSuccess,
    {
      shinyalert(
        title = "Completed",
        text = "This is an example Success message",
        type = "success"
      )
    }
  )
  
  # Info
  observeEvent(
    input$cmdShowPopupInfo,
    {
      shinyalert(
        title = "FYI",
        text = "This is an example Info message",
        type = "info"
      )
    }
  )
  
  # Warning
  observeEvent(
    input$cmdShowPopupWarning,
    {
      shinyalert(
        title = "Careful",
        text = "This is an example Warning message",
        type = "warning"
      )
    }
  )
  
  # Error
  observeEvent(
    input$cmdShowPopupError,
    {
      shinyalert(
        title = "Error",
        text = "This is an example Error message",
        type = "error"
      )
    }
  )
  
}