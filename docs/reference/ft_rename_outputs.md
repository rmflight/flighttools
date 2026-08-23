# rename outputs

When running a targets workflow, I often have files that are generated
automatically as part of the workflow. However, I often rename them to
match the directory, and add the day to the filename. This enables that
automatically.

## Usage

``` r
ft_rename_outputs(
  file_names = NULL,
  prefix = "",
  suffix = Sys.Date(),
  overwrite = FALSE
)
```

## Arguments

- file_names:

  which files need to be renamed?

- prefix:

  what is the prefix to add?

- suffix:

  what is the suffix to add (default is today's date)

- overwrite:

  should we overwrite already existing files?

## Value

new file paths (invisibly) to allow piping to other functions

## Details

To rename actual targets, pass the output of `tar_read(target_name)`.
Note that this function will not copy and rename `qmd` and `rmd` source
files.

## See also

Other File Manipulation:
[`ft_add_figure_numbers()`](https://rmflight.github.io/flighttools/reference/ft_add_figure_numbers.md),
[`ft_rename_code()`](https://rmflight.github.io/flighttools/reference/ft_rename_code.md),
[`ft_zip_directory()`](https://rmflight.github.io/flighttools/reference/ft_zip_directory.md)
