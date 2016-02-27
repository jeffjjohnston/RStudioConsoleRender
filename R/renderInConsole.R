
#' Render in console
#'
#' Call this function as an addin to render the current Rmd document in the console
#'
#' @export
#' @importFrom rmarkdown render
#' @import rstudioapi
renderInConsole <- function() {
  docpath <- rstudioapi::getActiveDocumentContext()$path

  if(file.exists(docpath)) {
    setwd(dirname(docpath))
    output_file <- rmarkdown::render(docpath, envir=.GlobalEnv)
    rstudioapi::viewer(output_file)
  }
}
