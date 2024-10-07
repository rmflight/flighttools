#' Notifier functions
#' 
#' These functions can be used to supply an alert to the user that the evaluation of
#' an expression succeeded or resulted in an error.
#' 
#' @param expr the expression to evaluate
#' @param success what to use for success (sound or string)
#' @param error what to use for an error (sound or string)
#' @param image for `notify`, is there a specific image to use for the graphical notification?
#' 
#' @details
#' Each of these functions takes an expression as the first argument, so it is possible
#' to pipe into them, or just wrap the expression to run. They check if the evaluated
#' expression returns an error or not, so they can give the correct feedback to the user.
#' 
#' @examples
#' if (require(beepr)) {
#'   # usual syntax, works
#'   ft_beep_success_error(Sys.sleep(2))
#'   
#'   # have an error (can't add a letter to a number)
#'   ft_beep_success_error(2 + "x")
#'   
#'   # pipe syntax
#'   Sys.sleep(2) |> ft_beep_success_error()
#' }
#' 

#' @return results of expression
#' @name notifier
NULL

#' @rdname notifier
#' @export
ft_beep_success_error = function(expr, 
                                 success = 4, 
                                 error = 2)
{
  if (!require("beepr", quietly = TRUE)) {
    stop("beepr is required to be setup.")
  }
  tmp = try(expr)
  if (inherits(tmp, "try-error")) {
    beepr::beep(sound = error)
  } else {
    beepr::beep(sound = success)
    return(tmp)
  }
}


#' @rdname notifier
#' @export
ft_ntfy_success_error = function(expr, success = "It Worked!", error = "Better Check on Me.")
{
  if (!require("ntfy", quietly = TRUE)) {
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


#' @rdname notifier
#' @export
ft_notify_success_error = function(expr, success = "All done!", 
                                   error = "Shit!", image = NULL)
{
  ns = Sys.which("notify-send")
    
  if (ns == "") {
    stop("Cannot find notify-send executable, you need to install it.\n",
         "You need the 'libnotify-bin' package on Debian/Ubuntu, or\n",
         "the 'libnotify' package on Fedora Linux.")
  }
  
  tmp = try(expr)
  if (inherits(tmp, "try-error")) {
    notify_message = error
    title = "Error"
  } else {
    notify_message = success
    title = "Success"
  }
    
  ## Otherwise error
  if (is.null(image)) {
    image = normalizePath(system.file(package = packageName(), "R.png"))
  }
    
  args = c("-i", image, title, notify_message)
  run(ns, args)
  return(tmp)
}
