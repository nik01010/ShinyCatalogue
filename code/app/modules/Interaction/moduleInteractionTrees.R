# Ui functions ------------------------------------------------------------
uiInteractionTrees <- function()
{
  ns <- NS("moduleInteractionTrees")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiInteractionTrees"))
  )
  
  return(userInterfaceOutput)
}

# Server functions --------------------------------------------------------
serverInteractionTrees <- function(input, output, session, moduleData)
{
  ns <- NS("moduleInteractionTrees")
 
  parentSession <- moduleData$parentSession
  aceEditorTheme <- moduleData$appSettings$codeChunks$aceEditorTheme
  aceEditorMode <- moduleData$appSettings$codeChunks$aceEditorMode
  aceEditorReadOnly <- moduleData$appSettings$codeChunks$aceEditorReadOnly
  packageUrls <- moduleData$appData$packageUrls
  codeChunks <- moduleData$appData$codeChunks
  
  # Static data
  projectRootPath <- "../"
  projectFilePaths <- list.files(path = projectRootPath, all.files = FALSE, recursive = TRUE)
  projectFilePathTree <- as.Node(data.frame(pathString = projectFilePaths, Value = projectFilePaths))
  
  # Reactive values
  values <- reactiveValues()
  values$txtInteractionTreesFileContents <- "Select a file in the tree to show its contents here."
  
  # Render collapsible tree
  output$ctrProjectFolderStructure <- renderCollapsibleTree({
    collapsibleTree(
      df = projectFilePathTree,
      inputId = ns("treProjectFolderStructure"),
      tooltip=TRUE,
      attribute="Value",
      aggFun=identity,
      zoomable = TRUE,
      width = "100%",
      height = "600px"
    )
  })
  
  # Tab Ui
  output$uiInteractionTrees <- renderUI({
    
    tagList(
      
      tabBox(
        
        id = ns("tbxInteractionTrees"),
        title = "Interaction - Collapsible Trees",
        width = 12,
        side = "left",
        selected = "Basic tree input",
        
        tabPanel(
          
          title = "Basic tree input",
          icon = icon("sitemap"),
          
          fluidRow(
            
            column(
              
              width = 12,
              
              column(
                
                width = 6,
                
                h4("Example"),
                h5("Visualise collapsible tree structures and allow selection of nodes."),
                
                collapsibleTreeOutput(ns("ctrProjectFolderStructure"))
                
              ),
              
              column(
                
                width = 6,
                
                br(),
                br(),
                
                h5("File contents"),
                
                aceEditor(
                  outputId = ns("chunkInteractionTreesFileContents"),
                  theme = aceEditorTheme,
                  mode = aceEditorMode,
                  height = "450px",
                  readOnly = aceEditorReadOnly,
                  value = "# Select a file in the tree to show its contents here."
                )
                
              )
              
            )
            
          )
        
        )
        
      )
    
    )
    
  })
  
  # Read file contents when prompted
  observeEvent(
    input$treProjectFolderStructure,
    {
      # Use selected node to get required filepath
      basePath <- "."
      selectedNodePath <- paste(input$treProjectFolderStructure, collapse = "/")
      selectedFilePath <- file.path(basePath, selectedNodePath)
      
      # Check path is a valid file and not a folder directory
      if(file.exists(selectedFilePath) && !dir.exists(selectedFilePath)){
        
        # Read file contents
        fileContents <- readtext(file = selectedFilePath)
        # Update file contents viewer
        updateAceEditor(
          session = parentSession,
          editorId = ns("chunkInteractionTreesFileContents"),
          value = paste(
            "### ShinyCatalogue",
            paste("### Selected file:", selectedFilePath), 
            fileContents$text, 
            sep = "\n"
          )
        )
      }
    }
  )
  
}