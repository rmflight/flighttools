# dive into a dataframe

Drops the user into a debug session in the context of a given
data.frame, which allows for calculations and investigation of columns
in a particular data.frame.

## Usage

``` r
ft_dive(df)
```

## Source

Miles McBain
<https://milesmcbain.micro.blog/2025/07/04/diveing-into-the-hunt-rstats.html>

## Arguments

- df:

  the data.frame to investigate

## Examples

``` r
if (FALSE) { # \dontrun{
weird_df = data.frame(x = rnorm(200), id = sample(letters, 200, replace = TRUE))
weird_df$y = weird_df$x * 4
weird_df |>
  dplyr::filter(id %in% "a") |>
  ft_dive()
} # }


```
