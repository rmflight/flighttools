# Set function parameters to an environment.

This function is designed to help debug functions. It will attempt to
set all the default parameter values to the specified environment
(global environment by default). This is useful for when you want to
execute code within the function definition interactively but need the
parameters set in the current environment.

## Usage

``` r
ft_set_function_params(FUN, envir = globalenv(), verbose = interactive())
```

## Source

Jason Bryer blog,
https://bryer.org/posts/2026-05-05-Setting_Function_Parameters_for_Debugging.html

## Arguments

- FUN:

  the function to assign parameters to an environment.

- envir:

  the environment to assign the variables to. Defaults to the global
  environment.

- verbose:

  whether to return the data frame invisibly or to print the results.

## Value

a data frame where row names correspond to the parameter name with two
columns: `set` which is logical indicating if the variable was set and
`value` with a character representation of the variable value.

## Details

**Warning:** This function will modify the global environment and
therefore violates CRAN policy ["Packages should not modify the global
environment"](https://cran.r-project.org/web/packages/policies.html#Source-packages).

## See also

Other 'Analysis':
[`ft_launch_watch_relaunch()`](https://rmflight.github.io/flighttools/reference/ft_launch_watch_relaunch.md),
[`ft_limma_code()`](https://rmflight.github.io/flighttools/reference/ft_limma_code.md)

## Author

Jason Bryer
