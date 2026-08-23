# save plot to temp

Take a plot object (default is `ggplot2::last_plot()`), and write it to
a file that can be easily found and opened in a VSCode editor pane for a
zoomed view of the plot.

## Usage

``` r
ft_plot_temp_file(
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

## See also

[`ragg::agg_png()`](https://ragg.r-lib.org/reference/agg_png.html)

Other Graphics:
[`ft_add_figure_numbers()`](https://rmflight.github.io/flighttools/reference/ft_add_figure_numbers.md),
[`ft_add_padding()`](https://rmflight.github.io/flighttools/reference/ft_add_padding.md),
[`ft_discretize_colorscale()`](https://rmflight.github.io/flighttools/reference/ft_discretize_colorscale.md),
[`ft_ggplot2_add_ellipse()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_add_ellipse.md),
[`ft_ggplot2_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_colors.md),
[`ft_ggplot2_legend_inside()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_legend_inside.md),
[`ft_ggplot2_rotate_axis_labels()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_rotate_axis_labels.md),
[`ft_ggplot2_self_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_self_colors.md),
[`ft_upset_add_counts()`](https://rmflight.github.io/flighttools/reference/ft_upset_add_counts.md),
[`ft_upset_comb_matrix()`](https://rmflight.github.io/flighttools/reference/ft_upset_comb_matrix.md)
