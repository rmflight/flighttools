#' knitr chunk options
#' 
#' My preferred knitr chunk options.
#' 
#' @export
#' @return string
ft_knitr_opts = function()
{
  cat('knitr::opts_chunk$set(echo = FALSE,
                      message = FALSE,
                      warning = FALSE,
                      fig.width = 10,
                      fig.height = 8,
                      dev = c("ragg_png", "svg"),
                      dpi = 600)', sep = "\n")
}

#' rmd / qmd title block
#' 
#' My preferred title block
#' 
#' @export
#' @return string
ft_title_block = function()
{
  cat('
title: "A Good Title"
author: "Robert M Flight"
date: last-modified
date-format: YYYY-MM-DD HH:mm
format: 
  docx:
    keep-md: true
  html:
    toc: true
    self-contained: true
bibliography: bibliography_file.json', sep = "\n")
}

#' remove figures at start
#' 
#' It happens very often, that we don't want to keep old figures laying around
#' from a previous rendering of the document. So this creates the code we would
#' insert into a setup chunk to go and delete the previously created figures.
#' 
#' @export
#' @return string
ft_remove_figures = function()
{
  cat("if (doc_type %in% 'docx') {
  unlink(here::here('path', 'to', 'documentname_files'), recursive = TRUE)
}", sep = "\n")
}
