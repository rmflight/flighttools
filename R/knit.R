#' rmarkdown render
#'
#' A version of `rmarkdown::render` that has sane defaults for when working in a `targets` project
#' where report documents are frequently kept in a subfolder, but `targets` needs to operate from
#' the root folder to find and load everything.
#'
#' @param document the `Rmd` document being used.
#' @param working_directory the root directory of the `targets` project (default to getwd)
#' @param format the output format to generate (default is html_document)
#' @param ... any other parameters used by `rmarkdown::render`
#'
#' @export
#' @family 'Document Rendering'
#' @return the output of running `rmarkdown::render`
ft_render_document = function(
  document = NULL,
  working_directory = getwd(),
  format = "html_document",
  ...
) {
  if (!require("rmarkdown", quietly = TRUE)) {
    stop(
      "rmarkdown and knitr need to be installed."
    )
  }
  rmarkdown::render(
    input = document,
    output_format = format,
    knit_root_dir = working_dir,
    ...
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
#' @param format the output format to generate (default is html)
#' @param ... any other parameters used by `quarto::quarto_render`
#'
#' @export
#' @family 'Document Rendering'
#' @return the output of running `quarto::quarto_render`
ft_quarto_document = function(
  document = NULL,
  working_directory = getwd(),
  format = "html",
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
