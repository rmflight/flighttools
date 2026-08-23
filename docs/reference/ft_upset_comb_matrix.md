# manually create combinations

Provides a code framework for creating a combination matrix with code
instead of using lists. Needed because sometimes
`ComplexHeatmap::make_comb_mat` will choke on list elements.

## Usage

``` r
ft_upset_comb_matrix()
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
[`ft_upset_add_counts()`](https://rmflight.github.io/flighttools/reference/ft_upset_add_counts.md)

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
[`ft_upset_add_counts()`](https://rmflight.github.io/flighttools/reference/ft_upset_add_counts.md)

Other UpSet:
[`ft_upset_add_counts()`](https://rmflight.github.io/flighttools/reference/ft_upset_add_counts.md)

## Examples

``` r
  ft_upset_comb_matrix()
#> make_combination_matrix = function(list_items) {
#>   all_items = sort(unique(unlist(list_items)))
#>   comb_mat = matrix(0, nrow = length(all_items), ncol = length(list_items))
#>   colnames(comb_mat) = names(list_items)
#>   
#>   for (i_out in seq_along(list_items)) {
#>     comb_mat[all_items %in% list_items[[i_out]], i_out] = 1
#>   }
#>   return(comb_mat)
#> }
```
