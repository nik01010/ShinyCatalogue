# Ui functions ------------------------------------------------------------
uiInteractionPopupScreens <- function()
{
  ns <- NS("moduleInteractionPopupScreens")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiInteractionPopupScreens"))
  )
  
  return(userInterfaceOutput)
}

# Helper functions --------------------------------------------------------
# Helper function to create popup input screen
popupInputScreen <- function(title, actionButtonId, actionButtonLabel)
{
  ns <- NS("moduleInteractionPopupScreens")
  
  popupScreen <- modalDialog(
    
    title = title,
    size = "m",
    easyClose = FALSE,
    
    fluidPage(
      
      fluidRow(
        
        column(
          
          width = 12,
          
          textInput(
            inputId = ns("txtProductName"),
            label = "Product Name",
            value = NULL,
          ),
          
          numericInput(
            inputId = ns("nbxProductPrice"),
            label = "Product Price",
            min = 0,
            max = 1000,
            value = 0,
            step = 1
          )
          
        )

      )
      
    ),
    
    footer = list(
      actionButton(
        inputId = ns(actionButtonId),
        label = actionButtonLabel,
        icon = icon("save")
      ),
      
      modalButton("Dismiss")
    )
      
  )
}

# Helper function to validate Product inputs
validateProductData <- function(name, price)
{
  if(is.null(name) || is.null(price)){
    return(FALSE)
  }
  if(is.character(name) == FALSE || is.numeric(price) == FALSE){
    return(FALSE)
  }
  if(name == "" || price < 0){
    return(FALSE)
  }
  return(TRUE)
}

# Server functions --------------------------------------------------------
serverInteractionPopupScreens <- function(input, output, session, moduleData)
{
  ns <- NS("moduleInteractionPopupScreens")
 
  aceEditorTheme <- moduleData$appSettings$codeChunks$aceEditorTheme
  aceEditorMode <- moduleData$appSettings$codeChunks$aceEditorMode
  aceEditorReadOnly <- moduleData$appSettings$codeChunks$aceEditorReadOnly
  packageUrls <- moduleData$appData$packageUrls
  codeChunks <- moduleData$appData$codeChunks
  
  # Reactive values
  values <- reactiveValues()
  values$tblProducts <- data.frame(
    Name = c("PS4", "Xbox", "Switch"),
    Price = c(300, 250, 200),
    stringsAsFactors = FALSE
  )
  
  # Render tables
  observe({
    output$tblProducts <- DT::renderDataTable({
      datatable(
        data = values$tblProducts,
        rownames = FALSE,
        selection = "single",
        options = list(
          dom = "t"
        )
      )
    })
    
    output$tblProductsEdit <- DT::renderDataTable(
      {
        datatable(
          data = values$tblProducts,
          rownames = FALSE,
          selection = "single",
          options = list(
            dom = "t"
          )
        )
      },
      server = TRUE
    )
  })

  
  # Tab Ui
  output$uiInteractionPopupScreens <- renderUI({
    
    tagList(
      
      tabBox(
        
        id = ns("tbxInteractionPopupScreens"),
        title = "User interaction - Popup input screens",
        width = 12,
        side = "left",
        selected = "Add table row",
        
        tabPanel(
          
          title = "Add table row",
          icon = icon("plus-circle"),
          
          fluidRow(
            
            column(
              
              width = 12,
              
              column(
                
                width = 4,
                
                h4("Example"),
                h5("Create new row of data in a table using a popup input screen."),
                
                fluidRow(
                  
                  column(
                    
                    width = 8,

                    dataTableOutput(ns("tblProducts"))
                    
                  )

                ),
                
                br(),
                
                fluidRow(
                  
                  column(
                    
                    width = 8,
                    
                    actionButton(
                      inputId = ns("cmdShowAddProductScreen"),
                      label = "Add Product",
                      icon = icon("plus-circle"),
                      width = "100%"
                    )
                    
                  )
                  
                )
                
              ),
              
              column(
                
                width = 8,
                
                h4("Instructions"),
                
                bs_accordion(id = ns("accInteractionPopupScreensAdd")) %>%
                  
                  bs_append(
                    
                    title = "Step 1: Required Packages",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("Install the below package(s) and ensure they're loaded in your code."),
                      
                      h5(packageUrls$shinyalert),
                      h5(packageUrls$DT),
                      
                      fluidRow(
                        
                        column(
                          
                          width = 12,
                          
                          h5(
                            "In the Ui, add the below line to enable shinyalert functionality."
                          ),
                          
                          aceEditor(
                            outputId = "chunkInteractionPopupsShinyalert",
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
                    
                    title = "Step 2: Required data",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("Within the Server, ensure you have loaded the required data for the table."),
                      h5(
                        "Create a reactive values object using the data - this will allow the table to automatically
                         update on screen with any new records once they are created."
                      ),
                      
                      aceEditor(
                        outputId = "chunkInteractionPopupsData",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "160px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionPopupsData
                      )
                      
                    )
                    
                  ) %>%
                  

                  
                  bs_append(
                    
                    title = "Step 3: Create table and Add button",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Server, create an Output object for the required table using 
                        DT::renderDataTable(), linked to the reactive values dataframe created above."
                      ),
                      
                      aceEditor(
                        outputId = "chunkInteractionPopupsTableServer",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "240px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionPopupsTableServer
                      ),
                      
                      h5(
                        "In the Ui, receive the Output object created above using dataTableOutput(),
                        and create an actionButton underneath, which will show the popup input screen."
                      ),
                      
                      aceEditor(
                        outputId = "chunkInteractionPopupsTableUi",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "210px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionPopupsTableUi
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 4: Helper functions",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "Create a helper function to create a popup input screen. This can be used
                        for both an Add and an Edit screen, therefore reducing code duplication."
                      ),
                      h5(
                        "Also create a helper function that will validate the received inputs,
                        and show an error message if they are invalid."
                      ),
                      
                      aceEditor(
                        outputId = "chunkInteractionPopupsHelper",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "350px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionPopupsHelper
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 5: Show popup input screen",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Server, add an ObserveEvent that monitors the Add Product button
                        and calls the helper function created above."
                      ),
                      
                      aceEditor(
                        outputId = "chunkInteractionPopupsShowAdd",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "220px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionPopupsShowAdd
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 6: Save new record",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Server, add an ObserveEvent that monitors Save New Product button 
                        on the popup screen and calls the helper validation function created above."
                      ),
                      h5("If the inputs are invalid, an error message is shown, otherwise the data are saved."),
                      
                      aceEditor(
                        outputId = "chunkInteractionPopupsAddSave",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "350px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionPopupsAddSave
                      )
                      
                    )
                    
                  )
                
              )
              
            )
            
          )
        
        ),
        
        tabPanel(
          
          title = "Edit table row",
          icon = icon("edit"),
          
          fluidRow(
            
            column(
              
              width = 12,
              
              column(
                
                width = 4,
                
                h4("Example"),
                h5("Edit existing row of data in a table using a popup input screen."),
                
                fluidRow(
                  
                  column(
                    
                    width = 8,
                    
                    dataTableOutput(ns("tblProductsEdit"))
                    
                  )
                  
                ),
                
                br(),
                
                fluidRow(
                  
                  column(
                    
                    width = 8,
                    
                    actionButton(
                      inputId = ns("cmdShowEditProductScreen"),
                      label = "Edit Product",
                      icon = icon("plus-circle"),
                      width = "100%"
                    )
                    
                  )
                  
                )
                
              ),
              
              column(
                
                width = 8,
                
                h4("Instructions"),
                
                bs_accordion(id = ns("accInteractionPopupScreensEdit")) %>%
                  
                  bs_append(
                    
                    title = "Step 1: Pre-requisites",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "See Steps 1-4 in the example for Adding table rows. In the Ui, 
                        create an additional button to show the Edit Product popup screen."
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 2: Show popup input screen",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Server, add an ObserveEvent that monitors the Edit Product button
                        and calls the helper function created earlier."
                      ),
                      
                      aceEditor(
                        outputId = "chunkInteractionPopupsShowEdit",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "220px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionPopupsShowEdit
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 3: Edit existing record",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Server, add an ObserveEvent that monitors Save Edited Product button 
                        on the popup screen and calls the helper validation function created above."
                      ),
                      h5("If the inputs are invalid, an error message is shown, otherwise the data are saved."),
                      
                      aceEditor(
                        outputId = "chunkInteractionPopupsEditSave",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "400px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtInteractionPopupsEditSave
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
  
  # Show Add Product Screen when prompted
  observeEvent(
    input$cmdShowAddProductScreen,
    {
      createScreen <- popupInputScreen(
        title = "Add Product", 
        actionButtonId = "cmdSaveNewProduct", 
        actionButtonLabel = "Save New Product"
      )
      
      showModal(createScreen)
    }
  )
  
  # Show Edit Product Screen when prompted
  observeEvent(
    input$cmdShowEditProductScreen,
    {
      editScreen <- popupInputScreen(
        title = "Edit Product", 
        actionButtonId = "cmdSaveEditedProduct", 
        actionButtonLabel = "Save Edited Product"
      )
      
      showModal(editScreen)
    }
  )
  
  # Save New Product row in table when prompted
  observeEvent(
    input$cmdSaveNewProduct,
    {
      # Collect inputs
      productName <- input$txtProductName
      productPrice <- input$nbxProductPrice

      # Input validation
      if(validateProductData(productName, productPrice) == FALSE){
        # Showing error message
        shinyalert(
          title = "Error",
          text = "Please check the provided inputs.",
          type = "error"
        )
      } else{
        # Creating new record then updating table and reactive values
        newRecord <- data.frame(Name = productName, Price = productPrice)
        values$tblProducts <- rbind(values$tblProducts, newRecord)
       
        # Closing popup screen and showing completed message
        removeModal()
        shinyalert(
          title = "Completed",
          text = "Successfully added new product.",
          type = "success"
        )
      }
    }
  )
  
  # Save Edited Product row in table when prompted
  observeEvent(
    input$cmdSaveEditedProduct,
    {
      # Collect inputs
      productName <- input$txtProductName
      productPrice <- input$nbxProductPrice
      # Selected table row to edit
      selectedRow <- input$tblProductsEdit_rows_selected

      # Input validation
      if(validateProductData(productName, productPrice) == FALSE){
        # Showing error message
        shinyalert(
          title = "Error",
          text = "Please check the provided inputs.",
          type = "error"
        )
      } else{
        # Editing existing record then updating table and reactive values
        values$tblProducts$Name[selectedRow] <- productName
        values$tblProducts$Price[selectedRow] <- productPrice

        # Closing popup screen and showing completed message
        removeModal()
        shinyalert(
          title = "Completed",
          text = "Successfully edited product.",
          type = "success"
        )
      }
    }
  )
  
}