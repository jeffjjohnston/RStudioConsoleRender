
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

    valid_viewer_modes <- c("none", "browser", "viewer_pane")

    viewer_mode <- getOption("RStudioConsoleRender.viewer_mode")

    if(is.null(viewer_mode)) {
      viewer_mode <- "browser"
    }

    if(viewer_mode == "browser" | !viewer_mode %in% valid_viewer_modes) {
      rstudioapi::viewer(output_file)
    }

    if(viewer_mode == "viewer_pane") {
      temp_output_file <- paste0(tempfile(pattern="RStudioConsoleRender"), "_", basename(output_file))
      file.copy(output_file, temp_output_file)
      rstudioapi::viewer(temp_output_file)
    }
  }
}
