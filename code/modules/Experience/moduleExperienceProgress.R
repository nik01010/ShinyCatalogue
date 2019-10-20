# Ui functions ------------------------------------------------------------
uiExperienceProgress <- function()
{
  ns <- NS("moduleExperienceProgress")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiExperienceProgress"))
  )
  
  return(userInterfaceOutput)
}


# Server functions --------------------------------------------------------
serverExperienceProgress <- function(input, output, session, moduleData)
{
  ns <- NS("moduleExperienceProgress")
 
  aceEditorTheme <- moduleData$appSettings$codeChunks$aceEditorTheme
  aceEditorMode <- moduleData$appSettings$codeChunks$aceEditorMode
  aceEditorReadOnly <- moduleData$appSettings$codeChunks$aceEditorReadOnly
  packageUrls <- moduleData$appData$packageUrls
  codeChunks <- moduleData$appData$codeChunks
  
  # Tab Ui
  output$uiExperienceProgress <- renderUI({
    
    tagList(
      
      tabBox(
        
        id = ns("tbxExperienceProgress"),
        title = "User experience - Progress bars",
        width = 12,
        side = "left",
        selected = "Progress notifications",
        
        tabPanel(
          
          title = "Progress notifications",
          icon = icon("spinner"),
          
          fluidRow(
            
            column(
              
              width = 12,
              
              column(
                
                width = 5,
                
                h4("Example"),
                h5(
                  "Show a notification with a progress bar, illustrating how
                  a complex process is evolving."
                ),
                
                br(),
                
                fluidRow(
                  
                  column(
                    
                    width = 5,
                    
                    actionButton(
                      inputId = ns("cmdExampleStartProcess"),
                      label = "Start Example Process",
                      icon = icon("play-circle"),
                      width = "100%"
                    )
                    
                  )
                  
                )
                
              ),
              
              column(
                
                width = 7,
                
                h4("Instructions"),
                
                bs_accordion(id = ns("accExperienceProgress")) %>%
                  
                  bs_append(
                    
                    title = "Server changes",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Server, use the withProgress() function wrapped around the 
                        process you want to create a progress bar for."
                      ),
                      h5(
                        "Use the incProgress() function at selected points of the process
                        to split it up into meaningful tasks. For each task, set the new 
                        value of the progress bar using the amount = ... parameter."
                      ),
                      h5(
                        "It's possible to repeat this process such that tasks have
                        sub-tasks with a second progress indicator shown separately."
                      ),
                      h5("A notification can be generated at the end of the process."),
                      
                      aceEditor(
                        outputId = "chunkExperienceProgressServer",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "500px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtExperienceProgressServer
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
  
  # Show the progress indicator when prompted
  observeEvent(
    input$cmdExampleStartProcess,
    {
      # Progress indicator
      withProgress(
        message = "Example progress bar",
        value = 0,
        min = 0,
        max = 4,
        {
          
          # Task 1
          incProgress(amount = 1, detail = "Task 1")
          # Simulating task using sleep function
          Sys.sleep(2)
          
          # Task 2
          incProgress(amount = 1, detail = "Task 2")
          # Task 2 sub-tasks
          withProgress(
            message = "Task 2 sub-tasks",
            value = 0,
            min = 1,
            max = 5,
            {
              # Task 2 Subtask
              # Simulating looped task using sleep function
              for(i in 1:5){
                incProgress(amount = 1, detail = paste("Processing Task 2 Item",i))
                Sys.sleep(1)
              }
            }
          )
          
          # Task 3
          incProgress(amount = 1, detail = "Task 3")
          # Simulating task using sleep function
          Sys.sleep(2)
        }
      )
      
      # Completed notification
      showNotification(
        ui = list(
          h4(strong("Completed")),
          h5(paste("Example process completed at", Sys.time()))
        ),
        duration = NULL,
        closeButton = TRUE,
        session = session
      )
    }
  )
  
  
}