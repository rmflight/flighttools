# setup timekeeping

setup timekeeping

## Usage

``` r
ft_setup_timekeeping()
```

## Value

text

## See also

Other Timekeeping:
[`ft_tk_check_log()`](https://rmflight.github.io/flighttools/reference/ft_tk_check_log.md),
[`ft_tk_get_categories()`](https://rmflight.github.io/flighttools/reference/ft_tk_get_categories.md),
[`ft_tk_logfile()`](https://rmflight.github.io/flighttools/reference/ft_tk_logfile.md),
[`ft_tk_logtask()`](https://rmflight.github.io/flighttools/reference/ft_tk_logtask.md),
[`ft_tk_parselog()`](https://rmflight.github.io/flighttools/reference/ft_tk_parselog.md),
[`ft_tk_removelast()`](https://rmflight.github.io/flighttools/reference/ft_tk_removelast.md),
[`ft_tk_summarize_time()`](https://rmflight.github.io/flighttools/reference/ft_tk_summarize_time.md)

## Examples

``` r
ft_setup_timekeeping()
#> Copy and modify these lines to a commonly used .Renviron file:
#> 
#>   R_FT_TK_LOGFILE=/path/to/timekeeping_dir/.timekeeping/.timekeeping.csv
#>   R_FT_TK_CATEGORIES=qcqa,analysis,packagedev,cleaning,reporting,writing,anythingelse
#>   
#>   Run this in an R session:
#>     
#>   fs::dir_create('/path/to/timekeeping_dir', recurse = TRUE)
#>   fs::file_create('/path/to/timekeeping_dir/.timekeeping.csv'
```
