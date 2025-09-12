#' get allowed timekeeping categories
#'
#' @returns string
#' @family {Timekeeping}
#' @export
ft_tk_get_categories = function() {
  tk_categories = Sys.getenv("R_FT_TK_CATEGORIES")
  strsplit(tk_categories, ",")[[1]]
}


#' setup timekeeping
#'
#' @returns text
#'
#' @family {Timekeeping}
#' @export
#' @return NULL
ft_setup_timekeeping = function() {
  cat(
    "Copy and modify these lines to a commonly used .Renviron file:

  R_FT_TK_LOGFILE=/path/to/timekeeping_dir/.timekeeping/.timekeeping.csv
  R_FT_TK_CATEGORIES=qcqa,analysis,packagedev,cleaning,reporting,writing,anythingelse
  
  Run this in an R session:
    
  fs::dir_create('/path/to/timekeeping_dir', recurse = TRUE)
  fs::file_create('/path/to/timekeeping_dir/.timekeeping.csv'",
    sep = "\n"
  )
  return(NULL)
}


#' get timekeeping file
#'
#' @returns file path from .Renviron
#'
#' @family {Timekeeping}
#' @export
#' @return filename string
ft_tk_logfile = function() {
  tk_file = Sys.getenv("R_FT_TK_LOGFILE")
  tk_file
}


#' log starting or stopping a task
#'
#' @param collab collaborating party
#' @param project the project being worked on
#' @param category what type of work is being done
#' @param type are you starting or stopping work
#' @param comments futher comments about it
#' @param log_file where to put this info. Defaults to file returned by `ft_tk_logfile()`
#'
#' @family {Timekeeping}
#' @returns NULL
#'
#' @export
ft_tk_logtask = function(
  collab = "",
  project = "",
  category = "",
  type = "start",
  comments = "",
  log_file = ft_tk_file()
) {
  tk_categories = ft_tk_get_categories()

  if (!fs::file_exists(log_file)) {
    cli::cli_abort(
      "{.file log_file} does not exist, can't add to it, aborting."
    )
  }

  if (!(category %in% tk_categories)) {
    cli::cli_abort(
      "{.var category} is not in the list returned by {.function ft_tk_get_categories}."
    )
  }

  if (!(type %in% c("start", "stop"))) {
    cli::cli_abort("{.var type} must by either 'start' or 'stop'.")
  }

  log_string = paste(
    collab,
    project,
    category,
    type,
    comments,
    Sys.time(),
    sep = ","
  )
  cli::cli_inform(paste0('logging: ', log_string))

  ft_check_last(log_file, new_type = type)

  cat(
    log_string,
    "\n",
    file = log_file,
    append = TRUE
  )
  return(invisible(log_string))
}

ft_tk_parselog = function(log_file = ft_tk_logfile()) {
  log_table = read.csv(log_file, header = FALSE) |>
    tibble::as_tibble()
  names(log_table) = c(
    "collab",
    "project",
    "category",
    "type",
    "comments",
    "timestamp"
  )
  log_table
}

ft_tk_readlog = function(log_file = ft_tk_logfile()) {
  readLines(log_file)
}

ft_check_last = function(log_file, new_type = "") {
  current_log = ft_tk_readlog(log_file)
  last_log = current_log[length(current_log)]

  has_type = grepl(new_type, last_log)
  if (has_type) {
    cli::cli_inform(
      'The last timekeeping entry has the same {.var type} as {.var {new_type}}.\nIf this is a mistake, you might want to remove this last logging entry using {.fun ft_tk_removelast}.'
    )
  }
}

ft_tk_check_log = function(log_table) {
  # for each collaborator and project, we should check that
  # stops immediately follow starts, and that there is an equal number of both.
}


#' remove last timekeeping entry
#'
#' @param log_file
#'
#' @returns NULL invisibly
#' @family {Timekeeping}
#' @export
ft_tk_removelast = function(log_file = ft_tk_logfile()) {
  current_log = ft_tk_readlog(log_file)
  if (length(current_log) > 0) {
    cli::cli_inform("Removing the last entry of the log file.")
    keep_lines = seq(1, length(current_log) - 1)
    out_log = current_log[keep_lines]
    cat(out_log, file = log_file, sep = "\n", append = FALSE)
  }
  return(invisible(NULL))
}

ft_tk_summarize_time = function(
  log_file = ft_tk_logfile(),
  collab = "",
  project = "",
  category = "",
  units = "days"
) {
  # this should get
  return(NULL)
}
