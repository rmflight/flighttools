#' rmarkdown render
#'
#' A version of `rmarkdown::render` that has sane defaults for when working in a `targets` project
#' where report documents are frequently kept in a subfolder, but `targets` needs to operate from
#' the root folder to find and load everything, **and** is run within a separate `callr` process so
#' all the outputs from the render are not in the local workspace.
#'
#' @param document the `Rmd` document being used.
#' @param working_directory the root directory of the `targets` project (default to getwd)
#' @param ... any other parameters used by `rmarkdown::render`
#'
#' @export
#' @family 'Document Rendering'
#' @return the output of running `rmarkdown::render`
ft_render_document = function(
  document = NULL,
  working_directory = getwd(),
  ...
) {
  if (nchar(find.package("rmarkdown", quiet = TRUE)) == 0) {
    stop(
      "rmarkdown and knitr need to be installed."
    )
  }

  if (nchar(find.package("callr", quiet = TRUE)) == 0) {
    stop(
      "callr needs to be installed."
    )
  }
  callr::r(
    function(document, working_directory, ...) {
      rmarkdown::render(
        input = document,
        knit_root_dir = working_directory,
        ...
      )
    },
    show = TRUE,
    args = list(document, working_directory, ...)
  )
}

#' quarto render
#'
#' A version of `quarto::quarto_render` that has sane defaults for when working in a `targets` project
#' where report documents are frequently kept in a subfolder, but `targets` needs to operate from
#' the root folder to find and load everything.
#'
#' @param document the `qmd` document being used
#' @param working_directory the root directory of the `targets` project (default to getwd)
#' @param ... any other parameters used by `quarto::quarto_render`
#'
#' @export
#' @family 'Document Rendering'
#' @return the output of running `quarto::quarto_render`
ft_quarto_document = function(
  document = NULL,
  working_directory = getwd(),
  ...
) {
  if (!require("quarto", quietly = TRUE)) {
    stop(
      "quarto must be installed!"
    )
  }
  quarto::quarto_render(
    input = document,
    output_format = format,
    execute_dir = working_directory,
    ...
  )
}
