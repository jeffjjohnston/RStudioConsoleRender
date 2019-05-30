# RStudioConsoleRender

A short blog post about this package: [Faster rendering in RStudio](http://jeffjjohnston.github.io/rstudio/rmarkdown/2016/03/01/faster-rendering-in-rstudio.html).

This package provides a single RStudio addin command called **Render in console**. Executing it will call `rmarkdown::render(active_document_path, envir=.GlobalEnv)` in the RStudio console and then launch a viewer for the resulting rendered document.

The effect is very similar to the **Code** | **Run region** | **Run all** command, except that it also renders your output document. Unlike the **Knit** button, however, it does not create a fresh environment. This has some important consequences to keep in mind.

First, packages loaded by your RMarkdown document will not need to be reloaded if they are already loaded in the console environment. This was my primary motivation for building the addin. My RMarkdown documents often depend on a set of [Bioconductor](http://www.bioconductor.org) packages, and these can take many seconds to load. If I'm making minor changes to a document and need to constantly render it to check the output, not having to reload packages each time is much faster.

Second, because rendering occurs in the console's environment, it is easy to introduce mistakes that you won't catch until you render in an empty environment via the **Knit** command. For example, if you load a package in your console environment but forget to load it in your RMarkdown document, the package will be available when you render via the console but not when you use the **Knit** command. I find that it is a good idea to periodically use the **Knit** command to make sure my RMarkdown document does not have any dependencies on the state of the console environment.

## Viewer options

By default, `RStudioConsoleRender` will call `rstudioapi::viewer()` on the rendered document. This will typically open a browser window. You can control this behavior by setting the `RStudioConsoleRender.viewer_mode` option to one of three values:

   * `browser`: This is the default option and simply calls `rstudioapi::viewer()`. 
   * `viewer_pane`: This will open the rendered document in the RStudio Viewer pane by first copying it to the RStudio session temporary directory (a requirement of the Viewer pane).
   * `none`: No action will be performed after rendering the document when the option is set to this value.
   
Set the option using `options()` like this:

```r
options("RStudioConsoleRender.viewer_mode"="viewer_pane")
```

## Installation

Install the package via `devtools::install_github("jeffjjohnston/RStudioConsoleRender")`. The **Render in console** command should then appear in RStudio's **Tools** | **Addins** drop-down menu. You can assign the command a keyboard shortcut using **Tools** | **Modify Keyboard Shortcuts...**.
