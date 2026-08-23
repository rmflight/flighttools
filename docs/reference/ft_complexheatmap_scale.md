# generate ComplexHeatmap color scale

The code for creating a function that maps values to colors for
`ComplexHeatmap` heatmaps is not easy for me to remember. Here it is.

## Usage

``` r
ft_complexheatmap_scale()
```

## Value

string

## Details

My favorite colors to use include:

- `viridis::viridis`

- `scico::scico(n, palette = "vik")`

You can also use `scico::scico_palette_show()` to see other colorblind
safe palettes.

## See also

Other Code Generators:
[`ft_add_padding()`](https://rmflight.github.io/flighttools/reference/ft_add_padding.md),
[`ft_data_dictionary()`](https://rmflight.github.io/flighttools/reference/ft_data_dictionary.md),
[`ft_ggplot2_add_ellipse()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_add_ellipse.md),
[`ft_ggplot2_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_colors.md),
[`ft_ggplot2_legend_inside()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_legend_inside.md),
[`ft_ggplot2_rotate_axis_labels()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_rotate_axis_labels.md),
[`ft_ggplot2_self_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_self_colors.md),
[`ft_knitr_opts()`](https://rmflight.github.io/flighttools/reference/ft_knitr_opts.md),
[`ft_plot_includes()`](https://rmflight.github.io/flighttools/reference/ft_plot_includes.md),
[`ft_remove_figures()`](https://rmflight.github.io/flighttools/reference/ft_remove_figures.md),
[`ft_rename_code()`](https://rmflight.github.io/flighttools/reference/ft_rename_code.md),
[`ft_title_block()`](https://rmflight.github.io/flighttools/reference/ft_title_block.md),
[`ft_upset_add_counts()`](https://rmflight.github.io/flighttools/reference/ft_upset_add_counts.md),
[`ft_upset_comb_matrix()`](https://rmflight.github.io/flighttools/reference/ft_upset_comb_matrix.md)

Other Colors:
[`ft_discretize_colorscale()`](https://rmflight.github.io/flighttools/reference/ft_discretize_colorscale.md),
[`ft_ggplot2_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_colors.md)

## Examples

``` r
ft_complexheatmap_scale()
#> n_value = 20
#> circlize::colorRamp2(seq(low, high, length.out = n_value), viridis::viridis(n_value))
#> 
#> or
#> 
#> circlize::colorRamp2(seq(low, high, length.out = n_value), scico::scico(n_value, palette = "vik"))
```
