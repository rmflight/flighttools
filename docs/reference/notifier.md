# Notifier functions

These functions can be used to supply an alert to the user that the
evaluation of an expression succeeded or resulted in an error.

## Usage

``` r
ft_beep_success_error(expr, success = 4, error = 2)

ft_ntfy_success_error(
  expr,
  success = "It Worked!",
  error = "Better Check on Me."
)

ft_notify_success_error(
  expr,
  success = "All done!",
  error = "Shit!",
  image = NULL
)
```

## Arguments

- expr:

  the expression to evaluate

- success:

  what to use for success (sound or string)

- error:

  what to use for an error (sound or string)

- image:

  for `notify`, is there a specific image to use for the graphical
  notification?

## Value

results of expression

## Details

Each of these functions takes an expression as the first argument, so it
is possible to pipe into them, or just wrap the expression to run. They
check if the evaluated expression returns an error or not, so they can
give the correct feedback to the user.

## Examples

``` r
if (require(beepr)) {
  # usual syntax, works
  ft_beep_success_error(Sys.sleep(2))

  # have an error (can't add a letter to a number)
  ft_beep_success_error(2 + "x")

  # pipe syntax
  Sys.sleep(2) |> ft_beep_success_error()
}
#> Loading required package: beepr
#> Warning: there is no package called ‘beepr’
```
