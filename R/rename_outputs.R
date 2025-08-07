#' rename outputs
#'
#' When running a targets workflow, I often have files that are generated automatically
#' as part of the workflow. However, I often rename them to match the directory, and
#' add the day to the filename. This enables that automatically.
#'
#' To rename actual targets, pass the output of `tar_read(target_name)`. Note that
#' this function will not copy and rename `qmd` and `rmd` source files.
#'
#' @param file_names which files need to be renamed?
#' @param prefix what is the prefix to add?
#' @param suffix what is the suffix to add (default is today's date)
#' @param overwrite should we overwrite already existing files?
#'
#' @family {File Manipulation}
#' @export
#' @return new file paths (invisibly) to allow piping to other functions
ft_rename_outputs = function(
  file_names = NULL,
  prefix = "",
  suffix = Sys.Date(),
  overwrite = FALSE
) {
  if (is.null(file_names)) {
    cli::cli_abort("No {.var file_names} provided, aborting!")
  } else if (nchar(file_names)[1] == 0) {
    cli::cli_abort("No {.var file_names} provided, aborting!")
  } else {
    has_file = purrr::map_lgl(file_names, \(in_file) {
      nchar(in_file) > 0
    })
    file_names = file_names[has_file]
    has_rmd_qmd = purrr::map_lgl(file_names, \(in_file) {
      grepl(".qmd$|.rmd$", in_file, ignore.case = TRUE)
    })
    file_names = file_names[!has_rmd_qmd]
    #message(file_names)
  }
  if (length(file_names) == 0) {
    cli::cli_abort("No {.var file_names} exist, aborting!")
  }
  out_files = purrr::map_chr(file_names, function(in_file) {
    if (fs::file_exists(in_file)) {
      dir_part = fs::path_dir(in_file)
      file_part = fs::path_file(in_file)
      file_noext = fs::path_ext_remove(file_part)
      file_ext = fs::path_ext(file_part)
      if (nchar(prefix) > 0) {
        prefix = paste0(prefix, "_")
      }
      if ((nchar(suffix) > 0) || (!is.null(suffix))) {
        suffix = paste0("_", suffix)
      }
      if (nchar(file_ext) == 0) {
        new_file = paste0(prefix, file_noext, suffix)
      } else {
        new_file = paste0(prefix, file_noext, suffix, ".", file_ext)
      }
      new_path = fs::path(dir_part, new_file)
      cli::cli_alert_info("Copying {.file {in_file}} to {.file {new_path}}.")
      file_info = fs::file_info(in_file)
      if (file_info$type %in% "file") {
        fs::file_copy(in_file, new_path, overwrite = overwrite)
      } else if (file_info$type %in% "directory") {
        fs::dir_copy(in_file, new_path, overwrite = TRUE)
      } else {
        cli::cli_alert_warning(
          "{.file {in_file}} is not a file or directory, skipping!"
        )
      }
    } else {
      cli::cli_alert_warning("{.file {in_file}} does not exist.")
    }
  })
  return(invisible(out_files))
}

#' zip a directory
#'
#' Given a file folder, creates a zip file containing all the underlying files, starting
#' at the directory level.
#'
#' @param directory what directory of files to zip
#' @param zipfile where to save the zip file
#' @param add_date should the date be added?
#'
#' @family {File Manipulation}
#' @return path to file
#' @export
ft_zip_directory = function(directory, zipfile, add_date = TRUE) {
  zipfile = fs::path_abs(zipfile)
  if (add_date) {
    file_noext = fs::path_ext_remove(zipfile)
    file_ext = fs::path_ext(zipfile)
    new_file = paste0(file_noext, "_", Sys.Date(), ".", file_ext)
    zipfile = new_file
  }
  curr_dir = getwd()
  if (fs::dir_exists(directory)) {
    setwd(directory)
    dir_files = fs::dir_ls()
    try(zip(zipfile, files = dir_files))
    setwd(curr_dir)
    return(zipfile)
  }
}

#' rename code
#'
#' Provide the code I want when I rename stuff
#'
#' @family {Code Generators}
#' @family {File Manipulation}
#' @examples
#' ft_rename_code()
#' @return string
#' @export
ft_rename_code = function() {
  cat(
    'c(
   "target_1",
   "target_2"
 ) |>
   purrr::walk(.f = \\(x) {
     flighttools::ft_rename_outputs(
       tar_read_raw(x),
       prefix = "prefix",
       overwrite = TRUE
     ) |>
       fs::file_move("output_dir")
   })
'
  )
}
