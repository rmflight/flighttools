#' show targets progress
#' 
#' @param names the names of the things to track
#' 
#' @export
#' @return tibble
show_targets_progress = function(names = NULL, ...)
{
  if (!require("targets")) {
    stop("targets package must be installed!")
  }
  tmp_network = targets::tar_network(targets_only = TRUE, names = names, ...)
  
  n_todo = nrow(tmp_network$vertices)
  
  progress_out = tibble::add_column(targets::tar_progress_summary(), todo = n_todo, .before = 1)
  progress_out
}
