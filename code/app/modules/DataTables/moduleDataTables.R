# Ui functions ------------------------------------------------------------
uiDataTables <- function()
{
  ns <- NS("moduleDataTables")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiDataTables"))
  )
  
  return(userInterfaceOutput)
}


# Server functions --------------------------------------------------------
serverDataTables <- function(input, output, session, moduleData)
{
  ns <- NS("moduleDataTables")
 
  aceEditorTheme <- moduleData$appSettings$codeChunks$aceEditorTheme
  aceEditorMode <- moduleData$appSettings$codeChunks$aceEditorMode
  aceEditorReadOnly <- moduleData$appSettings$codeChunks$aceEditorReadOnly
  packageUrls <- moduleData$appData$packageUrls
  codeChunks <- moduleData$appData$codeChunks
  
  
  # Render table
  output$tblExampleDataTable <- DT::renderDataTable({
    
    datatable(
      # Table data
      data = EuStockMarkets,
      
      # Hiding row names
      rownames = FALSE,
      
      # Single row can be selected
      selection = "single",
      
      # Enabling buttons on top of table and scrollbar
      extensions = c("Buttons", "Scroller"),

      # Filter
      filter = "bottom",
      
      options = list(
        # Table components can be added/removed here
        dom = "Blfrtip",
        
        # Freezing panes
        fixedHeader = TRUE,
        
        # Specify buttons on top of table
        buttons = c("copy", "excel", I("colvis")),
        
        # Scroll heights
        scrollY = 300,
        scrollX = 500,
        
        # Page length and menu
        paging = TRUE,
        pageLength = 50,
        lengthMenu = list(
          c(50, 100, 500, -1),
          list("50", "100", "500", "All")
        )
      )

    )
    
  })
  
  # Tab Ui
  output$uiDataTables <- renderUI({
    
    tagList(
      
      tabBox(
        
        id = ns("tbxDataTables"),
        title = "DataTables",
        width = 12,
        side = "left",
        selected = "General Customisation",
        
        tabPanel(
          
          title = "General Customisation",
          icon = icon("table"),
          
          fluidRow(
            
            column(
              
              width = 12,
              
              column(
                
                width = 6,
                
                h4("Example"),
                h5("Improving the appearance of a DataTable with custom settings."),

                br(),
                
                fluidRow(
                  
                  column(
                    
                    width = 10,
                    
                    div(
                      dataTableOutput(ns("tblExampleDataTable")),
                      style = "font-size: 80%;"
                    )
                    
                  )
                  
                )
                
              ),
              
              column(
                
                width = 6,
                
                h4("Instructions"),
                
                bs_accordion(id = ns("accDataTables")) %>%
                  
                  bs_append(
                    
                    title = "Step 1: Required Packages",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("Install the below package(s) and ensure they're loaded in your code."),
                      
                      h5(packageUrls$DT)
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 2: Server changes",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5(
                        "In the Server, create an Output object for the required table using the 
                        DT::renderDataTable() function. Inside, use the datatable() function pointing to
                        the required data, and using any custom options."
                      ),
                      
                      aceEditor(
                        outputId = "chunkDataTablesServer",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "450px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtDataTablesServer
                      )
                      
                    )
                    
                  ) %>%
                  
                  bs_append(
                    
                    title = "Step 3: Ui changes",
                    
                    content = column(
                      
                      width = 12,
                      
                      h5("In the Ui, receive the Output object created above using dataTableOutput()"),
                      h5("For very large tables, it's possible to scale down the table size using a custom style."),
                      
                      aceEditor(
                        outputId = "chunkDataTablesUi",
                        theme = aceEditorTheme,
                        mode = aceEditorMode,
                        height = "200px",
                        readOnly = aceEditorReadOnly,
                        value = codeChunks$txtDataTablesUi
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