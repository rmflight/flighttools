# watch pid

Given a process id (pid), watches the process, and if the process dies,
then takes an action given by the supplied function. Also able to take
action if the process is still alive.

## Usage

``` r
ft_watch_pid(
  pid = NULL,
  dead_action = function() {
     ft_notify_success_error(NULL, "it died")
 },
  alive_action = NULL,
  check_interval = 60
)
```

## Arguments

- pid:

  the process ID to watch

- dead_action:

  what to do if the process no longer exists (display message)

- alive_action:

  what to do if the process is alive

- check_interval:

  how often to check the process in seconds (default is 60)

## See also

[`ft_notify_success_error()`](https://rmflight.github.io/flighttools/reference/notifier.md)
[`ft_ntfy_success_error()`](https://rmflight.github.io/flighttools/reference/notifier.md)
[`ft_beep_success_error()`](https://rmflight.github.io/flighttools/reference/notifier.md)

## Examples

``` r
if (FALSE) { # \dontrun{
use_pid = ps::ps_pid()
alive_action = function(){ft_notify_success_error(NULL, "it's running!")}
dead_action = function(){ft_notify_success_error(NULL, "it died")}
ft_watch_pid(use_pid, alive_action = alive_action, dead_action = dead_action)
} # }
```
