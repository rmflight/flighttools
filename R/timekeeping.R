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
  log_file = ft_tk_logfile()
) {
  tk_categories = ft_tk_get_categories()

  if (!fs::file_exists(log_file)) {
    cli::cli_abort(
      "{.file log_file} does not exist, can't add to it, aborting."
    )
  }

  if (!(category %in% tk_categories)) {
    cli::cli_abort(
      "{.var {category}} is not in the list returned by {.fun ft_tk_get_categories}."
    )
  }

  if (!(type %in% c("start", "stop"))) {
    cli::cli_abort("{.var type} must be either 'start' or 'stop'.")
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


#' Parse timekeeping log-file
#'
#' @param log_file
#'
#' @returns tibble of the log-file contents
#' @family {Timekeeping}
#' @export
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


#' check a timekeeping log
#'
#' @param log_file the log file to check
#'
#' @returns NULL (invisibly)
#' @family {Timekeeping}
#' @export
ft_tk_check_log = function(log_file = ft_tk_logfile()) {
  # for each collaborator and project, we should check that
  # stops immediately follow starts, and that there is an equal number of both.

  tk_contents = ft_tk_parselog(log_file)

  tk_grouped = tk_contents |>
    dplyr::group_by(collab, project) |>
    dplyr::summarise(
      n_start = sum(type %in% "start"),
      n_stop = sum(type %in% "stop")
    )

  tk_oddout = tk_grouped |>
    dplyr::filter(n_start != n_stop)

  if (nrow(tk_oddout) > 0) {
    for (irow in seq_len(nrow(tk_oddout))) {
      out_message = paste0(
        "collab: ",
        tk_oddout$collab[irow],
        "; project: ",
        tk_oddout$project[irow],
        " has an odd number of `start` and `stop` entries."
      )
      cli::cli_warn(out_message)
    }
  }

  start_locs = which(tk_contents$type %in% "start")
  stop_locs = which(tk_contents$type %in% "stop")

  n_start = length(start_locs)
  n_stop = length(stop_locs)

  if (n_start == n_stop) {
    diff_start_stop = stop_locs - start_locs

    diff_g1 = which(diff_start_stop > 1)

    if (length(diff_g1) > 0) {
      str_diffs = paste0(diff_g1, collapse = "\n")
      full_message = paste0(
        "There is a difference in start and stop entries greater than 1 near entry:\n",
        str_diffs
      )
      cli::cli_warn(full_message)
    }
  }
  return(invisible(NULL))
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

#' summarize working time
#'
#' @param log_file the log file to use (ft_tk_logfile)
#' @param collab the collaborator to select
#' @param project the project
#' @param category the category of work
#' @param units what to summarize to? Default is "days"
#' @param min_cumulative minimum number of minutes to count as one "unit"
#' @param return_type whether to give the number of days, or specific time durations by day.
#'
#' @returns data.frame
#' @family {Timekeeping}
#' @export
ft_tk_summarize_time = function(
  log_file = ft_tk_logfile(),
  collab_q = "",
  project_q = "",
  category_q = "",
  units = "days",
  min_cumulative = 120,
  return_type = "n-days"
) {
  # this should sum time spent on a collaborator, project, and category basis,
  # and if the time is greater than the minimum, then it counts as one of the "units".
  # units are assumed to be minutes.
  tk_contents = ft_tk_parselog(log_file)
  use_collab = check_empty_string(collab_q)
  use_project = check_empty_string(project_q)
  use_category = check_empty_string(category_q)

  if (use_collab & use_project & use_category) {
    sum_contents = tk_contents |>
      dplyr::filter(
        collab %in% collab_q,
        project %in% project_q,
        category %in% category_q
      )
  } else if (use_collab & use_project & !use_category) {
    sum_contents = tk_contents |>
      dplyr::filter(collab %in% collab_q, project %in% project_q)
  } else if (use_collab & !use_project & !use_category) {
    sum_contents = tk_contents |>
      dplyr::filter(collab %in% collab_q)
  } else if (!use_collab & use_project & use_category) {
    sum_contents = tk_contents |>
      dplyr::filter(project %in% project_q, category %in% category_q)
  }

  if (!requireNamespace("lubridate", quietly = TRUE)) {
    cli::cli_abort(
      "package `lubridate` must be installed for adding up time entries."
    )
  }
  start_locs = which(sum_contents$type %in% "start")
  stop_locs = which(sum_contents$type %in% "stop")

  time_df = tibble::tibble(
    start = lubridate::ymd_hms(sum_contents$timestamp[start_locs]),
    stop = lubridate::ymd_hms(sum_contents$timestamp[stop_locs])
  )

  min_duration = lubridate::duration(min_cumulative, units = "minutes")

  diff_df = time_df |>
    dplyr::mutate(diff = stop - start, day = lubridate::date(start)) |>
    dplyr::group_by(day) |>
    dplyr::summarise(total = sum(diff))

  if (return_type %in% "n-days") {
    n_days = diff_df |>
      dplyr::filter(total >= min_duration) |>
      nrow()
    return(n_days)
  } else if (return_type %in% "full") {
    return(diff_df)
  }
}

check_empty_string = function(in_string) {
  if (nchar(in_string) > 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
