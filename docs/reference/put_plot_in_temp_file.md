# save plot temp

Take a plot object (default is
[`ggplot2::last_plot()`](https://ggplot2.tidyverse.org/reference/last_plot.html)),
and write it to a file that can be easily found and opened in a VSCode
editor pane for a zoomed view of the plot.

## Usage

``` r
put_plot_in_temp_file(
  in_plot = ggplot2::last_plot(),
  filename = "_deleteme_plot.png",
  width = 10,
  height = 8,
  units = "in",
  res = 300,
  ...
)
```

## Arguments

- in_plot:

  the plot to save

- filename:

  the file to save it to. Default is underscore to make it easily
  findable

- width:

  width of the saved plot

- height:

  height of the saved plot

- units:

  units to use

- res:

  the resolution

- ...:

  other parameters to
  [`ragg::agg_png()`](https://ragg.r-lib.org/reference/agg_png.html)

## Value

filename
