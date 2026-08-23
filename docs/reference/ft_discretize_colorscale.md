# discretize a continuous colorscale

When one is using a continuous colorscale to visualize data (say
log-fold-changes or correlations), it may be useful to create discrete
colors from a usually continuous color scale.

## Usage

``` r
ft_discretize_colorscale(
  color_scale = NULL,
  discrete_locs = c(25, 75),
  show_colors = TRUE
)
```

## Arguments

- color_scale:

  the color scale to take colors from

- discrete_locs:

  where to take them from

- show_colors:

  create a plot showing the continuous and discrete colors

- discrete_n:

  how many colors to take

## Value

vector of colors

## See also

Other Graphics:
[`ft_add_figure_numbers()`](https://rmflight.github.io/flighttools/reference/ft_add_figure_numbers.md),
[`ft_add_padding()`](https://rmflight.github.io/flighttools/reference/ft_add_padding.md),
[`ft_ggplot2_add_ellipse()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_add_ellipse.md),
[`ft_ggplot2_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_colors.md),
[`ft_ggplot2_legend_inside()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_legend_inside.md),
[`ft_ggplot2_rotate_axis_labels()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_rotate_axis_labels.md),
[`ft_ggplot2_self_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_self_colors.md),
[`ft_plot_temp_file()`](https://rmflight.github.io/flighttools/reference/ft_plot_temp_file.md),
[`ft_upset_add_counts()`](https://rmflight.github.io/flighttools/reference/ft_upset_add_counts.md),
[`ft_upset_comb_matrix()`](https://rmflight.github.io/flighttools/reference/ft_upset_comb_matrix.md)

Other Colors:
[`ft_complexheatmap_scale()`](https://rmflight.github.io/flighttools/reference/ft_complexheatmap_scale.md),
[`ft_ggplot2_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_colors.md)

## Examples

``` r
if (require("scico")) {
  ft_discretize_colorscale(scico::scico(100, palette = "vanimo", direction = -1),
                           discrete_locs = c(20, 80))
}
#> Loading required package: scico
#> Warning: there is no package called ‘scico’
```
