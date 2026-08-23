# rmarkdown render

A version of
[`rmarkdown::render`](https://pkgs.rstudio.com/rmarkdown/reference/render.html)
that has sane defaults for when working in a `targets` project where
report documents are frequently kept in a subfolder, but `targets` needs
to operate from the root folder to find and load everything, **and** is
run within a separate `callr` process so all the outputs from the render
are not in the local workspace.

## Usage

``` r
ft_render_document(document = NULL, working_directory = getwd(), ...)
```

## Arguments

- document:

  the `Rmd` document being used.

- working_directory:

  the root directory of the `targets` project (default to getwd)

- ...:

  any other parameters used by
  [`rmarkdown::render`](https://pkgs.rstudio.com/rmarkdown/reference/render.html)

## Value

the output of running
[`rmarkdown::render`](https://pkgs.rstudio.com/rmarkdown/reference/render.html)

## See also

Other 'Document Rendering':
[`ft_quarto_document`](https://rmflight.github.io/flighttools/reference/ft_quarto_document.md)`()`
