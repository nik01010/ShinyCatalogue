# Ui functions ------------------------------------------------------------
uiAppearanceThemes <- function()
{
  ns <- NS("moduleAppearanceThemes")
  userInterfaceOutput <- tagList(
    uiOutput(ns("uiApperanceThemes"))
  )
  
  return(userInterfaceOutput)
}

# Server functions --------------------------------------------------------
serverAppearanceThemes <- function(input, output, session, moduleData)
{
  ns <- NS("moduleAppearanceThemes")
 
  aceEditorTheme <- moduleData$appSettings$codeChunks$aceEditorTheme
  aceEditorMode <- moduleData$appSettings$codeChunks$aceEditorMode
  aceEditorReadOnly <- moduleData$appSettings$codeChunks$aceEditorReadOnly
  packageUrls <- moduleData$appData$packageUrls
  codeChunks <- moduleData$appData$codeChunks
  
  userInterface <- tagList(
    
    tabBox(
      
      id = ns("tbxAppearanceThemes"),
      title = "Appearance - Themes",
      width = 12,
      side = "left",
      selected = "Custom Themes",
      
      tabPanel(
        
        title = "Custom Themes",
        icon = icon("paint-brush"),
        
        fluidRow(
          
          column(
            
            width = 12,
            
            column(
              
              width = 5,
              
              h4("Example"),
              h5(
                "Custom themes can be used to change the appearance of an application, 
                and custom logos can be added to the title section of the Navbar."
              ),
              
              br(),
              
              fluidRow(
                
                column(
                  
                  width = 12,
                  
                  h5("Example logos"),
                  
                  column(
                    
                    width = 5,
                    
                    shinyDashboardLogoDIY(
                      boldText = "Your"
                      ,mainText = "AppName"
                      ,textSize = 16
                      ,badgeText = "v1.0"
                      ,badgeTextColor = "black"
                      ,badgeTextSize = 2
                      ,badgeBackColor = "#d1e709"
                      ,badgeBorderRadius = 3
                    )
                    
                  ),
                  
                  column(
                    
                    width = 5,
                    
                    shinyDashboardLogoDIY(
                      boldText = "Smaller"
                      ,mainText = "Logo"
                      ,textSize = 13
                      ,badgeText = "ALPHA"
                      ,badgeTextColor = "black"
                      ,badgeTextSize = 1
                      ,badgeBackColor = "#d1e709"
                      ,badgeBorderRadius = 3
                    )
                    
                  )
                  
                )
                
              ),

              br(),
              
              fluidRow(
                
                column(
                  
                  width = 12,
                  
                  h5("Available Themes"),
                  
                  a(img(src="https://thumb.ibb.co/dbMBHn/blue_gradient.png"), href="https://ibb.co/dbMBHn", target="_blank"),
                  a(img(src="https://thumb.ibb.co/bvGNOS/boe_website.png"), href="https://ibb.co/bvGNOS", target="_blank"),
                  a(img(src="https://thumb.ibb.co/cNgYV7/grey_dark.png"), href="https://ibb.co/cNgYV7", target="_blank"),
                  br(),
                  a(img(src="https://thumb.ibb.co/iuFGiS/grey_light.png"), href="https://ibb.co/iuFGiS", target="_blank"),
                  a(img(src="https://thumb.ibb.co/mW4WHn/onenote.png"), href="https://ibb.co/mW4WHn", target="_blank"),
                  a(img(src="https://thumb.ibb.co/mYhkcn/poor_mans_flatly.png"), href="https://ibb.co/mYhkcn", target="_blank")
                  
                )
                  
              )
        
            ),
            
            column(
              
              width = 7,
              
              h4("Instructions"),
              
              bs_accordion(id = ns("accAppearanceThemes")) %>%
                
                bs_append(
                  
                  title = "Required Packages",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5("Install the below package(s) and ensure they're loaded in your code."),
                    
                    h5(packageUrls$dashboardthemes)
                    
                  )
                  
                ) %>%
                
                bs_append(
                  
                  title = "Creating custom logos",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5(
                      "Use the shinyDashboardLogoDIY() function within the title parameter 
                      within the dashboardHeader part of the application."
                    ),
                    
                    aceEditor(
                      outputId = "chunkCustomThemesLogo",
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "480px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtCustomThemesLogo
                    )
                    
                  )
                  
                ) %>%
                
                bs_append(
                  
                  title = "Using available themes",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5("Use the shinyDashboardThemes() function within the dashboardBody part of the application."),
                    h5("Further documentation and available theme chocies are available in the package link above."),
                    
                    aceEditor(
                      outputId = "chunkCustomThemes",
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "160px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtCustomThemes
                    )
                    
                  )
                  
                ) %>%
                
                bs_append(
                  
                  title = "Creating custom themes",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5("Use the shinyDashboardThemeDIY() function within the dashboardBody part of the application."),
                    h5("Further documentation and available parameters are available in the package link above."),
                    
                    aceEditor(
                      outputId = "chunkCustomThemesDIY",
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "400px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtCustomThemesDIY
                    )
                    
                  )
                  
                ) 
                
            )
            
          )
        
        )
        
      ),
      
      tabPanel(
        
        title = "Live Theme Switcher",
        icon = icon("chevron-circle-down"),
        
        fluidRow(
          
          column(
            
            width = 12,
            
            column(
              
              width = 5,
              
              h4("Example"),
              h5(
                "Drop-down which automatically changes application appearance based on the selected choice."
              ),
              
              fluidRow(
                
                column(
                  
                  width = 12,
                  
                  br(),
                  
                  uiChangeThemeDropdown(dropDownLabel = "Change Theme", defaultTheme = "grey_light")
                  
                )
                
              )
              
            ),
            
            column(
              
              width = 7,
              
              h4("Instructions"),
              
              bs_accordion(id = ns("accLiveThemeSwitcherInstructions")) %>%
                
                bs_append(
                  
                  title = "Step 1: Required Packages",
                  
                  content = column(
                    
                    width = 12,
                    
                    h5("Install the below package(s) and ensure they're loaded in your code."),
                    
                    h5(packageUrls$dashboardthemes)
                    
                  )
                  
                ) %>%
                
                bs_append(
                  
                  title = "Step 2: Create Shiny Module", 
                  
                  content = column(
                    
                    width = 12,
                    
                    h5(
                      "Copy the below Shiny Module code into a new script (e.g. moduleChangeTheme.R) 
                      and source it within your application."
                    ),

                    aceEditor(
                      outputId = "chunkChangeThemeModule",
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "400px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtChangeThemeModule
                    )
                    
                  )
                  
                ) %>%
                
                bs_append(
                  
                  title = "Step 3: Ui changes", 
                  
                  content = column(
                    
                    width = 12,
                    
                    h5("Insert the uiChangeThemeOutput() function within the body of the application."),
                    h5("This will ensure the CSS styles sent by the server part of the application are received and applied in real-time."),
                    
                    aceEditor(
                      outputId = ns("chunkChangeThemeUiChanges1"),
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "150px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtChangeThemeUiChanges1
                    ),
                    
                    br(),
                    h5("Insert the uiChangeThemeDropdown() function where you want the live theme switcher drop-down to be displayed."),
                    h5("This will create a drop-down with Id 'dbxChangeTheme', which can be monitored in the server part of the application."),
                    h5(
                      "It's possible to change the default drop-down label and default selected 
                      theme via the dropDownLabel and defaultTheme parameters respectively."
                    ),
                    
                    aceEditor(
                      outputId = ns("chunkChangeThemeUiChanges2"),
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "180px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtChangeThemeUiChanges2
                    )
                    
                  )
                  
                ) %>%
                
                bs_append(
                  title = "Step 4: Server changes", 
                  content = column(
                    
                    width = 12,
                    
                    h5("Call the Shiny Module created above using the callModule() function."),
                    h5(
                      "This will create an ObserveEvent that monitors the 'dbxChangeTheme' 
                      drop-box created within the Ui, and dynamically inject CSS styles into the application in real-time."
                    ),
                    
                    aceEditor(
                      outputId = ns("chunkChangeThemeServerChanges"),
                      theme = aceEditorTheme,
                      mode = aceEditorMode,
                      height = "100px",
                      readOnly = aceEditorReadOnly,
                      value = codeChunks$txtChangeThemeServerChanges
                    )
                    
                )
                  
              )
              
            )
        
          )
        
        )
        
      )
      
    )
    
  )
  
  output$uiApperanceThemes <- renderUI({
    userInterface
  })
  
}