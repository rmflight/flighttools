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
ft_beep_success_error = function(expr, success = 4, error = 2)
{
  if (!require("beepr", quietly = TRUE)) {
    stop("beepr is required to be setup.\nSee https://github.com/jonocarroll/ntfy")
  }
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


#' Notify on success or error
#'
#' Uses libnotify on Linux to give a system notification when sound nor `ntfy`
#' are available.
#' 
#' @param expr the expression to run
#' @param success the message to show when no errors happen
#' @param error the message to show when an error is encountered
#' @param image an image to put on the notification
#'
#' @importFrom processx run
#' @export
#' 
#' @return the results of the expression, invisibly
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
