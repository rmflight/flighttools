# get categories from posts

Goes through the directory of quarto blog posts, and parses the yaml
frontmatter for the `categories` field, counts how many of each category
there are and arranges them in decreasing order as a tibble.

## Usage

``` r
ft_quarto_get_categories(post_directory = "posts")
```

## Arguments

- post_directory:

  the directory that holds all of the posts

## Value

tibble

## See also

Other Quarto:
[`ft_quarto_create_post()`](https://rmflight.github.io/flighttools/reference/ft_quarto_create_post.md)
