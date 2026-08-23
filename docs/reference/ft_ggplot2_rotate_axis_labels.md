# rotate axis labels

Gives me the code to rotate axis labels.

## Usage

``` r
ft_ggplot2_rotate_axis_labels()
```

## Value

string

## See also

Other Graphics:
[`ft_add_figure_numbers()`](https://rmflight.github.io/flighttools/reference/ft_add_figure_numbers.md),
[`ft_add_padding()`](https://rmflight.github.io/flighttools/reference/ft_add_padding.md),
[`ft_discretize_colorscale()`](https://rmflight.github.io/flighttools/reference/ft_discretize_colorscale.md),
[`ft_ggplot2_add_ellipse()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_add_ellipse.md),
[`ft_ggplot2_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_colors.md),
[`ft_ggplot2_legend_inside()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_legend_inside.md),
[`ft_ggplot2_self_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_self_colors.md),
[`ft_plot_temp_file()`](https://rmflight.github.io/flighttools/reference/ft_plot_temp_file.md),
[`ft_upset_add_counts()`](https://rmflight.github.io/flighttools/reference/ft_upset_add_counts.md),
[`ft_upset_comb_matrix()`](https://rmflight.github.io/flighttools/reference/ft_upset_comb_matrix.md)

Other ggplot2:
[`ft_ggplot2_add_ellipse()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_add_ellipse.md),
[`ft_ggplot2_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_colors.md),
[`ft_ggplot2_legend_inside()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_legend_inside.md),
[`ft_ggplot2_self_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_self_colors.md)

Other Code Generators:
[`ft_add_padding()`](https://rmflight.github.io/flighttools/reference/ft_add_padding.md),
[`ft_complexheatmap_scale()`](https://rmflight.github.io/flighttools/reference/ft_complexheatmap_scale.md),
[`ft_data_dictionary()`](https://rmflight.github.io/flighttools/reference/ft_data_dictionary.md),
[`ft_ggplot2_add_ellipse()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_add_ellipse.md),
[`ft_ggplot2_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_colors.md),
[`ft_ggplot2_legend_inside()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_legend_inside.md),
[`ft_ggplot2_self_colors()`](https://rmflight.github.io/flighttools/reference/ft_ggplot2_self_colors.md),
[`ft_knitr_opts()`](https://rmflight.github.io/flighttools/reference/ft_knitr_opts.md),
[`ft_plot_includes()`](https://rmflight.github.io/flighttools/reference/ft_plot_includes.md),
[`ft_remove_figures()`](https://rmflight.github.io/flighttools/reference/ft_remove_figures.md),
[`ft_rename_code()`](https://rmflight.github.io/flighttools/reference/ft_rename_code.md),
[`ft_title_block()`](https://rmflight.github.io/flighttools/reference/ft_title_block.md),
[`ft_upset_add_counts()`](https://rmflight.github.io/flighttools/reference/ft_upset_add_counts.md),
[`ft_upset_comb_matrix()`](https://rmflight.github.io/flighttools/reference/ft_upset_comb_matrix.md)

## Examples

``` r
ft_ggplot2_rotate_axis_labels()
#> scale_x_discrete(guide = guide_axis(angle = 90))
#> 
#> theme(axis.text.x=element_text(angle = 90)
#> 
#> coord_flip()
```
