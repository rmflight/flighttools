#' template a data dictionary
#'
#' I always forget the syntax I use for creating a data dictionary
#'
#' @family {Code Generators}
#' @export
#' @return string
ft_data_dictionary = function() {
  cat(
    'dictionary = tibble::tribble(
~field, ~description,
\'fieldname\', \'description\',
...
)'
  )
}
