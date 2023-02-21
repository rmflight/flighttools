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
