#' create a new quarto blog post
#' 
#' Sets up the directory for a new blog post.
#' Note this function was modified from the one originally supplied
#' by [Tom Mock](https://themockup.blog/posts/2022-11-08-use-r-to-generate-a-quarto-blogpost/).
#' 
#' @param title the title of the post
#' @param file what file should be output (default is index.qmd)
#' @param subtitle what the subtitle should be
#' @param date the date of the post
#' @param draft is this a draft post?
#' @param title_limit maximum number of characters in the title
#' @param open_file should the file be opened by RStudio?
#' 
#' @export
#' @return NULL
ft_quarto_create_post = function(
    title, 
    file = "index.qmd",
    subtitle = "",
    date = Sys.Date(), 
    draft = FALSE,
    title_limit = 40,
    open_file = TRUE
)
{
  
  # convert to kebab case and remove non space or alphanumeric characters
  title_kebab = stringr::str_to_lower(title) |> 
    stringr::str_remove_all("[^[:alnum:][:space:]]") |> 
    stringr::str_replace_all(" ", "-")
  
  # warn if a very long slug
  if (nchar(title_kebab) >= title_limit) {
    cli::cli_alert_warning("Warning: Title slug is longer than {.val {title_limit}} characters!")
  }
  
  # generate the slug as draft, prefix with _ which prevents
  # quarto from rendering/recognizing the folder
  if (draft) {
    slug = glue::glue("posts/_{date}-{title_kebab}")
    cli::cli_alert_info("Appending a '_' to folder name to avoid render while a draft, remove '_' when finished.")
  } else {
    slug = glue::glue("posts/{date}-{title_kebab}")
  }
  
  # create and alert about directory
  fs::dir_create(
    path = slug
  )
  cli::cli_alert_success("Folder created at {.file {slug}}")
  
  # wrap description at 77 characters
  subtitle = stringr::str_wrap(subtitle, width = 77) |> 
    stringr::str_replace_all("[\n]", "\n  ")

  # start generating file
  new_post_file = glue::glue("{slug}/{file}")
  
  # build yaml core
  new_post_core = c(
    "---",
    glue::glue('title: "{title}"'),
    "subtitle: |",
    glue::glue('  {subtitle}'),
    glue::glue("date: {date}")
  )
  
  new_post_core = c(
    new_post_core,
    "categories: []",
    "editor_options:",
    "  chunk_output_type: console",
    "bibliography: refs.bib"
  )
  
  # add draft if draft
  if(draft){
    new_post_text = c(
      new_post_core,
      "draft: true",
      "---\n"
    )
  } else {
    new_post_text = c(
      new_post_core,
      "---\n"
    )
  }
  
# add email link at the bottom
  
  # finalize new post text
  new_post_text = paste0(
    new_post_text,
    collapse = "\n"
  )
  
  # create file and alert
  fs::file_create(new_post_file)
  cli::cli_alert_success("File created at {.file {new_post_file}}")
  
  # create refs and alert
  new_ref_file = glue::glue("{slug}/refs.bib")
  fs::file_create(new_ref_file)
  cli::cli_alert_success("File created at {.file {new_ref_file}}")
  
  # print new post information
  cat(new_post_text)
  
  if (yesno::yesno2("Are you ready to write that to disk?")) {
    writeLines(
      text = new_post_text,
      con = new_post_file
    )
    
    rstudioapi::documentOpen(new_post_file, line = length(new_post_text))
  }
  
}

#' get categories from posts
#' 
#' Goes through the directory of quarto blog posts, and parses the yaml frontmatter
#' for the `categories` field, counts how many of each category there are and arranges
#' them in decreasing order as a {tibble}.
#' 
#' @param post_directory the directory that holds all of the posts
#' 
#' @export
#' @return tibble
ft_quarto_get_categories = function(post_directory = "posts")
{
  # post_directory = "posts"
  all_posts = fs::path(dir(post_directory, full.names = TRUE), "index.qmd")
  
  get_frontmatter = purrr::safely(function(in_file){
    rmarkdown::yaml_front_matter(in_file)
  })
  all_frontmatter = purrr::map(all_posts, get_frontmatter) |>
    purrr::map(.x = _, \(.y){.y$result})
  all_categories = purrr::map(all_frontmatter, \(.x){.x$categories}) |> unlist() |> sort()
  rle_categories = rle(all_categories)
  category_df = tibble::tibble(categories = rle_categories$values,
                               number_of_posts = rle_categories$lengths)
  sort_df = order(category_df$number_of_posts, decreasing = TRUE)
  category_df = category_df[sort_df, ]
  
  category_df
}
