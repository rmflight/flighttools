#' watch pid
#'
#' Given a process id (pid), watches the process, and if the process dies, then
#' takes an action given by the supplied function. Also able to take action if
#' the process is still alive.
#'
#' @param pid the process ID to watch
#' @param dead_action what to do if the process no longer exists (display message)
#' @param alive_action what to do if the process is alive
#' @param check_interval how often to check the process in seconds (default is 60)
#'
#' @examples
#' \dontrun{
#' use_pid = ps::ps_pid()
#' alive_action = function(){ft_notify_success_error(NULL, "it's running!")}
#' dead_action = function(){ft_notify_success_error(NULL, "it died")}
#' ft_watch_pid(use_pid, alive_action = alive_action, dead_action = dead_action)
#' }
#'
#' @seealso [ft_notify_success_error()] [ft_ntfy_success_error()] [ft_beep_success_error()]
#'
#' @export
#' @return NULL
ft_watch_pid = function(
  pid = NULL,
  dead_action = function() {
    ft_notify_success_error(NULL, "it died")
  },
  alive_action = NULL,
  check_interval = 60
) {
  if (is.null(pid)) {
    stop("No process supplied!")
  }

  status_str = paste0("--pid ", pid)
  pid_status = system2("ps", status_str, stdout = FALSE)

  if (pid_status == 1) {
    dead_action
  }
  # loop_count = 0
  while (pid_status == 0) {
    Sys.sleep(check_interval)
    pid_status = system2("ps", status_str, stdout = FALSE)

    if (!is.null(alive_action)) {
      alive_action()
    }

    # loop_count = loop_count + 1
    # message(loop_count)
  }
  dead_action()
}
