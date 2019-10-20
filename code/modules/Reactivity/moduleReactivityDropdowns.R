# Ui functions ------------------------------------------------------------
uiReactivityDropdowns <- function()
{
  ns <- NS("moduleReactivityDropdowns")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiReactivityDropdowns"))
  )
  
  return(userInterfaceOutput)
}

# Server functions --------------------------------------------------------
serverReactivityDropdowns <- function(input, output, session, moduleData)
{
  ns <- NS("moduleReactivityDropdowns")
 
  aceEditorTheme <- moduleData$appSettings$codeChunks$aceEditorTheme
  aceEditorMode <- moduleData$appSettings$codeChunks$aceEditorMode
  aceEditorReadOnly <- moduleData$appSettings$codeChunks$aceEditorReadOnly
  packageUrls <- moduleData$appData$packageUrls
  codeChunks <- moduleData$appData$codeChunks
  
  # Static data
  tblCustomers <- data.frame(
    Name = c("John", "Jack", "Jill")
  )
  
  tblProducts <- data.frame(
    Name = c("PS4", "Xbox", "Switch"),
    Price = c("300", "250", "200")
  )
  
  tblCustomersProducts <- data.frame(
    ProductName = c("PS4", "PS4", "Xbox", "Switch", "Switch"),
    CustomerName = c("John", "Jack", "Jack", "Jack", "Jill")
  )
  
  # Reactive values
  values <- reactiveValues()
  observe({values$dbxCustomer <- input$dbxCustomer})
  observe({values$dbxProduct <- input$dbxProduct})
  
  # Monitor customer drop-down
  observe({
    if(!is.null(values$dbxCustomer)){
      # Get available product choices
      values$tblProductsForCustomer <- tblCustomersProducts %>%
        filter(CustomerName == values$dbxCustomer)
      
      # Update product drop-down choices
      updateSelectizeInput(
        session = session,
        inputId = "dbxProduct",
        choices = values$tblProductsForCustomer$ProductName
      )
    }
  })
  
  # Monitor product drop-down
  observe({
    if(!is.null(values$dbxProduct)){
      # Get product price
      values$tblProductPrice <- tblProducts %>%
        filter(Name == values$dbxProduct) %>%
        select(Price)
    }
  })
  
  # Tab Ui
  output$uiReactivityDropdowns <- renderUI({
    
    tagList(
      
      tabBox(
        
        id = ns("tbxReactivityDropdowns"),
        title = "Reactivity - Dynamic drop-downs",
        width = 12,
        side = "left",
        selected = "Update choices",
        
        tabPanel(
          
          title = "Update choices",
          icon = icon("list-ul"),
          
          fluidRow(
            
            column(
              
              width = 12,
              
              column(
                
                width = 4,
                
                h4("Example"),
                h5(
                  "Selecting an option in one drop-down to update the choices available
                  for another drop-down in the application."
                ),
                
                fluidRow(
                  
                  column(
                    
                    width = 12,
                    
                    br(),
                    
                    selectizeInput(
                      inputId = ns("dbxCustomer"),
                      label = "Select Customer",
                      choices = tblCustomers$Name,
                      options = list(
                        placeholder = "Customer Name",
                        onInitialize = I('function() { this.setValue(""); }')
                      )
                    ),
                    
                    selectizeInput(
                      inputId = ns("dbxProduct"),
                      label = "Select a Product",
                      choices = NULL,
                      options = list(
                        placeholder = "Product Name",
                        onInitialize = I('function() { this.setValue(""); }')
                      )
                    )
                    
                  )
                  
                )
                
              ),
              
              column(
                
                width = 8,
                
                h4("Instructions"),
                
                bs_accordion(id = ns("accReactivityDropdowns")) %>%
                  
                  bs_append(
                    
                    title = "Step 1: Required Packages",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("Install the below package(s) and ensure they're loaded in your code."),
                      
                      h5(packageUrls$dplyr)
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 2: Required data",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "Ensure you have loaded the required data for the drop-downs within your application.
                        Data for this example are given below."
                      ),
                      
                      aceEditor(
                        outputId = "chunkReactivityDropdownsData",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "220px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtReactivityDropdownsData
                      )
                      
                    )
                    
                  ) %>%

                  bs_append(
                    
                    title = "Step 3: Create drop-downs",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Server part of the application use the renderUI() function to create 
                        the required selectizeInput drop-downs, with set Ids that can be referenced later."
                      ),
                      h5("The options = list(onInitialize = ...) command will set the default values to blank."),
                      h5("For the first drop-down, set the available choices to the required column table."),
                      h5("For the conditional drop-down, set the choices to NULL, as they will be updated dynamically."),
                      
                      aceEditor(
                        outputId = "chunkReactivityDropdownsCreateServer",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "200px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtReactivityDropdownsCreateServer
                      ),
                      
                      h5(
                        "In the Ui, receive the output object created above using the uiOutput() function."
                      ),
                      
                      aceEditor(
                        outputId = "chunkReactivityDropdownsCreateUi",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "140px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtReactivityDropdownsCreateUi
                      )
                      
                    )
                  
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 4: Create reactive values",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("In the Server, create reactive values to monitor the selected drop-down values."),
                      h5(
                        "Also create an observe() event to update the conditional Product choices when
                        the Customer drop-down value has been changed."
                      ),
                      
                      aceEditor(
                        outputId = "chunkReactivityDropdownsReactiveValues",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "300px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtReactivityDropdownsReactiveValues
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
  
}