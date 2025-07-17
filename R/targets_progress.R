#' show targets progress
#'
#' @param names the names of the things to track
#'
#' @family {targets}
#' @export
#' @return tibble
ft_show_targets_progress = function(names = NULL, ...) {
  if (!require("targets")) {
    stop("targets package must be installed!")
  }
  tmp_network = targets::tar_network(targets_only = TRUE, names = names, ...)

  n_todo = nrow(tmp_network$vertices)

  progress_out = tibble::add_column(
    targets::tar_progress_summary(),
    todo = n_todo,
    .before = 1
  )
  progress_out
}

#' useful targets options
#'
#' Provides a text snippet with useful targets progress options.
#'
#' @family {targets}
#' @export
#' @return text
ft_targets_options = function() {
  cat(
    'Put this snippet in "packages.R":\n\n',
    'targets::tar_config_set(reporter_make = "timestamp_positives")\n\n',
    'also see the "reporter" section of ?targets::tar_make',
    sep = ""
  )
}
