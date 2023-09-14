#' rename outputs
#' 
#' When running a targets workflow, I often have files that are generated automatically
#' as part of the workflow. However, I often rename them to match the directory, and 
#' add the day to the filename. This enables that automatically.
#' 
#' @param file_names which files need to be renamed?
#' @param prefix what is the prefix to add?
#' @param suffix what is the suffix to add (default is today's date)
#' @param overwrite should we overwrite already existing files?
#' 
#' @export
#' @return NULL
rename_outputs = function(file_names = "", prefix = "",
                          suffix = Sys.Date(),
                          overwrite = FALSE)
{
  if (nchar(file_names)[1] == 0) {
    cli::cli_alert_warning("No {.val {file_names}} provided, aborting!")
    return(NULL)
  } else {
    purrr::walk(file_names, function(in_file){
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
      new_file = paste0(prefix, file_noext, suffix, ".", file_ext)
      new_path = file.path(dir_part, new_file)
      fs::file_copy(in_file, new_path, overwrite = overwrite)
    })
    return(NULL)
  }
  
}
