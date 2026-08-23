# launch and relaunch a command

Given a command string and arguments, runs it, checks if the process is
still alive, and if the process has died, launches it again. Requires
packages `sys` and `ps`.

## Usage

``` r
ft_launch_watch_relaunch(
  command,
  args = NULL,
  ntry = 10,
  check_interval = 60,
  status_expected = "running",
  ...
)
```

## Arguments

- command:

  the command to run

- args:

  the command arguments

- ntry:

  how many times to try relaunching the command

- check_interval:

  how long to wait in seconds before checking on it

- status_expected:

  what status is expected, default is "running"

- ...:

  other arguments passed to
  [`sys::exec_background`](https://jeroen.r-universe.dev/sys/reference/exec.html)

## Value

NULL invisibly

## See also

[`sys::exec_background()`](https://jeroen.r-universe.dev/sys/reference/exec.html),
[`ps::ps_status()`](https://ps.r-lib.org/reference/ps_status.html)

Other 'Analysis':
[`ft_limma_code()`](https://rmflight.github.io/flighttools/reference/ft_limma_code.md),
[`ft_set_function_params()`](https://rmflight.github.io/flighttools/reference/ft_set_function_params.md)
