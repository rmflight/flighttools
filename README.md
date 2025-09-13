
# flighttools

<!-- badges: start -->

<!-- badges: end -->

`flighttools` is a personal package for Robert M Flight, with some
functions that I find myself needing regularly. Nothing in it is meant
to be **required** for an analysis, so that this package doesn’t
**need** to be installed for something to run. Instead, most of the
functions are helpers, either providing interactive functionality, or
providing code that I can paste somewhere else to do something.

If you like the functions and want to use them as is, go ahead and
install the package. I actually recommend that you fork this package, or
look over the code and borrow what you want to make your own. Everything
is MIT licensed, so go for it.

## Installation

You can install the development version of `flighttools` from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("rmflight/flighttools")
```

## Notifiers

The functions I use the most are probably the notification functions.
There are three, for slightly different use cases, but they all work
roughly the same way:

``` r
library(flighttools)
ft_*_success_error(code_to_evaluate)
```

- `ft_beep_success_error`: plays a sound from `beepr` if code is
  successful, a different one if there is an error;
- `ft_notify_success_error`: creates a visual notification using
  `notify-send` on linux;
- `ft_ntfy_success_error`: sends a network notification using the `ntfy`
  [package](https://github.com/jonocarroll/ntfy).

I typically use these when I am running a long function, or when I am
running `targets` pipelines. What is really nice, is they take whatever
R code you supply, evaluate it, and then check if the code errored. If
it didn’t error, it just returns the results. If it errored, it tells
you, by changing the notification, and then returns the results.

``` r
ft_beep_success_error(tar_make())
ft_beep_success_error(tar_make(valid_target_name))
```

## Markdown Code Helpers

Many functions just spit code into the terminal for me to copy into a
document or code file. For example, I have a title block I use
regularly. It’s not enough for me to have a template, but I do like to
use a consistent one. This way, I can have this package installed, but
not as a hard dependency, and just copy the output into a project Rmd or
qmd file.

``` r
library(flighttools)
ft_title_block()
```


    title: "A Good Title"
    author: "Robert M Flight"
    date: last-modified
    date-format: YYYY-MM-DD HH:mm
    format: 
      docx:
        keep-md: true
      html:
        toc: true
        embed-resources: true
    bibliography: bibliography_file.json

## Graphics Code Helpers

Do you remember the code to turn axis labels 90 degrees in a `ggplot2`
graph? Me neither. But this gives me the code to add to a plot.

``` r
ft_ggplot2_rotate_axis_labels()
```

    ## scale_x_discrete(guide = guide_axis(angle = 90))
    ## 
    ## theme(axis.text.x=element_text(angle = 90)
    ## 
    ## coord_flip()

## File Manipulation

When I’m using `targets`, I also like to be able to rename file outputs
with the current date, so I can keep track of versions, as well as zip
the Word figure directory up to share with others.

``` r
ft_rename_outputs(tar_read(file_output), prefix = "initials_info")
ft_zip_directory("docs/file_output/figure-docx", "docs/file_output_figures.zip")
```

## Timekeeping

I work in an academic environment, and I do a lot of data analysis for
collaborators. We really want to provide information on roughly how much
time I spend on various tasks working with them, but I don’t want to
manually track it. Therefore, I built a set of relatively simple time
tracking functions into this package.

The way it works, is you set up a file where the timekeeping is recorded
via **start** and **stop** statements. The file path is defined in an
environment variable. I set this in the top level `.Renviron`. See
`ft_setup_timekeeping()`. You also set which categories of tasks you are
allowed to record in another environment variable, so that you restrict
yourself to what **categories** you are recording, because personally,
I’ll keep changing them.

Actual timekeeping log entries are comma separated, so don’t use comma’s
in your **comments**, or anything else.

The functions are:

- `ft_setup_timekeeping()`: only run once to give you code for setting
  things up;
- `ft_tk_logtask()`: log starting and stopping tasks;
- `ft_tk_removelast()`: remove the last entry in case you messed up;
- `ft_tk_summarize_time()`: summarize how many days you’ve worked on
  particular projects;
- `ft_tk_parselog()`: parse and display the log file.
