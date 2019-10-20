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
  
  # Example file paths for a project
  projectFilePaths <- c(
    "app/ui.R",
    "app/server.R",
    "app/ShinyCatalogue.Rproj",
    "app/Scripts/functions/appStart.R",
    "app/Scripts/modules/Appearance/moduleAppearanceThemes.R",
    "app/Scripts/modules/Appearance/moduleChangeTheme.R",
    "app/Scripts/modules/DataTables/moduleDataTables.R",
    "app/Scripts/modules/Experience/moduleExperiencePopups.R",
    "app/Scripts/modules/Experience/moduleExperienceProgress.R",
    "app/Scripts/modules/Experience/moduleExperienceValidation.R",
    "app/Scripts/modules/Home/moduleHome.R",
    "app/Scripts/modules/Home/moduleSidebarMenu.R",
    "app/Scripts/modules/Interaction/moduleInteractionPopupScreens.R",
    "app/Scripts/modules/Interaction/moduleInteractionTrees.R",
    "app/Scripts/modules/Navigation/moduleCollapsibleSidebar.R",
    "app/Scripts/modules/Navigation/moduleNavigationLinks.R",
    "app/Scripts/modules/Navigation/moduleNavigationSidebar.R",
    "app/Scripts/modules/Reactivity/moduleReactivityDropdowns.R",
    "app/www/collapsibleSidebar.gif"
  )
  # Alternative method of deriving file paths programmatically
  #projectRootPath <- "../"
  #projectFilePaths <- list.files(path = projectRootPath, all.files = FALSE, recursive = TRUE)
  
  # Creating nodes for tree
  projectFilePathTree <- as.Node(data.frame(pathString = projectFilePaths, Value = projectFilePaths))
  
  # Reactive values
  values <- reactiveValues()
  # Placeholder text
  values$txtSelectedTreePath <- "Select a node in the tree."
  
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
                
                width = 5,
                
                h4("Example"),
                h5("Visualise collapsible tree structures and allow selection of nodes."),
                
                collapsibleTreeOutput(ns("ctrProjectFolderStructure")),
                textOutput(ns("txtSelectedTreePath"))
                
              ),
              
              column(
                
                width = 7,
                
                h4("Instructions"),
                
                bs_accordion(id = ns("accInteractionTrees")) %>%
                  
                  bs_append(
                    
                    title = "Step 1: Required Packages",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("Install the below package(s) and ensure they're loaded in your code."),
                      
                      h5(packageUrls$datatree),
                      h5(packageUrls$collapsibleTree)
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 2: Required data",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("Within the Server, ensure you have loaded the required data for the collapsible tree."),
                      h5("In the example below, a dummy file directory is created using all file paths in a project."),
                      h5("The as.Node() function can help with creating a tree structure from a list."),
                      h5("Create a reactive values object that will store the user's selected node path."),
                      
                      aceEditor(
                        outputId = "chunkInteractionTreesData",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "340px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionTreesData
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 3: Server changes",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Server, create an Output object for the tree using renderCollapsibleTree()
                        Set an Id for the tree, so it can monitored when a node is selected. 
                        Additional options are available to customise the tree's size and appearance."
                      ),
                      h5(
                        "Add an Output object for the text that will show the selected tree node using 
                        renderText(). Ensure this is linked to the reactive values object created above."
                      ),
                      h5(
                        "Add an observeEvent that monitors when the tree is selected, then
                        concatenates the selected node into a path and updates the reactive values
                        text object created earlier with the selected path."
                      ),
                      
                      aceEditor(
                        outputId = "chunkInteractionTreesServer",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "320px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionTreesServer
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 4: Ui changes",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("In the Ui, receive the tree Output object created above using collapsibleTreeOutput()"),
                      h5(
                        "Also receive the text object for the selected node path using textOutput()"
                      ),
                      
                      aceEditor(
                        outputId = "chunkInteractionTreesUi",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "220px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionTreesUi
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
  
  # Render text for selected tree node
  output$txtSelectedTreePath <- renderText({values$txtSelectedTreePath})
  
  # Read file contents when prompted
  observeEvent(
    input$treProjectFolderStructure,
    {
      # Use selected node to get required filepath
      basePath <- "."
      selectedNodePath <- paste(input$treProjectFolderStructure, collapse = "/")
      selectedFilePath <- file.path(basePath, selectedNodePath)
      
      # Update reactive values with selected path
      values$txtSelectedTreePath <- paste("Selected path:", selectedFilePath)
    }
  )
  
}