# create a new quarto blog post

Sets up the directory for a new blog post. Note this function was
modified from the one originally supplied by [Tom
Mock](https://themockup.blog/posts/2022-11-08-use-r-to-generate-a-quarto-blogpost/).

## Usage

``` r
ft_quarto_create_post(
  title,
  file = "index.qmd",
  subtitle = "",
  date = Sys.Date(),
  draft = FALSE,
  title_limit = 40,
  open_file = TRUE
)
```

## Arguments

- title:

  the title of the post

- file:

  what file should be output (default is index.qmd)

- subtitle:

  what the subtitle should be

- date:

  the date of the post

- draft:

  is this a draft post?

- title_limit:

  maximum number of characters in the title

- open_file:

  should the file be opened by RStudio?

## See also

Other Quarto:
[`ft_quarto_get_categories()`](https://rmflight.github.io/flighttools/reference/ft_quarto_get_categories.md)
