# launch and relaunch an R process

Given a bit of R code, runs it in the background, checks if the R
process is still alive, and if the R process has died, launches it
again. Requires packages `sys` and `ps`.

## Usage

``` r
ft_r_launch_watch_relaunch(
  command,
  args = NULL,
  ntry = 10,
  check_interval = 60,
  status_expected = c("sleeping", "running"),
  ...
)
```

## Arguments

- command:

  the R code to run as a string

- args:

  the command arguments

- ntry:

  how many times to try relaunching the command

- check_interval:

  how long to wait in seconds before checking on it

- status_expected:

  what status is expected, default is "sleeping" & "running"

- ...:

  other arguments passed to
  [`sys::exec_background`](https://jeroen.r-universe.dev/sys/reference/exec.html)

## Value

NULL invisibly

## Details

Note: this writes the command provided to an R file in `tmp`, and then
passes it via `std_in`.

## See also

[`sys::r_background()`](https://jeroen.r-universe.dev/sys/reference/exec_r.html),
[`ps::ps_status()`](https://ps.r-lib.org/reference/ps_status.html)

Other 'Analysis':
[`ft_launch_watch_relaunch()`](https://rmflight.github.io/flighttools/reference/ft_launch_watch_relaunch.md),
[`ft_limma_code()`](https://rmflight.github.io/flighttools/reference/ft_limma_code.md),
[`ft_set_function_params()`](https://rmflight.github.io/flighttools/reference/ft_set_function_params.md)
