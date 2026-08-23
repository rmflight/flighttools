# summarize working time

summarize working time

## Usage

``` r
ft_tk_summarize_time(
  log_file = ft_tk_logfile(),
  collab_q = "",
  project_q = "",
  category_q = "",
  units = "days",
  min_cumulative = 120,
  return_type = "n-days"
)
```

## Arguments

- log_file:

  the log file to use (ft_tk_logfile)

- units:

  what to summarize to? Default is "days"

- min_cumulative:

  minimum number of minutes to count as one "unit"

- return_type:

  whether to give the number of days, or specific time durations by day.

- collab:

  the collaborator to select

- project:

  the project

- category:

  the category of work

## Value

data.frame

## See also

Other Timekeeping:
[`ft_setup_timekeeping()`](https://rmflight.github.io/flighttools/reference/ft_setup_timekeeping.md),
[`ft_tk_check_log()`](https://rmflight.github.io/flighttools/reference/ft_tk_check_log.md),
[`ft_tk_get_categories()`](https://rmflight.github.io/flighttools/reference/ft_tk_get_categories.md),
[`ft_tk_logfile()`](https://rmflight.github.io/flighttools/reference/ft_tk_logfile.md),
[`ft_tk_logtask()`](https://rmflight.github.io/flighttools/reference/ft_tk_logtask.md),
[`ft_tk_parselog()`](https://rmflight.github.io/flighttools/reference/ft_tk_parselog.md),
[`ft_tk_removelast()`](https://rmflight.github.io/flighttools/reference/ft_tk_removelast.md)
