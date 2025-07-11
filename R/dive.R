#' dive into a dataframe
#'
#' Drops the user into a debug session in the context of a given data.frame, which allows for calculations and
#' investigation of columns in a particular data.frame.
#'
#' @param df the data.frame to investigate
#'
#' @export
#' @examples
#' \dontrun{
#' weird_df = data.frame(x = rnorm(200), id = sample(letters, 200, replace = TRUE))
#' weird_df$y = weird_df$x * 4
#' weird_df |>
#'   dplyr::filter(id %in% "a") |>
#'   ft_dive()
#' }
#'
#'
#'
#' @source Miles McBain <https://milesmcbain.micro.blog/2025/07/04/diveing-into-the-hunt-rstats.html>
ft_dive = function(df) {
  df_env = list2env(df)
  local(browser(), envir = df_env)
}
