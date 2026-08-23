# add counts to UpSet

Provides the code for adding column and row counts to UpSet plot
intersections and groups.

## Usage

``` r
ft_upset_add_counts()
```

## Value

a string

## See also

Other Graphics:
[`ft_add_figure_numbers()`](https://rmflight.github.io/flighttools/reference/ft_add_figure_numbers.md),
[`ft_add_padding()`](https://rmflight.github.io/flighttools/reference/ft_add_padding.md),
[`ft_discretize_colorscale()`](https://rmflight.github.io/flighttools/reference/ft_discretize_colorscale.md),
[`ft_ggplot2_add_ellipse()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_add_ellipse.md),
[`ft_ggplot2_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_colors.md),
[`ft_ggplot2_legend_inside()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_legend_inside.md),
[`ft_ggplot2_rotate_axis_labels()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_rotate_axis_labels.md),
[`ft_ggplot2_self_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_self_colors.md),
[`ft_plot_temp_file()`](https://rmflight.github.io/flighttools/reference/ft_plot_temp_file.md),
[`ft_upset_comb_matrix()`](https://rmflight.github.io/flighttools/reference/ft_upset_comb_matrix.md)

Other Code Generators:
[`ft_add_padding()`](https://rmflight.github.io/flighttools/reference/ft_add_padding.md),
[`ft_complexheatmap_scale()`](https://rmflight.github.io/flighttools/reference/ft_complexheatmap_scale.md),
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
[`ft_upset_comb_matrix()`](https://rmflight.github.io/flighttools/reference/ft_upset_comb_matrix.md)

Other UpSet:
[`ft_upset_comb_matrix()`](https://rmflight.github.io/flighttools/reference/ft_upset_comb_matrix.md)

## Examples

``` r
ft_upset_add_counts()
#> UpSet(combinations, top_annotation = upset_top_annotation(combinations, add_numbers = TRUE),
#>   right_annotation = upset_right_annotation(combinations, add_numbers = TRUE))
```
