# zip a directory

Given a file folder, creates a zip file containing all the underlying
files, starting at the directory level.

## Usage

``` r
ft_zip_directory(directory, zipfile, add_date = TRUE)
```

## Arguments

- directory:

  what directory of files to zip

- zipfile:

  where to save the zip file

- add_date:

  should the date be added?

## Value

path to file

## See also

Other File Manipulation:
[`ft_add_figure_numbers()`](https://rmflight.github.io/flighttools/reference/ft_add_figure_numbers.md),
[`ft_rename_code()`](https://rmflight.github.io/flighttools/reference/ft_rename_code.md),
[`ft_rename_outputs()`](https://rmflight.github.io/flighttools/reference/ft_rename_outputs.md)
