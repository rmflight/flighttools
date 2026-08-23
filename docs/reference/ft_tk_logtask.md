# log starting or stopping a task

Logs **starting** and **stopping** work on a tast to a CSV file set
using the environment variable `R_FT_TK_LOGFILE`. Allowed `categories`
are set as a comma delimited string in the environment variable
`R_FT_TK_CATEGORIES`.

## Usage

``` r
ft_tk_logtask(
  collab = "",
  project = "",
  category = "",
  type = "start",
  comments = "",
  log_file = ft_tk_logfile(),
  time = Sys.time()
)
```

## Arguments

- collab:

  collaborating party

- project:

  the project being worked on

- category:

  what type of work is being done

- type:

  are you starting or stopping work (`start` or `stop`)

- comments:

  futher comments about it

- log_file:

  where to put this info. Defaults to file returned by
  [`ft_tk_logfile()`](https://rmflight.github.io/flighttools/reference/ft_tk_logfile.md)

- time:

  what time did this occur? Defaults to current time returned by
  [`Sys.time()`](https://rdrr.io/r/base/Sys.time.html)

## See also

Other Timekeeping:
[`ft_setup_timekeeping()`](https://rmflight.github.io/flighttools/reference/ft_setup_timekeeping.md),
[`ft_tk_check_log()`](https://rmflight.github.io/flighttools/reference/ft_tk_check_log.md),
[`ft_tk_get_categories()`](https://rmflight.github.io/flighttools/reference/ft_tk_get_categories.md),
[`ft_tk_logfile()`](https://rmflight.github.io/flighttools/reference/ft_tk_logfile.md),
[`ft_tk_parselog()`](https://rmflight.github.io/flighttools/reference/ft_tk_parselog.md),
[`ft_tk_removelast()`](https://rmflight.github.io/flighttools/reference/ft_tk_removelast.md),
[`ft_tk_summarize_time()`](https://rmflight.github.io/flighttools/reference/ft_tk_summarize_time.md)
