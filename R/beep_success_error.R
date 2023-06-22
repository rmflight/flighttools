#' beep on success or error
#' 
#' Given an expression to evaluate, beeps on error or success so you still know it is done.
#' 
#' @param expr the expression to evaluate
#' @param success which beep to use upon success
#' @param error which beep to use upon an error happening
#'
#' @export
#' @return whatever should have been returned
beep_success_error = function(expr, success = 4, error = 2)
{
  tmp = try(expr)
  if (inherits(tmp, "try-error")) {
    beepr::beep(sound = error)
  } else {
    beepr::beep(sound = success)
    return(tmp)
  }
}

#' ntfy on success or error
#' 
#' Given an expression to evaluate, sends a ntfy message on error or success so you still know it is done.
#' 
#' @param expr the expression to evaluate
#' @param success the message to send upon success
#' @param error the message to send upon an error
#'
#' @export
#' @return whatever should have been returned
ntfy_success_error = function(expr, success = "It Worked!", error = "Better Check on Me.")
{
  if (!require("ntfy")) {
    stop("ntfy is required to be setup.\nSee https://github.com/jonocarroll/ntfy")
  }
  tmp = try(expr)
  if (inherits(tmp, "try-error")) {
    ntfy::ntfy_send(error)
  } else {
    ntfy::ntfy_send(success)
    return(tmp)
  }
}
