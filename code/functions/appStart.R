# Import all Shiny module files -------------------------------------------
importShinyModules <- function(path = "./code/modules/")
{
  moduleFiles <- list.files(path = path, pattern = "\\.[Rr]", recursive = TRUE)
  
  for(i in 1:length(moduleFiles))
  {
    moduleFilePath <- paste0(path, moduleFiles[i])
    source(moduleFilePath)
  }
}

# Import text files for code chunks ---------------------------------------
importCodeChunks <- function(path = "./reference/codeChunks/")
{
  codeChunks <- list()
  
  codeChunkFiles <- list.files(path = path, pattern = "\\.[txt]", recursive = TRUE)
  
  for(i in 1:length(codeChunkFiles))
  {
    codeChunkFileName <- codeChunkFiles[i]
    codeChunkFileNameNoExt <- file_path_sans_ext(basename(codeChunkFileName))
    
    codeChunkFilePath <- paste0(path, codeChunkFileName)
    codeChunk <- readtext(codeChunkFilePath)
    
    codeChunks[[codeChunkFileNameNoExt]] <- codeChunk$text
  }
  
  return(codeChunks)
}

# Application settings ----------------------------------------------------
appSettings <- function()
{
  settingsList <- list()
  settingsList$codeChunks$aceEditorTheme <- "chrome"
  settingsList$codeChunks$aceEditorMode <- "r"
  settingsList$codeChunks$aceEditorReadOnly <- FALSE
  
  return(settingsList)
}

# Application data --------------------------------------------------------
appData <- function()
{
  dataList <- list()
  dataList$codeChunks <- importCodeChunks()
  dataList$packageUrls$dashboardthemes <- a("dashboardthemes", href = "https://github.com/nik01010/dashboardthemes", target = "_blank")
  dataList$packageUrls$shinyjs <- a("shinyjs", href = "https://github.com/daattali/shinyjs", target = "_blank")
  dataList$packageUrls$dplyr <- a("dplyr", href = "https://github.com/tidyverse/dplyr", target = "_blank")
  dataList$packageUrls$shinyalert <- a("shinyalert", href = "https://github.com/daattali/shinyalert", target = "_blank")
  dataList$packageUrls$DT <- a("DT", href = "https://github.com/rstudio/DT", target = "_blank")
  dataList$packageUrls$datatree <- a("data.tree", href = "https://github.com/gluc/data.tree", target = "_blank")
  dataList$packageUrls$collapsibleTree <- a("collapsibleTree", href = "https://github.com/AdeelK93/collapsibleTree", target = "_blank")
  
  return(dataList)
}
