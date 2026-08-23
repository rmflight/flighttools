#' create limma code
#'
#' A helper that provides a template for limma code to programmatically
#' set up the differences one wants to extract.
#'
#' @examples
#' ft_limma_code()
#'
#' @export
#' @family 'Analysis'
#' @return NULL, invisibly
ft_limma_code = function() {
  cat(
    '#\' run limma
#\'
#\' Run limma code between two levels or factors.
#\'
#\' @param data_in a matrix of values, columns are samples
#\' @param data_info data.frame of attributes
#\' @param contrast the attribute, and factors
#\'
#\' @examples
#\' data_in = matrix(rnorm(200), nrow = 10, ncol = 20)
#\' rownames(data_in) = paste0("f", seq(1, 10))
#\' colnames(data_in) = paste0("s", seq(1, 20))
#\' data_in[, 1:10] = data_in[, 1:10] + 2
#\'
#\' data_info = data.frame(sample_id = paste0("s", seq(1, 20)), group = rep(c("g1", "g2"), each = 10))
#\' # g2 is the reference
#\' # LFC should all be positive
#\' contrast = c("group", "g2", "g1")
#\'
#\' run_limma(data_in, data_info, contrast)
#\' # g1 is the reference
#\' # LFC should all be negative
#\' contrast = c("group", "g1", "g2")  
#\' run_limma(data_in, data_info, contrast)
run_limma = function(data_in, data_info, contrast) {
  data_info[[contrast[1]]] = factor(
    data_info[[contrast[1]]],
    levels = contrast[c(2, 3)]
  )

  design_matrix = model.matrix(
    as.formula(paste("~", contrast[1], sep = " ")),
    data = data_info
  )
  ncol_design = ncol(design_matrix)
  colnames(design_matrix)[ncol_design] = contrast[1]

  out_contrast = paste0(contrast[3], " / ", contrast[2])

  data_in = data_in[, data_info$sample_id]

  # depending on your data type, you may need to add an extractor,
  # log-transformation, imputation, or combinations of them prior
  # to running the actual limma calculations below

  lm_fit = limma::lmFit(data_in, design_matrix)
  e_fit = limma::eBayes(lm_fit)

  results = limma::topTable(
    e_fit,
    coef = contrast[1],
    number = Inf,
    p.value = 1
  )
  results$feature_id = rownames(results)
  results$contrast = out_contrast
  return(results)
}
'
  )
  return(invisible(NULL))
}

#' Set function parameters to an environment.
#'
#' This function is designed to help debug functions. It will attempt to set all
#' the default parameter values to the specified environment (global environment
#' by default). This is useful for when you want to execute code within the
#' function definition interactively but need the parameters set in the current
#' environment.
#'
#' **Warning:** This function will modify the global environment and therefore
#' violates CRAN policy
#' ["Packages should not modify the global environment"](https://cran.r-project.org/web/packages/policies.html#Source-packages).
#'
#' @param FUN the function to assign parameters to an environment.
#' @param envir the environment to assign the variables to. Defaults to the
#'        global environment.
#' @param verbose whether to return the data frame invisibly or to print the results.
#' @return a data frame where row names correspond to the parameter name with
#'        two columns: `set` which is logical indicating if the variable was set
#'        and `value` with a character representation of the variable value.
#' @author Jason Bryer
#' @source Jason Bryer blog, https://bryer.org/posts/2026-05-05-Setting_Function_Parameters_for_Debugging.html
#' @family 'Analysis'
#' @export
ft_set_function_params = function(
  FUN,
  envir = globalenv(),
  verbose = interactive()
) {
  params = formals(FUN)
  params_set = data.frame(
    row.names = names(params),
    set = rep(FALSE, length(params)),
    value = rep(NA_character_, length(params))
  )
  for (param in names(params)) {
    value = params[[param]]
    if (!missing(value)) {
      if (is.character(value)) {
        assign(param, value, envir = envir)
        params_set[param, ]$value = paste0(value, collapse = ",")
      } else {
        assign(param, eval(value), envir = envir)
        params_set[param, ]$value = paste0(eval(value), collapse = ",")
      }
      params_set[param, ]$set = TRUE
    }
  }
  if (verbose) {
    return(params_set)
  } else {
    invisible(params_set)
  }
}

#' launch and relaunch a command
#'
#' Given a command string and arguments, runs it, checks if the process is still alive,
#' and if the process has died, launches it again. Requires packages `sys` and `ps`.
#'
#' @param command the command to run
#' @param args the command arguments
#' @param ntry how many times to try relaunching the command
#' @param check_interval how long to wait in seconds before checking on it
#' @param status_expected what status is expected, default is "running"
#' @param ... other arguments passed to `sys::exec_background`
#'
#' @seealso [sys::exec_background()], [ps::ps_status()]
#' @export
#' @family 'Analysis'
#' @return NULL invisibly
ft_launch_watch_relaunch = function(
  command,
  args = NULL,
  ntry = 10,
  check_interval = 60,
  status_expected = "running",
  ...
) {
  if (!requireNamespace("ps", quietly = TRUE)) {
    cli::cli_abort(
      "package `ps` must be installed for watching launched jobs."
    )
  }
  if (!requireNamespace("sys", quietly = TRUE)) {
    cli::cli_abort(
      "package `sys` must be installed for launching background jobs."
    )
  }
  itry = 1
  while (itry <= ntry) {
    cli::cli_inform("Running command iteration {itry} of {ntry} ...")

    command_pid = sys::exec_background(cmd = command, args = args, ...)
    ps_id = ps::ps_handle(command_pid)
    # cli::cli_inform("pid is {command_pid}")

    # cli::cli_inform("Sleeping ...")
    Sys.sleep(check_interval)

    status_str = fs::path("/proc", command_pid)
    pid_status = ps::ps_status(ps_id)

    if (!pid_status %in% status_expected) {
      # cli::cli_inform("pid not found, iterating ...")
      itry = itry + 1
    }

    while (pid_status %in% status_expected) {
      # cli::cli_inform("Sleeping inner ...")
      Sys.sleep(check_interval)
      pid_status = ps::ps_status(ps_id)
      # cli::cli_inform("pid status is {pid_status}")

      if (!pid_status %in% status_expected) {
        # cli::cli_inform("pid not found, iterating inner ...")
        ps::ps_kill(ps_id)
        itry = itry + 1
        break()
      }
    }
  }
  return(invisible(NULL))
}
