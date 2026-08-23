# quarto render

A version of `quarto::quarto_render` that has sane defaults for when
working in a `targets` project where report documents are frequently
kept in a subfolder, but `targets` needs to operate from the root folder
to find and load everything.

## Usage

``` r
ft_quarto_document(document = NULL, working_directory = getwd(), ...)
```

## Arguments

- document:

  the `qmd` document being used

- working_directory:

  the root directory of the `targets` project (default to getwd)

- ...:

  any other parameters used by `quarto::quarto_render`

## Value

the output of running `quarto::quarto_render`

## See also

Other 'Document Rendering':
[`ft_render_document`](https://rmflight.github.io/flighttools/reference/ft_render_document.md)`()`
