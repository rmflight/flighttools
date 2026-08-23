# rename code

Provide the code I want when I rename stuff

## Usage

``` r
ft_rename_code()
```

## Value

string

## See also

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
[`ft_title_block()`](https://rmflight.github.io/flighttools/reference/ft_title_block.md),
[`ft_upset_add_counts()`](https://rmflight.github.io/flighttools/reference/ft_upset_add_counts.md),
[`ft_upset_comb_matrix()`](https://rmflight.github.io/flighttools/reference/ft_upset_comb_matrix.md)

Other File Manipulation:
[`ft_add_figure_numbers()`](https://rmflight.github.io/flighttools/reference/ft_add_figure_numbers.md),
[`ft_rename_outputs()`](https://rmflight.github.io/flighttools/reference/ft_rename_outputs.md),
[`ft_zip_directory()`](https://rmflight.github.io/flighttools/reference/ft_zip_directory.md)

## Examples

``` r
ft_rename_code()
#> c(
#>    "target_1",
#>    "target_2"
#>  ) |>
#>    purrr::walk(.f = \(x) {
#>      flighttools::ft_rename_outputs(
#>        tar_read_raw(x),
#>        prefix = "prefix",
#>        overwrite = TRUE
#>      ) |>
#>        fs::file_move("output_dir")
#>    })
```
