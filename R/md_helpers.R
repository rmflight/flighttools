#' knitr chunk options
#' 
#' My preferred knitr chunk options.
#' 
#' @family {Markdown} 
#' @family {Code Generators}
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
#' @family {Markdown} 
#' @family {Code Generators}
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
    embed-resources: true
bibliography: bibliography_file.json', sep = "\n")
}

#' remove figures at start
#' 
#' It happens very often, that we don't want to keep old figures laying around
#' from a previous rendering of the document. So this creates the code we would
#' insert into a setup chunk to go and delete the previously created figures.
#' 
#' @family {Markdown} 
#' @family {Code Generators}
#' @export
#' @return string
ft_remove_figures = function()
{
  cat("
  if (!interactive()) {
    doc_type = knitr::opts_knit$get('rmarkdown.pandoc.to')
    if (doc_type %in% 'docx') {
      unlink(here::here('path', 'to', 'documentname_files'), recursive = TRUE)
    }
  }", sep = "\n")
}

#' plot list includes
#' 
#' Using `!expr glue::glue(...)` will break `quarto inspect`, which is used
#' by `targets`
#' 
#' @family {Markdown} 
#' @family {Code Generators}
#' @export
#' @return string
ft_plot_includes = function()
{
  cat('
write_plot_list_includes = function(plot_list,
                                    out_file = "docs/_plot_list.qmd",
                                    use_id = "plot_list")
{
  load_code = glue::glue(
    "```{{r}}
    plot_list = targets::tar_read({use_id})
    ```"
  )
  plot_code = purrr::map(names(plot_list), \\(in_name){
    id_name = gsub(" ", "-", tolower(in_name))
    glue::glue("```{{r}}
    #| label: fig-{id_name}
    #| fig-cap: Displacement vs {in_name}.
    #| echo: false
    plot_list[[\\\"{in_name}\\\"]]
    ```")
  
  }) |> purrr::list_c()
  
  all_code = c(load_code, plot_code)
  
  cat(all_code, file = out_file, sep = "\\n\\n", append = FALSE)
  out_file_nofolder = basename(out_file)
  cli::cli_alert_info("Make sure to have 
  
  {.strong tar_load(include_name)} 
  
  in a code block, and 
  
  {.strong {{{{< include {out_file_nofolder} >}}}} } 
  
  where you want the figures in the parent file.\")
  return(list(code = all_code, file = out_file))
  
}'
  )
}
