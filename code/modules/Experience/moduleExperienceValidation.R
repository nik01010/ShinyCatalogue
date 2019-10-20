# Ui functions ------------------------------------------------------------
uiExperienceValidation <- function()
{
  ns <- NS("moduleExperienceValidation")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiExperienceValidation"))
  )
  
  return(userInterfaceOutput)
}


# Helper functions --------------------------------------------------------
# Validation function to check required inputs
validateRequiredInput <- function(inputData, inputName)
{
  if(is.null(inputData) || is.na(inputData) || inputData == ""){
    
    # Error message
    txtError <- paste("Please provide a value for the input", inputName)
    
    # Create error popup
    shinyalert(
      title = "Error",
      text = txtError,
      type = "error"
    )
    
    return(FALSE)
  }
  
  return(TRUE)
}

# Custom validation function for Customer Data
validateCustomerData <- function(firstName, lastName, code, bday)
{
  # Custom string validation
  if(firstName == lastName){
    shinyalert(
      title = "Error",
      text = "First Name cannot be the same as Last Name",
      type = "error"
    )
    return(FALSE)
  }
  
  # Custom number validation
  if(!is.numeric(code) || code < 0 || code > 100){
    shinyalert(
      title = "Error",
      text = "Code must be a valid number between 0 and 100",
      type = "error"
    )
    return(FALSE)
  }
  
  # Custom date validation
  if(month(bday) != 2){
    shinyalert(
      title = "Error",
      text = "Customer must be born in February",
      type = "error"
    )
    return(FALSE)
  }
  
  return(TRUE)
}

# Server functions --------------------------------------------------------
serverExperienceValidation <- function(input, output, session, moduleData)
{
  ns <- NS("moduleExperienceValidation")
 
  aceEditorTheme <- moduleData$appSettings$codeChunks$aceEditorTheme
  aceEditorMode <- moduleData$appSettings$codeChunks$aceEditorMode
  aceEditorReadOnly <- moduleData$appSettings$codeChunks$aceEditorReadOnly
  packageUrls <- moduleData$appData$packageUrls
  codeChunks <- moduleData$appData$codeChunks
  
  # Tab Ui
  output$uiExperienceValidation <- renderUI({
    
    tagList(
      
      tabBox(
        
        id = ns("tbxExperienceValidation"),
        title = "User experience - Input validation",
        width = 12,
        side = "left",
        selected = "Custom validation",
        
        tabPanel(
          
          title = "Custom validation",
          icon = icon("bell-o"),
          
          fluidRow(
            
            column(
              
              width = 12,
              
              column(
                
                width = 5,
                
                h4("Example"),
                h5(
                  "Create custom validation rules applied to a set of data received
                  in a user interface form. Generate error messages if the inputs
                  are invalid, or generate a success message if valid."
                ),
                
                br(),
                
                h5("Example Customer Form:"),
                
                fluidRow(
                  
                  column(
                    
                    width = 12,
                    
                    column(
                      
                      width = 5,
                      
                      textInput(
                        inputId = ns("txtExampleFirstName"),
                        label = "First Name",
                        width = "100%"
                      ),
                      
                      textInput(
                        inputId = ns("txtExampleLastName"),
                        label = "Last Name",
                        width = "100%"
                      ),
                      
                      numericInput(
                        inputId = ns("nbxExampleCode"),
                        label = "Customer Code",
                        value = 0,
                        min = 0,
                        max = 100,
                        step = 1,
                        width = "100%"
                      ),
                      
                      dateInput(
                        inputId = ns("txtExampleBirthday"),
                        label = "Birthday",
                        min = "1900-01-01",
                        max = "2000-01-01",
                        value = "1990-01-01",
                        format = "yyyy-mm-dd",
                        weekstart = 1,
                        width = "100%"
                      ),
                      
                      br(),
                      
                      actionButton(
                        inputId = ns("cmdExampleSave"),
                        label = "Save Customer",
                        icon = icon("save"),
                        width = "100%"
                      )
                      
                    )
                    
                  )
                  
                ),
                
                br()
                
              ),
              
              column(
                
                width = 7,
                
                h4("Instructions"),
                
                bs_accordion(id = ns("accExperienceValidation")) %>%
                  
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
                            outputId = "chunkExperienceValidationShinyalert",
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
                    
                    title = "Step 2: Ui Changes",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Ui, create the required Form, and set specific Ids for each user input,
                        so they can be validated individually."
                      ),
                      
                      aceEditor(
                        outputId = "chunkExperienceValidationUi",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "400px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtExperienceValidationUi
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 3: Helper functions",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("Create helper functions to validate input data, and source them in your code."),
                      h5("The first function below is an example of validating required inputs."),
                      h5("The second function is an example of creating custom validation logic, across multiple inputs."),
                      h5(
                        "In both cases, if a validation error is found, the function generates and error message
                        and returns FALSE, otherwise the function returns TRUE."
                      ),
                      
                      aceEditor(
                        outputId = "chunkExperienceValidationHelper",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "350px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtExperienceValidationHelper
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 4: Server changes",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("In the Server, create an ObserveEvent that monitors when the form is submitted."),
                      h5(
                        "Then collect the inputs and pass them to the helper validation functions as part of a
                        single validation result. If the validations pass, continue the expected process 
                        (e.g. saving inputs to a database) and finally generate a completed message."
                      ),
                      
                      aceEditor(
                        outputId = "chunkExperienceValidationServer",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "400px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtExperienceValidationServer
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
  
  # Monitor button that submits the Example Customer Form
  observeEvent(
    input$cmdExampleSave,
    {
      # Collect inputs
      firstName <- input$txtExampleFirstName
      lastName <- input$txtExampleLastName
      custCode <- input$nbxExampleCode
      bday <- input$txtExampleBirthday
      
      # Validate inputs
      validationResult <- (
        # Required inputs
        validateRequiredInput(inputData = firstName, inputName = "First Name") &&
        validateRequiredInput(inputData = lastName, inputName = "Last Name") &&
        validateRequiredInput(inputData = custCode, inputName = "Code") &&

        # Custom logic
        validateCustomerData(firstName, lastName, custCode, bday)
      )
      
      # Check validation result
      if(validationResult == TRUE){
        # If ok, carry on normal process
        # ...
        
        # Completed message
        shinyalert(
          title = "Completed",
          text = "All inputs are valid.",
          type = "success"
        )
      }
      
    }
  )
  
}