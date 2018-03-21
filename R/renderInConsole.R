
#' Render in console
#'
#' Call this function as an addin to render the current Rmd document in the console
#'
#' @export
#' @importFrom rmarkdown render
#' @import rstudioapi
renderInConsole <- function() {
  doc <- rstudioapi::getSourceEditorContext()
  
  if(file.exists(doc$path)) {
    rstudioapi::documentSave(doc$id)
    setwd(dirname(doc$path))
    output_file <- rmarkdown::render(doc$path, envir=.GlobalEnv)
    rstudioapi::viewer(output_file)
  }
}
